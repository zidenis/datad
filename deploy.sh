#!/bin/bash
if [ -d "zidenis.github.io" ]; then
	cd zidenis.github.io
	echo "deleting old structure ..."
	for file in *; do
    		[ "$file" = ".git" ] && continue
		[ "$file" = "CNAME" ] && continue
		echo "removing $file"
    		rm -rf "$file"
	done
	cd ..
fi
hugo -d zidenis.github.io
