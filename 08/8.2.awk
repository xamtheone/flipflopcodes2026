rules[$1$2] == "" {
    for (i = 3; i <= NF; i++) rules[$1$2] = rules[$1$2] $i
}
END {
    stoats = "AB"
    for (g = 1; g <= 7; g++) {
        for (i = 1; i < length(stoats); i++) {
            stoat1 = substr(stoats, i, 1)
            stoat2 = substr(stoats, i + 1, 1)
            
            evo = rules[stoat1 stoat2]

            if (evo == "") evo = rules[stoat2 stoat1]

            if (i == 1) {
                next_stoats = next_stoats stoat1 evo stoat2
            }
            else {
                next_stoats = next_stoats evo stoat2
            }
        }
        stoats = next_stoats
        next_stoats = ""
    }

    print length(stoats)
}