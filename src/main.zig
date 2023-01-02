const std = @import("std");
const h = @import("hexdump.zig");

pub fn main() !void {
    const alc = std.heap.page_allocator;
    const args = try std.process.argsAlloc(alc);
    defer std.process.argsFree(alc, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} input_file\n", .{args[0]});
        std.os.exit(1);
    }
    const inputfile = std.mem.sliceTo(args[1], 0);
    var file = try std.fs.cwd().openFile(inputfile, .{});
    defer file.close();
    
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    defer bw.flush() catch {};
    const stdout = bw.writer();

    var buf: [16]u8 = undefined;
    var hbuf1: [32]u8 = undefined;
    var hbuf2: [32]u8 = undefined;
    var abuf: [16]u8 = undefined;
    var offset: usize = 0;
    var n: usize = 16;
    while(n == 16) : (offset += n) {
        n = try file.readAll(&buf);
        if (n == 0) {
            try stdout.print("{x:0>8}\n",.{offset});
            break;
        }
        try stdout.print("{x:0>8}  ",.{offset});
        if (n > 8) {
            try stdout.print("{s} {s: <24} |{s}|\n",
                             .{try h.toHex(buf[0..8], &hbuf1), try h.toHex(buf[8..n], &hbuf2), try h.toPrintable(buf[0..n], &abuf)});
        } else {
            try stdout.print("{s: <49} |{s}|\n",
                             .{try h.toHex(buf[0..n], &hbuf1), try h.toPrintable(buf[0..n], &abuf)});
        }
    } else {
        try stdout.print("{x:0>8}\n",.{offset});
    }
}
