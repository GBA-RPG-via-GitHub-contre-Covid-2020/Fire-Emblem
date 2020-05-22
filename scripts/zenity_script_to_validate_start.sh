#!/usr/bin/env bash
#
# Script bash pour appeler (si disponible) "zenity --question" pour valider le commit de fin de jeu.
#

type zenity >/dev/null && { \
zenity --question \
       --timeout=60 --width=440 --height=200 \
       --title="GBA RPG via GitHub contre Covid-19" \
       --text="$(echo -e "Voulez-vous vraiment continuer le jeu depuis cette sauvegarde ?\n\n$(file Fire_Emblem_Europe.sav)\n$(ls -larth Fire_Emblem_Europe.sav)")" \
; } || echo "Zenity pas trouvé. Regarde https://github.com/GBA-RPG-via-GitHub-contre-Covid-2020/Fire-Emblem/issues/3 ?"
