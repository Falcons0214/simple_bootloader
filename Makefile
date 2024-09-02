CFILES = $(wildcard *.c)
OFILES = $(CFILES:.c=.o)
GCCLIBPATH = /home/joseph/rpi/arm_toolchain/gcc-arm-toolchain/lib/gcc/aarch64-none-linux-gnu/10.3.1/include/
GCCFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -I${GCCLIBPATH}
GCCPATH = /home/joseph/rpi/arm_toolchain/gcc-arm-toolchain/bin

all: clean kernel8.img

el_switch.o: el_switch.S
	$(GCCPATH)/aarch64-none-linux-gnu-gcc $(GCCFLAGS) -c el_switch.S -o el_switch.o

boot.o: boot.S
	$(GCCPATH)/aarch64-none-linux-gnu-gcc $(GCCFLAGS) -c boot.S -o boot.o

%.o: %.c
	$(GCCPATH)/aarch64-none-linux-gnu-gcc $(GCCFLAGS) -c $< -o $@

kernel8.img: boot.o el_switch.o $(OFILES)
	$(GCCPATH)/aarch64-none-linux-gnu-ld -nostdlib boot.o el_switch.o $(OFILES) -T link.ld -o kernel8.elf
	$(GCCPATH)/aarch64-none-linux-gnu-objcopy -O binary kernel8.elf bootloader.bin

clean:
	/bin/rm kernel8.elf *.o bootloader.bin > /dev/null 2> /dev/null || true