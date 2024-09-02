#include "io.h"
#include "utils.h"
#include "device_tree.h"

extern int switch_el2_to_el1(unsigned long el1_stack_addr);


void user_task1() {
    char buf[64] = "Hello Exception !\n";
    mn_uart_write_txt(buf);
}

void main() {
    // unsigned long dtb_addr = get_dtb_base_addr();
    mn_uart_init();
    mn_uart_write_txt("\033[2J\033[H");
    mn_uart_write_txt("This is Bootloader !!\n");

    unsigned long curEL;
    curEL = get_current_el();
    mn_uart_write_hex(curEL);
    mn_uart_write_txt("\n");

    switch_el2_to_el1(0x15000000);

    curEL = get_current_el();
    mn_uart_write_hex(curEL);
    mn_uart_write_txt("\n");

    // user_task1();

    return;
}