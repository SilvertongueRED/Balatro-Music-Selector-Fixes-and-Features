# Balatro Music Selector
Standalone music selector for Balatro with additional soundtracks, fixes, and menu compatibility with Colour/Main Menu Theme Selector.

# DISCLAIMER
I'm NOT a programmer, I helped myself with templates/guides and I tried my best to understand the code because I'm trying to learn Lua in my own way. A lot of the code in this mod comes from [Cardsauce](https://github.com/BarrierTrio/Cardsauce/). Please, support [the original devs](https://github.com/BarrierTrio).

# Why?
I simply wanted to be able to choose different music and add my own, but I didn't want to install Cardsauce in its entirety just for that. So, I identified the chunk of code responsible for that and made it standalone, then I somehow managed to add a way to make it modular (but the procoess is still a little laborious. See the [provided instructions](#how-to-add-your-own-music)) so that everyone can add their own music.<br>
This mod was also heavily inspired by [qvattro0](https://github.com/qvattr0)'s [Balatro Music Replacer](https://github.com/qvattr0/balatro-music-replacer) which, however, is not a mod but an external software to literally replace the music files.

# How it works
It simply adds an extra option in the Audio settings that allows to pick different soundtracks.<br>
The mod allows to [add custom music](#how-to-add-your-own-music) as well.
<img width="971" height="738" alt="image" src="https://github.com/user-attachments/assets/7ee221aa-3348-4396-8b1a-49b6479a54ff" />

# Notes
⚠️ If you have the Cardsauce mod installed, **this mod won't load**. This is by design: since this mod is essentially a piece of the other, I preferred to avoid any issues and conflicts because I currently lack the skills to solve them.<br>
⚠️ If any of the original authors of the soundtracks featured in this mod come forward and ask me to remove their work, **I will comply without question**.<br>
⚠️ For the same reason above, if BarrierTrio asks me to take this mod down, **I will also comply**.<br>
⚠️ The code I came up with is likely spaghetti. I'm sure there are better ways to do all of this but, as I said, I currently lack the skills.

# Credits
❇️ [qvattro0](https://github.com/qvattr0) for the inspiration<br>
❇️ [BarrierTrio](https://github.com/BarrierTrio) for the original code

## Featured soundtracks
❇️ [Cardsauce OST](https://www.youtube.com/watch?v=Swe_WOWdaqQ) by Basscleff ([Cardsauce mod](https://github.com/BarrierTrio/Cardsauce/))<br>
 <sup>↳ [YouTube](https://www.youtube.com/@Bassclefff) | [Bandcamp](https://bassclefff.bandcamp.com) | [Newgrounds](https://bassclefff.newgrounds.com) | [Soundcloud](https://soundcloud.com/bassclefff) | [Twitter](https://x.com/bassclef_3)</sup><br>
❇️ [Balatro: B-Side](https://www.youtube.com/watch?v=_u8tHrRMNG8) by Afterlight ([standalone mod](https://github.com/afterlightgames/b-side))<br>
<sup>↳ [YouTube](https://www.youtube.com/@afterlight_games) | [Bandcamp](https://afterlightgames.bandcamp.com/album/b-side) | [GitHub](https://github.com/afterlightgames)</sup><br>
❇️ [Bonne Soirée](https://www.youtube.com/watch?v=KiIXRr_GGCw) by Vongola<br>
<sup>↳ [YouTube](https://www.youtube.com/@vongol) | [Soundcloud](https://soundcloud.com/vongolavonvongola) | [Ko-Fi](https://ko-fi.com/vonkofi)</sup><br>
❇️ Bonne Soirée (Slowed Down) by Vongola - the same music played slower (pitch 0.7), as a separate option<br>
❇️ [Going In Blind](https://www.youtube.com/watch?v=oRoLuU3vA8E) by Recycled Scraps ([standalone mod](https://github.com/Parsa-ALONE9GHOST/Going-In-Blind))<br>
<sup>↳ [YouTube](https://www.youtube.com/@RecycledScraps)</sup><br>
❇️ Alternative Soundtrack by Hoverman ([standalone mod](https://github.com/hocermanc/balatro_alt_music)) - all 16 tracks, ante-based switching kept<br>
❇️ Cryptid OST by the Cryptid team ([Cryptid mod](https://github.com/SpectralPack/Cryptid)) - all 7 music tracks (menu themes, Code, Jimball, Big, Exotic)<br>
❇️ [Monkey Business](https://www.youtube.com/watch?v=V3ps8wvrmxw) by Bombaflex<br>
 <sup>↳ [YouTube](https://www.youtube.com/@bombaflex2383) | [Spotify](https://open.spotify.com/intl-it/artist/1rL5Ni1ym91shGIswrLhdu) | [Instagram](https://imginn.com/elbombaflex) | [GitHub](https://github.com/Bombaflex) | [Portfolio](https://jbombaron.wixsite.com/bombaflex-portfolio)</sup><br>
❇️ [Raise The Stakes](https://www.youtube.com/watch?v=p6TGmmQ_Fj4) by JohnathanSucks ([standalone mod](https://github.com/JohnathanSucks/Raise-The-Stakes))<br>
<sup>↳ [YouTube](https://www.youtube.com/@johnathansucks7886) | [Bandcamp](https://johnathansucks.bandcamp.com) | [GitHub](https://github.com/JohnathanSucks)</sup>

## Installation
1. Make a copy of the original "balatro.exe" and rename it "balatro_unmodded.exe";<br>
  <sup>ℹ️ This step is optional, but will allow you to keep a vanilla version of the game just in case you may need it.</sup>
2. Install [Lovely](https://github.com/ethangreen-dev/lovely-injector) following the guides below:<br>
  ➡️ [For Windows, Proton and Wine](https://github.com/ethangreen-dev/lovely-injector?tab=readme-ov-file#windows--proton--wine)<br>
  ➡️ [For Mac](https://github.com/ethangreen-dev/lovely-injector?tab=readme-ov-file#mac)
3. Install [Steamodded](https://github.com/Steamodded/smods/) following [this guide](https://github.com/Steamodded/smods/wiki/Installing-Steamodded-windows);
4. Download the latest .zip file from the Releases;
5. Open it with a software like 7-Zip, then drag and drop the folder inside the %AppData&/Balatro/Mods folder.

# How to add your own music
1. Choose a name for your music pack (it must be all lowercase);
2. Create inside "assets/sounds" a folder with the name you chose for the pack;
   - You can also rename the "template" folder, but it's recommended to keep it for future uses.
3. Place inside that folder the music files (in .ogg format) of your choice, being mindful of using these exact names:
   - music1.ogg = main menu, Small and Big Blinds
   - music2.ogg = Standard, Buffoon, Spectral and Arcana Packs
   - music3.ogg = Celestial Packs
   - music4.ogg = Shop
   - music5.ogg = Boss Blinds
4. Copy "mpack_template.lua" from "assets/template" inside your folder;
5. Rename "mpack_template.lua" by replacing "template" with your folder's name;
6. Now open that file and:
   - Replace the string in "mpack_name" with the folder's name (don't delete the quote marks);
   - Replace "\[soundtrack title]" and "\[artist]" with the approriate info (keep the quote marks here as well);
   - Save and close the file.
7. Go back to the mod's root folder ("Music Selector") and open "main.lua";
8. Add your folder's name to "mpack_files", making sure to use quote marks and a comma ("example",), then save and close.

# What I hope to do
🔧 Make an injector for the Cardsauce mod in order to feature extra tracks even with Cardsauce installed.<br>
<sup>🔧 Otherwise, being able to at least override its music selector with this one.</sup>


## 1.2.1 - Slowed Down Bonne Soirée + faster soundtrack switching
- New soundtrack option: **Bonne Soirée (Slowed Down) - Vongola** (the same audio as Bonne Soirée, played at 0.7 speed/pitch; reuses the existing audio files, so no extra disk space).
- Speed fix: the game used to start every music track of every mod at once (80+), but only 64 sounds can play at the same time, so many soundtracks were slow to start or silent until you changed menu tab and chose again. `lovely/sound_limit.toml` now makes the game start only the tracks of the soundtrack that is playing. (Delete that one file to go back to the old behaviour.)
- The Soundtrack cycler's callback is now re-applied after the Audio tab is built, so another mod can no longer take it over.

## 1.1.0 - Lost Edition OST built in
- If the **Lost Edition** mod is installed, its soundtrack now shows up as an option (right after the base Balatro OST) in this mod's Soundtrack cycler.
- Lost Edition's own duplicate "Soundtrack" cycler is hidden, so there is only one selector.
- The selected option is always the soundtrack that plays (the old duplicate selector swapped Balatro and Lost Edition).
