#include <stdint.h>
#include <stdio.h>

int infinite_loops = 0;

int check(int count)
{
    if (count > 5000000) {
        infinite_loops++;
        return 0;
    }
    return 1;
}

int main(void)
{
    uint16_t R[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    for (int c = 0; c < 65536; c++) {
        if (c % 100 == 0) {
            printf("R0 = %d\n", c);
        }
        for (int d = 0; d < 16; d++) {
            for (int i = 0; i < 16; i++) R[i] = 0;
            R[0] = c;
            R[1] = d;
            int count = 0;
            R[2] = 23;
            R[3] = 43;
            R[4] = 32;
            R[5] = 2;
            R[6] = 39;
            R[7] = 24;
            R[15] = 16;
    l0:
    if (!check(count)) continue;
            R[1] = R[1] + R[2];
            R[3] += 1;
            R[0] = R[3] + R[0];
            R[0] = R[0] - R[4];
            R[0] = R[15] == 0 ? 0 : R[0] % R[15];
            count += 6; if (R[0] != 0) goto l5;
    l1:
    if (!check(count)) continue;
            R[1] = R[1] + R[3];
            R[12] = R[1];
            R[12] = R[12] * R[12];
            R[3] = R[3] + R[12];
            R[3] = R[3] + R[4];
            count += 6; if (R[3] != 0) goto l9;
    l2:
    if (!check(count)) continue;
            R[7] = R[3];
            R[7] = R[15] == 0 ? 0 : R[7] % R[15];
            count += 3; if (R[7] == 0) goto l4;
    l3:
    if (!check(count)) continue;
            R[8] = R[3];
            R[8] = R[8] * R[8];
            R[9] = R[8] + R[4];
            R[10] = R[15] == 0 ? 0 : R[9] % R[15];
            R[0] = R[0] - R[10];
            count += 6; if (R[0] != 0) goto l20;
    l4:
    if (!check(count)) continue;
            R[11] = R[7];
            R[11] = R[11] * R[11];
            R[3] = R[11] + R[4];
            R[3] = R[3] + R[2];
            count += 5; if (R[11] != 0) goto l8;
    l5:
    if (!check(count)) continue;
            R[0] = R[0] + R[15];
            R[0] = R[0] - R[2];
            count += 3; if (R[2] != 0) goto l1;
    l6:
    if (!check(count)) continue;
            R[2] = R[0] == 0 ? 0 : R[2] % R[0];
            count += 2; if (R[4] != 0) goto l19;
    l7:
    if (!check(count)) continue;
            R[6] = R[6] - R[0];
            R[4] = R[4] - R[2];
            count += 3; if (R[6] == 0) goto l6;
            count += 4; goto l9;
    l8:
    if (!check(count)) continue;
            R[4] += 1;
            R[15] -= 1;
            count += 3; if (R[15] != 0) goto l7;
    l9:
    if (!check(count)) continue;
            R[0] = R[0] + R[4];
            R[0] = R[0] - R[3];
            count += 3; if (R[0] == 0) goto l15;
    l10:
    if (!check(count)) continue;
            R[15] = R[1];
            R[15] = R[15] * R[1];
            R[15] = R[15] + R[2];
            R[2] = R[10] - R[2];
            R[2] = R[15] + R[2];
            R[15] = R[4] == 0 ? 0 : R[15] % R[4];
            count += 7; if (R[15] != 0) goto l18;
    l11:
    if (!check(count)) continue;
            R[5] = R[3];
            R[5] = R[5] * R[3];
            R[5] = R[5] + R[2];
            R[5] = R[4] == 0 ? 0 : R[5] % R[4];
            count += 5; if (R[5] != 0) goto l3;
    l12:
    if (!check(count)) continue;
            R[0] = R[0] + R[15];
            R[0] = R[0] - R[5];
            count += 3; goto l21;
    l13:
    if (!check(count)) continue;
            R[2] = R[2] + R[4];
            R[3] = R[3] - R[15];
            count += 3; if (R[2] != 0) goto l10;
    l14:
    if (!check(count)) continue;
            R[4] = R[4] + R[5];
            R[1] = R[1] - R[2];
            count += 3; if (R[4] != 0) goto l11;
    l15:
    if (!check(count)) continue;
            R[2] = R[2] + R[3];
            R[15] = R[15] - R[4];
            count += 3; if (R[2] != 0) goto l12;
    l16:
    if (!check(count)) continue;
            R[4] = R[4] + R[0];
            R[5] = R[5] - R[15];
            count += 3; if (R[4] == 0) goto l13;
    l17:
    if (!check(count)) continue;
            R[15] = R[15] + R[1];
            R[3] = R[3] - R[5];
            count += 3; if (R[15] != 0) goto l14;
    l18:
    if (!check(count)) continue;
            R[5] = R[5] + R[2];
            R[0] = R[0] - R[3];
            count += 3; if (R[5] != 0) goto l16;
    l19:
    if (!check(count)) continue;
            R[3] = R[3] + R[4];
            R[2] = R[2] - R[0];
            count += 3; if (R[3] != 0) goto l17;
    l20:
    if (!check(count)) continue;
            R[13] = R[0] - R[5];
            R[14] = R[2] == 0 ? 0 : R[13] % R[2];
            R[0] = R[0] + R[14];
            count += 4; if (R[0] == 0) goto l0;
    l21:
    if (!check(count)) continue;
            R[13] = R[15] - R[3];
            R[14] = R[4] == 0 ? 0 : R[13] % R[4];
            R[2] = R[2] + R[14];
            R[0] = R[0] + R[14];
            R[13] = R[1] - R[2];
            R[14] = R[6] == 0 ? 0 : R[13] % R[6];
            count += 7; if (R[13] != 0) goto l2;
        }
    }
    printf("%d\n", infinite_loops);
    return 0;
}
