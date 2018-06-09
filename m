Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 9 Jun 2018 11:34:11 +0200
Message-ID: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
Subject: mainline boot is broken: KASAN: use-after-free in blk_flush_complete_seq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

Boot of mainline kernel is currently broken.
On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
Config:
https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
Should have been introduced very recently.

You may need to also patch "umh: fix race condition", because that's
another boot crasher currently present in tree.

==================================================================
BUG: KASAN: use-after-free in blk_flush_complete_seq+0xfde/0x1810
block/blk-flush.c:215
Read of size 4 at addr ffff880063f876d4 by task swapper/2/0

CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.17.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1a7/0x275 lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23c/0x360 mm/kasan/report.c:412
 __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
 blk_flush_complete_seq+0xfde/0x1810 block/blk-flush.c:215
 flush_end_io+0x523/0xb50 block/blk-flush.c:257
 blk_finish_request+0x3fa/0x6a0 block/blk-core.c:3209
 scsi_end_request+0x3d3/0x820 drivers/scsi/scsi_lib.c:715
 scsi_io_completion+0x1869/0x1910 drivers/scsi/scsi_lib.c:898
 scsi_finish_command+0x4de/0x8d0 drivers/scsi/scsi.c:248
 scsi_softirq_done+0x3ad/0x4b0 drivers/scsi/scsi_lib.c:1683
 blk_done_softirq+0x48c/0x700 block/blk-softirq.c:37
 __do_softirq+0x2e0/0xb94 kernel/softirq.c:284
 invoke_softirq kernel/softirq.c:364 [inline]
 irq_exit+0x1cc/0x200 kernel/softirq.c:404
 exiting_irq arch/x86/include/asm/apic.h:525 [inline]
 do_IRQ+0xf1/0x190 arch/x86/kernel/irq.c:257
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
 </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
Code: 48 89 df e8 5c 88 a3 fa e9 51 ff ff ff 4c 89 ef e8 4f 88 a3 fa
eb 9b 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3
0f 1f 84 00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0000:ffff88006bdcfc38 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffde
RAX: dffffc0000000000 RBX: 1ffff1000d7b9f8a RCX: 0000000000000000
RDX: 1ffffffff10e2b78 RSI: 0000000000000001 RDI: ffffffff88715bc0
RBP: ffff88006bdcfc38 R08: ffffed000d9246d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88006bdcfcf0 R14: 0000000000000000 R15: ffffffff88715bb0
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0xbf/0x440 arch/x86/kernel/process.c:500
 arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
 default_idle_call+0x36/0x90 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x345/0x560 kernel/sched/idle.c:262
 cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
 start_secondary+0x42b/0x5b0 arch/x86/kernel/smpboot.c:265
 secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 1:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:553
 __do_kmalloc_node mm/slab.c:3682 [inline]
 __kmalloc_node+0x47/0x70 mm/slab.c:3689
 kmalloc_node include/linux/slab.h:555 [inline]
 alloc_request_size+0x80/0x120 block/blk-core.c:844
 mempool_alloc+0x16c/0x4b0 mm/mempool.c:384
 __get_request block/blk-core.c:1424 [inline]
 get_request+0xe04/0x2480 block/blk-core.c:1535
 blk_queue_bio+0x5e9/0x1980 block/blk-core.c:2054
 generic_make_request+0x919/0x1540 block/blk-core.c:2447
 submit_bio+0x19a/0x4d0 block/blk-core.c:2555
 submit_bio_wait+0x137/0x1e0 block/bio.c:977
 blkdev_issue_flush+0x204/0x2f0 block/blk-flush.c:551
 jbd2_journal_recover+0x3f3/0x4b0 fs/jbd2/recovery.c:289
 jbd2_journal_load+0x256/0xca0 fs/jbd2/journal.c:1686
 ext4_load_journal fs/ext4/super.c:4704 [inline]
 ext4_fill_super+0x8e60/0xb700 fs/ext4/super.c:4076
 mount_bdev+0x2ba/0x370 fs/super.c:1174
 ext4_mount+0x34/0x40 fs/ext4/super.c:5771
 mount_fs+0x6b/0x2d0 fs/super.c:1277
 vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
 vfs_kern_mount fs/namespace.c:2515 [inline]
 do_new_mount fs/namespace.c:2518 [inline]
 do_mount+0xea4/0x2bd0 fs/namespace.c:2848
 ksys_mount+0xab/0x120 fs/namespace.c:3064
 do_mount_root init/do_mounts.c:366 [inline]
 mount_block_root+0x381/0x685 init/do_mounts.c:395
 mount_root+0x287/0x2bb init/do_mounts.c:540
 prepare_namespace+0x1cf/0x20c init/do_mounts.c:599
 kernel_init_freeable+0x53f/0x55d init/main.c:1154
 kernel_init+0x13/0x180 init/main.c:1061
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Freed by task 0:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kfree+0xd9/0x260 mm/slab.c:3813
 free_request_size+0x5b/0x70 block/blk-core.c:859
 mempool_free+0xda/0x350 mm/mempool.c:493
 blk_free_request block/blk-core.c:1210 [inline]
 __blk_put_request+0x513/0xc70 block/blk-core.c:1768
 blk_finish_request+0x349/0x6a0 block/blk-core.c:3214
 __blk_end_bidi_request+0xeb/0x1e0 block/blk-core.c:3278
 __blk_end_request_all+0x129/0x270 block/blk-core.c:3368
 blk_flush_complete_seq+0xf92/0x1810 block/blk-flush.c:208
 flush_end_io+0x523/0xb50 block/blk-flush.c:257
 blk_finish_request+0x3fa/0x6a0 block/blk-core.c:3209
 scsi_end_request+0x3d3/0x820 drivers/scsi/scsi_lib.c:715
 scsi_io_completion+0x1869/0x1910 drivers/scsi/scsi_lib.c:898
 scsi_finish_command+0x4de/0x8d0 drivers/scsi/scsi.c:248
 scsi_softirq_done+0x3ad/0x4b0 drivers/scsi/scsi_lib.c:1683
 blk_done_softirq+0x48c/0x700 block/blk-softirq.c:37
 __do_softirq+0x2e0/0xb94 kernel/softirq.c:284

The buggy address belongs to the object at ffff880063f876c0
 which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 20 bytes inside of
 1024-byte region [ffff880063f876c0, ffff880063f87ac0)
The buggy address belongs to the page:
page:ffffea00018fe180 count:1 mapcount:0 mapping:ffff88006c400ac0
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000008100(slab|head)
raw: 01fffc0000008100 ffffea00018fe108 ffff88006c401848 ffff88006c400ac0
raw: 0000000000000000 ffff880063f86040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880063f87580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff880063f87600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff880063f87680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                 ^
 ffff880063f87700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880063f87780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
