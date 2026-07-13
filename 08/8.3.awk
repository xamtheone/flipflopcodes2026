rules[$1$2] == "" {
    for (i = 3; i <= NF; i++) rules[$1$2] = rules[$1$2] $i
}
END {
    print evolve("AB", 21, 0)
}

function evolve(stoats, generations, depth,
    i, r, l, pair, next_stoats) {

    if (depth == generations) return length(stoats)

    for (i = 1; i < length(stoats); i++) {
        stoat1 = substr(stoats, i, 1)
        stoat2 = substr(stoats, i + 1, 1)

        pair = stoat1 stoat2
        
        evo = rules[pair]

        if (evo == "") {
            evo = rules[stoat2 stoat1]
        }

        next_stoats = stoat1 evo stoat2

        if (MEMO[next_stoats][generations - depth] != "") {
            r = MEMO[next_stoats][generations - depth]
        }
        else {
            r = evolve(next_stoats, generations, depth + 1)
            MEMO[next_stoats][generations - depth] = r
        }

        if (i > 1) r -= 1

        l += r
    }

    return l
}