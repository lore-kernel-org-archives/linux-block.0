Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8458BC433DB
	for <linux-block@archiver.kernel.org>; Sun, 14 Mar 2021 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A5A64EC3
	for <linux-block@archiver.kernel.org>; Sun, 14 Mar 2021 11:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhCNLIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Mar 2021 07:08:47 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51694 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhCNLIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Mar 2021 07:08:15 -0400
Received: by mail-il1-f200.google.com with SMTP id y11so22071260ilc.18
        for <linux-block@vger.kernel.org>; Sun, 14 Mar 2021 04:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LaictTX5V5YWajK3UC2MhCvWWWbTxgBXC6jz+KlPajY=;
        b=RTJDV4mASeD07FoHG3V5mvQlaoz00Iku5fCFC442XU7fLt5ovsyIJqb8HG65cGiJss
         ASBY82lUUkw9ZYLANxQaXWz2xPuhQZpKzN6JsBiUmE549qTHr5PRYDFmYTKZNc7i6r0H
         bYJhWSnzM8gpuaNRTOiqy9FBXMsfQAaK873Z89zUmFxMGw9Y+8mcqpFIbl/5IyyGRgEV
         uZCcUaOlkvUHqVPcdExYuiM3V2ivrGySMzqUvtNw/hTq/DVpPePlWDJwbtC4ijwFBZLb
         QtYbo4hU8S5SAfX45bOVcqHywIfPF9o2Ilru0tudj5DouPGIH7wvB+J/+TCD63cTVOMP
         1LiQ==
X-Gm-Message-State: AOAM533O5kyixXv4uu5dzEJV1nfvUBb/vo1YgN7d0HjMySPJZiJoFgVg
        RtdfsxmPhglS2qLw/AkdC7WHlqHcQfOovAyK/wunSB6D+tfe
X-Google-Smtp-Source: ABdhPJxQaqYn9qQamJFWL1Xa7J4WQdX9CFPHnbR13AQExG9jc1GbxRlOjdLdCnIhYuNQo3Cezf7VnjWFjXCFXbjAM3kYpKTG8Hjg
MIME-Version: 1.0
X-Received: by 2002:a5d:9510:: with SMTP id d16mr4422246iom.81.1615720095142;
 Sun, 14 Mar 2021 04:08:15 -0700 (PDT)
Date:   Sun, 14 Mar 2021 04:08:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053da9405bd7d2644@google.com>
Subject: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdev_nr_sectors include/linux/genhd.h:266 [inline]
BUG: KASAN: use-after-free in disk_part_iter_next+0x49d/0x530 block/genhd.c:207
Read of size 8 at addr ffff88804b0022e8 by task systemd-udevd/9804

CPU: 1 PID: 9804 Comm: systemd-udevd Not tainted 5.12.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2c6 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdev_nr_sectors include/linux/genhd.h:266 [inline]
 disk_part_iter_next+0x49d/0x530 block/genhd.c:207
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:543
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1237
 __loop_clr_fd+0x7c7/0xff0 drivers/block/loop.c:1271
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1923
 __blkdev_put+0x54e/0x800 fs/block_dev.c:1579
 blkdev_put+0x92/0x580 fs/block_dev.c:1632
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1640
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8141652270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffe05d67588 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007f8141652270
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f814250c710 R08: 000055e767969790 R09: 000055e767968300
R10: 00007f814250c8c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000055e767979eb0 R14: 0000000000000003 R15: 000000000000000e

Allocated by task 9582:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 __kasan_slab_alloc+0x73/0x90 mm/kasan/common.c:460
 kasan_slab_alloc include/linux/kasan.h:223 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc mm/slab.c:3325 [inline]
 kmem_cache_alloc+0x1c3/0x4f0 mm/slab.c:3502
 bdev_alloc_inode+0x18/0x80 fs/block_dev.c:786
 alloc_inode+0x61/0x230 fs/inode.c:234
 new_inode_pseudo fs/inode.c:928 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:957
 bdev_alloc+0x20/0x2f0 fs/block_dev.c:876
 add_partition+0x1ab/0x8a0 block/partitions/core.c:348
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:451
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:548
 block_ioctl+0xf9/0x140 fs/block_dev.c:1658
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8676:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xc7/0x100 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 __cache_free mm/slab.c:3440 [inline]
 kmem_cache_free+0x6f/0x1d0 mm/slab.c:3733
 i_callback+0x3f/0x70 fs/inode.c:223
 rcu_do_batch kernel/rcu/tree.c:2559 [inline]
 rcu_core+0x722/0x1280 kernel/rcu/tree.c:2794
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:345

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x700 kernel/rcu/tree.c:3114
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x57e/0x810 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 disk_part_iter_exit block/genhd.c:236 [inline]
 disk_part_iter_next+0x9a/0x530 block/genhd.c:203
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:543
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1237
 loop_reread_partitions+0x29/0x50 drivers/block/loop.c:655
 loop_set_status+0x704/0x1050 drivers/block/loop.c:1418
 loop_set_status64 drivers/block/loop.c:1538 [inline]
 lo_ioctl+0x4ca/0x1620 drivers/block/loop.c:1706
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:583
 block_ioctl+0xf9/0x140 fs/block_dev.c:1658
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88804b0022c0
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff88804b0022c0, ffff88804b002da8)
The buggy address belongs to the page:
page:00000000708f9251 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804b002fff pfn:0x4b002
flags: 0x4fff00000000200(slab)
raw: 04fff00000000200 ffffea00010ecd48 ffffea00012c2fc8 ffff888010b95700
raw: ffff88804b002fff ffff88804b0022c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88804b002180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804b002200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804b002280: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff88804b002300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804b002380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
