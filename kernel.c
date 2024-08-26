#include "io.h"
#include "utils.h"

void main() {
    mn_uart_init();
    mn_uart_write_txt("\033[2J\033[H");
    mn_uart_write_txt("This is Bootloader !\n");
    simple_shell();
    return;
}