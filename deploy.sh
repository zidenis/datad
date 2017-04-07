#!/bin/bash
if [ -d "zidenis.github.io" ]; then
	echo "removing old structure"
	for file in ./zidenis.github.io/*; do
    		[ "$file" = ".git" ] && continue
		[ "$file" = "CNAME" ] && continue
    		rm -rf "$file"
	done
fi
hugo -d zidenis.github.io
