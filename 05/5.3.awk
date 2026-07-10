BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) streets[NR][i] = $i
}
END {
    dirs["^"]["y"] = -1
    dirs[">"]["x"] = 1
    dirs["v"]["y"] = 1
    dirs["<"]["x"] = -1

    b = visit(streets, NF, NR)
    
    for (i = 2; i < NR; i++) {
        for (j = 2; j < NF; j++) {
            og = streets[i][j]
            for (d in dirs) {
                if (d != og) {
                    streets[i][j] = d
                    v = visit(streets, NF, NR)
                    if (v > b) b = v
                }
            }
            streets[i][j] = og
        }
    }
    
    print b
}

function visit(streets, X, Y,
    visited) {
    x = 1
    y = 1
    illegal_turns = 0

    while (1) {
        dir = streets[y][x]

        if (visited[x,y] != "") {
            # Edge
            if (x == 1 || x == X || y == 1 || y == Y) {
                break
            }
    
            if (illegal_turns == 3) break

            switch (dir) {
                case ">": dir = "v"; break
                case "<": dir = "^"; break
                case "v": dir = "<"; break
                case "^": dir = ">"; break
            }
            illegal_turns++
        }

        visited[x,y] = 1
        switch (dir) {
            case ">": x++; break
            case "<": x--; break
            case "v": y++; break
            case "^": y--; break
        }
    }

    return length(visited)
}