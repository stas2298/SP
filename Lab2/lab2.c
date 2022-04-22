#include <stdio.h>
#include <stdint.h>
#include <stddef.h>


void process(uint32_t *dst, uint32_t *src, size_t n) {

    uint8_t *ptr_dst, *ptr_src;
    size_t i, len;

    ptr_dst = (uint8_t *) dst;
    ptr_src = (uint8_t *) src;
    len = n * sizeof(uint32_t);

    for (i = 0; i < len; ++i) {

        if (ptr_src[i] & 0x80) {
            ptr_dst[i] = ptr_src[i] >> 1;
        }
        else {
            ptr_dst[i] = ptr_src[i];
        }
    }
}

uint32_t sum(uint32_t *src, size_t n) {
    
    uint32_t temp;
    size_t i;

    temp = 0;

    for (i = 0; i < n; ++i) {
        temp += src[i];
    }

    return temp;
}

int main(void) {

    static uint32_t buf1[] = {0x01, 0x80, 0x48000};
    size_t size = sizeof(buf1) / sizeof(uint32_t);
    uint32_t buf2[sizeof(buf1) / sizeof(uint32_t)];

    process(buf2, buf1, size);
    printf("%u\n", sum(buf2, size));

    return 0;
}
