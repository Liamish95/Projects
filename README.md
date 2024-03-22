# **Swapcase Assembly Project**

### **Author:** Liam Moore

### **Student Number:** C00196503

### **License Detail:** This program is licensed under the GNU General Public        License. For more information please visit https://www.gnu.org/licenses/gpl-3.0.en.html#license-text.

# **Project Description**
The aim of this project is to produce to piece of assembly code that will perform a case swap on alphabetic characters, swapping them from uppercase to lowercase and vice versa. It does this by taking a string as input from the user and utilising the ascii values of the characters to determine which operation to carry out, uppercase or lowercase. For example, the string "HELLO world" would become "hello WORLD"

The program does this by comparing the ascii value of the given character to check whether it is between 'a' and 'z' or 'A' and 'Z'. If it falls under one of these conditions then a call is made to a function to carry out the desired operation. The program is also able to deal with non letter characters such as '!' and '?' by simply ignoring them. The swapped output is then displayed back to the user.

# **Instructions on Producing an Executable**

1. Ensure you have installed NASM on your Linux operating system.
   
2. In a terminal window, navigate to the correct directory that contains the desired program.
   
3. Once you are in the correct directory, execute the following commands:
    ```bash
    nasm -f elf64 swapcase.asm -o swapcase.o
    ```
    then 
    ```bash
    ld swapcase.o -o swapcase
    ```
4. Once you have executed those commands, the executable should have been created. You can run the executable by using the command:
    ```bash
    ./swapcase
    ```

5. You should then be able to interact with the program and enter a string as prompted on screen.

# **Notes**
* Please note that this program is only able to accept and inital string of 23 characters in length.
* This program was designed in a Linux environment. User's who wish to run this program in another envrionment may run into issues.

