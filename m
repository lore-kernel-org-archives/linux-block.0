Return-Path: <3g1jLWwkbBUY067sittmzixxql.owwotm20mzkwv1mv1.kwui5jwmsmzvmt.ls@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 20 Oct 2018 09:32:03 -0700
In-Reply-To: <000000000000140c370577db5ece@google.com>
Message-ID: <0000000000006089ec0578ab8f08@google.com>
Subject: Re: KASAN: use-after-free Read in debugfs_remove (3)
From: syzbot <syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

syzbot has found a reproducer for the following crash on:

HEAD commit:    270b77a0f30e Merge tag 'drm-fixes-2018-10-20-1' of git://a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1678d019400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1248e21d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com

overlayfs: missing 'lowerdir'
overlayfs: missing 'lowerdir'
overlayfs: missing 'lowerdir'
overlayfs: missing 'lowerdir'
==================================================================
BUG: KASAN: use-after-free in debugfs_remove+0x10b/0x130  
fs/debugfs/inode.c:682
Read of size 8 at addr ffff8801c3d48a60 by task kworker/1:3/5820

CPU: 1 PID: 5820 Comm: kworker/1:3 Not tainted 4.19.0-rc8+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events __blk_release_queue
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
  blk_trace_shutdown+0x63/0x80 kernel/trace/blktrace.c:752
  __blk_release_queue+0x22d/0x500 block/blk-sysfs.c:852
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
kobject: 'mq' (00000000f4ee6bf8): kobject_uevent_env: filter function  
caused the event to drop!
kobject: '0' (000000001977fe41): kobject_add_internal: parent: 'mq',  
set: '<NULL>'
  kthread+0x35a/0x420 kernel/kthread.c:246
kobject: 'cpu0' (00000000e409d4ee): kobject_add_internal: parent: '0',  
set: '<NULL>'
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

kobject: 'cpu1' (000000004ffe025c): kobject_add_internal: parent: '0',  
set: '<NULL>'
Allocated by task 11189:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
kobject: 'queue' (00000000c1b3424e): kobject_uevent_env
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  __d_alloc+0xc8/0xcc0 fs/dcache.c:1614
  d_alloc+0x96/0x380 fs/dcache.c:1698
  d_alloc_parallel+0x15a/0x1f40 fs/dcache.c:2441
  __lookup_slow+0x1e6/0x540 fs/namei.c:1654
kobject: 'queue' (00000000c1b3424e): kobject_uevent_env: filter function  
caused the event to drop!
  lookup_one_len+0x1d8/0x220 fs/namei.c:2543
  start_creating+0xc6/0x200 fs/debugfs/inode.c:308
  __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  do_blk_trace_setup+0x454/0xda0 kernel/trace/blktrace.c:528
  __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x8bc/0x2010 block/ioctl.c:587
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
kobject: 'iosched' (000000001a1643a8): kobject_add_internal:  
parent: 'queue', set: '<NULL>'
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kobject: 'iosched' (000000001a1643a8): kobject_uevent_env

Freed by task 5443:
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
kobject: 'iosched' (000000001a1643a8): kobject_uevent_env: filter function  
caused the event to drop!
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801c3d48a20
  which belongs to the cache dentry of size 288
The buggy address is located 64 bytes inside of
  288-byte region [ffff8801c3d48a20, ffff8801c3d48b40)
The buggy address belongs to the page:
page:ffffea00070f5200 count:1 mapcount:0 mapping:ffff8801da978c40  
index:0xffff8801c3d488c0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000726ebc8 ffffea00071b0988 ffff8801da978c40
kobject: 'integrity' (000000000b36b365): kobject_add_internal:  
parent: 'loop0', set: '<NULL>'
raw: ffff8801c3d488c0 ffff8801c3d48080 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c3d48900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c3d48980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ffff8801c3d48a00: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801c3d48a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
kobject: 'integrity' (000000000b36b365): kobject_uevent_env
  ffff8801c3d48b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================
