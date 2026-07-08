{s = 0}
/[a-z]/{s++}
/[A-Z]/{s++}
/[0-9]/{s++}
{s *= length($0)}
{
    if (s > m) {
        b = $0
        m = s
    }
}
END {print b}