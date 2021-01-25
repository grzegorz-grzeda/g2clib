PROJECT = g2lib

BUILD_DIR = build

SRC = \

INC = \
	inc/types.h

TEST_INC = \
	test/test.h \
	test/types/testTypes.h \

TEST = \
	test/test.c \
	test/types/testTypes.c \

GCC = ccache gcc
AR = ar

####################
TMP = tmp

INC_DIR = $(patsubst %,-I%,$(dir $(INC)))
TEST_INC_DIR = $(patsubst %,-I%,$(dir $(TEST_INC)))
TEST_TARGET = $(TMP)/test_$(PROJECT)

BUILD_INC_DIR = $(patsubst %, -Ibuild/%, $(dir $(INC)))

OBJS = $(patsubst %,$(TMP)/%.o,$(SRC))

$(PROJECT): $(BUILD_DIR) $(OBJS)
	@echo Creating $(PROJECT) library archive in $(BUILD_DIR)/
	@$(AR) -rc $(BUILD_DIR)/$(PROJECT).a $(OBJS) 
	@rm -rf $(TMP)

$(OBJS) : $(SRC)
	@echo Compiling $@
	@mkdir -p $(dir $@)
	@$(GCC) -o $@ -c $(INC_DIR) $< 

$(BUILD_DIR):
	@echo Copying headers to $(BUILD_DIR)/
	@mkdir -p $(BUILD_DIR)
	@cp -r inc/ $(BUILD_DIR)/

clean:
	@echo Cleaning
	@rm -rf $(BUILD_DIR)
	@rm -rf $(TMP)

test: $(TEST_TARGET)
	@echo Testing $(PROJECT)
	@./$(TMP)/test_$(PROJECT)

$(TEST_TARGET): $(PROJECT) $(TEST)
	@echo Compiling test harness for $(PROJECT)
	@mkdir -p $(dir $@)
	@$(GCC) -o $(TMP)/test_$(PROJECT) $(BUILD_INC_DIR) $(TEST_INC_DIR) $(TEST)
	