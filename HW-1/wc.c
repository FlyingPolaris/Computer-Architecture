#include <stdio.h>
#include <ctype.h>
#include <string.h>
void wc(FILE *ofile, FILE *infile, char *inname) 
{
	char str[999];
	int len;
	int i;
	int flag;
	int word_num, line_num, char_num;
	char ch;
	word_num = line_num = char_num = 0;
	flag = 1;
	infile = fopen(inname,"rb");
	if(infile)
	{
		while(fgets(str,999,infile))
		{
			len = strlen(str);
			for(i = 0;i < len;++i)
			{
				ch = str[i];
				if(ch == ' '||ch == '\t')
				{
					char_num++;
					if(!flag) word_num++;
					flag = 1;
				}
				else if(ch != '\n' && ch != '\r')
				{
					char_num++;
					flag = 0;
				}
			}
			if(!flag) word_num++;
			flag = 1;
			char_num++;
			line_num++;
		}
	}
	fclose(infile);
	printf(" %d %d %d %s\n", line_num, word_num, char_num, inname);
}
int main (int argc, char *argv[]) {
	FILE* infile,* ofile;
	infile = NULL;
	ofile = NULL;
	wc(infile, ofile, argv[1]);
	return 0;
}
