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
    q[0]["last_dir"] = ""

    while(length(q)) {
        ny = q[qs]["y"]
        nx = q[qs]["x"]
        l = q[qs]["length"]
        last_dir = q[qs]["last_dir"]
        
        delete q[qs]
        qs++
        visited[nx,ny] = 1

        if (ny == exity && nx == exitx) {
            print l
            break
        }
        
        for (d in dirs) {
            # Use a portal first when turning
            if (d != last_dir) {
                x = nx
                y = ny
                
                while (walls[y + dirs[d]["y"]][x + dirs[d]["x"]] != "#") {
                    x += dirs[d]["x"]
                    y += dirs[d]["y"]
                }

                # Make sure we didn't visit this spot before adding to the queue
                if ((x != nx || y != ny) && visited[x,y] == "") {
                    q[++qe]["y"] = y
                    q[qe]["x"] = x
                    q[qe]["length"] = l + 1
                    q[qe]["last_dir"] = d
                    visited[x,y] = 1
                }
            }

            # Then walk
            x = dirs[d]["x"] + nx
            y = dirs[d]["y"] + ny

            if (walls[y][x] != "#" && visited[x,y] == "") {
                q[++qe]["y"] = y
                q[qe]["x"] = x
                q[qe]["length"] = l + 1
                q[qe]["last_dir"] = d
            }
        }
    }
}