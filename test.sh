#!/bin/sh -eux
zig test src/hexdump.zig
zig build -Drelease-small=true
OUTDIR=./.test_output
rm -rf $OUTDIR
mkdir $OUTDIR
for i in d20 d29 d32
do
    ./zig-out/bin/hexdump ./testdata/$i.bin > $OUTDIR/$i.hex;
    cmp $OUTDIR/$i.hex ./testdata/$i.hex
done

