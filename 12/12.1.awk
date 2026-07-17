BEGIN { index_card = 0 }
!is_cards {
    for (i = 1; i <= NF; i++) numbers[j++] = $i
}
is_cards {
    j = 0
    for (i = 1; i <= NF; i++) {
        cards[index_card][j][(i - 1) % 5] = $i
        lut_cards[$i][index_card]["y"] = j
        lut_cards[$i][index_card]["x"] = (i - 1) % 5
        if (i % 5 == 0) j++
    }
    index_card++
}
/^$/ { is_cards = 1 }
END {

    for (i = 1; i <= length(numbers); i++) {
        n = numbers[i]
        if (n in lut_cards) {
            for (index_card in lut_cards[n]) {
                y = lut_cards[n][index_card]["y"]
                x = lut_cards[n][index_card]["x"]
                cards[index_card][y][x] = "X"
                bingos = count_bingos(cards)
                if (bingos >= 5) {
                    print n
                    exit
                }
            }
        }
    }
}

function count_bingos(cards,
    c, y, x, bingos) {
    bingos = 0
    for (c in cards) {
        diag_top_bottom = 0
        diag_bottom_up = 0
        for (y = 0; y < 5; y++) {
            if (cards[c][y][y] == "X") diag_top_bottom++
            if (cards[c][4 - y][y] == "X") diag_bottom_up++
            line = 0
            for (x = 0; x < 5; x++) {
                if (cards[c][y][x] == "X") line++
            }
            if (line == 5) bingos++
        }
        if (diag_top_bottom == 5) bingos++
        if (diag_bottom_up == 5) bingos++
        for (x = 0; x < 5; x++) {
            row = 0
            for (y = 0; y < 5; y++) {
                if (cards[c][y][x] == "X") row++
            }
            if (row == 5) bingos++
        }
    }

    return bingos
}