ghdl -a --work=work ./shared/mux2to1.vhd &&
ghdl -a --work=work ./signalProcessing/signalProcessing.vhd &&
ghdl -a --work=work ./signalProcessing/tb_signalProcessing.vhd &&
ghdl -e --work=work tb_signalProcessing &&
ghdl -r --work=work tb_signalProcessing --vcd=tb_signalProcessing.vcd &&
gtkwave tb_signalProcessing.vcd