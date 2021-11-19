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
c4=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $4}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )
c5=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $5}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )
c6=( $(ls -1 $path | sed 's/_/ /g' | awk '{ print $6}' | sort -u | sed ':a; N; $!ba; s/\n/ /g') )

echo "Creating article.txt"
for action in ${c3[@]}; do
        printf "\n=== $action ===\n" | tee -a article.txt

        for voice in ${c4[0]}; do
                echo "==== $voice ====" >> article.txt
                for condition in ${c5[@]}; do

                        if ls "$path"/*_"$action"_"$voice"_"$condition"_* 1> /dev/null 2>&1; then
                                echo "===== $condition =====" >> article.txt
                        fi

                        for number in ${c6[@]}; do
                                result=$(find $path -type f ! -name "*_istealth_*" -name "*_${action}_*_${condition}_${number}_*" -printf "{{Audio|%f}} ")
                                if [[ -n $result ]]; then
                                        echo "* $result'''$condition $number'''" >> article.txt
                                fi
                        done
                done
        done

        for voice in ${c4[2]}; do

		if ls "$path"/*_"$action"_"$voice"_* 1> /dev/null 2>&1; then
                echo "==== $voice ====" >> article.txt
		fi

                for condition in ${c5[@]}; do

                        if ls "$path"/*_"$action"_"$voice"_"$condition"_* 1> /dev/null 2>&1; then
                                echo "===== $condition =====" >> article.txt
                        fi

                        for number in ${c6[@]}; do
                                result=$(find $path -type f -name "*_${action}_istealth_${condition}_${number}_*" -printf "{{Audio|%f}} ")
                                if [[ -n $result ]]; then
                                        echo "* $result'''$condition $number'''" >> article.txt
                                fi
                        done
                done
        done
done
