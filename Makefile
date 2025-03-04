CLIENT = client

SERVER = server

CLT_SRC =	utils.c\
			client.c\

SRV_SRC =	utils.c\
			server.c\

CLT_OBJ = $(CLT_SRC:.c=.o)

SRV_OBJ = $(SRV_SRC:.c=.o)

CC = gcc

CFLAGS += -Wall -Werror -Wextra -g3 -fsanitize=address

#CFLAGS += -g3 -fsanitize=address

RM = rm -rf

all: $(CLIENT) $(SERVER) echoOK
	$(CC) $(CFLAGS) $(CLT_OBJ) -o $(CLIENT)
	$(CC) $(CFLAGS) $(SRV_OBJ) -o $(SERVER)

$(CLIENT): $(CLT_OBJ) echoClient
	$(CC) $(CLT_SRC) -c

$(SERVER): $(SRV_OBJ) echoServer
	$(CC) $(SRV_SRC) -c

%.o:		%.c
	$(CC) -c $(CFLAGS) -o $@ $<
	printf "$(GREEN)██"

clean:
	$(RM) $(CLT_OBJ) $(SRV_OBJ)

fclean: clean echoFCLEAN
	$(RM) $(CLIENT) $(SERVER)

re:		fclean all

leaks:
	valgrind --leak-check=full --show-leak-kinds=all ./$(NAME)

git:
	make fclean
	git add .
	git commit -m "make done"
	git push

norme:
	norminette ./*.c ./minitalk.h

.PHONY:		all clean fclean re leaks git norme
.SILENT:

##############______________Colors______________##############

RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
END = \033[0m

##############______________MESSAGES______________##############

echoServer:
	echo "$(YELLOW)===> Compiling $(RED)Server$(END)\n"
echoClient:
	echo "$(YELLOW)===> Compiling $(RED)Client$(END)\n"
echoOK:
	echo "$(GREEN) OK ===> Compilation Success$(END)\n"
echoCLEAN :
	echo "\n$(CYAN)===> Cleanning OBJS$(END)\n"
echoFCLEAN :
	echo "$(CYAN)===> Cleanning Client, Server & Libft$(END)\n"
