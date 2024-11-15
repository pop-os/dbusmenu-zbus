#!/usr/bin/env bash

set -ex

rm -rfv src
mkdir -p src
pushd src

for file in ../res/*.xml
do
    cargo run --manifest-path ../zbus/zbus_xmlgen/Cargo.toml --release -- file "$file"
done

for file in *.rs
do
    name="$(basename $file .rs)"
    echo "pub mod ${name};" >> lib.rs
done
echo "pub use zbus;" >> lib.rs

popd
