#!/bin/sh -eux
if [ $# -eq 0 ]; then
    OPTS=-Doptimize=Debug
else
    OPTS=-Doptimize=$1
fi
zig test $OPTS src/hexdump.zig
zig build $OPTS
OUTDIR=./.test_output
rm -rf $OUTDIR
mkdir $OUTDIR
for i in d20 d29 d32
do
    ./zig-out/bin/hexdump ./testdata/$i.bin > $OUTDIR/$i.hex;
    cmp $OUTDIR/$i.hex ./testdata/$i.hex
done

