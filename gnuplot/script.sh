#!/bin/bash

while read -r line1;do
	while read -r line2;do
		for param in $line1;do
			for thread in $line2;do
				for i in $(seq 1 100);do
					./App $param $thread 
				done
			done
		done
	done < "$2"
done < "$1"

