#!/bin/bash
set -xue

sh build.sh

# QEMU 실행 파일 경로
QEMU=qemu-system-riscv32

(cd disk && tar cf ../disk.tar --format=ustar *.txt)   

# QEMU 실행
$QEMU -machine virt -bios default -nographic -serial stdio \
      -monitor telnet:127.0.0.1:1234,server,nowait --no-reboot \
	  -drive id=drive0,file=disk.tar,format=raw,if=none \
      -device virtio-blk-device,drive=drive0,bus=virtio-mmio-bus.0 \
	  -kernel kernel.elf
# telnet localhast 1234