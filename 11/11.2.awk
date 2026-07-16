BEGIN {
    PROCINFO["sorted_in"] = "@ind_str_asc"
}
$0 != "" {
    tree = int((NR - 1) / 3)

    for (i = 1; i <= length($0); i += 12) {
        nth_segment = int((i - 1) / 12)

        # top line
        if ((NR - 1) % 3 == 0) {
            top = substr($0, i + 4, 2)
            top_buffer[nth_segment] = top
        }
        else {
            left = substr($0, i, 2)
            id = substr($0, i + 4, 2)
            right = substr($0, i + 8, 2)

            trees[tree][id]["left"] = left
            trees[tree][id]["right"] = right
            trees[tree][id]["top"] = top_buffer[nth_segment]
        }
    }
}
END {
    dirs["left"]["x"] = -1
    dirs["right"]["x"] = 1
    dirs["top"]["y"] = 1

    # all_spaces is for checking collision and energy in a single grid

    for (tree = 0; tree < length(trees); tree++) {
        spaces[tree][0][tree * 10] = "00"
        all_spaces[0][tree * 10] = "00"
    }

    for (year = 1; year <= 100; year++) {
        for (tree = 0; tree < length(trees); tree++) {
            if (trees_dead[tree]) continue

            split("", keys, "")
            for (y in spaces[tree]) {
                for (x in spaces[tree][y]) {
                    keys[y][x] = ""
                }
            }

            for (y in keys) {
                for (x in keys[y]) {
                    
                    id = spaces[tree][y][x]

                    # Nothing to do if previously a stem
                    if (id == "#") continue

                    # Spawn sprouts
                    for (d in dirs) {
                        neighbor_id = trees[tree][id][d]
                        
                        if (neighbor_id == "XX") continue

                        dx = x + dirs[d]["x"]
                        dy = y + dirs[d]["y"]

                        

                        if (dy in spaces[tree] && dx in spaces[tree][dy]) {
                            # "A stem remains a stem forever"
                            if (spaces[tree][dy][dx] == "#") continue

                            # If there's already an id, highest id wins
                            existing_id = spaces[tree][dy][dx]

                            if (neighbor_id < existing_id) continue
                        }
                        # Collision check with other trees
                        else if (dy in all_spaces && dx in all_spaces[dy]) {
                            continue
                        }

                        spaces[tree][dy][dx] = neighbor_id
                        all_spaces[dy][dx] = neighbor_id
                    }

                    # Turns into a stem after growing sprouts
                    spaces[tree][y][x] = "#"
                    all_spaces[y][x] = "#"
                }
            }
        }

        for (tree = 0; tree < length(trees); tree++) {
            if (trees_dead[tree]) continue

            e = 0
            m = 0

            for (y in spaces[tree]) {
                for (x in spaces[tree][y]) {
                    e += get_energy(all_spaces, y, x, year)
                    m++
                }
            }

            energy_left = e - m * 3

            if (year >= 5 && energy_left < 0) {
                trees_dead[tree] = 1
            }
        }
    }

    for (y in all_spaces) {
        total += length(all_spaces[y])
    }
    print total
}

function get_energy(space, y, x, max_y,
    factor, i, height) {
    if (space[y][x] != "#") return 0
    
    factor = 3
    height = y + 1
    if (height > 10) height = 10

    for (i = y + 1; i <= max_y && factor > 0; i++) {
        if (i in space && x in space[i] && space[i][x] == "#") {
            factor--
        }
    }

    return factor * height
}

function print_tree(space, year,
    yy, xx, output, lines) {
    
    # Can set yy to year for just high enough output
    for (yy = 55; yy >= 0; yy--) {
        if (yy in space) {
            for (xx = -10; xx < 250; xx++) {
                if (xx in space[yy]) {
                    printf "%s", space[yy][xx] != "#" ? "@" : "#"
                }
                else {
                    printf " "
                }
            }
        }
        print ""
    }
    print ""
}

# Shows id numbers
function print_tree2(space, year,
    yy, xx, output, lines) {
    
    # Can set yy to year for just high enough output
    for (yy = 55; yy >= 0; yy--) {
        if (yy in space) {
            for (xx = -50; xx < 50; xx++) {
                if (xx in space[yy]) {
                    printf "[%s]", space[yy][xx] != "#" ? space[yy][xx] : "##"
                }
                else {
                    printf "    "
                }
            }
        }
        print ""
    }
    print ""
}