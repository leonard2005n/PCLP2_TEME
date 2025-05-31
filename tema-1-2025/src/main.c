#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Function that gets the parameters
void get_three(char **a, char **b, char **c, char line[], char delim[])
{
	*c = strtok(line, delim);
	while (!strchr(*c, ';') && !strchr(*c, ')')) {
		*a = *b;
		*b = *c;
		*c = strtok(0, delim);
	}
	(*c)[strlen(*c) - 1] = 0;
}

//Function that prints the variables
void print_variables(char *s)
{
	if (strchr(s, 'a'))
		printf("eax");
	else if (strchr(s, 'b'))
		printf("ebx");
	else if (strchr(s, 'c'))
		printf("ecx");
	else if (strchr(s, 'd'))
		printf("edx");
	else
		printf("%s", s);
}

//Fucntion that prints the move function
void move(char *a, char *b)
{
	printf("MOV ");
	print_variables(a);
	printf(", ");
	print_variables(b);
	printf("\n");
}

//Fucntion that prints the cmp function
void cmp(char *a, char *b)
{
	printf("CMP ");
	print_variables(a);
	printf(", ");
	print_variables(b);
	printf("\n");
}

//Fucntion that prints the logical function
void logical(char *a, char *b, char *c)
{
	if (b[0] == '&')
		printf("AND ");

	if (b[0] == '|')
		printf("OR ");

	if (b[0] == '^')
		printf("XOR ");

	print_variables(a);
	printf(", ");
	print_variables(c);
	printf("\n");
}

//Fucntion that prints the logical function
void add_sub(char *a, char *b, char *c)
{
	if (b[0] == '+')
		printf("ADD ");

	if (b[0] == '-')
		printf("SUB ");

	print_variables(a);
	printf(", ");
	print_variables(c);
	printf("\n");
}

//Function that prints mul function
void mul(char *a, char *b)
{
	if (a[0] == 'a') {
		printf("MUL ");
		print_variables(b);
		printf("\n");
	} else {
		move("a", a);
		printf("MUL ");
		print_variables(b);
		printf("\n");
		move(a, "a");
	}
}

//Function that prints div function
void divide(char *a, char *b)
{
	if (b[0] == '0') {
		printf("Error\n");
	} else if (a[0] == 'a') {
		printf("DIV ");
		print_variables(b);
		printf("\n");
	} else {
		move("a", a);
		printf("DIV ");
		print_variables(b);
		printf("\n");
		move(a, "a");
	}
}

//Function that prints shift function
void shift(char *a, char *b, char *c)
{
	if (b[0] == '>')
		printf("SHR ");
	else
		printf("SHL ");
	print_variables(a);
	printf(", ");
	print_variables(c);
	printf("\n");
}

//Function that prints the jump function
void print_jump(char *b)
{
	if (strstr(b, "==")) {
		printf("JNE");
		return;
	}

	if (b[0] == '>')
		printf("JL");
	else
		printf("JG");

	if (b[1] != '=')
		printf("E");
}

// Function that prints a if function
void if_statement(char *a, char *b, char *c)
{
	cmp(a, c);
	print_jump(b);
	printf(" end_label\n");
}

// Function that close the parentheses
void close_parentheses(char *state)
{
	if (*state == '1') {
		printf("end_label:\n");
	} else if (*state == '2') {
		printf("JMP start_loop\nend_label:\n");
	} else {
		printf("ADD ");
		print_variables(state);
		printf(", 1\n");
		printf("JMP start_loop\nend_loop:\n");
	}
	*state = '0';
}

//Function that prints the while function
void while_statement(char *a, char *b, char *c)
{
	printf("start_loop:\n");
	cmp(a, c);
	print_jump(b);
	printf(" end_label\n");
}

//Function that prints the for statement
void for_statement(char *a, char *b, char *c, char *state)
{
	printf("MOV ");
	print_variables(a);
	printf(", 0\n");
	printf("start_loop:\n");
	cmp(a, c);
	*state = *a;
	print_jump(b);
	printf(" end_label\n");
}

int main(void) {
	char line[50], delim[] = " (", *a, *b, *c, state;
	while (fgets(line, 50, stdin)) {
		line[strlen(line) - 1] = 0;
		if (strstr(line, "if")) {
			state = '1';
			get_three(&a, &b, &c, line, delim);
			if_statement(a, b, c);
		} else if (strchr(line, '}')) {
			close_parentheses(&state);
		} else if (strstr(line, "while")) {
			state = '2';
			get_three(&a, &b, &c, line, delim);
			while_statement(a, b, c);
		} else if (strstr(line, "for")) {
			get_three(&a, &b, &c, line + 11, delim);
			for_statement(a, b, c, &state);
		} else if (strchr(line, '&') || strchr(line, '|') ||
				   strchr(line, '^')) {
			get_three(&a, &b, &c, line, delim);
			logical(a, b, c);
		} else if (strchr(line, '-') || strchr(line, '+')) {
			get_three(&a, &b, &c, line, delim);
			add_sub(a, b, c);
		} else if (strchr(line, '*')) {
			get_three(&a, &b, &c, line, delim);
			mul(a, c);
		} else if (strchr(line, '/')) {
			get_three(&a, &b, &c, line, delim);
			divide(a, c);
		} else if (strchr(line, '<') || strchr(line, '>')) {
			get_three(&a, &b, &c, line, delim);
			shift(a, b, c);
		} else {
			get_three(&a, &b, &c, line, delim);
			move(a, c);
		}
	}
	return 0;
}
