#!/bin/python

import os

retrosoc_repo_path = '../../retroSoC'

src_files = [
    'tech/tc_io.v',
    'tech/tc_clk.v',
    'tech/tc_pll.v',
    'tech/tc_sram.v',
    'rtl/ip/spram_model.v',
    'rtl/ip/spimemio.v',
    'rtl/ip/simpleuart.v',
    'rtl/ip/counter_timer.v',
    'rtl/ip/spi_slave.v',
    'rtl/ip/ravenna_spi.v',
    'rtl/ip/rcu.v',
    'rtl/ip/cust/register.v',
    'rtl/ip/cust/lfsr.v',
    'rtl/ip/cust/fifo.v',
    'rtl/ip/cust/cdc_sync.v',
    'rtl/ip/cust/clk_int_div.v',
    'rtl/ip/cust/edge_det.v',
    'rtl/ip/cust/rst_sync.v',
    'rtl/ip/cust/archinfo.v',
    'rtl/ip/cust/rng.v',
    'rtl/ip/cust/uart.v',
    'rtl/ip/cust/pwm.v',
    'rtl/ip/cust/ps2.v',
    'rtl/ip/cust/i2c.v',
    'rtl/ip/cust/psram_core.v',
    'rtl/ip/cust/psram.v',
    'rtl/ip/cust/spfs/spi_defines.v',
    'rtl/ip/cust/spfs/spi_clgen.v',
    'rtl/ip/cust/spfs/spi_shift.v',
    'rtl/ip/cust/spfs/spi_top.v',
    'rtl/ip/cust/spfs/spi_flash.v',
    'rtl/ip/cust/apb_spi_master/spi_master_apb_if.v',
    'rtl/ip/cust/apb_spi_master/spi_master_clkgen.v',
    'rtl/ip/cust/apb_spi_master/spi_master_controller.v',
    'rtl/ip/cust/apb_spi_master/spi_master_fifo.v',
    'rtl/ip/cust/apb_spi_master/spi_master_rx.v',
    'rtl/ip/cust/apb_spi_master/spi_master_tx.v',
    'rtl/ip/cust/apb_spi_master/apb_spi_master.v',
    'rtl/ip/cust/axil2apb/flop.v',
    'rtl/ip/cust/axil2apb/address_decoder.v',
    'rtl/ip/cust/axil2apb/read_data_mux.v',
    'rtl/ip/cust/axil2apb/apb_master.v',
    'rtl/ip/cust/axil2apb/axi_apb_bridge.v',
    'rtl/ip/axil_ip_wrapper.v',
    'rtl/picorv32.v',
    'rtl/retrosoc.v',
    'rtl/retrosoc_asic.v',
]

for v in src_files:
    print(f'{retrosoc_repo_path}/{v} .')
    os.system(f'cp -rf {retrosoc_repo_path}/{v} .')
