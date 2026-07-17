BEGIN { 
    z = 0
    index_cube = 0
}
!is_cubes {
    for (i = 1; i <= NF; i++) numbers[j++] = $i
}
is_cubes {
    j = 0
    for (i = 1; i <= NF; i++) {
        cubes[index_cube][z][j][(i - 1) % 5] = $i
        lut_cubes[$i][index_cube]["z"] = z
        lut_cubes[$i][index_cube]["y"] = j
        lut_cubes[$i][index_cube]["x"] = (i - 1) % 5
        if (i % 5 == 0) j++
    }
    z++
    if (z % 5 == 0) {
        z = 0
        index_cube++
    }
}
/^$/ { is_cubes = 1 }
END {
    for (i = 1; i <= length(numbers); i++) {
        n = numbers[i]
        if (n in lut_cubes) {
            for (index_cube in lut_cubes[n]) {
                z = lut_cubes[n][index_cube]["z"]
                y = lut_cubes[n][index_cube]["y"]
                x = lut_cubes[n][index_cube]["x"]
                cubes[index_cube][z][y][x] = "X"
                bingos = count_bingos(cubes)
                if (bingos >= 5) {
                    print n
                    exit
                }
            }
        }
    }
}

function count_bingos(cubes,
    c, y, x, z, bingos) {
    bingos = 0
    for (c in cubes) {
        diag_cross_front_top_bottom = 0
        diag_cross_front_bottom_up = 0
        diag_cross_back_top_bottom = 0
        diag_cross_back_bottom_up = 0
        for (z = 0; z < 5; z++) {
            if (cubes[c][z][z][z] == "X") diag_cross_front_top_bottom++
            if (cubes[c][z][4 - z][z] == "X") diag_cross_front_bottom_up++
            if (cubes[c][4 - z][z][z] == "X") diag_cross_back_top_bottom++
            if (cubes[c][4 - z][4 - z][z] == "X") diag_cross_back_bottom_up++
            diag_top_bottom = 0
            diag_bottom_up = 0
            for (y = 0; y < 5; y++) {
                if (cubes[c][z][y][y] == "X") diag_top_bottom++
                if (cubes[c][z][4 - y][y] == "X") diag_bottom_up++
                line = 0
                for (x = 0; x < 5; x++) {
                    if (cubes[c][z][y][x] == "X") line++
                }
                if (line == 5) bingos++
            }
            if (diag_top_bottom == 5) bingos++
            if (diag_bottom_up == 5) bingos++
            for (x = 0; x < 5; x++) {
                row = 0
                for (y = 0; y < 5; y++) {
                    if (cubes[c][z][y][x] == "X") row++
                }
                if (row == 5) bingos++
            }
        }

        if (diag_cross_front_top_bottom == 5) bingos++
        if (diag_cross_front_bottom_up == 5) bingos++
        if (diag_cross_back_top_bottom == 5) bingos++
        if (diag_cross_back_bottom_up == 5) bingos++

        for (x = 0; x < 5; x++) {
            
            for (y = 0; y < 5; y++) {
                depth_line = 0
                for (z = 0; z < 5; z++) {
                    if (cubes[c][z][y][x] == "X") depth_line++
                }

                if (depth_line == 5) bingos++
            }
            
        }

        for (y = 0; y < 5; y++) {
            depth_front_diag = 0
            depth_back_diag = 0
            for (x = 0; x < 5; x++) {
                if (cubes[c][y][x][x] == "X") depth_front_diag++
                if (cubes[c][y][x][4 - x] == "X") depth_back_diag++
            }
            if (depth_front_diag == 5) bingos++
            if (depth_back_diag == 5) bingos++
        }

        for (x = 0; x < 5; x++) {
            top_bottom_depth = 0
            bottom_up_depth = 0
            for (y = 0; y < 5; y++) {
                if (cubes[c][y][x][y] == "X") top_bottom_depth++
                if (cubes[c][4 - y][x][y] == "X") bottom_up_depth++
            }
            if (top_bottom_depth == 5) bingos++
            if (bottom_up_depth == 5) bingos++
        }
    }

    return bingos
}

function print_cube(cube,
    z, y, x) {
    for (z = 0; z < 5; z++) {
        for (y = 0; y < 5; y++) {
            for (x = 0; x < 5; x++) {
                printf "%3s ", cube[z][y][x]
            }
            print ""
        }
        print ""
    }               
}