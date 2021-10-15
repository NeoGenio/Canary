.code16
.text
.org 0x0

.global main

main:
	jmp start                       # jump to beginning of code
	nop

.include "../bootloader/func.inc"

start:
    # Clear the screen
    mov $0x00, %ah
    mov $0x03, %al # Set video mode (80x25 text mode, 16 colors)
    int $0x10

    # Display message
    mov $msg, %si
    call print

msg: .asciz "Hello world!"

.fill (510-(.-main)), 1, 0  # Pad with nulls up to 510 bytes (excl. boot magic)
.word 0xaa55                # magic word for BIOS
