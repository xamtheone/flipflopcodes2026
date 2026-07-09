{
    leafs[i++] = $0
}
END {
    for (j = i; j >= 0; j--) {
        if (i - j - 1 > 400 && leafs[j] ~ /o/) a++
    }
    print a
}