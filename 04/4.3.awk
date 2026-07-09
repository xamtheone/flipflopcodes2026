/o/ {
    leafs[i++] = $0
}
END {
    while (length(leafs) > 0) {
        split("", copy, "")
        k = 0
        for (j = length(leafs) - 1; j > 0; j--) {
            if (leafs[j - 1] == leafs[j]) {
                copy[k++] = leafs[j]
            }
        }

        # we're done pruning leaves
        if (k+1 == length(leafs)) {
            workers += k+1
            break
        }

        split("", leafs, "")
        for (i = length(copy) - 1; i >= 0; i--) {
            leafs[length(copy) - i - 1] = copy[i]
        }

        workers++
    }
    print workers
}