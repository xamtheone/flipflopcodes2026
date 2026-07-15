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
    q[0]["walked"] = 1
    q[0]["visited"][starty][startx] = 1
    visited[startx,starty] = 1
    m = 800

    while(length(q)) {
        ny = q[qe]["y"]
        nx = q[qe]["x"]
        l = q[qe]["length"]
        last_dir = q[qe]["last_dir"]
        next_to_portal = q[qe]["next_to_portal"]

        split("", this_visited, "")
        for (y in q[qe]["visited"]) {
            for (x in q[qe]["visited"][y]) {
                this_visited[y][x] = 1
            }
        }

        # split("", ancestors, "")
        # for (a = 0; a < length(q[qs]["ancestors"]); a++) {
        #     ancestors[a]["x"] = q[qs]["ancestors"][a]["x"]
        #     ancestors[a]["y"] = q[qs]["ancestors"][a]["y"]
        #     ancestors[a]["steps"] = q[qs]["ancestors"][a]["steps"]
        # }
        
        delete q[qe]
        qe--

        if (l >= m) continue

        if (ny == exity && nx == exitx && l < m) {
            # example: 19
            # example p3: 9
            print l
            m = l

            # for (a = 0; a < length(ancestors); a++) {
            #     print ancestors[a]["y"], ancestors[a]["x"], "steps:", ancestors[a]["steps"]
            # }
            # print exity, exitx
            # print "-"
            continue
        }

        next_to_wall = 0
        for (d in dirs) {
            x = dirs[d]["x"] + nx
            y = dirs[d]["y"] + ny
            if (walls[y][x] == "#") {
                next_to_wall = 1
                break
            }
        }
        
        for (d in dirs) {
            # Use a portal first when next to a wall
            if (next_to_wall) {
                x = nx
                y = ny
                
                while (walls[y + dirs[d]["y"]][x + dirs[d]["x"]] != "#") {
                    x += dirs[d]["x"]
                    y += dirs[d]["y"]
                }

                action_steps = next_to_portal ? 2 : 3

                # Make sure we didn't visit this spot before adding to the queue
                if ((abs(x - nx) > action_steps - 1 || abs(y - ny) > action_steps - 1) && this_visited[y][x] == "") {
                    q[++qe]["y"] = y
                    q[qe]["x"] = x
                    q[qe]["length"] = l + action_steps
                    q[qe]["last_dir"] = d
                    q[qe]["next_to_portal"] = 1
                    q[qe]["steps"] = action_steps

                    for (a = 0; a < length(ancestors); a++) {
                        q[qe]["ancestors"][a]["x"] = ancestors[a]["x"]
                        q[qe]["ancestors"][a]["y"] = ancestors[a]["y"]
                        q[qe]["ancestors"][a]["steps"] = ancestors[a]["steps"]
                    }

                    q[qe]["ancestors"][a]["x"] = nx
                    q[qe]["ancestors"][a]["y"] = ny
                    q[qe]["ancestors"][a]["steps"] = action_steps
                    
                    for (vy in this_visited) {
                        for (vx in this_visited[vy]) {
                            q[qe]["visited"][vy][vx] = 1
                        }
                    }
                    q[qe]["visited"][y][x] = 1
                }
            }

            # Then walk
            x = dirs[d]["x"] + nx
            y = dirs[d]["y"] + ny

            if (walls[y][x] != "#" && this_visited[y][x] == "") {
                q[++qe]["y"] = y
                q[qe]["x"] = x
                q[qe]["length"] = l + 1
                q[qe]["last_dir"] = d
                q[qe]["steps"] = 1


                for (a = 0; a < length(ancestors); a++) {
                    q[qe]["ancestors"][a]["x"] = ancestors[a]["x"]
                    q[qe]["ancestors"][a]["y"] = ancestors[a]["y"]
                    q[qe]["ancestors"][a]["steps"] = ancestors[a]["steps"]
                }

                q[qe]["ancestors"][a]["x"] = nx
                q[qe]["ancestors"][a]["y"] = ny
                q[qe]["ancestors"][a]["steps"] = 1
                
                for (vy in this_visited) {
                    for (vx in this_visited[vy]) {
                        q[qe]["visited"][vy][vx] = 1
                    }
                }
                q[qe]["visited"][y][x] = 1
            }
        }
    }

    
}

function abs(n) {
    return n < 0 ? -n : n
}