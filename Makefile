BINARY = mkproject
SOURCE_DIR = src
OBJECT_DIR = bin
TEMPLATE_DIR = templates

CC = g++
CFLAGS = -Iinclude/ -std=c++20 -lboost_filesystem

SOURCE_FILES = $(shell find $(SOURCE_DIR)/ -name *.cpp)
OBJECT_FILES = $(patsubst $(SOURCE_DIR)/%.cpp, $(OBJECT_DIR)/%.o, $(SOURCE_FILES))
TEMPLATE_DIRS = $(shell find $(TEMPLATE_DIR)/ -maxdepth 1 -type d -not -name "$(TEMPLATE_DIR)")
TEMPLATE_FILES = $(patsubst $(TEMPLATE_DIR)/%, $(TEMPLATE_DIR)/%.tar.gz, $(TEMPLATE_DIRS))

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	$(CC) $(CFLAGS) -c $^ -o $@

$(TEMPLATE_DIR)/%.tar.gz: $(TEMPLATE_DIR)/%/
	bash -c "cd $^ && tar -czf "../../$@" *"

all: clean $(OBJECT_FILES) templates
	$(CC) $(CFLAGS) -o $(OBJECT_DIR)/$(BINARY) $(OBJECT_FILES)

install: all templates
	sudo cp $(OBJECT_DIR)/$(BINARY) /bin
	mkdir -p ~/.mkproject/templates/
	cp $(TEMPLATE_FILES) ~/.mkproject/templates/

templates: $(TEMPLATE_FILES)

clean:
	rm $(OBJECT_DIR)/*
	rm $(TEMPLATE_DIR)/*.tar.gz
