# hexdump
A hexdump utility written in zig language.

## Usage
```shell-session
$ ./hexdump 
Usage: ./hexdump input_file
$ ./hexdump ./hexdump |head -5
00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
00000010  02 00 b7 00 01 00 00 00  7c e9 21 00 00 00 00 00  |........|.!.....|
00000020  40 00 00 00 00 00 00 00  00 83 12 00 00 00 00 00  |@...............|
00000030  00 00 00 00 40 00 38 00  08 00 40 00 13 00 11 00  |....@.8...@.....|
00000040  06 00 00 00 04 00 00 00  40 00 00 00 00 00 00 00  |........@.......|
$
```
