NAME		= libasm.a

SRCS_DIR	= srcs
INC_DIR		= includes
OBJ_DIR		= objs

SRCS		= ft_strlen.s \
			  ft_strcpy.s \
			  ft_strcmp.s \
			  ft_write.s \
			  ft_read.s \
			  ft_strdup.s
OBJS		= $(SRCS:%.s=$(OBJ_DIR)/%.o)

NASM		= nasm
NASM_FLAGS	= -f elf64

AR			= ar
ARFLAGS		= rcs

CC			= cc
CFLAGS		= -Wall -Wextra -Werror -I$(INC_DIR)

TEST		= test_libasm
TEST_SRC	= main.c

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJ_DIR)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(OBJ_DIR):
	mkdir -p $@

test: $(NAME) $(TEST_SRC)
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o $(TEST)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME) $(TEST)

re: fclean all

.PHONY: all clean fclean re test
