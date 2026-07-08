{s = 0}
/[a-z]/{s++}
/[A-Z]/{s++}
/[0-9]/{s++}
/7/ && $0 !~ /[012345689]/{s += 7}
{
    split($0, chars, "")

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
}
/red|green|blue/{s *= 3}
{s *= length($0)}
{
    if (s > m) {
        b = $0
        m = s
    }
}
END {print b}