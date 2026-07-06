
{ lines[nb++] = $1 }
END {
    for (i in lines) {
        if (i+0 >= nb / 2) continue;
        d = lines[i + nb / 2] - lines[i]
        if (d > 0) {
            a += d
        }
        else {
            a -= d * 5
        }
    }

    print a
}