ghdl -a --work=work ./shared/mux2to1.vhd &&
ghdl -a --work=work ./shared/syncRegister.vhd &&
ghdl -a --work=work ./syncSignalProcessing/syncSignalProcessing.vhd &&
ghdl -a --work=work ./syncSignalProcessing/tb_syncSignalProcessing.vhd &&
ghdl -e --work=work tb_syncSignalProcessing &&
ghdl -r --work=work tb_syncSignalProcessing --vcd=tb_syncSignalProcessing.vcd &&
gtkwave tb_syncSignalProcessing.vcd