/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */
`default_nettype none

`include "riscv_defines.vh"

module alu_decoder (
    input  wire                        imm_bit10,
    input  wire                        op_bit5,
    input  wire [                 2:0] funct3,
    input  wire                        funct7_bit5,
    input  wire [`ALU_OP_WIDTH   -1:0] ALUOp,
    output reg  [`ALU_CTRL_WIDTH -1:0] ALUControl
);

  wire is_rtype_sub = op_bit5 & funct7_bit5;
  wire is_srl_srli = (op_bit5 && !funct7_bit5) || (!op_bit5 && !imm_bit10);

  always @(*) begin
    case (ALUOp)
      `ALU_OP_ADD:                             ALUControl = `ALU_CTRL_ADD_ADDI;
      `ALU_OP_SUB:                             ALUControl = `ALU_CTRL_SUB;
      `ALU_OP_AUIPC:                           ALUControl = `ALU_CTRL_AUIPC;
      `ALU_OP_LUI:                             ALUControl = `ALU_CTRL_LUI;
      `ALU_OP_BRANCH: begin
        case (funct3)
          3'b000: ALUControl = `ALU_CTRL_BEQ;
          3'b001: ALUControl = `ALU_CTRL_BNE;
          3'b100: ALUControl = `ALU_CTRL_BLT;
          3'b101: ALUControl = `ALU_CTRL_BGE;
          3'b110: ALUControl = `ALU_CTRL_BLTU;
          3'b111: ALUControl = `ALU_CTRL_BGEU;
          default:
          /* verilator lint_off WIDTH */
          ALUControl = 'hx;
          /* verilator lint_on WIDTH */
        endcase
      end
      `ALU_OP_ARITH_LOGIC: begin
        case (funct3)
          3'b000: ALUControl = is_rtype_sub ? `ALU_CTRL_SUB : `ALU_CTRL_ADD_ADDI;
          3'b100: ALUControl = `ALU_CTRL_XOR_XORI;
          3'b110: ALUControl = `ALU_CTRL_OR_ORI;
          3'b111: ALUControl = `ALU_CTRL_AND_ANDI;
          3'b010: ALUControl = `ALU_CTRL_SLT_SLTI;
          3'b001: ALUControl = `ALU_CTRL_SLL_SLLI;
          3'b011: ALUControl = `ALU_CTRL_SLTU_SLTIU;
          3'b101: ALUControl = is_srl_srli ? `ALU_CTRL_SRL_SRLI : `ALU_CTRL_SRA_SRAI;
          default:
          /* verilator lint_off WIDTH */
          ALUControl = 'hx;
          /* verilator lint_on WIDTH */
        endcase
      end
      default:
  /* verilator lint_off WIDTH */ ALUControl = 'hx;
      /* verilator lint_on WIDTH */
    endcase
  end

endmodule
