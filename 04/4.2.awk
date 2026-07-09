/o/ {
    l++
    if (l > 1 && $0 != p) a++
    p = $0
}
END { print a }