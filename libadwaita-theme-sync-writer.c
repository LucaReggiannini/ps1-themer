/*

To build use:
    gcc libadwaita-theme-sync-writer.c -o libadwaita-theme-sync-writer

and set bit SUID:
    sudo chown root:root ./libadwaita-theme-sync-writer &&
    sudo chmod u+s ./libadwaita-theme-sync-writer &&
    sudo chmod +x ./libadwaita-theme-sync-writer

*/

#include <stdio.h>
#include <stdlib.h>

int main ( int argc, char **argv) {
	FILE *fptr;
	fptr = fopen("/etc/ps1-luku-theme.config", "w");

	if(fptr == NULL || !argv[1]) {
		return 1;
	}

	if (*argv[1]=='1') {
		fprintf(fptr, "userTheme=dark");
	} else if (*argv[1]=='0') {
		fprintf(fptr, "userTheme= ");
	}

	fclose(fptr);
	return 0;
}
