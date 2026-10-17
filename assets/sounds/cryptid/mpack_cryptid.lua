-- Cryptid OST (https://github.com/SpectralPack/Cryptid) ported into Music Selector as a soundtrack.
-- All 7 music tracks from Cryptid are included, with the same trigger rules as the original mod.
-- This pack does NOT need Cryptid to be installed: it never calls Cryptid code, it only looks for
-- Cryptid's jokers/cards/profile data if they happen to exist.
--
-- Cryptid's music only replaces the music in special situations (it has no tracks for ordinary blinds,
-- the shop, etc.), so everywhere else the normal Balatro music keeps playing.
--
-- Without the Cryptid mod, the four "event" tracks are mapped to normal Balatro moments instead
-- (see the settings just below). If Cryptid IS installed, its own triggers work as well.
--   Jimball  -> owning Blueprint or Brainstorm            (Cryptid: owning the Jimball joker)
--   Code     -> opening a Spectral pack                   (Cryptid: Code packs / Code cards)
--   Exotic   -> owning a Legendary joker                  (Cryptid: owning an Exotic joker)
--   Big      -> your best hand this run reaching 1e10     (Cryptid: a score above e1,000,000)
-- The three main-menu themes always play (see menu_theme).

return function(music_nums_ref, music_vals_list_ref, pack_display_names_ref, next_music_num_id_ref)

local mpack_name = "cryptid"

local mpack_display = "Cryptid OST - Cryptid Team"

-- Which main-menu theme to play when Cryptid isn't installed (Cryptid picks it from the selected gameset):
-- "mainline", "modest", "madness", or "random" (a different one each time the game starts).
local menu_theme = "random"

-- Balatro stand-ins for Cryptid's event music (only matter when Cryptid isn't providing its own triggers).
local use_vanilla_triggers = true                      -- set to false to only use Cryptid's own triggers
local jimball_jokers = { "j_blueprint", "j_brainstorm" } -- owning any of these plays the Jimball track
local big_score_threshold = 1e10                       -- best hand this run must reach this for the "big" track

local themes = { "mainline", "modest", "madness" }
local fallback_theme = menu_theme
if menu_theme == "random" then
    fallback_theme = themes[(os.time() % #themes) + 1]
end

local function selected()
    return G.SETTINGS.music_selection == mpack_name
end

-- Steamodded's "sync" table needs the fully prefixed track keys (e.g. "musel_cryptid_music_modest").
local key_prefix = ((SMODS.current_mod and SMODS.current_mod.prefix) or "musel") .. "_" .. mpack_name .. "_"
local function full_keys(t)
    local out = {}
    for k, v in pairs(t) do out[key_prefix .. k] = v end
    return out
end

local function add_track(key, file, opts, select)
    opts = opts or {}
    local sync = opts.sync -- nil (default), false (always restart) or a table of track names to keep in sync
    if type(sync) == "table" then sync = full_keys(sync) end
    SMODS.Sound({
        volume = opts.volume,
        pitch = 1,
        key = mpack_name .. "_" .. key,
        path = mpack_name .. "/" .. file,
        sync = sync,
        select_music_track = function()
            return selected() and select() or false
        end,
    })
end

-- Main-menu theme logic. Same rules as Cryptid (profile gameset / currently highlighted gameset); if there is
-- no gameset information at all (Cryptid not installed) the menu_theme above is used instead.
local function menu_match(name)
    if not (G.STAGES and G.STAGE == G.STAGES.MAIN_MENU) then return false end
    local profile = G.PROFILES and G.PROFILES[G.SETTINGS.profile]
    local profile_gameset = profile and profile.cry_gameset
    local selected_gameset = G.selectedGameset
    if not profile_gameset and not selected_gameset then
        return fallback_theme == name
    end
    if name == "mainline" then
        return profile_gameset == "mainline"
            or (selected_gameset and selected_gameset ~= "modest" and selected_gameset ~= "madness")
    end
    return profile_gameset == name or selected_gameset == name
end

-- Jimball joker owned (Cryptid) / Blueprint or Brainstorm owned (Balatro). sync = false -> always restarts the track.
add_track("music_jimball", "music_jimball.ogg", { sync = false }, function()
    if not G.jokers then return false end
    if next(SMODS.find_card("j_cry_jimball")) then return 200 end
    if use_vanilla_triggers then
        for _, key in ipairs(jimball_jokers) do
            if next(SMODS.find_card(key)) then return 200 end
        end
    end
    return false
end)

-- In a Code pack or using a Code card (Cryptid) / opening a Spectral pack (Balatro).
add_track("music_code", "music_code.ogg", nil, function()
    return (
        (
            G.booster_pack
            and not G.booster_pack.REMOVED
            and SMODS.OPENED_BOOSTER
            and SMODS.OPENED_BOOSTER.config.center.kind == "Code"
        )
        or (G.GAME and G.GAME.USING_CODE)
        or (use_vanilla_triggers and G.STATE and G.STATES and G.STATE == G.STATES.SPECTRAL_PACK)
    ) and 100
end)

-- Round score above e1,000,000 (Cryptid, needs Talisman/Amulet) / best hand reaching big_score_threshold (Balatro).
-- Once triggered it stays on for the rest of the run, at a lower priority, exactly like Cryptid.
add_track("music_big", "music_big.ogg", nil, function()
    if not G.GAME then return false end
    if G.GAME.cry_music_big then
        return G.GAME.cry_music_big
    end
    if type(to_big) == "function"
        and G.GAME.round_scores and G.GAME.round_scores["hand"]
        and to_big(G.GAME.round_scores["hand"].amt) > to_big(10) ^ 1000000
    then
        G.GAME.cry_music_big = 6
        return 100.001
    end
    if use_vanilla_triggers and G.GAME.round_scores and G.GAME.round_scores["hand"]
        and type(G.GAME.round_scores["hand"].amt) == "number"
        and G.GAME.round_scores["hand"].amt >= big_score_threshold
    then
        G.GAME.cry_music_big = 6
        return 100.001
    end
    return false
end)

-- Owning an exotic joker (Cryptid) / a Legendary joker (Balatro). Original volume 0.4.
add_track("music_exotic", "music_exotic.ogg", { volume = 0.4 }, function()
    if not (G.jokers and G.jokers.cards) then return false end
    for _, joker in ipairs(G.jokers.cards) do
        local rarity = joker.config and joker.config.center and joker.config.center.rarity
        if rarity == "cry_exotic" or (use_vanilla_triggers and rarity == 4) then -- 4 = Legendary
            return 100.002
        end
    end
    return false
end)

-- Main-menu themes, one per Cryptid gameset. Original volume 0.7, synced with each other.
add_track("music_mainline", "music_mainline.ogg", {
    volume = 0.7,
    sync = { music_modest = true, music_madness = true },
}, function() return menu_match("mainline") and 0 end)

add_track("music_madness", "music_madness.ogg", {
    volume = 0.7,
    sync = { music_modest = true, music_mainline = true },
}, function() return menu_match("madness") and 0 end)

add_track("music_modest", "music_modest.ogg", {
    volume = 0.7,
    sync = { music_mainline = true, music_madness = true },
}, function() return menu_match("modest") and 0 end)

 music_nums_ref[mpack_name] = next_music_num_id_ref[1]
 table.insert(music_vals_list_ref, mpack_name)
 pack_display_names_ref[mpack_name] = mpack_display
 next_music_num_id_ref[1] = next_music_num_id_ref[1] + 1
end
