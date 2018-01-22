/* Definitions for option handling for MSP430.
   Copyright (C) 2001-2012
   Free Software Foundation, Inc.

   This file is part of GCC.

   GCC is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published
   by the Free Software Foundation; either version 3, or (at your
   option) any later version.

   GCC is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING3.  If not see
   <http://www.gnu.org/licenses/>.  */

#ifndef GCC_MSP430_OPTS_H
#define GCC_MSP430_OPTS_H

/** Bit-markers for type of CPU present. */
typedef enum msp430_cpu_e
{
  MSP430_CPU_MSP430 = 0x0000,
  MSP430_CPU_MSP430X = 0x0002,
  MSP430_CPU_MSP430XV2 = 0x0003,
  MSP430_CPU = 0x0003
} msp430_cpu_e;

/** Bit-markers for type of hardware multiplier present. */
typedef enum msp430_mpy_e
{
  MSP430_MPY_NONE = 0x0000,
  MSP430_MPY_TYPE_16 = 0x0010,
  MSP430_MPY_TYPE_32 = 0x0020,
  MSP430_MPY_TYPE_ANY = 0x0030,
  MSP430_MPY_HAS_SE = 0x0001,
  MSP430_MPY_HAS_DW = 0x0002,
  MSP430_MPY_16 = MSP430_MPY_TYPE_16,
  MSP430_MPY_16SE = MSP430_MPY_16 | MSP430_MPY_HAS_SE,
  MSP430_MPY_32 = MSP430_MPY_TYPE_16 | MSP430_MPY_TYPE_32 | MSP430_MPY_HAS_SE,
  MSP430_MPY_32DW = MSP430_MPY_32 | MSP430_MPY_HAS_DW
} msp430_mpy_e;

/** Bit-markers indicating the selected memory model.  Values must be
 * disjoint from msp430_cpu_e and msp430_cpux_target_e.  Though these
 * are recorded in __MSP430X__, use the MSP430_CPUX_TARGET_foo flags
 * for control. */
typedef enum msp430_memory_model_e
{
  /* No memory model specified */
  MSP430_MEMORY_MODEL_NONE = 0x0000,
  /* Small: nominally -mc16 -md16 -msr16 -ma16 (all default) */
  MSP430_MEMORY_MODEL_SMALL = 0x0010,
  /* Medium: nominally -mc20 -msr20 */
  MSP430_MEMORY_MODEL_MEDIUM = 0x0020,
  /* Large: nominally -mc20 -md20 -msr20 */
  MSP430_MEMORY_MODEL_LARGE = 0x0030,
  /* Huge: nominally -mc20 -md20 -msr20 -ma20 */
  MSP430_MEMORY_MODEL_HUGE = 0x0040,
  /* Mask to extract the specific value from __MSP430X__ */
  MSP430_MEMORY_MODEL_MASK = 0x0070
} msp430_memory_model_e;

/** Bit-markers indicating CPUX target flags that are enabled.  Values
 * must be disjoint from msp430_cpu_e. 
 *
 * NOTE: The values associated with these flags MUST NOT CHANGE.  Ever.
 * They get encoded into object files when the idiom:
 *     .cpux_target bits=__MSP430X__
 * appears in assembly sources. */
typedef enum msp430_cpux_target_e
{
  MSP430_CPUX_TARGET_ISR20 = 0x0100,
  MSP430_CPUX_TARGET_SR20 = 0x0200,
  MSP430_CPUX_TARGET_A20 = 0x0400,
  MSP430_CPUX_TARGET_C20 = 0x0800,
  MSP430_CPUX_TARGET_D20 = 0x1000
} msp430_cpux_target_e;

/** Alternatives for the regions in which different types of
 * declaration may be placed. */
typedef enum msp430_section_region_e
{
  /** No specific region desired */
  MSP430_SECTION_REGION_DEFAULT,
  /** Place in lower 64 kB memory */
  MSP430_SECTION_REGION_NEAR,
  /** Place above 64 kB boundary */
  MSP430_SECTION_REGION_FAR,
  /** Place in either near or far region */
  MSP430_SECTION_REGION_ANY
} msp430_section_region_e;

#endif /* GCC_MSP430_OPTS_H */
