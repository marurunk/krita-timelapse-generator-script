#! /bin/bash

lastframe=$(ls | grep '\.jpg$' | sort | tail -n 1)

frames="${lastframe%.*}"
ceros="${frames%%[1-9]*}"
frames="${frames#"${ceros}"}"

echo "Detectado $frames frames"

while true
do 
	echo "Introducir FPS:"
	read framerate
	time=$(echo "$frames/$framerate" | bc)
	echo "La duracion sera de $time segundos. Proceder? [Y/n]"
	read respond
	if [ "$respond" == "y" ]
	then
		break
	fi
done

touch list.txt
echo "file 'video1.mp4'
file 'video2.mp4'" > list.txt


ffmpeg -framerate $framerate -i %07d.jpg video1.mp4
ffmpeg -loop 1 -i $lastframe -c:v libx264 -t 5 video2.mp4



ffmpeg -f concat -i list.txt -c copy output.mp4

trash video1.mp4 video2.mp4 list.txt

mv output.mp4 ~/Documentos/Export/
