#include "./includes/libasm.h"
#include <stdio.h>
#include <string.h>

static void	test_strlen(const char *s)
{
	size_t	expected;
	size_t	actual;

	expected = strlen(s);
	actual = ft_strlen(s);
	printf("ft_strlen(\"%s\") = %zu | strlen = %zu | %s\n",
		s, actual, expected,
		expected == actual ? "OK" : "KO");
}

int	main(void)
{
	printf("=== ft_strlen ===\n");
	test_strlen("");
	test_strlen("a");
	test_strlen("Hello, World!");
	test_strlen("42");
	test_strlen("The quick brown fox jumps over the lazy dog");
	return (0);
}
