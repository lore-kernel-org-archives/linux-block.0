Return-Path: <threeearcat@gmail.com>
Return-Path: <threeearcat@gmail.com>
Date: Fri, 27 Jul 2018 10:39:00 +0900
From: "Dae R. Jeong" <threeearcat@gmail.com>
To: jikos@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lifeasageek@gmail.com, kt0755@gmail.com
Subject: WARNING in __alloc_pages_slowpath
Message-ID: <20180727013900.GA1875@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Reporting the crash: WARNING in __alloc_pages_slowpath

This crash has been found in v4.18-rc4 using a modified version of
Syzkaller, which focus on exploring hard-to-reach coverages.

C repro code:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-1f029c.c
Kernel config:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/config-1f029c

Crash log:
print_req_error: I/O error, dev fd0, sector 0
WARNING: CPU: 0 PID: 12062 at mm/page_alloc.c:4065 __alloc_pages_slowpath+0x1b00/0x29f0 mm/page_alloc.c:4222
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 12062 Comm: syz-executor7 Not tainted 4.18.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
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
RIP: 0010:__alloc_pages_slowpath+0x1b00/0x29f0 mm/page_alloc.c:4222
Code: c0 84 c0 0f 85 1d 03 00 00 8b 85 d0 fe ff ff 45 84 ed 44 89 b5 48 fe ff ff 89 85 68 fe ff ff 0f 85 3b ea ff ff e9 25 f5 ff ff <0f> 0b e9 95 e5 ff ff 0f 0b 89 f8 c7 85 2c fe ff ff 00 00 00 00 25 
RSP: 0018:ffff88010bc07720 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff10021780efe RCX: 0000000000000000
RDX: ffff88010bc07978 RSI: 000000000000001b RDI: 0000000000000000
RBP: ffff88010bc07918 R08: 0000000000000000 R09: fffffffff8000f80
R10: ffff88013fff9487 R11: ffffed0027fff290 R12: ffff88010bc079d8
R13: 0000000000000000 R14: ffff880116f6ad80 R15: ffff88010bc07978
 __alloc_pages_nodemask+0x652/0x7d0 mm/page_alloc.c:4389
 alloc_pages_current+0x113/0x270 mm/mempolicy.c:2093
 alloc_pages include/linux/gfp.h:492 [inline]
 __get_free_pages+0x17/0x50 mm/page_alloc.c:4417
 dma_mem_alloc+0x30/0x40 arch/x86/include/asm/floppy.h:156
 raw_cmd_copyin drivers/block/floppy.c:3162 [inline]
 raw_cmd_ioctl drivers/block/floppy.c:3209 [inline]
 fd_locked_ioctl+0x108b/0x2c20 drivers/block/floppy.c:3547
 fd_ioctl+0x40/0x60 drivers/block/floppy.c:3574
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0xda0/0x2f70 block/ioctl.c:601
 block_ioctl+0x105/0x150 fs/block_dev.c:1880
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0xb2e/0x1940 fs/ioctl.c:686
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:706
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 
RSP: 002b:00007f122de2cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f122de2d6cc RCX: 00000000004497b9
RDX: 00000000200004c0 RSI: 0000800000000258 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000054f0 R14: 00000000006ed590 R15: 00007f122de2d700
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
