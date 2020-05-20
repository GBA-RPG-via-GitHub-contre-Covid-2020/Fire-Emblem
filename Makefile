# Makefile to send this page to Zam
SHELL=/usr/bin/env /bin/bash

all:	send
send:	send_zamok
send_zamok:
	CP --exclude=.git ./ ${Szam}publis/GBA-RPG-via-GitHub-contre-Covid-2020.github.io/
send_ovh:
	CP --exclude=.git ./ ${Fovh}publis/GBA-RPG-via-GitHub-contre-Covid-2020-fr.github.io/

check_metadata:	check_file check_md5sum check_dub

check_file:
	file Fire_Emblem_Europe.gba
	cat Fire_Emblem_Europe.gba.file
check_md5sum:
	md5sum Fire_Emblem_Europe.gba
	cat Fire_Emblem_Europe.gba.md5sum
check_dub:
	du -b Fire_Emblem_Europe.gba
	cat Fire_Emblem_Europe.gba.dub

start_playing:
	mgba -6 --savestate Fire_Emblem_Europe.sav Fire_Emblem_Europe.gba

start_playing_mgba:
	mgba -6 --savestate Fire_Emblem_Europe.sav Fire_Emblem_Europe.gba

start_playing_mgba_old:
	mgba -6 Fire_Emblem_Europe.gba

start_playing_qt:
	mgba-qt -6 --savestate Fire_Emblem_Europe.sav Fire_Emblem_Europe.gba

start_playing_vba:
	vba --video-4x Fire_Emblem_Europe.gba

play:	check_free_slot commit_start start_playing commit_done
play_mgba_old:	check_free_slot commit_start start_playing_mgba_old commit_done
play_mgba:	check_free_slot commit_start start_playing_mgba commit_done
play_vba:	check_free_slot commit_start start_playing_vba commit_done

check_free_slot:
	git pull
	! git log -1 | grep -q START
	echo "The slot is free. Let's play!"

commit_start:
	# ./scripts/zenity_script_to_validate_start.sh
	echo "START `whoami` commence à `date`, auto commit avec 'make commit_start'" | tee --append whoPlayedWhen.log
	./scripts/update_readme_start.sh
	git add whoPlayedWhen.log README.md
	git commit -m "START `whoami` commence, auto commit avec 'make commit_start'"
	git push

commit_done:
	./scripts/zenity_script_to_validate_end.sh
	echo "DONE `whoami` termine à `date`, auto commit avec 'make commit_done'" | tee --append whoPlayedWhen.log
	./scripts/update_readme_done.sh
	git add whoPlayedWhen.log README.md
	git add Fire_Emblem_Europe.sav
	git add screenshots*/*.png
	git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'`./scripts/zenity_script_to_enter_summary.sh`" || git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'"
	git push


clean_screenshots:
	# first screenshots of in game moments
	exiftool -v2 -fast -overwrite_original_in_place ./screenshots/*.png
	advpng -z -2 ./screenshots/*.png
