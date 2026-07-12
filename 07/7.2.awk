BEGIN { FS = "," }
NR == 1 { split($0, moves, "") }
NR > 2 { sushis[i++][$2][$1] = 1 }
END {
    x = 0
    y = 0
    s = 1
    eaten = 0
    snake[0]["x"] = 0
    snake[0]["y"] = 0

    for (i = 1; i <= length(moves); i++) {
        px = x
        py = y    

        switch (moves[i]) {
            case ">": x++; break
            case "<": x--; break
            case "v": y--; break
            case "^": y++; break
        }

        for (j = s - 1; j >= 0; j--) {
            snake[j]["y"] = snake[j-1]["y"]
            snake[j]["x"] = snake[j-1]["x"]
        }

        snake[0]["x"] = x
        snake[0]["y"] = y

        for (j = 1; j < s; j++) {
            if (snake[j]["y"] == y && snake[j]["x"] == x) {
                print s
                exit
            }
        }

        if (sushis[eaten][y][x] == 1) {
            eaten++
            snake[s]["y"] = py
            snake[s]["x"] = px
            s++
        }
    }
}