#include<stdlib.h>
#include<stdio.h>

extern int numberwords(char *);
extern void numbersymbols(char *, int *);

int main()
{

    char * sentence = malloc(256);
    printf("Введите предложение: ");
    fflush(stdin);
    fgets(sentence, 256, stdin);
    //printf("%s", sentence);

    int nwords = numberwords(sentence);

    int * nsymbols = malloc(nwords * sizeof(int));
    numbersymbols(sentence, nsymbols);

    printf("%d слов в предложении\n", nwords);
    for(int i = 0; i < nwords; ++i)
    {
        printf("%d символов в слове №%d\n", nsymbols[i], i + 1);
    }

    return 0;
}
