BEGIN {
    print "#include <stdint.h>"
    print ""
    print "int main(void)"
    print "{"
    print "    uint16_t R[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};"
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
        print "l" label_id ":"
        next
    }

    i = NR

    printf "    "

    switch (LINES[i]["values"][0]) { # opcode
        case 0: # Load immediate value into register. (val, dest_reg)
            print "R[" LINES[i]["values"][2] "] = " LINES[i]["values"][1] ";"
            break
        case 1: # Copy value from one register to another. (src_reg, dest_reg)
            print "R[" LINES[i]["values"][2] "] = " "R[" LINES[i]["values"][1] "];"
            break
        case 2: # Add values from two registers and store result in a third register. (src_reg1, src_reg2, dest_reg)
            print "R[" LINES[i]["values"][3] "] = " "R[" LINES[i]["values"][1] "] + " "R[" LINES[i]["values"][2] "]" ";"
            break
        case 3: # Subtract values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
            print "R[" LINES[i]["values"][3] "] = " "R[" LINES[i]["values"][1] "] - " "R[" LINES[i]["values"][2] "]" ";"
            break
        case 4: # Multiply values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
            print "R[" LINES[i]["values"][3] "] = " "R[" LINES[i]["values"][1] "] * " "R[" LINES[i]["values"][2] "]" ";"
            break
        case 5: # Modulo values from two registers and store result in a third. (src_reg1, src_reg2, dest_reg)
            print "R[" LINES[i]["values"][3] "] = " "R[" LINES[i]["values"][2] "] == 0 ? 0 : " "R[" LINES[i]["values"][1] "] % " "R[" LINES[i]["values"][2] "]" ";"
            break
        case 6: # Increment value in a register by 1. (reg)
            print "R[" LINES[i]["values"][1] "] += 1" ";"
            break
        case 7: # Decrement value in a register by 1. (reg)
            print "R[" LINES[i]["values"][1] "] -= 1" ";"
            break
        case 8: # Jump to label. (label)
            print "goto l" LINES[i]["values"][1] ";"
            break
        case 9: # Jump to label if value in register is zero. (reg, label)
            print "if (R[" LINES[i]["values"][1] "] == 0)" " goto l" LINES[i]["values"][2] ";"
            break
        case 10: # Jump to label if value in register is not zero. (reg, label)
            print "if (R[" LINES[i]["values"][1] "] != 0)" " goto l" LINES[i]["values"][2] ";"
            break
    }
}
END {
    print "    return 0;"
    print "}"
}