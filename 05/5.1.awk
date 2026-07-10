BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) streets[NR][i] = $i
}
END {
    x = 1
    y = 1
    while (visited[x,y] == "") {
        visited[x,y] = 1
        switch (streets[y][x]) {
            case ">": x++; break
            case "<": x--; break
            case "v": y++; break
            case "^": y--; break
        }
    }
    print length(visited)
}