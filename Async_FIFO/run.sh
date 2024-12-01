#compilation

vcs -full64 -sverilog -debug_access+all -kdb list.svh -cm line+cond+fsm+tgl+branch+assert

#simulation

./simv -cm line+cond+fsm+tgl+branch+assert
