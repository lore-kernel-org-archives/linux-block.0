Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41337 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeDHSVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Apr 2018 14:21:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id bj1-v6so3752337plb.8
        for <linux-block@vger.kernel.org>; Sun, 08 Apr 2018 11:21:07 -0700 (PDT)
Date: Sun, 8 Apr 2018 11:21:49 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+148f2573ec86c854cdac7339c41b98e31a94150a@syzkaller.appspotmail.com>
Cc: syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: KASAN: use-after-free Read in disk_unblock_events
Message-ID: <20180408182149.GA685@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001a114089d6ad9947055cc8b446@google.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 30 Oct 2017 12:32:58 -0700, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on  
> 36ef71cae353f88fd6e095e2aaa3e5953af1685d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> BUG: KASAN: use-after-free in disk_unblock_events+0x51/0x60  
> block/genhd.c:1632
> Read of size 8 at addr ffff8801d9049a80 by task blkid/14807
> 
> CPU: 1 PID: 14807 Comm: blkid Not tainted 4.14.0-rc5-next-20171018+ #36
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:16 [inline]
>   dump_stack+0x194/0x257 lib/dump_stack.c:52
>   print_address_description+0x73/0x250 mm/kasan/report.c:252
>   kasan_report_error mm/kasan/report.c:351 [inline]
>   kasan_report+0x25b/0x340 mm/kasan/report.c:409
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>   disk_unblock_events+0x51/0x60 block/genhd.c:1632
>   __blkdev_get+0x78d/0xf90 fs/block_dev.c:1535
>   blkdev_get+0x3a1/0xad0 fs/block_dev.c:1591
>   blkdev_open+0x1c9/0x250 fs/block_dev.c:1749
>   do_dentry_open+0x664/0xd40 fs/open.c:752
>   vfs_open+0x107/0x220 fs/open.c:866
>   do_last fs/namei.c:3387 [inline]
>   path_openat+0x1151/0x3520 fs/namei.c:3527
>   do_filp_open+0x25b/0x3b0 fs/namei.c:3562
>   do_sys_open+0x502/0x6d0 fs/open.c:1059
>   SYSC_open fs/open.c:1077 [inline]
>   SyS_open+0x2d/0x40 fs/open.c:1072
>   entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x7ff2d528f120
> RSP: 002b:00007ffd153fa6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2d528f120
> RDX: 00007ffd153fbf35 RSI: 0000000000000000 RDI: 00007ffd153fbf35
> RBP: 0000000000000082 R08: 0000000000000078 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001fca030
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000005
> 
> Allocated by task 14811:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>   set_track mm/kasan/kasan.c:459 [inline]
>   kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>   kmem_cache_alloc_node_trace+0x150/0x750 mm/slab.c:3657
>   kmalloc_node include/linux/slab.h:540 [inline]
>   kzalloc_node include/linux/slab.h:702 [inline]
>   alloc_disk_node+0xb4/0x4e0 block/genhd.c:1375
>   alloc_disk+0x18/0x20 block/genhd.c:1359
>   loop_add+0x45c/0xa50 drivers/block/loop.c:1808
>   loop_probe+0x16d/0x1a0 drivers/block/loop.c:1915
>   kobj_lookup+0x2ac/0x410 drivers/base/map.c:124
>   get_gendisk+0x37/0x230 block/genhd.c:773
>   bd_start_claiming fs/block_dev.c:1097 [inline]
>   blkdev_get+0x12d/0xad0 fs/block_dev.c:1584
>   blkdev_open+0x1c9/0x250 fs/block_dev.c:1749
>   do_dentry_open+0x664/0xd40 fs/open.c:752
>   vfs_open+0x107/0x220 fs/open.c:866
>   do_last fs/namei.c:3387 [inline]
>   path_openat+0x1151/0x3520 fs/namei.c:3527
>   do_filp_open+0x25b/0x3b0 fs/namei.c:3562
>   do_sys_open+0x502/0x6d0 fs/open.c:1059
>   SYSC_open fs/open.c:1077 [inline]
>   SyS_open+0x2d/0x40 fs/open.c:1072
>   entry_SYSCALL_64_fastpath+0x1f/0xbe
> 
> Freed by task 14807:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>   set_track mm/kasan/kasan.c:459 [inline]
>   kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>   __cache_free mm/slab.c:3492 [inline]
>   kfree+0xca/0x250 mm/slab.c:3807
>   disk_release+0x327/0x410 block/genhd.c:1218
>   device_release+0x7c/0x200 drivers/base/core.c:814
>   kobject_cleanup lib/kobject.c:648 [inline]
>   kobject_release lib/kobject.c:677 [inline]
>   kref_put include/linux/kref.h:70 [inline]
>   kobject_put+0x14c/0x240 lib/kobject.c:694
>   put_disk+0x23/0x30 block/genhd.c:1440
>   __blkdev_get+0x6ed/0xf90 fs/block_dev.c:1528
>   blkdev_get+0x3a1/0xad0 fs/block_dev.c:1591
>   blkdev_open+0x1c9/0x250 fs/block_dev.c:1749
>   do_dentry_open+0x664/0xd40 fs/open.c:752
>   vfs_open+0x107/0x220 fs/open.c:866
>   do_last fs/namei.c:3387 [inline]
>   path_openat+0x1151/0x3520 fs/namei.c:3527
>   do_filp_open+0x25b/0x3b0 fs/namei.c:3562
>   do_sys_open+0x502/0x6d0 fs/open.c:1059
>   SYSC_open fs/open.c:1077 [inline]
>   SyS_open+0x2d/0x40 fs/open.c:1072
>   entry_SYSCALL_64_fastpath+0x1f/0xbe
>
> The buggy address belongs to the object at ffff8801d9049500
>   which belongs to the cache kmalloc-2048 of size 2048
> The buggy address is located 1408 bytes inside of
>   2048-byte region [ffff8801d9049500, ffff8801d9049d00)
> The buggy address belongs to the page:
> page:ffffea0007641200 count:1 mapcount:0 mapping:ffff8801d9048400 index:0x0  
> compound_mapcount: 0
> flags: 0x200000000008100(slab|head)
> raw: 0200000000008100 ffff8801d9048400 0000000000000000 0000000100000003
> raw: ffffea000748e5a0 ffffea0007063920 ffff8801dac00c40 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff8801d9049980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8801d9049a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8801d9049a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff8801d9049b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8801d9049b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title

Last occurred 2 months ago, seems to have been fixed by commit 897366537fb6
(thanks Jan!), so telling syzbot:

#syz fix: genhd: Fix use after free in __blkdev_get()

- Eric
