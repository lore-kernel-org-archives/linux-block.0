Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
From: Kyungtae Kim <kt0755@gmail.com>
Date: Wed, 7 Nov 2018 04:46:42 -0500
Message-ID: <CAEAjamv2+DExHp2kyuBU=fZx-59MgOWyahDqTUL-uQMgUAmzuA@mail.gmail.com>
Subject: WARNING in pkt setup dev
To: Jens Axboe <axboe@kernel.dk>
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>,
	syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

We report a bug in v4.19-rc2 (the latest as well):

kernel config: https://kt0755.github.io/etc/config_v2-4.19
repro: https://kt0755.github.io/etc/repro.aa68f.c

In pkt_ctl_ioctl (cmd: PKT_CTRL_CMD_SETUP), it attempts to retrieve a
block device
using a variable "dev" that comes from ioctl's third argument
(driver/block/pktcdvd.c:2592).
However, an inappropriate block device can be retrieved and allowed to
access following statements.
It's because "dev" is used to retrieve block_device without prior sanity check.
although it can be manipulated by compromising syscall input.


Crash log:
===========================
Attempt to register a non-SCSI queue
WARNING: CPU: 0 PID: 6710 at drivers/block/pktcdvd.c:2599 pkt_new_dev
drivers/block/pktcdvd.c:2599 [inline]
WARNING: CPU: 0 PID: 6710 at drivers/block/pktcdvd.c:2599
pkt_setup_dev+0x1054/0x1340 drivers/block/pktcdvd.c:2760
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6710 Comm: syz-executor1 Not tainted 4.19.0-rc2 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 panic+0x1ff/0x419 kernel/panic.c:184
 __warn+0x208/0x220 kernel/panic.c:536
 report_bug+0x243/0x300 lib/bug.c:186
 fixup_bug.part.9+0x3e/0x90 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:248 [inline]
 do_error_trap+0x278/0x2c0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x20/0x30 arch/x86/kernel/traps.c:316
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:pkt_new_dev drivers/block/pktcdvd.c:2599 [inline]
RIP: 0010:pkt_setup_dev+0x1054/0x1340 drivers/block/pktcdvd.c:2760
Code: c2 48 c7 c7 80 89 68 87 e8 6e e7 0e fe e9 c7 fe ff ff e8 ef 8f
23 fe 48 c7 c7 40 8a 68 87 c6 05 06 bb e5 05 01 e8 cc 69 f8 fd <0f> 0b
e9 40 ff ff ff e8 80 0d 56 fe e9 1d f5 ff ff e8 f6 0c 56 fe
RSP: 0018:ffff880102f17b30 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88010126f600 RCX: ffffffff81439b91
RDX: 0000000000010000 RSI: ffffc9000335b000 RDI: ffffffff8a183e20
RBP: ffff880102f17c28 R08: ffffed0023503cfb R09: ffffed0023503cfb
R10: ffff88010f75731f R11: ffffed0023503cfa R12: ffff88010f757300
R13: 0000000000000000 R14: ffff8800b97cdd80 R15: ffff8801149f8000
 pkt_ctl_ioctl+0x273/0x3b0 drivers/block/pktcdvd.c:2881
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4be1b72c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4be1b736cc RCX: 00000000004497b9
RDX: 00000000200003c0 RSI: 00000040c0185801 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000055b0 R14: 00000000006ed650 R15: 00007f4be1b73700
Dumping ftrace buffer:
   (ftrace buffer empty)
==========================

Thanks,
Kyungtae Kim
