.code16
.text
.org 0x0

.global main

main:
	jmp start                       # jump to beginning of code
	nop

.include "../bootloader/bpb.inc"
.include "../bootloader/func.inc"

start:
    # Setup segments:
    cli
    mov %dl, iBootDrive  # save what drive we booted from (should be 0x0)
    mov %cs, %ax         # cs = 0x0, since that's where boot sector is (0x07c00)
    mov %ax, %ds         # cs = cs = 0x0
    mov %ax, %es         # cs = cs = 0x0
    mov %ax, %ss         # cs = cs = 0x0
    mov $0x7c00, %sp     # Stack grows down from offset 0x7c00 toward 0x0000.
    sti

    # Clear the screen
    mov $0x00, %ah
    mov $0x03, %al # Set video mode (80x25 text mode, 16 colors)
    int $0x10

    # Reset disk system
    # Jump to bootFailure on error
    mov iBootDrive, %dl   # drive to reset
    mov $0x00, %ah
    mov $0x00, %al
    int $0x13
    jc bootFailure        # display error message if carry set (error)

    # Display message if successful
    mov $msg, %si
    call print

    # Reboot
    call reboot

bootFailure:
    mov $diskerror, %si
    call print
    call reboot

# Program Data
msg:        .asciz "Disk reset successfully\r\n"
diskerror:  .asciz "(PANIC) Disk error\r\n"
rebootmsg:  .asciz "Press any key to reboot..."

.fill (510-(.-main)), 1, 0  # Pad with nulls up to 510 bytes (excl. boot magic)
.word 0xaa55                # magic word for BIOS
