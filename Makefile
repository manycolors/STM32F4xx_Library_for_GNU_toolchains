#  Project Name
PROJECT=stm32f4_stdperiph

#  List of the objects files to be compiled/assembled

SUBDIRS := src


SOURCES:=$(wildcard src/*.c)

OBJECTS:=$(SOURCES:.c=.o)
OPTIMIZATION = -Os -fno-schedule-insns2 -fsection-anchors -fpromote-loop-indices -ffunction-sections -DPREFER_SIZE_OVER_SPEED -D__OPTIMIZE_SIZE__ -fomit-frame-pointer -fno-unroll-loops -D__BUFSIZ__=256 -mabi=aapcs
#DEBUG = -g

#  Compiler Options
GCFLAGS = -Wall -mcpu=cortex-m4 -mfloat-abi=softfp -mthumb $(OPTIMIZATION) $(DEBUG) 
GCFLAGS += -I./inc
LDFLAGS = -static -mcpu=cortex-m4 -mfloat-abi=softfp -mthumb $(OPTIMIZATION)
#LDFLAGS += -L/Users/shota/Developer/Cross/arm-cs-tools-2011.09-69-0084249-20120622/arm-none-eabi/lib/thumb2/
ASFLAGS = -mcpu=cortex-m4 --defsym RAM_MODE=0
START =  -Wl,-Map=$(PROJECT).map -T$(LSCRIPT)
MAKE_FLAGS = --no-print-directory CC='$(CC)' LL='$(LL)' ALL_CFLAGS='$(ALL_CFLAGS)'

#  Compiler/Assembler/Linker Paths
GCC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
STRIP = arm-none-eabi-strip
OBJDUMP = arm-none-eabi-objdump
REMOVE = rm -f
SIZE = arm-none-eabi-size

#########################################################################
.PHONY: all
all: $(OBJECTS)
	$(AR) r libstm32f4_stdperiph.a $(OBJECTS)
#	@$(MAKE) -C src $(MAKE_FLAGS)
#	

clean:
	$(REMOVE) $(OBJECTS)
	$(REMOVE) lib$(PROJECT).a
	$(REMOVE) lib$(PROJECT).a

#########################################################################
#  Default rules to compile .c and .cpp file to .o
#  and assemble .s files to .o

.c.o :
	$(GCC) $(GCFLAGS) -c $< -o $@

.cpp.o :
	$(GCC) $(GCFLAGS) -c $<

.S.o :
	$(AS) $(ASFLAGS) -o $@ $<

#########################################################################