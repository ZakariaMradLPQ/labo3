ghdl -a --work=work ./shared/syncRegister.vhd &&
ghdl -a --work=work ./eightBitCounter/eightBitCounter.vhd &&
ghdl -a --work=work ./eightBitCounter/tb_eightBitCounter.vhd &&
ghdl -e --work=work tb_eightBitCounter &&
ghdl -r --work=work tb_eightBitCounter --vcd=tb_eightBitCounter.vcd &&
gtkwave tb_eightBitCounter.vcd