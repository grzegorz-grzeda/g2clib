PROJECT = g2lib

BUILD_DIR = build

SRC = \

INC = \
	inc/types.h


GCC = ccache gcc
AR = ar

####################
INC_DIR = $(patsubst %,-I$(dir %),$(INC))

TMP = tmp

OBJS = $(patsubst %,$(TMP)/%.o,$(SRC))

$(PROJECT): $(BUILD_DIR) $(OBJS)
	$(AR) -rc $(BUILD_DIR)/$(PROJECT).a $(OBJS) 
	rm -rf $(TMP)

$(OBJS) : $(SRC)
	mkdir -p $(dir $@)
	$(GCC) -o $@ -c $(INC_DIR) $< 

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	cp -r inc/ $(BUILD_DIR)/

clean:
	rm -rf $(BUILD_DIR)