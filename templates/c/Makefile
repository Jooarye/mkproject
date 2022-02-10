BINARY = main
SOURCE_DIR = src
OBJECT_DIR = bin

CC = gcc
CFLAGS = -Iinclude/ -std=c++20

SOURCE_FILES = $(shell find $(SOURCE_DIR)/ -name *.c)
OBJECT_FILES = $(patsubst $(SOURCE_DIR)/%.c, $(OBJECT_DIR)/%.o, $(SOURCE_FILES))

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.c
	$(CC) $(CFLAGS) -c $^ -o $@

all: $(OBJECT_FILES)
	$(CC) $(CFLAGS) -o $(OBJECT_DIR)/$(BINARY) $(OBJECT_FILES)

clean:
	rm $(OBJECT_DIR)/*
