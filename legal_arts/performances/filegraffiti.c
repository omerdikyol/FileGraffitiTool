#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <errno.h>
#include <dirent.h>
#include <limits.h> // for PATH_MAX

#define BUF_SIZE 4096 /* !!! exact memory page size, for disk operation efficiency reasons !!! */

int main(int argc, char *argv[])
{
    int fd;

    // Check argument count
    if (argc < 3)
    {
        fprintf(stderr, "Usage: %s <file> <graffiti>", argv[0]);
        exit(2);
    }

    // Check access to file
    if (access(argv[1], W_OK) < 0)
    {
        fprintf(stderr, "Error: source file %s is not accessible (ie it doesn't exist, or I don't have read access, or what?)\t", argv[1]);
        exit(9);
    }

    // Check stat of file
    struct stat st;
    if (stat(argv[1], &st) < 0)
    {
        fprintf(stderr, "Status error for source file %s .\t", argv[1]);
        exit(10);
    }

    // Get length of second argument
    int graffitiLength = strlen(argv[2]);

    // Open file
    if ((fd = open(argv[1], O_RDWR)) < 0)
    {
        perror("open");
        exit(3);
    }

    // Check the size of the file
    int size;
    if ((size = lseek(fd, 0, SEEK_END)) < 0)
    {
        perror("lseek");
        exit(4);
    }

    // If the size of the file is smaller than the length of the graffiti, print error message
    /* the message “CANVAS TOO SMALL\n”, if the size of the file's content is smaller than N, otherwise,
    the message “FILE VANDALIZED: <filepath >\n”, where <filepath> is the name of the modified file. */

    if (size < graffitiLength)
    {
        fprintf(stdout, "CANVAS TOO SMALL\n");
        exit(5);
    }

    // Seek to the last Nth index of file
    if (lseek(fd, -graffitiLength, SEEK_END) < 0)
    {
        perror("lseek");
        exit(7);
    }

    // Write graffiti to file
    if (write(fd, argv[2], graffitiLength) < 0)
    {
        perror("write");
        exit(8);
    }

    // Close file
    if (close(fd) < 0)
    {
        perror("close");
        exit(9);
    }

    // Get absolute path of file
    char path[PATH_MAX];
    strcpy(path, argv[1]);
    if (path == NULL)
    {
        perror("realpath");
        exit(6);
    }
    fprintf(stdout, "FILE VANDALIZED: %s\n", path);

    exit(0);
}
