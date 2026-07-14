BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) {
        if ($i == "#") {
            walls[NR][i] = $i
        }
        else if ($i == "S") {
            starty = NR
            startx = i
        }
        else if ($i == "E") {
            exity = NR
            exitx = i
        }
    }
}
END {
    dirs["UP"]["y"] = -1
    dirs["RIGHT"]["x"] = 1
    dirs["DOWN"]["y"] = 1
    dirs["LEFT"]["x"] = -1

    qs = 0
    qe = 0
    q[0]["y"] = starty
    q[0]["x"] = startx
    q[0]["length"] = 0

    while(length(q)) {
        ny = q[qs]["y"]
        nx = q[qs]["x"]
        l = q[qs]["length"]
        delete q[qs]
        qs++

        visited[nx,ny] = 1

        if (ny == exity && nx == exitx) {
            print l
            break
        }
        
        for (d in dirs) {
            x = dirs[d]["x"] + nx
            y = dirs[d]["y"] + ny

            if (walls[y][x] != "#" && visited[x,y] == "") {
                q[++qe]["y"] = y
                q[qe]["x"] = x
                q[qe]["length"] = l + 1
            }
        }
    }
}

function bfs(startx, starty,
    q, visited, x, y) {
    qs = 0
    qe = 0
    q[0]["y"] = starty
    q[0]["x"] = startx

    while(length(q)) {
        ny = q[qs]["y"]
        nx = q[qs]["x"]
        delete q[qs]
        qs++

        visited[nx,ny] = 1

        if (ny == exity && nx == exitx) break
        
        for (d in dirs) {
            x = dirs[d]["x"] + nx
            y = dirs[d]["y"] + ny

            if (walls[y][x] != "#" && visited[x,y] == "") {
                q[++qe]["y"] = y
                q[qe]["x"] = x
            }
        }
    }

    return length(visited)
}