Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CBC433DB
	for <linux-block@archiver.kernel.org>; Sat, 20 Mar 2021 20:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB11161938
	for <linux-block@archiver.kernel.org>; Sat, 20 Mar 2021 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCTUxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Mar 2021 16:53:54 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39309 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTUxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Mar 2021 16:53:24 -0400
Received: by mail-il1-f197.google.com with SMTP id v20so36924368ile.6
        for <linux-block@vger.kernel.org>; Sat, 20 Mar 2021 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4V27qZ8HGyrQu+l3shguVQUVaWwB04qajz95OS6c1nY=;
        b=KY16H+VE8w1m7lQ0bZ1kP0K5OUjNnwnSVrkCjvvoJj3augZPCoCI/tYA71dbhJgPkE
         LB6YSN/qa3zrhrtndGuC80BCNeZ92jdf99Z0GgyAbmRQ/w4SbL5ChwEpVynevmNaGaYQ
         4EakEhlHZ6IiTxV1+qXIXxlbah3GW6h0RV2YCZTbS8y/l8upkWmxBUtrof80aWezBXBV
         Ii2INg6W6r6f4Q0Pp70bnDXLUKTbNQ+BXTbReF55hNuiVBm6Obp4Ay5aI8wvErQTWS6o
         BplorCOj9ZPrpMOTeA2lUcy4+/VCTPZAdOEBqZKAJ+MY7NaUvrtuwExTXnXvxQaR8rNL
         EOdQ==
X-Gm-Message-State: AOAM5306G35eo51wivePTnwdqTD2J+quJdjre/Amz+ed3+SGDFp1z8xp
        ur/Ckl+J8Sp97ZxwpuOuQTmfJnwbRQBiV8tZpHdG9xjBwJKu
X-Google-Smtp-Source: ABdhPJx5niHz0GajqLEPAJmIyP55isEXpo/am+K2V0qoyfLIArUbxx/bntc1KqdEVVQVW6KgquGX88cpc3UHpX62X5RxAPMZETch
MIME-Version: 1.0
X-Received: by 2002:a92:da82:: with SMTP id u2mr6832094iln.301.1616273602363;
 Sat, 20 Mar 2021 13:53:22 -0700 (PDT)
Date:   Sat, 20 Mar 2021 13:53:22 -0700
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edc8ba05bdfe052d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1c273e10 Merge tag 'zonefs-5.12-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16889906d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dfe8bed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155a117cd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdev_nr_sectors include/linux/genhd.h:266 [inline]
BUG: KASAN: use-after-free in disk_part_iter_next+0x49d/0x530 block/genhd.c:206
Read of size 8 at addr ffff88803268d0a8 by task syz-executor193/10255

CPU: 0 PID: 10255 Comm: syz-executor193 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdev_nr_sectors include/linux/genhd.h:266 [inline]
 disk_part_iter_next+0x49d/0x530 block/genhd.c:206
 partition_overlaps+0x96/0x200 block/partitions/core.c:425
 bdev_add_partition+0x66/0x130 block/partitions/core.c:444
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:548
 block_ioctl+0xf9/0x140 fs/block_dev.c:1667
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445739
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca5947308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000445739
RDX: 0000000020000240 RSI: 0000000000001269 RDI: 0000000000000003
RBP: 00007ffca5947380 R08: 000000000000ece4 R09: 000000000000ece4
R10: 0023706f6f6c2f76 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffca5947370 R14: 00007ffca5947360 R15: 00007ffca594732c

Allocated by task 10192:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 __kasan_slab_alloc+0x75/0x90 mm/kasan/common.c:460
 kasan_slab_alloc include/linux/kasan.h:223 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 kmem_cache_alloc+0x155/0x370 mm/slub.c:2920
 bdev_alloc_inode+0x18/0x80 fs/block_dev.c:795
 alloc_inode+0x61/0x230 fs/inode.c:234
 new_inode_pseudo fs/inode.c:928 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:957
 bdev_alloc+0x20/0x2f0 fs/block_dev.c:885
 add_partition+0x1ab/0x880 block/partitions/core.c:346
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:449
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:548
 block_ioctl+0xf9/0x140 fs/block_dev.c:1667
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 0:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x92/0x210 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kmem_cache_free+0x8a/0x740 mm/slub.c:3177
 i_callback+0x3f/0x70 fs/inode.c:223
 rcu_do_batch kernel/rcu/tree.c:2559 [inline]
 rcu_core+0x74a/0x12f0 kernel/rcu/tree.c:2794
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:345

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3114
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x57e/0x810 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 disk_part_iter_exit block/genhd.c:235 [inline]
 disk_part_iter_next+0x9a/0x530 block/genhd.c:202
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:541
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1246
 __loop_clr_fd+0x7c7/0xff0 drivers/block/loop.c:1271
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1923
 __blkdev_put+0x54e/0x800 fs/block_dev.c:1588
 blkdev_put+0x92/0x580 fs/block_dev.c:1641
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1649
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3114
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x57e/0x810 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 disk_part_iter_exit block/genhd.c:235 [inline]
 disk_part_iter_next+0x9a/0x530 block/genhd.c:202
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:541
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1246
 __blkdev_get+0x86c/0xa30 fs/block_dev.c:1350
 blkdev_get_by_dev fs/block_dev.c:1454 [inline]
 blkdev_get_by_dev+0x26c/0x600 fs/block_dev.c:1422
 blkdev_reread_part block/ioctl.c:100 [inline]
 blkdev_common_ioctl+0x137e/0x17e0 block/ioctl.c:508
 blkdev_ioctl+0x1ef/0x6d0 block/ioctl.c:577
 block_ioctl+0xf9/0x140 fs/block_dev.c:1667
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803268d080
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff88803268d080, ffff88803268db68)
The buggy address belongs to the page:
page:ffffea0000c9a200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32688
head:ffffea0000c9a200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea0005110a00 0000000200000002 ffff8880109bdb40
raw: 0000000000000000 00000000800b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88803268cf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88803268d000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803268d080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88803268d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803268d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

