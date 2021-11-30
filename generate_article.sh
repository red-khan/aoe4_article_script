#!/bin/bash

if [[ -n $1 ]]; then
        path=$1
else
        echo "Please specify the folder with sound files as parameter"
        exit 1
fi

echo "Checking for previous file existence"
if [ -f article.txt ]; then
    echo "Previous file found, deleting"
	rm article.txt
else
	echo "No previous file found, continuing"
fi

c3=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $3}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )
#c4=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $4}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )
#c5=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $5}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )
c6=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $6}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )

echo "Creating article.txt"
for action in ${c3[@]}; do
        printf "\n== $action ==\n" | tee -a article.txt

	if ls "$path"/*_"$action"_*_clowest_* 1> /dev/null 2>&1; then
		echo "=== Dark Age ===" >> article.txt
	fi

	for number in ${c6[@]}; do
		result=$(find $path -type f -name "*_${action}_*_clowest_${number}_*" -printf "{{Audio|%f}} ")
		if [[ -n $result ]]; then
			echo "* $result'''$number'''" >> article.txt
		fi
	done

	if ls "$path"/*_"$action"_*_clow_* 1> /dev/null 2>&1; then
		echo "=== Feudal Age ===" >> article.txt
	fi

	for number in ${c6[@]}; do
		result=$(find $path -type f -name "*_${action}_*_clow_${number}_*" -printf "{{Audio|%f}} ")
		if [[ -n $result ]]; then
			echo "* $result'''$number'''" >> article.txt
		fi
	done
	
	if ls "$path"/*_"$action"_*_cmed_* 1> /dev/null 2>&1; then
		echo "=== Castle Age ===" >> article.txt
	fi

	for number in ${c6[@]}; do
		result=$(find $path -type f -name "*_${action}_*_cmed_${number}_*" -printf "{{Audio|%f}} ")
		if [[ -n $result ]]; then
			echo "* $result'''$number'''" >> article.txt
		fi
	done

	if ls "$path"/*_"$action"_*_chigh_* 1> /dev/null 2>&1; then
		echo "=== Imperial Age ===" >> article.txt
	fi

	for number in ${c6[@]}; do
		result=$(find $path -type f -name "*_${action}_*_chigh_${number}_*" -printf "{{Audio|%f}} ")
		if [[ -n $result ]]; then
			echo "* $result'''$number'''" >> article.txt
		fi
	done

	if ls "$path"/*_"$action"_*_cnone_* 1> /dev/null 2>&1; then
		echo "=== cnone ===" >> article.txt
	fi

	for number in ${c6[@]}; do
		result=$(find $path -type f -name "*_${action}_*_cnone_${number}_*" -printf "{{Audio|%f}} ")
		if [[ -n $result ]]; then
			echo "* $result'''$number'''" >> article.txt
		fi
	done
done
