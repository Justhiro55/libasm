#include "./includes/libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

static void	test_strlen(const char *s)
{
	size_t		expected;
	size_t		actual;
	const char	*result;

	expected = strlen(s);
	actual = ft_strlen(s);
	if (expected == actual)
		result = "OK";
	else
		result = "KO";
	printf("ft_strlen(\"%s\") = %zu | strlen = %zu | %s\n",
		s, actual, expected, result);
}

static void	test_strcpy(const char *src)
{
	char		expected[256];
	char		actual[256];
	char		*ret_expected;
	char		*ret_actual;
	const char	*buf_result;
	const char	*ret_result;

	memset(expected, 'X', sizeof(expected));
	memset(actual, 'X', sizeof(actual));
	ret_expected = strcpy(expected, src);
	ret_actual = ft_strcpy(actual, src);

	if (strcmp(expected, actual) == 0)
		buf_result = "OK";
	else
		buf_result = "KO";

	if (ret_expected == expected && ret_actual == actual)
		ret_result = "OK";
	else
		ret_result = "KO";

	printf("ft_strcpy(\"%s\") -> \"%s\" | strcpy -> \"%s\" | %s (ret %s)\n",
		src, actual, expected, buf_result, ret_result);
}

static int	sign(int n)
{
	if (n > 0)
		return (1);
	if (n < 0)
		return (-1);
	return (0);
}

static void	test_strcmp(const char *s1, const char *s2)
{
	int			expected;
	int			actual;
	const char	*result;

	expected = strcmp(s1, s2);
	actual = ft_strcmp(s1, s2);
	if (sign(expected) == sign(actual))
		result = "OK";
	else
		result = "KO";
	printf("ft_strcmp(\"%s\", \"%s\") = %d | strcmp = %d | %s\n",
		s1, s2, actual, expected, result);
}

static void	test_write(int fd, const char *buf, size_t count)
{
	ssize_t		expected;
	ssize_t		actual;
	int			expected_errno;
	int			actual_errno;
	const char	*result;

	errno = 0;
	expected = write(fd, buf, count);
	expected_errno = errno;
	errno = 0;
	actual = ft_write(fd, buf, count);
	actual_errno = errno;
	if (actual == expected && actual_errno == expected_errno)
		result = "OK";
	else
		result = "KO";
	printf("ft_write(fd=%d, count=%zu) = %zd (errno=%d) | write = %zd (errno=%d) | %s\n",
		fd, count, actual, actual_errno, expected, expected_errno, result);
}

static void	test_read(int fd_expected, int fd_actual, size_t count)
{
	char		buf_expected[128] = {0};
	char		buf_actual[128] = {0};
	ssize_t		ret_expected;
	ssize_t		ret_actual;
	int			errno_expected;
	int			errno_actual;
	const char	*result;

	errno = 0;
	ret_expected = read(fd_expected, buf_expected, count);
	errno_expected = errno;

	errno = 0;
	ret_actual = ft_read(fd_actual, buf_actual, count);
	errno_actual = errno;

	result = "OK";
	if (ret_actual != ret_expected)
		result = "KO";
	if (errno_actual != errno_expected)
		result = "KO";
	if (memcmp(buf_expected, buf_actual, sizeof(buf_expected)) != 0)
		result = "KO";

	printf("ft_read(fd=%d, n=%zu) = %zd (errno=%d) | read = %zd (errno=%d) | %s | buf=\"%s\"\n",
		fd_actual, count, ret_actual, errno_actual,
		ret_expected, errno_expected, result, buf_actual);
}

static void	test_strdup(const char *s)
{
	char		*ret_expected;
	char		*ret_actual;
	const char	*result;

	ret_expected = strdup(s);
	ret_actual = ft_strdup(s);

	result = "OK";
	if (ret_actual == NULL)
		result = "KO";
	if (ret_actual == s)
		result = "KO";
	if (strcmp(ret_expected, ret_actual) != 0)
		result = "KO";

	printf("ft_strdup(\"%s\") -> \"%s\" | strdup -> \"%s\" | %s\n",
		s, ret_actual, ret_expected, result);

	free(ret_expected);
	free(ret_actual);
}

int	main(void)
{
	printf("=== ft_strlen ===\n");
	test_strlen("");
	test_strlen("a");
	test_strlen("Hello, World!");
	test_strlen("42");
	test_strlen("The quick brown fox jumps over the lazy dog");

	printf("\n=== ft_strcpy ===\n");
	test_strcpy("");
	test_strcpy("a");
	test_strcpy("Hello, World!");
	test_strcpy("42 Tokyo");
	test_strcpy("The quick brown fox jumps over the lazy dog");

	printf("\n=== ft_strcmp ===\n");
	test_strcmp("", "");
	test_strcmp("abc", "abc");
	test_strcmp("abc", "abd");
	test_strcmp("abd", "abc");
	test_strcmp("abc", "abcd");
	test_strcmp("abcd", "abc");
	test_strcmp("", "a");
	test_strcmp("a", "");
	test_strcmp("Hello", "World");

	printf("\n=== ft_write ===\n");
	test_write(1, "hello\n", 6);          /* stdout, success */
	test_write(1, "", 0);                  /* zero bytes */
	test_write(-1, "nope\n", 5);           /* invalid fd, EBADF */
	test_write(999, "nope\n", 5);          /* closed fd, EBADF */

	printf("\n=== ft_read ===\n");
	int	fd_expected = open("Makefile", O_RDONLY);
	int	fd_actual = open("Makefile", O_RDONLY);
	test_read(fd_expected, fd_actual, 64);
	close(fd_expected);
	close(fd_actual);

	test_read(-1, -1, 10);

	printf("\n=== ft_strdup ===\n");
	test_strdup("");
	test_strdup("a");
	test_strdup("Hello, World!");
	test_strdup("42 Tokyo");
	test_strdup("The quick brown fox jumps over the lazy dog");
	return (0);
}
