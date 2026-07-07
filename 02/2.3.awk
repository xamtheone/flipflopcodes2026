{
    pos = 0
    split($0, dirs, "")
    for (i = 1; i <= length(dirs); i++) {
        j = length(dirs) - i + 1
        
        pos = move(pos, dirs[i] == ">")
        pos = move(pos, dirs[j] == "<")

        wall[pos]++
        if (wall[pos] > m) {
            m = wall[pos]
            mpos = pos
        }
        else if (wall[pos] == m && pos < mpos) {
            mpos = pos
        }
    }
}
END {
    print (mpos + 1) * m
}

function move(pos, forward) {
    if (forward) pos = (pos + 1) % 100
    else {
        pos--
        if (pos < 0) pos += 100
    }

    return pos
}