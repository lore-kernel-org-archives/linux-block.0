Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3F2EBBA1
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966332; cv=none; b=KMWyxnI6Aq2h+kJMWiWf6YhATB80ApcFZS7kYxnd5v60jYFCrzZcgNHs+z6umufhKw+QNzWwq2plQ/rqAOOWj65RdbRkir644yWYVLE1rNzmsFbdMhaESObX2al17oqHlJUxTqz/Tt8TxIp624a3K/TOsdiNakcqp9+E4sN6VzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966332; c=relaxed/simple;
	bh=2T3jIQk1/OjLMW7vFl3yQ7gt+9vgVJd5ceD8zGX+wiE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Roc9D06JylVbJGIFG+DpYOHnVop5GeIyUHLmtUQ8z/WKj7iBBWlajBfF2/6I75MfGiIS/vq4qCRbWz8ysHInEp+MUmiyLjJ6FemNUx4VxZyn4RjCJVQgxLGZjg+etUFQNB6Nv8G4dbN3FVA4zWRBIaeEWayyhjptXl0UAu4axiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dbd1866b66so16634112a34.1
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 10:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966330; x=1777571130;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eAR9jds46qbJnYTgWM5rGjuPHjjBlsxSQPn7dK1LY4=;
        b=PvnjvLon4hAjRralOYcTMmXJzH4GXs/nvl7IqHVNSctG+MWyy8dKRY6Rc08n2uOYbZ
         dRDdV8YRmiwlFiRA0xnHUxidVzUSWnM6wzL8Ma5m2r0sQL7D3YZjgYNgEaURXRTtAH5i
         D8CfDHAFYEoQxSzYOzKHGZPbX7fwqjCM5Lz22R/00wOH+JF2Sj8Xe+npqKrtss+aXeez
         yIj7uc4oNH56nPZrno7+Hlml0Rh43435qsPz/t48aKUfou6cYNU1I2E13W1P2KNwdyjA
         pl3R4AGRin42HegNNEEh+G5dlsdbt9jHNqbNmA6DkgwsN1uhJjMwqqkhQGg+9WAFPfQF
         BFGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zk3+EXRj1YMDXJIRQiOUznvGUGBw3G2gpMVgGahj2cdYdl+/iTarkmPVWYKdOhucO2N01JHuX6gCGOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhN2Oc4cd0v7Y1QSfTLJpHUk+a9FzajJxVdvJ+HqGPQQVClLVS
	sKXbOKAYpHGsF2qupxJeXeaYd2yNHwIkeDfTvegYsJqXwg5zX17rkiSZxFM5jBG7gi7bD/jWObg
	ueZXwaV8cSZ64vLihsolXP5nPVMjUntroW54Vj6knkFLxFebHWgzoTNbW7OA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2227:b0:695:b571:e57a with SMTP id
 006d021491bc7-695b571fb6amr4131589eaf.33.1776966329838; Thu, 23 Apr 2026
 10:45:29 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea5ab9.a00a0220.17a17.0046.GAE@google.com>
Subject: [syzbot] [block?] KASAN: slab-out-of-bounds Read in blk_mq_free_rqs
From: syzbot <syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a30aeb0d1b4 Merge tag 'nfsd-7.0-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163e72da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=555131780f7c7272
dashboard link: https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dc05dfe27bf/disk-8a30aeb0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec5900e43ce7/vmlinux-8a30aeb0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66501ac91f88/bzImage-8a30aeb0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in blk_mq_free_rqs+0x6e2/0x760 block/blk-mq.c:3486
Read of size 8 at addr ffff888027b4f7e8 by task syz.3.686/9329

CPU: 0 UID: 0 PID: 9329 Comm: syz.3.686 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 blk_mq_free_rqs+0x6e2/0x760 block/blk-mq.c:3486
 blk_mq_free_map_and_rqs block/blk-mq.c:4157 [inline]
 blk_mq_free_map_and_rqs+0x30/0x120 block/blk-mq.c:4152
 blk_mq_free_sched_tags+0xeb/0x1b0 block/blk-mq-sched.c:425
 blk_mq_free_sched_res+0x52/0x150 block/blk-mq-sched.c:436
 elevator_change_done+0x187/0x650 block/elevator.c:639
 elevator_change+0x2d7/0x530 block/elevator.c:685
 elevator_set_none+0x92/0xf0 block/elevator.c:769
 blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
 blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5220
 nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
 nbd_start_device_ioctl drivers/block/nbd.c:1548 [inline]
 __nbd_ioctl drivers/block/nbd.c:1623 [inline]
 nbd_ioctl+0x4a6/0xd30 drivers/block/nbd.c:1663
 blkdev_ioctl+0x5ad/0x6f0 block/ioctl.c:804
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f854359c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f854451d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8543815fa0 RCX: 00007f854359c799
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f8543632c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8543816038 R14: 00007f8543815fa0 R15: 00007ffc336cfa78
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5260 [inline]
 __kmalloc_node_noprof+0x307/0x850 mm/slub.c:5266
 kmalloc_array_node_noprof include/linux/slab.h:1169 [inline]
 blk_mq_alloc_tag_set+0x477/0x1330 block/blk-mq.c:4903
 nbd_dev_add+0x342/0xb10 drivers/block/nbd.c:1933
 nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
 do_one_initcall+0x11d/0x760 init/main.c:1382
 do_initcall_level init/main.c:1444 [inline]
 do_initcalls init/main.c:1460 [inline]
 do_basic_setup init/main.c:1479 [inline]
 kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
 kernel_init+0x1f/0x1e0 init/main.c:1582
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888027b4f7e0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888027b4f7e0, ffff888027b4f7e8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888027b4f680 pfn:0x27b4f
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813fe39500 ffffea0000abdd90 ffffea0000d70550
raw: ffff888027b4f680 000000080080007b 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 5607902614, free_ts 5601697774
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x111d/0x3140 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x27c/0x2ba0 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3481 [inline]
 new_slab+0xa6/0x6b0 mm/slub.c:3539
 refill_objects+0x26b/0x400 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1ab/0x660 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_node_track_caller_noprof+0x694/0x850 mm/slub.c:5368
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x51/0xe0 mm/util.c:84
 kstrdup_const+0x63/0x80 mm/util.c:104
 __kernfs_new_node+0x9b/0x960 fs/kernfs/dir.c:633
 kernfs_new_node+0x11b/0x1a0 fs/kernfs/dir.c:718
 kernfs_create_link+0xcc/0x240 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x90/0x140 fs/sysfs/symlink.c:44
 sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
 sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
 device_add_class_symlinks drivers/base/core.c:3448 [inline]
 device_add+0x675/0x1950 drivers/base/core.c:3640
 __add_disk+0x518/0xe40 block/genhd.c:496
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7e1/0x10d0 mm/page_alloc.c:2978
 vfree.part.0+0x12b/0x9d0 mm/vmalloc.c:3479
 vfree mm/vmalloc.c:3456 [inline]
 delayed_vfree_work+0x8e/0xd0 mm/vmalloc.c:3398
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888027b4f680: fa fc fc fc fa fc fc fc fa fc fc fc 05 fc fc fc
 ffff888027b4f700: 06 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
>ffff888027b4f780: 00 fc fc fc 05 fc fc fc 00 fc fc fc 00 fc fc fc
                                                          ^
 ffff888027b4f800: 06 fc fc fc 06 fc fc fc 06 fc fc fc 05 fc fc fc
 ffff888027b4f880: 05 fc fc fc 05 fc fc fc 05 fc fc fc 02 fc fc fc
==================================================================
block nbd3: shutting down sockets


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
