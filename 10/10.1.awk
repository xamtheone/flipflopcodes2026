BEGIN {
    LIMIT_16BIT = 2**16
    NB_REGISTERS = 16
    r = 0
    for (i = 0; i < NB_REGISTERS; i++) REGISTERS[i] = 0
}
{
    type = ""
    LINES[NR]["values"][0] = 0
    index_value = 0
    label_id = 0

    for (i = 1; i <= length($0); i += 2) {
        token = substr($0, i, 2)
        if (type == "instruction") {
            if (token == "na") LINES[NR]["values"][index_value]++
            else if (token == "ne") {
                index_value++
                LINES[NR]["values"][index_value] = 0
            }
        }
        else if (type == "label") {
            # Assuming "na"
            label_id++
        }
        else {
            switch (token) {
                case "ba":
                    type = "instruction"
                    break
                case "be":
                    type = "label"
                    break
                default:
                    print "NOT IMPLEMENTED"
            }  
        }
    }

    LINES[NR]["type"] = type

    if (type == "label") {
        LABELS[label_id] = NR
    }
}
END {
    for (i = 1; i <= NR; i++) {
        if (LINES[i]["type"] == "label") continue

        switch (LINES[i]["values"][0]) { # opcode
            case 0: # Load immediate value into register. (val, dest_reg)
                REGISTERS[LINES[i]["values"][2]] = LINES[i]["values"][1]
                break
            case 1: # Copy value from one register to another. (src_reg, dest_reg)
                REGISTERS[LINES[i]["values"][2]] = REGISTERS[LINES[i]["values"][1]]
                break
            case 2: # Add values from two registers and store result in a third register. (src_reg1, src_reg2, dest_reg)
                REGISTERS[LINES[i]["values"][3]] = (REGISTERS[LINES[i]["values"][1]] + REGISTERS[LINES[i]["values"][2]]) % LIMIT_16BIT
                break
            case 3: # Subtract values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
                REGISTERS[LINES[i]["values"][3]] = (REGISTERS[LINES[i]["values"][1]] - REGISTERS[LINES[i]["values"][2]] + LIMIT_16BIT) % LIMIT_16BIT
                break
            case 4: # Multiply values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
                REGISTERS[LINES[i]["values"][3]] = (REGISTERS[LINES[i]["values"][1]] * REGISTERS[LINES[i]["values"][2]]) % LIMIT_16BIT
                break
            case 5: # Modulo values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
                REGISTERS[LINES[i]["values"][3]] = REGISTERS[LINES[i]["values"][2]] == 0 ? 0 : REGISTERS[LINES[i]["values"][1]] % REGISTERS[LINES[i]["values"][2]]
                break
            case 6: # Increment value in a register by 1. (reg)
                REGISTERS[LINES[i]["values"][1]] = (REGISTERS[LINES[i]["values"][1]] + 1) % LIMIT_16BIT
                break
            case 7: # Decrement value in a register by 1. (reg)
                REGISTERS[LINES[i]["values"][1]] = (REGISTERS[LINES[i]["values"][1]] - 1 + LIMIT_16BIT) % LIMIT_16BIT
                break
            case 8: # Jump to label. (label)
                i = LABELS[LINES[i]["values"][1]]
                break
            case 9: # Jump to label if value in register is zero. (reg, label)
                if (REGISTERS[LINES[i]["values"][1]] == 0) {
                    i = LABELS[LINES[i]["values"][2]]
                }
                break
            case 10: # Jump to label if value in register is not zero. (reg, label)
                if (REGISTERS[LINES[i]["values"][1]] != 0) {
                    i = LABELS[LINES[i]["values"][2]]
                }
                break
        }
    }

    print REGISTERS[0]
}