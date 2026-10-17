-- Alternative Soundtrack by Hoverman (https://github.com/hocermanc/balatro_alt_music)
-- Ported into Music Selector as a full soundtrack. Every track from the original mod is included,
-- and the original ante-based track switching / sync behaviour is preserved.
--
-- Unlike the other (5-track) soundtracks, this one has:
--   * two full sets of 7 tracks (antes 1-4 and antes 5-8, repeating every 8 antes), and
--   * two "stop" tracks that cut the music after a boss blind when the set is about to change.
-- Do NOT install the standalone "Alternative Soundtrack" mod (AltSoundtrack) next to this - it would
-- play on top of the selector's choice. Everything it contains is in this folder.

return function(music_nums_ref, music_vals_list_ref, pack_display_names_ref, next_music_num_id_ref)

local mpack_name = "altsoundtrack"

local mpack_display = "Alternative Soundtrack - Hoverman"

local mpack_vol = 1.0 -- The original mod uses 1.0. Lower this (e.g. 0.6 like the other soundtracks) if it sounds too loud.

-- Same ante ranges as the original mod: set 1 = antes 1-4, set 2 = antes 5-8 (ante % 8 is 5, 6, 7 or 0).
local min1 = 1
local max1 = 4
local min2 = 5

local function selected()
    return G.SETTINGS.music_selection == mpack_name
end

local function ante_mod()
    return G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante and (G.GAME.round_resets.ante % 8)
end

local function in_set1()
    local a = ante_mod()
    return a and a >= min1 and a <= max1
end

local function in_set2()
    local a = ante_mod()
    return a and (a >= min2 or a == 0)
end

-- Steamodded's "sync" table needs the fully prefixed track keys (e.g. "musel_altsoundtrack_music_normal").
local key_prefix = ((SMODS.current_mod and SMODS.current_mod.prefix) or "musel") .. "_" .. mpack_name .. "_"
local function full_keys(t)
    local out = {}
    for k, v in pairs(t) do out[key_prefix .. k] = v end
    return out
end

local function add_track(key, file, select, sync)
    SMODS.Sound({
        vol = mpack_vol,
        volume = mpack_vol,
        pitch = 1,
        key = mpack_name .. "_" .. key,
        path = mpack_name .. "/" .. file,
        select_music_track = function()
            return selected() and select() or false
        end,
        sync = sync and full_keys(sync) or nil,
    })
end

local function cry_code_active()
    return (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "Code")
        or (G.GAME and G.GAME.USING_CODE)
end

-- ===== Stop tracks: cut the music after beating a boss blind when the track set is about to change =====
add_track("music_normal_stop", "music_normal_stop.ogg", function()
    return G.GAME
        and G.GAME.round_resets.blind_states.Boss == 'Defeated'
        and G.GAME.round_resets.ante % 8 == (max1 + 1)
        and 200
end, {
    music_normal = false,
    music_normal_ante3 = false,
})

add_track("music_normal_ante3_stop", "music_normal_ante3_stop.ogg", function()
    return G.GAME
        and G.GAME.round_resets.blind_states.Boss == 'Defeated'
        and G.GAME.round_resets.ante % 8 == 1
        and 200
end, {
    music_normal = false,
    music_normal_ante3 = false,
})

-- ===== Set 1 (antes 1-4) =====
-- Main menu, Small/Big Blinds (and anything not covered by a higher-priority track below).
add_track("music_normal", "music_normal.ogg", function()
    return 0 -- the original returns G.GAME here (= lowest priority); also used for the main menu
end, {
    music_tarot = true,
    music_planet = true,
    music_shop = true,
    music_boss = true,
    music_spectral = true,
    music_cry_code = true,
    music_normal_ante3 = false,
})

add_track("music_tarot", "music_tarot.ogg", function()
    return in_set1() and G.booster_pack and 50
end)

add_track("music_planet", "music_planet.ogg", function()
    return in_set1() and G.booster_pack_meteors and 100
end)

add_track("music_shop", "music_shop.ogg", function()
    return in_set1() and G.shop and 10
end)

add_track("music_boss", "music_boss.ogg", function()
    return in_set1() and G.GAME.blind and G.GAME.blind.boss and 10
end)

add_track("music_spectral", "music_spectral.ogg", function()
    return in_set1() and G.STATE and (G.STATE == G.STATES.SPECTRAL_PACK) and 100
end)

add_track("music_cry_code", "music_cry_code.ogg", function()
    return in_set1() and cry_code_active() and 100
end)

-- ===== Set 2 (antes 5-8) =====
add_track("music_normal_ante3", "music_normal_ante3.ogg", function()
    return in_set2() and 1
end, {
    music_tarot_ante3 = true,
    music_planet_ante3 = true,
    music_shop_ante3 = true,
    music_boss_ante3 = true,
    music_spectral_ante3 = true,
    music_cry_code_ante3 = true,
    music_normal = false,
})

add_track("music_tarot_ante3", "music_tarot_ante3.ogg", function()
    return in_set2() and G.booster_pack and 49
end)

add_track("music_planet_ante3", "music_planet_ante3.ogg", function()
    return in_set2() and G.booster_pack_meteors and 99
end)

add_track("music_shop_ante3", "music_shop_ante3.ogg", function()
    return in_set2() and G.shop and 9
end)

add_track("music_boss_ante3", "music_boss_ante3.ogg", function()
    return in_set2() and G.GAME.blind and G.GAME.blind.boss and 9
end)

add_track("music_spectral_ante3", "music_spectral_ante3.ogg", function()
    return in_set2() and G.STATE and (G.STATE == G.STATES.SPECTRAL_PACK) and 99
end)

add_track("music_cry_code_ante3", "music_cry_code_ante3.ogg", function()
    return in_set2() and cry_code_active() and 99
end)

 music_nums_ref[mpack_name] = next_music_num_id_ref[1]
 table.insert(music_vals_list_ref, mpack_name)
 pack_display_names_ref[mpack_name] = mpack_display
 next_music_num_id_ref[1] = next_music_num_id_ref[1] + 1
end
