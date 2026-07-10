BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) streets[NR][i] = $i
}
END {
    dirs["^"]["y"] = -1
    dirs[">"]["x"] = 1
    dirs["v"]["y"] = 1
    dirs["<"]["x"] = -1
    
    b = visit(streets)
    
    for (i = 2; i < NF; i++) {
        for (j = 2; j < NR; j++) {
            og = streets[j][i]
            for (d in dirs) {
                if (d != og) {
                    streets[j][i] = d
                    v = visit(streets)
                    if (v > b) b = v
                }
            }
            streets[j][i] = og
        }
    }
    
    print b
}

function visit(streets,
    visited) {
    x = 1
    y = 1
    while (visited[x,y] == "") {
        visited[x,y] = 1
        switch (streets[y][x]) {
            case ">": x++; break
            case "<": x--; break
            case "v": y++; break
            case "^": y--; break
        }
    }
    return length(visited)
}