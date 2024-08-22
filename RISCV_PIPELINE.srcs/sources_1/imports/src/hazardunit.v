`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2022 09:28:07 PM
// Design Name: 
// Module Name: hazardunit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hazardunit(
	clk,
	reset,
	
	StallF,
	StallD,
	FlushD,
	FlushE,
	ForwardAE,
	ForwardBE,
	
	Rs1D,
	Rs2D,
	RdE,
	Rs1E,
	Rs2E,
	PCSrcE,
	ResultSrcE,
	RdM,
	RegWriteM,
	RdW,
	RegWriteW
    );
    
    input wire clk;
	input wire reset;
	
	output wire StallF;
	output wire StallD;
	output wire FlushD;
	output wire FlushE;
	output wire [1:0] ForwardAE;
	output wire [1:0] ForwardBE;
	
	input wire [4:0] Rs1D;
	input wire [4:0] Rs2D;
	input wire [4:0] RdE;
	input wire [4:0] Rs1E;
	input wire [4:0] Rs2E;
	input wire [1:0] PCSrcE;
	input wire [2:0] ResultSrcE;
	input wire [4:0] RdM;
	input wire RegWriteM;
	input wire [4:0] RdW;
	input wire RegWriteW;
	
	wire lwStall;
	
	assign ForwardAE[1]=(((Rs1E==RdM) & RegWriteM) & ~(Rs1E==5'b00000));
	assign ForwardAE[0]=(((Rs1E==RdW) & RegWriteW) & ~(Rs1E==5'b00000));
	
	assign ForwardBE[1]=(((Rs2E==RdM) & RegWriteM) & ~(Rs2E==5'b00000));
	assign ForwardBE[0]=(((Rs2E==RdW) & RegWriteW) & ~(Rs2E==5'b00000));


	
	assign lwStall=(ResultSrcE==3'b001) & ((Rs1D==RdE) | (Rs2D==RdE));
	assign StallF=lwStall;
	assign StallD=lwStall;
	
	assign FlushD=PCSrcE;
	assign FlushE=lwStall | PCSrcE;
	
	
	//to do:
	//ligar aos fios do datapath e controlpath (inputs) e dos registos e muxs (outputs)
	
	
	
	
	
    
    
    
endmodule
