#!/usr/bin/env bash
#
# Script bash pour appeler (si disponible) "zenity --entry" pour éditer le message de commit.
#
# Ces deux lignes vides sont là pour faire un joli message de commit, comme cela :
#
# DONE lilian termine, auto commit avec 'make commit_done'
#
# J'ai le chapitre 3, j'ai le héros Mathias

echo -e "\n\n"

type zenity >/dev/null && { zenity --entry \
       --timeout=60 --width=640 --height=440 \
       --title="GBA RPG via GitHub contre Covid-19" \
       --entry-text="J'ai terminé tel chapitre, j'ai recruté tel héros..." \
       --text="Raconte ta session de jeu en quelques lignes maximum :" \
; } || echo "Zenity pas trouvé. Regarde https://github.com/GBA-RPG-via-GitHub-contre-Covid-2020/Fire-Emblem/issues/3 ?"
