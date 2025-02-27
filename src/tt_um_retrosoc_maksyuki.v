/*
 * Copyright (c) 2024 Yuchi Miao
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_retrosoc_maksyuki (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [15:0] s_gpio_out_o;
  wire [15:0] s_gpio_in_i;
  wire [15:0] s_gpio_outenb_o;
  wire        s_uart_tx_o;
  wire        s_uart_rx_i;
  wire        s_cust_ps2_ps2_clk_i;
  wire        s_cust_ps2_ps2_dat_i;
  wire        s_cust_i2c_scl_i;
  wire        s_cust_i2c_scl_o;
  wire        s_cust_i2c_scl_dir_o;
  wire        s_cust_i2c_sda_i;
  wire        s_cust_i2c_sda_o;
  wire        s_cust_i2c_sda_dir_o;
  wire        s_cust_qspi_spi_clk_o;
  wire [ 3:0] s_cust_qspi_spi_csn_o;
  wire [ 3:0] s_cust_qspi_spi_sdo_o;
  wire [ 3:0] s_cust_qspi_spi_oe_o;
  wire [ 3:0] s_cust_qspi_spi_sdi_i;
  wire        s_cust_psram_sclk_o;
  wire        s_cust_psram_ce_o;
  wire        s_cust_psram_sio0_i;
  wire        s_cust_psram_sio1_i;
  wire        s_cust_psram_sio2_i;
  wire        s_cust_psram_sio3_i;
  wire        s_cust_psram_sio0_o;
  wire        s_cust_psram_sio1_o;
  wire        s_cust_psram_sio2_o;
  wire        s_cust_psram_sio3_o;
  wire        s_cust_psram_sio_oe_o;
  wire        s_cust_spfs_clk_o;
  wire        s_cust_spfs_cs_o;
  wire        s_cust_spfs_mosi_o;
  wire        s_cust_spfs_miso_i;

  // gpio setting
  assign s_gpio_in_i[15:5]          = 11'd0;
  assign s_cust_qspi_spi_sdi_i[3:1] = 3'd0;
  // in
  assign s_uart_rx_i                = ui_in[0];
  assign s_cust_ps2_ps2_clk_i       = ui_in[1];
  assign s_cust_ps2_ps2_dat_i       = ui_in[2];
  assign s_gpio_in_i[1]             = ui_in[3];
  assign s_gpio_in_i[2]             = ui_in[4];
  assign s_gpio_in_i[3]             = ui_in[5];
  assign s_gpio_in_i[4]             = ui_in[6];
  assign s_cust_spfs_miso_i         = ui_in[7];
  // out
  assign uo_out[0]                  = s_cust_spfs_clk_o;
  assign uo_out[1]                  = s_cust_spfs_cs_o;
  assign uo_out[2]                  = s_cust_spfs_mosi_o;
  assign uo_out[3]                  = s_uart_tx_o;
  assign uo_out[4]                  = s_cust_qspi_spi_clk_o;
  assign uo_out[5]                  = s_cust_qspi_spi_csn_o[0];
  assign uo_out[6]                  = s_cust_psram_sclk_o;
  assign uo_out[7]                  = s_cust_psram_ce_o;
  // inout
  assign s_cust_psram_sio0_i        = uio_in[0];
  assign s_cust_psram_sio1_i        = uio_in[1];
  assign s_cust_psram_sio2_i        = uio_in[2];
  assign s_cust_psram_sio3_i        = uio_in[3];
  assign s_cust_qspi_spi_sdi_i[0]   = uio_in[4];
  assign s_cust_i2c_scl_i           = uio_in[5];
  assign s_cust_i2c_sda_i           = uio_in[6];
  assign s_gpio_in_i[0]             = uio_in[7];

  assign uio_out[0]                 = s_cust_psram_sio0_o;
  assign uio_out[1]                 = s_cust_psram_sio1_o;
  assign uio_out[2]                 = s_cust_psram_sio2_o;
  assign uio_out[3]                 = s_cust_psram_sio3_o;
  assign uio_out[4]                 = s_cust_qspi_spi_sdo_o[0];
  assign uio_out[5]                 = s_cust_i2c_scl_o;
  assign uio_out[6]                 = s_cust_i2c_sda_o;
  assign uio_out[7]                 = s_gpio_out_o[0];

  assign uio_oe[0]                  = ~s_cust_psram_sio_oe_o;
  assign uio_oe[1]                  = ~s_cust_psram_sio_oe_o;
  assign uio_oe[2]                  = ~s_cust_psram_sio_oe_o;
  assign uio_oe[3]                  = ~s_cust_psram_sio_oe_o;
  assign uio_oe[4]                  = s_cust_qspi_spi_oe_o[0];
  assign uio_oe[5]                  = ~s_cust_i2c_scl_dir_o;
  assign uio_oe[6]                  = ~s_cust_i2c_sda_dir_o;
  assign uio_oe[7]                  = ~s_gpio_outenb_o[0];


  retrosoc u_retrosoc (
      .clk_i                    (clk),
      .rst_n_i                  (rst_n),
      .clk_ext_sel_i            (1'b1),
      .hk_pt_i                  (1'b0),
      .hk_pt_csb_i              (1'b0),
      .hk_pt_sck_i              (1'b0),
      .hk_pt_sdi_i              (1'b0),
      .hk_pt_sdo_o              (),
      .ram_wstrb_o              (),
      .ram_addr_o               (),
      .ram_wdata_o              (),
      .ram_rdata_o              (),
      .gpio_out_o               (s_gpio_out_o),
      .gpio_in_i                (s_gpio_in_i),
      .gpio_pullupb_o           (),
      .gpio_pulldownb_o         (),
      .gpio_outenb_o            (s_gpio_outenb_o),
      .spi_slv_ro_config_i      (8'd0),
      .spi_slv_ro_xtal_ena_i    (1'b0),
      .spi_slv_ro_reg_ena_i     (1'b0),
      .spi_slv_ro_pll_cp_ena_i  (1'b0),
      .spi_slv_ro_pll_vco_ena_i (1'b0),
      .spi_slv_ro_pll_bias_ena_i(1'b0),
      .spi_slv_ro_pll_trim_i    (4'd0),
      .spi_slv_ro_mfgr_id_i     (12'd0),
      .spi_slv_ro_prod_id_i     (8'd0),
      .spi_slv_ro_mask_rev_i    (4'd0),
      .uart_tx_o                (s_uart_tx_o),
      .uart_rx_i                (s_uart_rx_i),
      .irq_pin_i                (1'b0),
      .irq_spi_i                (1'b0),
      .trap_o                   (),
      .flash_csb_o              (),
      .flash_clk_o              (),
      .flash_clk_oeb_o          (),
      .flash_csb_oeb_o          (),
      .flash_io0_oeb_o          (),
      .flash_io1_oeb_o          (),
      .flash_io2_oeb_o          (),
      .flash_io3_oeb_o          (),
      .flash_io0_do_o           (),
      .flash_io1_do_o           (),
      .flash_io2_do_o           (),
      .flash_io3_do_o           (),
      .flash_io0_di_i           (1'b0),
      .flash_io1_di_i           (1'b0),
      .flash_io2_di_i           (1'b0),
      .flash_io3_di_i           (1'b0),
      .cust_uart_rx_i           (),
      .cust_uart_tx_o           (),
      .cust_pwm_pwm_o           (),
      .cust_ps2_ps2_clk_i       (s_cust_ps2_ps2_clk_i),
      .cust_ps2_ps2_dat_i       (s_cust_ps2_ps2_dat_i),
      .cust_i2c_scl_i           (s_cust_i2c_scl_i),
      .cust_i2c_scl_o           (s_cust_i2c_scl_o),
      .cust_i2c_scl_dir_o       (s_cust_i2c_scl_dir_o),
      .cust_i2c_sda_i           (s_cust_i2c_sda_i),
      .cust_i2c_sda_o           (s_cust_i2c_sda_o),
      .cust_i2c_sda_dir_o       (s_cust_i2c_sda_dir_o),
      .cust_qspi_spi_clk_o      (s_cust_qspi_spi_clk_o),
      .cust_qspi_spi_csn_o      (s_cust_qspi_spi_csn_o),
      .cust_qspi_spi_sdo_o      (s_cust_qspi_spi_sdo_o),
      .cust_qspi_spi_oe_o       (s_cust_qspi_spi_oe_o),
      .cust_qspi_spi_sdi_i      (s_cust_qspi_spi_sdi_i),
      .cust_psram_sclk_o        (s_cust_psram_sclk_o),
      .cust_psram_ce_o          (s_cust_psram_ce_o),
      .cust_psram_sio0_i        (s_cust_psram_sio0_i),
      .cust_psram_sio1_i        (s_cust_psram_sio1_i),
      .cust_psram_sio2_i        (s_cust_psram_sio2_i),
      .cust_psram_sio3_i        (s_cust_psram_sio3_i),
      .cust_psram_sio0_o        (s_cust_psram_sio0_o),
      .cust_psram_sio1_o        (s_cust_psram_sio1_o),
      .cust_psram_sio2_o        (s_cust_psram_sio2_o),
      .cust_psram_sio3_o        (s_cust_psram_sio3_o),
      .cust_psram_sio_oe_o      (s_cust_psram_sio_oe_o),
      .cust_spfs_div4_i         (1'b0),
      .cust_spfs_clk_o          (s_cust_spfs_clk_o),
      .cust_spfs_cs_o           (s_cust_spfs_cs_o),
      .cust_spfs_mosi_o         (s_cust_spfs_mosi_o),
      .cust_spfs_miso_i         (s_cust_spfs_miso_i)
  );
endmodule
