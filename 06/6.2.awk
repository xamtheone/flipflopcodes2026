BEGIN {
    FS = ""
    PROCINFO["sorted_in"] = "@ind_str_asc"
}
{
    for (i = 1; i <= NF; i++) {
        if ($i == "*") {
            lights[NR][i] = $i
        }
        else if ($i == "#" || $i == "3") {
            gears[NR][i] = "#"
        }
        else if ($i == "S") {
            starty = NR
            startx = i
        }
        else if ($i ~ /[a-z]/) {
            # btinputs[NR][i] = $i
            btinputs[$i]["y"] = NR
            btinputs[$i]["x"] = i
        }
        else if ($i ~ /[A-Z]/) {
            # btoutputs[NR][i] = $i
            btoutputs[$i]["y"] = NR
            btoutputs[$i]["x"] = i
        }
    }
}
END {
    dirs["UP"]["y"] = -1
    dirs["RIGHT"]["x"] = 1
    dirs["DOWN"]["y"] = 1
    dirs["LEFT"]["x"] = -1

    rotate_gears(startx, starty, "L")

    for (btinput in btinputs) {
        bix = btinputs[btinput]["x"]
        biy = btinputs[btinput]["y"]

        btoutput = toupper(btinput)
        
        box = btoutputs[btoutput]["x"]
        boy = btoutputs[btoutput]["y"]

        output = ""
        for (d in dirs) {
            x = dirs[d]["x"] + bix
            y = dirs[d]["y"] + biy

            if (gears[y][x] == "L") {
                output = "R"
                break
            }
            else if (gears[y][x] == "R") {
                output = "L"
                break
            }
        }
        print btoutput, boy, box, output
        if (output != "") {
            for (d in dirs) {
                x = dirs[d]["x"] + box
                y = dirs[d]["y"] + boy

                if (gears[y][x] != "") {
                    rotate_gears(x, y, output)
                }
            }
        }
    }
    
    for (i = 1; i <= NR; i++) {
        for (j = 1; j <= NF; j++) {
            if (gears[i][j] != "") {
                printf gears[i][j]
            }
            else if (lights[i][j] == "*") {
                l = "*"
                for (d in dirs) {
                    dx = dirs[d]["x"]
                    dy = dirs[d]["y"]

                    x = dx + j
                    y = dy + i

                    if (gears[y][x] == "R") {
                        bin = bin "1"
                        l = 1
                        break
                    }
                    else if (gears[y][x] == "L") {
                        bin = bin "0"
                        l = 0
                        break
                    }
                }
                printf l
            }
            else printf "."
            
        }
        print ""
    }
    print bin
    print bin2int(bin)
}

function bin2int(b,
    a, i, v) {
    split(b, a, "")
    for (i = 0; i < length(b); i++) {
        v += 2**(length(b) -1 - i) * a[i+1]
    }

    return v
}

function rotate_gears(startx, starty, start_gear,
    q) {
    qs = 0
    qe = 0
    q[0]["y"] = starty
    q[0]["x"] = startx
    q[0]["gear"] = start_gear

    while(length(q)) {
        gy = q[qs]["y"]
        gx = q[qs]["x"]
        gear = q[qs]["gear"]
        delete q[qs]
        qs++
        gears[gy][gx] = gear
        
        for (d in dirs) {
            dx = dirs[d]["x"]
            dy = dirs[d]["y"]

            x = dx + gx
            y = dy + gy

            if (gears[y][x] == "#") {
                if (gear == "L") next_gear = "R"
                else next_gear = "L"
                q[++qe]["y"] = y
                q[qe]["x"] = x
                q[qe]["gear"] = next_gear
            }
        }
    }
}