// 在 M1 上移除 PIE flag 无法运行，已经关闭SIP和移除签名：
//  错误日志：[/usr/libexec/taskgated] no signature for pid=2333 (cannot make code: UNIX[No such process])

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <mach-o/loader.h>

int main(int argc, char *argv[])
{
    struct mach_header currentHeader;
    FILE *fp;

    if (argc < 1)
    {
        printf("Please enter the filename binary: in the format removePIE filename.\n");
        return EXIT_FAILURE;
    }
    if ((fp = fopen(argv[1], "rb+")) == NULL)
    {
        printf("Error unable to open file.\n");
        return EXIT_FAILURE;
    }

    if (0 == fread(&currentHeader, sizeof(currentHeader), 1, fp))
    {
        printf("Error reading MACH-O header.\n");
        return EXIT_FAILURE;
    }

    if (currentHeader.magic == MH_MAGIC || currentHeader.magic == MH_MAGIC_64)
    {
        printf("patch MH_MAGIC/MH_MAGIC_64.\n");
        currentHeader.flags &= ~MH_PIE;

        fseek(fp, 0, SEEK_SET);
        if ((fwrite(&currentHeader, sizeof(currentHeader), 1, fp)) == (uintptr_t)NULL)
        {
            printf("Error writing to file.\n");
        }
        printf("ASLR has been disabled for %s\n", argv[1]);
        fclose(fp);

        return EXIT_SUCCESS;
    }
    else if (currentHeader.magic == MH_CIGAM || currentHeader.magic == MH_CIGAM_64) // big endian
    {
        printf("patch MH_CIGAM/MH_CIGAM_64.\n");
        // OSSwapInt32 -> 大端转换
        uint32_t flags = OSSwapInt32(currentHeader.flags);
        flags &= ~MH_PIE;
        currentHeader.flags = OSSwapInt32(flags);

        fseek(fp, 0, SEEK_SET);
        if ((fwrite(&currentHeader, sizeof(currentHeader), 1, fp)) == (uintptr_t)NULL)
        {
            printf("Error writing to file.\n");
        }
        printf("ASLR has been disabled for %s\n", argv[1]);
        fclose(fp);

        return EXIT_SUCCESS;
    }
    else // FAT_MAGIC/FAT_CIGAM
    {
        printf("not supported.\n");
        return EXIT_FAILURE;
    }

    return EXIT_FAILURE;
}