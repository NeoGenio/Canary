cmake_minimum_required(VERSION 3.15)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
project(Canary)

enable_language(ASM-ATT)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS "-ffreestanding -O2 -Wall -Wextra")

file(GLOB BOOT_SRCS bootloader/*.s)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)

add_executable(bootloader.bin ${BOOT_SRCS})
                  SET_TARGET_PROPERTIES(bootloader.bin PROPERTIES LINKER_LANGUAGE C CXX ASM)
                  SET_TARGET_PROPERTIES(bootloader.bin PROPERTIES  LINK_FLAGS " -T ${CMAKE_SOURCE_DIR}/linker.ld -ffreestanding -O2 -nostdlib -lgcc ")
                  set(CMAKE_C_LINK_EXECUTABLE "${CMAKE_C_COMPILER} -o <TARGET> <LINK_FLAGS> <OBJECTS>")

add_custom_target(Canary.img ALL
                  COMMAND dd if=/dev/zero of=${EXECUTABLE_OUTPUT_PATH}/Canary.img bs=512 count=2880
                  COMMAND dd conv=notrunc if=${EXECUTABLE_OUTPUT_PATH}/bootloader.bin of=${EXECUTABLE_OUTPUT_PATH}/Canary.img bs=512 count=1 seek=0
                  DEPENDS bootloader.bin)