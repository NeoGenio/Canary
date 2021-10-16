# This file contains the functions for the bootloader

.func print
print:
    lodsb			# load byte at ds:si into al (advancing si)
    cmp $0, %al   	# test if character is 0 (end)
    je print_done	# jump to end if 0.

    mov $0x0e, %ah  # Subfunction 0xe of int 10h (video teletype output)
    mov $9, %bx     # Set bh (page nr) to 0, and bl (attribute) to white (9)
    int $0x10       # call BIOS interrupt.

    jmp print    	# Repeat for next character.

print_done:
    ret
.endfunc

.func reboot
reboot:
	mov $rebootmsg, %si  # Load address of reboot message into si
	call print   		 # print the string
	mov $0x00, %ah
	mov $0x00, %al
	int $0x16            # wait for a key press
	.byte 0xea           # machine language to jump to ffff:0000 (reboot)
	.word 0x0000
	.word 0xffff
.endfunc
