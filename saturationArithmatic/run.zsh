ghdl -a --work=work ./shared/mux2to1.vhd &&
ghdl -a --work=work ./saturationArithmatic/saturationArithmatic.vhd &&
ghdl -a --work=work ./saturationArithmatic/tb_saturationArithmatic.vhd &&
ghdl -e --work=work tb_saturationArithmatic &&
ghdl -r tb_saturationArithmatic --vcd=./saturationArithmatic/tb_saturationArithmatic.vcd &&
gtkwave ./saturationArithmatic/tb_saturationArithmatic.vcd