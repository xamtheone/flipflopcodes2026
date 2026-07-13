rules[$1] == "" {
    for (i = 2; i <= NF; i++) rules[$1] = rules[$1] $i
}
END {
    stoats = "AB"
    for (g = 1; g <= 7; g++) {
        for (i = 1; i <= length(stoats); i++) {
            stoat = substr(stoats, i, 1)
            evo = rules[stoat]
            next_stoats = next_stoats evo
        }
        stoats = next_stoats
        next_stoats = ""
    }

    print length(stoats)
}