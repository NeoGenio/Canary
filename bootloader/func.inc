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
