Return-Path: <37Q3nWgkbBYIy45qgrrkxgvvoj.muumrk0ykxiutzktz.iusg3hukqkxtkr.jq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 30 Apr 2018 05:37:01 -0700
In-Reply-To: <0000000000001558f3056a369689@google.com>
Message-ID: <00000000000048d84e056b101c2e@google.com>
Subject: Re: WARNING in __device_add_disk
From: syzbot <syzbot+3337db851ace689ceb50@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

syzbot has found reproducer for the following crash on upstream commit
6da6c0db5316275015e8cc2959f12a17584aeb64 (Sun Apr 29 21:17:42 2018 +0000)
Linux v4.17-rc3
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=3337db851ace689ceb50

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5078600311111680
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5938566311968768
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6326042692157440
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6493557782959164711
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3337db851ace689ceb50@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004404a9
RDX: 00000000004a1d2c RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 0030656c69662f2e R08: 00007fffca04f610 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
WARNING: CPU: 1 PID: 4539 at block/genhd.c:685  
__device_add_disk+0x104a/0x1340 block/genhd.c:685
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4539 Comm: syz-executor708 Not tainted 4.17.0-rc3+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:__device_add_disk+0x104a/0x1340 block/genhd.c:685
RSP: 0018:ffff8801ad26f4e0 EFLAGS: 00010293
RAX: ffff8801d908e380 RBX: ffff8801d95d8e80 RCX: ffffffff83437c33
RDX: 0000000000000000 RSI: ffffffff83437d6a RDI: 0000000000000005
RBP: ffff8801ad26f6b0 R08: ffff8801d908e380 R09: 0000000000000006
R10: ffff8801d908e380 R11: 0000000000000000 R12: 00000000fffffff4
R13: ffff8801ad26f688 R14: ffff8801d95d93e0 R15: ffff8801d95d8e84
  device_add_disk+0x22/0x30 block/genhd.c:705
  add_disk include/linux/genhd.h:397 [inline]
  loop_add+0x70b/0x9c0 drivers/block/loop.c:1895
  loop_probe+0x185/0x1c0 drivers/block/loop.c:1967
  kobj_lookup+0x269/0x460 drivers/base/map.c:124
  get_gendisk+0x4c/0x380 block/genhd.c:813
  bdev_get_gendisk fs/block_dev.c:1063 [inline]
  bd_start_claiming fs/block_dev.c:1118 [inline]
  blkdev_get+0x16a/0xb30 fs/block_dev.c:1604
  blkdev_get_by_path+0x5c/0xe0 fs/block_dev.c:1689
  mount_bdev+0x5d/0x3e0 fs/super.c:1122
  fuse_mount_blk+0x34/0x40 fs/fuse/inode.c:1222
  mount_fs+0xae/0x328 fs/super.c:1267
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404a9
RSP: 002b:00007fffca04f5f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004404a9
RDX: 00000000004a1d2c RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 0030656c69662f2e R08: 00007fffca04f610 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
