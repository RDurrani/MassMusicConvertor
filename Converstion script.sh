#! /bin/bash
shopt -s globstar
progress=0
total=0
cd $1
for i in **/*.{wma,ra}
do 
	((total++));
done
for i in **/*.{wma,ra}
do 
	((progress++));	
	echo "========================================================================================"; echo "========================================================================================";
	echo "Found ($progress/$total): \"$i\"";
	o=$(echo $i | sed -E 's/\.(wma|ra)/\.mp3/');
	echo "Converting to \"$o\"";
	ffmpeg -i "$i" "$o";
	exitcode=$?; 		
	if [ $exitcode == '0' ]		
		then 
			echo "Removing original"; rm "$i";
		else 
			rm "$o"				
			echo "FAILURE FAILURE FAILURE FAILURE FAILURE"; echo "FAILURE FAILURE FAILURE FAILURE FAILURE"; 
			echo "FAILURE FAILURE FAILURE FAILURE FAILURE"; echo "FAILURE FAILURE FAILURE FAILURE FAILURE";
			echo "FAILURE FAILURE FAILURE FAILURE FAILURE"; echo "FAILURE FAILURE FAILURE FAILURE FAILURE";
			echo "exit code: $exitcode";
			echo "Error in $progress of $total, Filename: \"$i\", Exit Code $exitcode">> errors.log
		fi
	echo "Done ($progress/$total): \"$o\"z";
	echo "========================================================================================"; echo "========================================================================================";
done
cat errors.log
