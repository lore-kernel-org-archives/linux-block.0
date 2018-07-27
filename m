Return-Path: <threeearcat@gmail.com>
Return-Path: <threeearcat@gmail.com>
Date: Fri, 27 Jul 2018 10:42:35 +0900
From: "Dae R. Jeong" <threeearcat@gmail.com>
To: jikos@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lifeasageek@gmail.com, kt0755@gmail.com
Subject: WARNING in schedule_bh
Message-ID: <20180727014235.GA2483@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Reporting the crash: WARNING in schedule_bh

This crash has been found in v4.18-rc4 using a modified version of
Syzkaller, which focus on exploring hard-to-reach coverages.

C repro code:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-98b14a.c
Kernel config:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/config-98b14a

Crash log:
WARNING: CPU: 0 PID: 6107 at drivers/block/floppy.c:984 schedule_bh+0x4d/0x60 drivers/block/floppy.c:984
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6107 Comm: kworker/u4:6 Not tainted 4.18.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy floppy_work_workfn
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x198 lib/dump_stack.c:113
 panic+0x27d/0x489 kernel/panic.c:184
 __warn+0x291/0x2d0 kernel/panic.c:536
 report_bug+0x243/0x300 lib/bug.c:186
 fixup_bug.part.9+0x42/0x1a0 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:248 [inline]
 do_error_trap+0x278/0x2c0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x20/0x30 arch/x86/kernel/traps.c:316
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:schedule_bh+0x4d/0x60 drivers/block/floppy.c:984
Code: c2 29 fe 48 8b 35 43 ee 88 07 48 c7 c2 40 f4 ac 88 bf 40 00 00 00 48 89 1d 50 e9 88 07 e8 cb 77 03 fe 5b 5d c3 e8 63 c2 29 fe <0f> 0b eb d0 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 
RSP: 0018:ffff88011a607d38 EFLAGS: 00010006
RAX: 0000000000010000 RBX: ffffffff83350970 RCX: ffffffff8333e1bd
RDX: ffff880110404440 RSI: ffffffff8abcd070 RDI: ffffffff83350970
RBP: ffff88011a607d40 R08: fffffbfff10e6995 R09: fffffbfff10e6995
R10: ffffffff88734ca3 R11: fffffbfff10e6994 R12: ffffffff83350970
R13: ffffffff8abcd070 R14: 0000000000000000 R15: ffffffff8abce960
 floppy_interrupt+0x1f6/0x390 drivers/block/floppy.c:1734
 floppy_hardint+0x25c/0x330 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x10e/0xa30 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x71/0x160 kernel/irq/handle.c:189
 handle_irq_event+0xca/0x170 kernel/irq/handle.c:206
 handle_edge_irq+0x2b0/0x960 kernel/irq/chip.c:791
 generic_handle_irq_desc include/linux/irqdesc.h:154 [inline]
 handle_irq+0x2dc/0x480 arch/x86/kernel/irq_64.c:77
 do_IRQ+0x15b/0x3c0 arch/x86/kernel/irq.c:245
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
 </IRQ>
RIP: 0010:outb arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:outb_p arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:output_byte+0x133/0x3d0 drivers/block/floppy.c:1128
Code: 03 48 01 d0 80 38 00 0f 85 ab 02 00 00 4a 8d 14 b5 00 00 00 00 44 89 e8 49 01 d6 49 c1 e6 03 49 8b 96 70 d0 bc 8a 83 c2 05 ee <49> c7 c4 30 e1 6b 88 48 ba 00 00 00 00 00 fc ff df 4c 89 e0 48 c1 
RSP: 0018:ffff8800b998fcb8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffdc
RAX: 00000000ffffff8f RBX: 0000000000000090 RCX: ffffffff833438e3
RDX: 00000000000003f5 RSI: ffffffff8abcd070 RDI: ffffffff8abcd070
RBP: ffff8800b998fce0 R08: ffffffff8abcd070 R09: ffffffff8abcd060
R10: 0000000000000000 R11: ffffffff8abcd070 R12: 0000000000000000
R13: 00000000ffffff8f R14: 0000000000000000 R15: 0000000000000000
 seek_floppy drivers/block/floppy.c:1616 [inline]
 floppy_ready+0xac4/0x18f0 drivers/block/floppy.c:1920
 seek_interrupt+0x2c2/0x540 drivers/block/floppy.c:1540
 floppy_work_workfn+0x1a/0x20 drivers/block/floppy.c:977
 process_one_work+0x98d/0x1a30 kernel/workqueue.c:2153
 worker_thread+0x8f/0xcf0 kernel/workqueue.c:2296
 kthread+0x3d5/0x4b0 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
