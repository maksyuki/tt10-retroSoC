#!/bin/python

import os

retrosoc_repo_path = '../../retroSoC'

src_files = [
    'rtl/ip/simpleuart.v',
    'rtl/ip/counter_timer.v',
    'rtl/ip/cust/register.v',
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
    'rtl/ip/axil_ip_wrapper_tiny.v',
    'rtl/picorv32.v',
    'rtl/retrosoc_tiny.v',
    'rtl/retrosoc_asic_tiny.v',
]

os.system('rm -rf *.v')
for v in src_files:
    print(f'{retrosoc_repo_path}/{v} .')
    os.system(f'cp -rf {retrosoc_repo_path}/{v} .')
