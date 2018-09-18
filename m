Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
From: Kyungtae Kim <kt0755@gmail.com>
Date: Tue, 18 Sep 2018 13:40:49 -0400
Message-ID: <CAEAjamu1FRhz6StCe_55XY5s389ZP_xmCF69k987En+1z53=eg@mail.gmail.com>
Subject: KASAN: use-after-free Read in raw_cmd_done
To: jikos@kernel.org, axboe@kernel.dk
Cc: DaeRyong Jeong <threeearcat@gmail.com>, Byoungyoung Lee <lifeasageek@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

We report the crash:
KASAN: use-after-free in raw_cmd_done

This crash was found in v4.19-rc2 using Alexkidd-fuzzer (a modified
version of Syzkaller).
Our analysis shows that the race arose between a kernel thread (kworker) and
the invoked ioctl syscall.

kernel config: https://kt0755.github.io/etc/config-4.19-rc2
repro: https://kt0755.github.io/etc/repro.92596.c

Analysis:
When there is a race between "raw_cmd_done"
(driver/block/floppy.c:3054) and "raw_cmd_free" (driver/block/floppy.c:3115),
a pointer variable "raw_cmd" in raw_cmd_done may point to the
freed memory area. When raw_cmd_done dereferences this
pointer, use-after-free occurs.


<Thread-0 (raw_cmd_ioctl)>               <Thread-1 (floppy_shutdown)>

1. raw_cmd_copyin(&my_raw_cmd)
     // allocate my_raw_cmd
2. raw_cmd = my_raw_cmd
3. cont = &raw_cmd_cont
4. wait_til_done(floppy_start)
-------------------------------------------------------------------------------------------
                                                               5. cont->done(0)
                                                                  //
call raw_cmd_done()
------------------------------------------------------------------------------------------
6. raw_cmd_free(&my_raw_cmd)
      // kfree(my_raw_cmd)
------------------------------------------------------------------------------------------
                                                               7. rmd_cmd->flag

// Use-after-free

# Call Sequence
<Thread-0>
fd_ioctl
  fd_locked_ioctl
    raw_cmd_ioctl
      raw_cmd_free

<Thread-1>
worker_thread
  process_one_work
    floppy_shutdown
      raw_cmd_done


We observed that raw_cmd_ioctl (say T0) is invoked by fd_locked_ioctl
(FDRAWCMD).
It first allocates "raw_cmd" (driver/block/floppy.c:3212), and then
wait until floppy_start is done. In the meantime, floppy_shutdown scheduled
by floppy_start is called (say T1) and invokes raw_cmd_done.
Unfortunately, before raw_cmd_done accesses raw_cmd, T0 waked up and
deallocated raw_cmd in raw_cmd_free (driver/block/floppy.c:3225).
So the access to raw_cmd (by T1) fails.
We suspect that the insufficient locking between raw_cmd_done and
raw_cnd_free, is the cause of the crash.

Crash log
==================================================================
BUG: KASAN: use-after-free in raw_cmd_done+0x58a/0x5e0
drivers/block/floppy.c:3054
Read of size 4 at addr ffff880119b35cc0 by task kworker/u4:0/7

CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.19.0-rc2 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy floppy_shutdown
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 print_address_description+0x7f/0x2c0 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x271/0x3a0 mm/kasan/report.c:412
 __asan_report_load4_noabort+0x19/0x20 mm/kasan/report.c:432
 raw_cmd_done+0x58a/0x5e0 drivers/block/floppy.c:3054
 floppy_shutdown+0x127/0x1f0 drivers/block/floppy.c:1851
 process_one_work+0x923/0x1690 kernel/workqueue.c:2153
 worker_thread+0x8f/0xcf0 kernel/workqueue.c:2296
 kthread+0x3a3/0x470 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Allocated by task 16211:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc5/0xf0 mm/kasan/kasan.c:553
 kmem_cache_alloc_trace+0x14a/0x2b0 mm/slub.c:2733
 kmalloc include/linux/slab.h:513 [inline]
 raw_cmd_copyin drivers/block/floppy.c:3130 [inline]
 raw_cmd_ioctl drivers/block/floppy.c:3206 [inline]
 fd_locked_ioctl+0x608/0x21b0 drivers/block/floppy.c:3544
 fd_ioctl+0x40/0x60 drivers/block/floppy.c:3571
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0xb48/0x1a50 block/ioctl.c:601
 block_ioctl+0x105/0x150 fs/block_dev.c:1883
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 16211:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x14d/0x1a0 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 slab_free_hook mm/slub.c:1371 [inline]
 slab_free_freelist_hook mm/slub.c:1398 [inline]
 slab_free mm/slub.c:2953 [inline]
 kfree+0x109/0x2f0 mm/slub.c:3906
 raw_cmd_free+0x82/0x170 drivers/block/floppy.c:3115
 raw_cmd_ioctl drivers/block/floppy.c:3225 [inline]
 fd_locked_ioctl+0x1d37/0x21b0 drivers/block/floppy.c:3544
 fd_ioctl+0x40/0x60 drivers/block/floppy.c:3571
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0xb48/0x1a50 block/ioctl.c:601
 block_ioctl+0x105/0x150 fs/block_dev.c:1883
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880119b35cc0
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff880119b35cc0, ffff880119b35d40)
The buggy address belongs to the page:
page:ffffea000466cd40 count:1 mapcount:0 mapping:ffff88011a403500 index:0x0
flags: 0x200000000000100(slab)
raw: 0200000000000100 ffffea0004042700 0000000700000007 ffff88011a403500
raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880119b35b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff880119b35c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff880119b35c80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                           ^
 ffff880119b35d00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff880119b35d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
