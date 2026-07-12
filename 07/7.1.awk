BEGIN { FS = "," }
NR == 1 { split($0, moves, "") }
NR > 2 { sushis[i++][$2][$1] = 1 }
END {
    x = 0
    y = 0
    eaten = 0
    for (i = 1; i <= length(moves) / 2; i++) {
        switch (moves[i]) {
            case ">": x++; break
            case "<": x--; break
            case "v": y--; break
            case "^": y++; break
        }

        if (sushis[eaten][y][x] == 1) eaten++
    }

    print eaten
}