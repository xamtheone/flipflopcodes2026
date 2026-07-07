{
    pos = 0
    rw = 0
    split($0, dirs, "")
    for (i = 1; i <= length(dirs); i++) {
        j = length(dirs) - i + 1
        
        pos = move(pos, dirs[i])
        rw = move(rw, dirs[j])
        
        if (pos == rw) h++
    }
}
END {
    print h
}

function move(pos, dir) {
    if (dir == ">") pos = (pos + 1) % 100
    else {
        pos--
        if (pos < 0) pos += 100
    }

    return pos
}