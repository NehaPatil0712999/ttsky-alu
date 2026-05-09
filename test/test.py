# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    dut._log.info("Start ALU Test")

    # Create Clock
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # -------------------------
    # Reset DUT
    # -------------------------
    dut._log.info("Reset DUT")

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    # -------------------------
    # Test 1 : Addition
    # sel = 00
    # A = 5
    # B = 3
    # Expected = 8
    # -------------------------
    dut._log.info("Test 1: ADDITION")

    dut.ui_in.value = 0b00000101
    dut.uio_in.value = 0b00000011

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 8, "Addition Failed"

    # -------------------------
    # Test 2 : Subtraction
    # sel = 01
    # A = 9
    # B = 4
    # Expected = 5
    # -------------------------
    dut._log.info("Test 2: SUBTRACTION")

    dut.ui_in.value = 0b01001001
    dut.uio_in.value = 0b00000100

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 5, "Subtraction Failed"

    # -------------------------
    # Test 3 : AND
    # sel = 10
    # A = 12
    # B = 10
    # Expected = 8
    # -------------------------
    dut._log.info("Test 3: AND")

    dut.ui_in.value = 0b10001100
    dut.uio_in.value = 0b00001010

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 8, "AND Operation Failed"

    # -------------------------
    # Test 4 : OR
    # sel = 11
    # A = 12
    # B = 10
    # Expected = 14
    # -------------------------
    dut._log.info("Test 4: OR")

    dut.ui_in.value = 0b11001100
    dut.uio_in.value = 0b00001010

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 14, "OR Operation Failed"

    dut._log.info("All ALU Tests Passed Successfully!")
