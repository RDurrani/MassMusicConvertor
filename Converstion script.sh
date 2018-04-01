#! /bin/bash
shopt -s globstar
cd $1
for i in **/*.{wma,ra}
do 
	echo "========================================================================================"; echo "========================================================================================";
	echo "Found $i";
	o=$(echo $i | sed -E 's/\.(wma|ra)/\.mp3/');
	echo "Converting to $o";
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
			echo "Error in $i, Exit Code $exitcode">> errors.log
		fi
	echo "done";
	echo "========================================================================================"; echo "========================================================================================";
done
cat errors.log
