/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-msp430")
OUTPUT_ARCH("msp430")
INCLUDE memory.x
INCLUDE periph.x
SECTIONS
{
  /* Read-only sections, merged into text segment.  */
  .hash            : { *(.hash)          }
  .dynsym          : { *(.dynsym)        }
  .dynstr          : { *(.dynstr)        }
  .gnu.version     : { *(.gnu.version)   }
  .gnu.version_d   : { *(.gnu.version_d) }
  .gnu.version_r   : { *(.gnu.version_r) }
  .rel.init      : { *(.rel.init)  }
  .rela.init     : { *(.rela.init) }
  .rel.fini      : { *(.rel.fini)  }
  .rela.fini     : { *(.rela.fini) }
  .rel.text      : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*)        }
  .rela.text     : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)     }
  .rel.rodata    : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*)    }
  .rela.rodata   : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
  .rel.data      : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*)        }
  .rela.data     : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)     }
  .rel.bss       : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*)          }
  .rela.bss      : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)       }
  .rel.ctors     : { *(.rel.ctors)  }
  .rela.ctors    : { *(.rela.ctors) }
  .rel.dtors     : { *(.rel.dtors)  }
  .rela.dtors    : { *(.rela.dtors) }
  .rel.got       : { *(.rel.got)    }
  .rela.got      : { *(.rela.got)   }
  .rel.plt       : { *(.rel.plt)    }
  .rela.plt      : { *(.rela.plt)   }
  /* .any.{text,rodata,data,bss}{,.*} sections are treated as orphans and
   * placed in output sections with available space by linker.  Do not list
   * them here, or the linker will not consider them orphans. */
  .text :
  {
     . = ALIGN(2);
     KEEP(*(.init .init.*))
     KEEP(*(.init0))  /* Start here after reset.               */
     KEEP(*(.init1))  /* User definable.                       */
     KEEP(*(.init2))  /* Initialize stack.                     */
     KEEP(*(.init3))  /* Initialize hardware, user definable.  */
     KEEP(*(.init4))  /* Copy data to .data, clear bss.        */
     KEEP(*(.init5))  /* User definable.                       */
     KEEP(*(.init6))  /* C++ constructors.                     */
     KEEP(*(.init7))  /* User definable.                       */
     KEEP(*(.init8))  /* User definable.                       */
     KEEP(*(.init9))  /* Call main().                          */
     KEEP(*(.fini9))  /* Falls into here after main(). User definable.  */
     KEEP(*(.fini8))  /* User definable.                           */
     KEEP(*(.fini7))  /* User definable.                           */
     KEEP(*(.fini6))  /* C++ destructors.                          */
     KEEP(*(.fini5))  /* User definable.                           */
     KEEP(*(.fini4))  /* User definable.                           */
     KEEP(*(.fini3))  /* User definable.                           */
     KEEP(*(.fini2))  /* User definable.                           */
     KEEP(*(.fini1))  /* User definable.                           */
     KEEP(*(.fini0))  /* Infinite loop after program termination.  */
     KEEP(*(.fini .fini.*))
     . = ALIGN(2);
     __ctors_start = .;
     KEEP(*(.ctors))
     __ctors_end = .;
     __dtors_start = .;
     KEEP(*(.dtors))
     __dtors_end = .;
     . = ALIGN(2);
    *(.text .text.* .gnu.linkonce.t.*)
    *(.near.text .near.text.*)
  }  > REGION_TEXT
  .rodata   :
  {
     . = ALIGN(2);
    *(.rodata .rodata.* .gnu.linkonce.r.*)
    *(.near.rodata .near.rodata.*)
  }  > REGION_TEXT
   . = ALIGN(2);
   _etext = .; /* Past last read-only (loadable) segment */
  .data   :
  {
     . = ALIGN(2);
     __data_start = .;
    *(.data .data.* .gnu.linkonce.d.*)
    *(.near.data .near.data.*)
     . = ALIGN(2);
     _edata = .;  /* Past last read-write (loadable) segment */
  }  > REGION_DATA AT > REGION_TEXT
   __data_load_start = LOADADDR(.data);
   __data_size = SIZEOF(.data);
  .bss   :
  {
     __bss_start = .;
    *(.bss .bss.*)
    *(.near.bss .near.bss.*)
    *(COMMON)
     . = ALIGN(2);
     __bss_end = .;
  }  > REGION_DATA
   __bss_size = SIZEOF(.bss);
  .noinit   :
  {
     . = ALIGN(2);
     __noinit_start = .;
    *(.noinit .noinit.*)
     . = ALIGN(2);
     __noinit_end = .;
  }  > REGION_DATA
   . = ALIGN(2);
   _end = .;   /* Past last write (loadable) segment */
  .infomem   :
  {
     . = ALIGN(2);
    *(.infomem .infomem.*)
  }  > infomem
  .infomemnobits   :
  {
     . = ALIGN(2);
    *(.infomemnobits .infomemnobits.*)
  }  > infomem
  .infoa   :
  {
     . = ALIGN(2);
    *(.infoa .infoa.*)
  }  > infoa
  .infob   :
  {
     . = ALIGN(2);
    *(.infob .infob.*)
  }  > infob
  .infoc   :
  {
     . = ALIGN(2);
    *(.infoc .infoc.*)
  }  > infoc
  .infod   :
  {
     . = ALIGN(2);
    *(.infod .infod.*)
  }  > infod
  /* Values placed in the first 32 entries of a 64-entry interrupt vector
   * table.  This exists because the FRAM chips place the BSL and JTAG
   * passwords at specific offsets that technically fall within the
   * interrupt table, but for which no MCU has a corresponding interrupt.
   * See https://sourceforge.net/tracker/?func=detail&aid=3554291&group_id=42303&atid=432701 */
  PROVIDE(__vte_0 = 0xffff);
  PROVIDE(__vte_1 = 0xffff);
  PROVIDE(__vte_2 = 0xffff);
  PROVIDE(__vte_3 = 0xffff);
  PROVIDE(__vte_4 = 0xffff);
  PROVIDE(__vte_5 = 0xffff);
  PROVIDE(__vte_6 = 0xffff);
  PROVIDE(__vte_7 = 0xffff);
  PROVIDE(__vte_8 = 0xffff);
  PROVIDE(__vte_9 = 0xffff);
  PROVIDE(__vte_10 = 0xffff);
  PROVIDE(__vte_11 = 0xffff);
  PROVIDE(__vte_12 = 0xffff);
  PROVIDE(__vte_13 = 0xffff);
  PROVIDE(__vte_14 = 0xffff);
  PROVIDE(__vte_15 = 0xffff);
  PROVIDE(__vte_16 = 0xffff);
  PROVIDE(__vte_17 = 0xffff);
  PROVIDE(__vte_18 = 0xffff);
  PROVIDE(__vte_19 = 0xffff);
  PROVIDE(__vte_20 = 0xffff);
  PROVIDE(__vte_21 = 0xffff);
  PROVIDE(__vte_22 = 0xffff);
  PROVIDE(__vte_23 = 0xffff);
  PROVIDE(__vte_24 = 0xffff);
  PROVIDE(__vte_25 = 0xffff);
  PROVIDE(__vte_26 = 0xffff);
  PROVIDE(__vte_27 = 0xffff);
  PROVIDE(__vte_28 = 0xffff);
  PROVIDE(__vte_29 = 0xffff);
  PROVIDE(__vte_30 = 0xffff);
  PROVIDE(__vte_31 = 0xffff);
  .vectors   :
  {
     __vectors_start = .;
    KEEP(*(.vectors*))
     _vectors_end = .;
  }  > vectors
  /* Legacy section, prefer .far.text */
  .fartext   :
  {
     . = ALIGN(2);
    *(.fartext .fartext.*)
  }  > REGION_FAR_TEXT
  .far.text   :
  {
     . = ALIGN(2);
    *(.far.text .far.text.*)
  }  > REGION_FAR_TEXT
  .far.rodata   :
  {
     . = ALIGN(2);
    *(.far.rodata .far.rodata.*)
  }  > REGION_FAR_TEXT
   . = ALIGN(2);
   _efartext = .; /* Past last read-only (loadable) segment */
  .far.data   :
  {
     . = ALIGN(2);
     __far_data_start = .;
    *(.far.data .far.data.*)
     . = ALIGN(2);
     _efardata = .;  /* Past last read-write (loadable) segment */
  }  > REGION_FAR_DATA AT > REGION_FAR_TEXT
   __far_data_load_start = LOADADDR(.far.data);
   __far_data_size = SIZEOF(.far.data);
  .far.bss   :
  {
     . = ALIGN(2);
     __far_bss_start = .;
    *(.far.bss .far.bss.*)
     . = ALIGN(2);
     __far_bss_end = .;
  }  > REGION_FAR_DATA
   __far_bss_size = SIZEOF(.far.bss);
   . = ALIGN(2);
   _far_end = .;   /* Past last write (loadable) segment */
  /* Stabs for profiling information*/
  .profiler 0 : { *(.profiler) }
  /* Stabs debugging sections.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  .stab.excl 0 : { *(.stab.excl) }
  .stab.exclstr 0 : { *(.stab.exclstr) }
  .stab.index 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0 : { *(.comment) }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info) *(.gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* DWARF 3 */
  .debug_pubtypes 0 : { *(.debug_pubtypes) }
  .debug_ranges   0 : { *(.debug_ranges) }
  /* __stack is the only symbol that the user can override */
   PROVIDE (__stack = ORIGIN(ram) + LENGTH(ram));
   __data_start_rom = _etext;
   __data_end_rom   = _etext + SIZEOF (.data);
}
