return function(music_nums_ref, music_vals_list_ref, pack_display_names_ref, next_music_num_id_ref)

-- "Slowed Down" version of Bonne Soirée. It is the very same audio as the normal Bonne Soirée soundtrack
-- (see ../bonnesoiree/), played at a lower pitch/speed (0.7), so no audio files are duplicated here.
local mpack_name = "bonnesoireeslow"
local audio_folder = "bonnesoiree"
local slow_pitch = 0.7

local mpack_display = "Bonne Soirée (Slowed Down) - Vongola"

SMODS.Sound({ 
    vol = 0.6,
    pitch = slow_pitch,
    key = "bososlow_music1",
    path = audio_folder .. "/boso_music1.ogg",
    select_music_track = function()
        return G.SETTINGS.music_selection == mpack_name and 10 or false
    end,
})

SMODS.Sound({
    vol = 0.6,
    pitch = slow_pitch,
    key = "bososlow_music2",
    path = audio_folder .. "/boso_music2.ogg",
    select_music_track = function()
        return G.SETTINGS.music_selection == mpack_name and (((G.booster_pack_sparkles and not G.booster_pack_sparkles.REMOVED) or (not G.booster_pack_meteors and G.booster_pack and not G.booster_pack.removed)) and 11) or false
    end,
})

SMODS.Sound({
    vol = 0.6,
    pitch = slow_pitch,
    key = "bososlow_music3",
    path = audio_folder .. "/boso_music3.ogg",
    select_music_track = function()
        return G.SETTINGS.music_selection == mpack_name and ((G.booster_pack_meteors and not G.booster_pack_meteors.REMOVED) and 11) or false
    end,
})

SMODS.Sound({
    vol = 0.6,
    pitch = slow_pitch,
    key = "bososlow_music4",
    path = audio_folder .. "/boso_music4.ogg",
    select_music_track = function()
        return G.SETTINGS.music_selection == mpack_name and ((G.shop and not G.shop.REMOVED) and 11) or false
    end,
})

SMODS.Sound({
    vol = 0.6,
    pitch = slow_pitch,
    key = "bososlow_music5",
    path = audio_folder .. "/boso_music5.ogg",
    select_music_track = function()
        return G.SETTINGS.music_selection == mpack_name and ((G.GAME.blind and G.GAME.blind.boss) and 11) or false
    end,
})

 music_nums_ref[mpack_name] = next_music_num_id_ref[1]
 table.insert(music_vals_list_ref, mpack_name)
 pack_display_names_ref[mpack_name] = mpack_display
 next_music_num_id_ref[1] = next_music_num_id_ref[1] + 1
end