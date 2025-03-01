# VHDL-MMX-SIMD

## Overview

This repository contains a VHDL implementation of an MMX (MultiMedia eXtension) arithmetic unit for SIMD (Single Instruction, Multiple Data) operations, targeted for the Nexys A7 FPGA board. The project demonstrates hardware-based parallel data processing using an architecture inspired by Intel's MMX technology.

The implementation features various SIMD instructions operating on 64-bit vectors, supporting operations on packed 8-bit, 16-bit, and 32-bit data elements. It includes standard arithmetic operations with wrap-around as well as saturating operations to handle overflow conditions.

## Features

- **SIMD Operations**:
  - **PADD**: Packed addition with wrap-around (8, 16, and 32-bit)
  - **PADDS**: Packed addition with signed saturation (8 and 16-bit)
  - **PADDUS**: Packed addition with unsigned saturation (8 and 16-bit)
  - **PSUB**: Packed subtraction with wrap-around (8, 16, and 32-bit)
  - **PSUBS**: Packed subtraction with signed saturation (8 and 16-bit)
  - **PMUL**: Packed multiplication (16-bit) with support for both low word (PMULLW) and high word (PMULHW) results

- **Integrated Components**:
  - Seven-segment display (SSD) for visualizing results
  - Built-in test memory unit with predefined vector pairs
  - Button debouncing using MPG (Multiple Pulse Generator)
  - Bit selection logic to display upper or lower 32 bits of results

## Architecture

The system follows a modular architecture with the following key components:

1. **MMX_Unit**: Core unit that integrates all SIMD operations
2. **MemoryUnit**: Provides test vector pairs (A and B) for SIMD operations
3. **BitSelector**: Selects which portion of the 64-bit result to display
4. **SSD (Seven-Segment Display)**: Displays selected results in hexadecimal format
5. **Operation Modules**: Individual modules for each SIMD operation (PADD, PADDS, etc.)
6. **Basic Arithmetic Units**: 
   - AdderSubtractor modules (1-bit and 8-bit versions)
   - Multiplier modules (8-bit and 16-bit versions)

The design uses a data flow where vectors are sourced from the MemoryUnit, processed by the MMX_Unit with the selected operation, and finally, results are displayed on the seven-segment display.

## Implementation Details

- **Data Sizes**: Operations support various element sizes:
  - 8-bit: 8 elements per 64-bit vector
  - 16-bit: 4 elements per 64-bit vector
  - 32-bit: 2 elements per 64-bit vector

- **Saturation Handling**:
  - Signed saturation prevents overflow/underflow by clamping results to the maximum/minimum representable value
  - Unsigned saturation prevents overflow by clamping results to the maximum representable value

- **Multiplier Design**:
  - Uses combinational logic for 8-bit multiplication
  - Combines multiple 8-bit multipliers for 16-bit multiplication
  - Supports selecting either low or high word of multiplication results

## Getting Started

### Prerequisites

- Xilinx Vivado Design Suite
- Nexys A7 FPGA board
- Micro USB cable

### Setup

1. Clone this repository
2. Open Vivado and create a new project
3. Add all the VHDL files from this repository to your project
4. Add the constraint file (NexysA7_test_env.xdc)
5. Generate bitstream
6. Program the Nexys A7 board using the generated bitstream or use the provided test_env.bit

## Usage

After programming the FPGA:

1. Use the center button (btn[0]) to reset the memory index
2. Use up button (btn[1]) to increment the memory index (move to next test vector pair)
3. Use down button (btn[4]) to decrement the memory index
4. Use switches sw[2:0] to select the SIMD operation:
   - 000: PADD
   - 001: PADDS
   - 010: PADDUS
   - 011: PSUB
   - 100: PSUBS
   - 101: PMULLW
   - 110: PMULHW
5. Use switches sw[4:3] to select the element size:
   - 00: 8-bit
   - 01: 16-bit
   - 10: 32-bit
6. Use switch sw[15] to toggle between displaying lower 32 bits (0) or upper 32 bits (1) of the result
7. The LEDs display:
   - led[14:5]: Current memory index
   - led[4:3]: Current element size
   - led[2:0]: Current operation
   - led[15]: Indicates selection between lower/upper bits

## Project Structure

```
.
├── AdderSubtractor1bit.vhd        # 1-bit adder/subtractor
├── AdderSubtractor8bit.vhd        # 8-bit adder/subtractor with overflow detection
├── AdderSubtractor8bit_TB.vhd     # Testbench for 8-bit adder/subtractor
├── BitSelector.vhd                # Selects upper or lower 32 bits of result
├── MMX_Unit.vhd                   # Main SIMD arithmetic unit
├── MMX_Unit_TB.vhd                # Testbench for MMX unit
├── MPG.vhd                        # Multiple Pulse Generator for button debouncing
├── MemoryUnit.vhd                 # Memory with predefined test vectors
├── Multiplier16bit.vhd            # 16-bit multiplier
├── Multiplier8bit.vhd             # 8-bit multiplier
├── NexysA7_test_env.xdc          # Constraint file for Nexys A7 board
├── PADD.vhd                       # Packed addition module
├── PADDS.vhd                      # Packed addition with signed saturation
├── PADDS_TB.vhd                   # Testbench for PADDS
├── PADDUS.vhd                     # Packed addition with unsigned saturation
├── PADDUS_TB.vhd                  # Testbench for PADDUS
├── PADD_TB.vhd                    # Testbench for PADD
├── PMUL.vhd                       # Packed multiplication module
├── PMUL_TB.vhd                    # Testbench for PMUL
├── PSUB.vhd                       # Packed subtraction module
├── PSUBS.vhd                      # Packed subtraction with signed saturation
├── PSUBS_TB.vhd                   # Testbench for PSUBS
├── PSUB_TB.vhd                    # Testbench for PSUB
├── SSD.vhd                        # Seven-segment display controller
├── test_env.bit                   # Pre-generated bitstream
└── test_env.vhd                   # Top-level entity
```

## Testing

The project includes comprehensive testbenches for each SIMD operation and main components:

- Individual testbenches for PADD, PADDS, PADDUS, PSUB, PSUBS, and PMUL
- Integrated testbench for the entire MMX_Unit
- Test vectors covering various scenarios including:
  - Normal operation
  - Wrap-around cases
  - Saturation conditions
  - Different data sizes
  - Zero, maximum, and minimum values

To run tests, use the appropriate testbench files in your Vivado simulation environment.

## Acknowledgments

This project was developed as an educational implementation to demonstrate SIMD principles and MMX-style operations in hardware using VHDL. It is inspired by the MMX technology originally developed by Intel.
