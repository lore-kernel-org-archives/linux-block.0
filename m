Return-Path: <3n7O9WwkbBeAUabMCNNGTCRRKF.IQQINGWUGTEQPVGPV.EQOCZDQGMGTPGN.FM@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 10 Oct 2018 01:09:03 -0700
Message-ID: <000000000000140c370577db5ece@google.com>
Subject: KASAN: use-after-free Read in debugfs_remove (3)
From: syzbot <syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148516a1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com

QAT: Invalid ioctl
==================================================================
BUG: KASAN: use-after-free in debugfs_remove+0x10b/0x130  
fs/debugfs/inode.c:682
Read of size 8 at addr ffff880173458460 by task syz-executor0/8436

CPU: 1 PID: 8436 Comm: syz-executor0 Not tainted 4.19.0-rc7+ #274
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  debugfs_remove+0x10b/0x130 fs/debugfs/inode.c:682
  blk_trace_free+0x35/0x130 kernel/trace/blktrace.c:312
  blk_trace_cleanup kernel/trace/blktrace.c:339 [inline]
  __blk_trace_remove+0x7a/0xa0 kernel/trace/blktrace.c:352
  blk_trace_ioctl+0x243/0x2f0 kernel/trace/blktrace.c:730
  blkdev_ioctl+0x8bc/0x2010 block/ioctl.c:587
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
dccp_close: ABORT with 1061 bytes unread
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f55a7fc7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
dccp_close: ABORT with 105978 bytes unread
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f55a7fc86d4
R13: 00000000004bea1e R14: 00000000004ce728 R15: 00000000ffffffff

Allocated by task 8444:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  __d_alloc+0xc8/0xcc0 fs/dcache.c:1614
  d_alloc+0x96/0x380 fs/dcache.c:1698
  d_alloc_parallel+0x15a/0x1f40 fs/dcache.c:2441
  __lookup_slow+0x1e6/0x540 fs/namei.c:1654
  lookup_one_len+0x1d8/0x220 fs/namei.c:2543
  start_creating+0xc6/0x200 fs/debugfs/inode.c:308
  __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  do_blk_trace_setup+0x454/0xda0 kernel/trace/blktrace.c:528
  __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x8bc/0x2010 block/ioctl.c:587
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
QAT: Invalid ioctl
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8444:
QAT: Invalid ioctl
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff880173458420
  which belongs to the cache dentry(17:syz0) of size 288
The buggy address is located 64 bytes inside of
  288-byte region [ffff880173458420, ffff880173458540)
The buggy address belongs to the page:
page:ffffea0005cd1600 count:1 mapcount:0 mapping:ffff8801ca231c80 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0005d3fec8 ffff8801ce0f5848 ffff8801ca231c80
raw: 0000000000000000 ffff880173458000 000000010000000b ffff880186fa62c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff880186fa62c0
QAT: Invalid ioctl

Memory state around the buggy address:
  ffff880173458300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff880173458380: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ffff880173458400: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff880173458480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880173458500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
