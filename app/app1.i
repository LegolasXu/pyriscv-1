# 1 "app1.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "app1.c"
int i = 0xdeadbeef;
int row = 0x5a5a5a5a;
int j = 0x12345678;
int charcol = 0xa5a5a5a5;
int fontp = 0x11111111;
int fontp2 = 0x22222222;
int r = 0x33333333;
int pointer = 0;
char screen[4*4*32] = {'s', 'c', 'r', 't', 1, 2, 3, 4, 1, 2, 3, 4, 0x55, 0xaa, 0x55, 0xaa};
char font[]={0x30, 0x78, 0xcc, 0xcc, 0xfc, 0xcc, 0xcc, 0x00 ,
     0xfc, 0x66, 0x66, 0x7c, 0x66, 0x66, 0xfc, 0x00 ,
     0x3c, 0x66, 0xc0, 0xc0, 0xc0, 0x66, 0x3c, 0x00 ,
     0xf8, 0x6c, 0x66, 0x66, 0x66, 0x6c, 0xf8, 0x00 ,
     0xfe, 0x62, 0x68, 0x78, 0x68, 0x62, 0xfe, 0x00 ,
     0xfe, 0x62, 0x68, 0x78, 0x68, 0x60, 0xf0, 0x00 ,
     0x3c, 0x66, 0xc0, 0xc0, 0xce, 0x66, 0x3e, 0x00 ,
     0xcc, 0xcc, 0xcc, 0xfc, 0xcc, 0xcc, 0xcc, 0x00 ,
     0x78, 0x30, 0x30, 0x30, 0x30, 0x30, 0x78, 0x00 ,
     0x1e, 0x0c, 0x0c, 0x0c, 0xcc, 0xcc, 0x78, 0x00 ,
     0xe6, 0x66, 0x6c, 0x78, 0x6c, 0x66, 0xe6, 0x00 ,
     0xf0, 0x60, 0x60, 0x60, 0x62, 0x66, 0xfe, 0x00 ,
     0xc6, 0xee, 0xfe, 0xfe, 0xd6, 0xc6, 0xc6, 0x00 ,
     0xc6, 0xe6, 0xf6, 0xde, 0xce, 0xc6, 0xc6, 0x00 ,
     0x38, 0x6c, 0xc6, 0xc6, 0xc6, 0x6c, 0x38, 0x00 ,
     0xfc, 0x66, 0x66, 0x7c, 0x60, 0x60, 0xf0, 0x00 ,
     0x78, 0xcc, 0xcc, 0xcc, 0xdc, 0x78, 0x1c, 0x00 ,
     0xfc, 0x66, 0x66, 0x7c, 0x6c, 0x66, 0xe6, 0x00 ,
     0x78, 0xcc, 0xe0, 0x70, 0x1c, 0xcc, 0x78, 0x00 ,
     0xfc, 0xb4, 0x30, 0x30, 0x30, 0x30, 0x78, 0x00 ,
     0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xfc, 0x00 ,
     0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0x78, 0x30, 0x00 ,
     0xc6, 0xc6, 0xc6, 0xd6, 0xfe, 0xee, 0xc6, 0x00 ,
     0xc6, 0xc6, 0x6c, 0x38, 0x38, 0x6c, 0xc6, 0x00 ,
     0xcc, 0xcc, 0xcc, 0x78, 0x30, 0x30, 0x78, 0x00 ,
     0xfe, 0xc6, 0x8c, 0x18, 0x32, 0x66, 0xfe, 0x00 ,
};
char hello[]="HELLO WORLD HELLO WORLD";

void printchar(char ch, int row, int col) {
    int k;
    fontp = ch - 'A';
    fontp = fontp << 3;
    r = 128 * row + col;
    fontp2 = fontp + 8;
    for (k = fontp; k < fontp2; k++) {
        r += 16;
        screen[r] = font[k];
    }
}
void putchar(char ch[]) {
    if (ch == '\n') {
        int pointer2 = 0;
        int row = 0;
        pointer2 = pointer;
        while (pointer2 >= 16) {
            pointer2 = pointer2 - 16;
            row++;
        }
        row++;
        pointer = row * 16;
        return;
    }
    if (ch == '\r') {
        pointer = pointer + 16;
        return;
    }
    if (ch == '\t') {
        int pointer2 = 0;
        int row = 0;
        pointer2 = pointer;
        while (pointer2 >= 4) {
            pointer2 = pointer2 - 4;
            row++;
        }
        row++;
        pointer = row * 4;
        return;
    }
    if (ch == ' ') {
        pointer++;
        return;
    }
        int pointer2 = 0;
        int row = 0;
        int col = 0;
        pointer2 = pointer;
        while (pointer2 >= 16) {
            pointer2 = pointer2 - 16;
            row++;
        }
        col = pointer2 - 16;
        printchar(ch, row, col);
        pointer++;
}
void putstr(char ch[]) {
    int curpos = 0;
    while (ch[curpos] != 0) {
        char cur = ch[curpos];
        curpos++;
        putchar(cur);
    }
}
void uart(char inputstr[]) {
    int uarti = 0;
    while (inputstr[uarti] != 0) {
        screen[0] = inputstr[uarti];
        uarti++;
    }
}
void main() {
    pointer = 0;
    putstr(hello);
}
