{
    split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", achars, "")

    for (j = 1; j <= length(achars); j++) {
        pw = $0 achars[j]
        s = 0
        if (pw ~ /[a-z]/) s++
        if (pw ~ /[A-Z]/) s++
        if (pw ~ /[0-9]/) s++
        if (pw ~ /7/ && pw !~ /[012345689]/) s += 7

        split(pw, chars, "")

        msub = 0
        lsub = 1
        for (i = 2; i <= length(chars); i++) {
            if (chars[i] == chars[i-1]) {
                lsub++
            }
            else {
                if (lsub >= 3 && lsub > msub) {
                    msub = lsub
                }
                lsub = 1
            }
        }
        if (lsub >= 3 && lsub > msub) {
            msub = lsub
        }
        s += msub ** 2

        if (pw ~ /red|green|blue/) s *= 3
        s *= length(pw)

        totals[achars[j]] += s
    }
}
END {
    m = 0
    for (i in totals) {
        if (totals[i] > m) m = totals[i]
    }
    print m
}