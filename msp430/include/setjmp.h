/* Copyright (c) 2012, Peter A. Bigot
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef __SETJMP_H_
#define __SETJMP_H_

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* Preserve 20-bit register values if SR20 is enabled for at least
 * interrupts.  Use a 20-bit return if -mc20 was specified.  Keep
 * these checks consistent with msp430-libc's setjmp.S source file. */
typedef struct {
#if __MSP430X__ & (__MSP430_CPUX_TARGET_SR20__ | __MSP430_CPUX_TARGET_ISR20__)
  unsigned long int __attribute__((__a20__))
#else /* any SR20 */
  unsigned int
#endif /* any SR20 */
    r1,
    r2,
    r4, r5, r6, r7, r8, r9, r10, r11;
#if __MSP430X__ & __MSP430_CPUX_TARGET_C20__
  unsigned long int __attribute__((__a20__))
#else /* C20 */
  unsigned int
#endif /* C20 */
    r0;
} jmp_buf[1];

int setjmp (jmp_buf env);
__attribute__((__noreturn__)) void longjmp (jmp_buf env, int val);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __SETJMP_H_ */
