#!/usr/bin/env bash

# Compiling with ghcjs:
stack build --stack-yaml=stack.yaml

# Moving the generated files to the js folder:
mkdir -p js
cp -r $(stack path --local-install-root --stack-yaml=stack-ghcjs.yaml)/bin/app.jsexe/all.js js/
cp -r $(stack path --local-install-root --stack-yaml=stack-ghcjs.yaml)/bin/app.jsexe/all.js.externs js/

# Minifying all.js file using the closure compiler:
cd js

closure-compiler all.js  --compilation_level=ADVANCED_OPTIMIZATIONS  --isolation_mode=IIFE --assume_function_wrapper --jscomp_off="*" --externs=all.js.externs --create_source_map=all.js.min.map > all.min.js

rm all.js all.js.externs

zopfli -i1000 all.min.js
