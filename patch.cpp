#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main (void)
{
    FILE * file  = fopen ("pass.com", "rb");
    fseek (file, 0, SEEK_SET);
    long int beginFile = ftell (file);
    fseek (file, 0, SEEK_END);
    long int endFile   = ftell (file);
    long int sizeFile = endFile - beginFile;
    printf ("sizeFile = %ld\n", sizeFile);

    char * fileContent = (char *) calloc (sizeFile, sizeof (char));
    fseek (file, 0, SEEK_SET);

    fread (fileContent, sizeof(char), sizeFile, file);

    FILE * newFile = fopen ("passNew.com", "wb");
    fwrite (fileContent, sizeof(char), sizeFile, newFile);

    long int offset = 198;
    fseek (newFile, offset, SEEK_SET);

    char arr[] = {1};
    
    fwrite (arr, sizeof(char), 1, newFile);

    return 0;

}