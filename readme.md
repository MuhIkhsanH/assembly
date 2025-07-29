** Assembly Windows 11 With NASM and GCC


```
nasm -f win64 hello.asm -o hello.obj
gcc hello.obj -o hello.exe -lkernel32 -mconsole -Wl,-entry=main
```
