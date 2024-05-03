`timescale 1ns / 1ps


module MBistController_TB();
parameter AWIDTH = 4;

reg clk;
reg test_mode;
reg rst;
reg [1:0]fault;

wire bist_status;

MBistController MBist_inst (.clk(clk),.rst(rst),.test_mode(test_mode),.bist_status(bist_status),.fault(fault));

initial begin
	clk = 0;
	forever begin
		#2;
		clk = ~clk;
	end
end

initial begin
	test_mode = 0;
	rst = 1;
	#5;
	rst = 0;
	#5;
	test_mode = 1;
	fault=2'b11;
	$display("Normal Operation");
	#10;
	fault=2'b00;
	$display("Struck-at-faults detection");
	#10;
	fault=2'b01;
	$display("transition faults detection");
	#10;
	fault=2'b10;
	$display("Coupling detection");
	#10;
	fault=2'b11;
	$display("Normal Operation");
	#10;
	test_mode = 0;
end

 //force u.u_mem_model.mem[3] = 0;
 //#(1000*`clock_period);
 //$finish;
endmodule
