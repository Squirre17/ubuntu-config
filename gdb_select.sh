#!/bin/bash
peda="source /home/squ/tools/gdb-tools/peda/peda.py"
pwndbg="source /home/squ/tools/pwndbg/gdbinit.py"
gef="source /home/squ/tools/gef/gef.py"
function usage() {

    echo -e "\033[1;31m[!]\033[0m first argument error\n" \
            "\t-r\traw\n"                                 \
            "\t-g\tgef\n"                                 \
            "\t-d\tpwndbg\n"                              \
            "\t-p\tpeda"
    exit 1
}
echo -e "\033[34m[+]\033[0m GDB select script launching..."
cmd="source /home/squ/tools/Pwngdb/pwngdb.py\n"

rcmd="set pagination off\n"
rcmd=$rcmd"set confirm off\n"
rcmd=$rcmd"set disassembly-flavor intel\n"
rcmd=$rcmd"set print pretty\n"

if [ $# -eq 0 ]; then
	usage
fi
if [ $1 == '-p' -o $1 == 'p' -o $1 == '--peda' ];then
    cmd=$cmd$peda
    echo -e "$cmd" > /home/squ/.gdbinit
    shift
    gdb -q $@
elif [ $1 == '-g' -o $1 == 'g' -o $1 == '--gef' ];then
    cmd=$cmd$gef
    echo -e "$cmd" > /home/squ/.gdbinit
    shift
    gdb -q $@
elif [ $1 == '-d' -o $1 == 'd' -o $1 == '--pwndbg' ];then
    # seeming there have execute order
    cmd=$pwndbg"\n"$cmd
    echo -e "$cmd" > /home/squ/.gdbinit
    shift
    gdb -q $@
elif [ $1 == '-r' -o $1 == 'r' -o $1 == '--raw' ];then
    echo -e $rcmd > /home/squ/.gdbinit
    shift
    gdb -q $@
else
	usage
fi
