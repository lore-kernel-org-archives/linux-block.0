Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C5C433DB
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 21:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9A46191F
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCUVjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Mar 2021 17:39:23 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51167 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCUVjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Mar 2021 17:39:09 -0400
Received: by mail-il1-f199.google.com with SMTP id b14so15904634ilv.17
        for <linux-block@vger.kernel.org>; Sun, 21 Mar 2021 14:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=snG14cpDB0Goni3WBkcna2wa98UcNbm0/Nb2FkEkcl4=;
        b=bFBFpoCgALIivXdMw78+1NFsuIIlZkZVBMGhoc5xRvgFqlH/495nhm9fHFHCnLr+mU
         MJc8E7Wi77k1Vs82uJ+Qst8eMvlLEpuTE5jK4Qxoa3IHfJqUm+4r9FyFxwx1xWszbrAc
         zjGH6b9Kez7Wg5fks+fbtZZXrBSeyT52cDs6RkazWBeVUBJhl8mdLU8Dms5hzaTWjl/r
         cMPTrxoBsdWafAICIXc+UJehwwVWSL3wBfMHR+dVeSWQZJT/IPzFrif+C8w8gM+Vcz1J
         1BgyKYhxXn9mhitORiRkRHhMfpZTP07M9sQPqsFNPSrkqE60XjhrrQ1Trtq/MfIcMCs9
         Mr+g==
X-Gm-Message-State: AOAM530s/W59mMKLylk+JRw/a38lXmCng2x86aatK+Dvp1xY58FGReDZ
        2dHVsP+c7ufzpSC/lUfP2OLfygdlMXnXStfLZ2RAwQrQqTtV
X-Google-Smtp-Source: ABdhPJwEvfK4es/UewD5ayJHa7lJAU6l7bJYF/d2GZ/F7oJg0ia88IH70D/a2/qPNBqadyrMchnbFGNj1eh2G8XXQC+n+A6yh9pA
MIME-Version: 1.0
X-Received: by 2002:a92:c561:: with SMTP id b1mr2131410ilj.165.1616362749312;
 Sun, 21 Mar 2021 14:39:09 -0700 (PDT)
Date:   Sun, 21 Mar 2021 14:39:09 -0700
In-Reply-To: <f40ed33d-8ca2-a2f2-e534-9db9920570ad@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008046aa05be12c7cc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in disk_part_iter_next

==================================================================
BUG: KASAN: use-after-free in bdev_nr_sectors include/linux/genhd.h:266 [inline]
BUG: KASAN: use-after-free in disk_part_iter_next+0x49d/0x530 block/genhd.c:206
Read of size 8 at addr ffff88801626b9a8 by task syz-executor.0/10146

CPU: 0 PID: 10146 Comm: syz-executor.0 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdev_nr_sectors include/linux/genhd.h:266 [inline]
 disk_part_iter_next+0x49d/0x530 block/genhd.c:206
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:543
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
RIP: 0033:0x41926b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffc4fc09520 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000041926b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b30620070
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000056c9e0
R13: 000000000056c9e0 R14: 000000000056bf60 R15: 0000000000013222

Allocated by task 10160:
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
 add_partition+0x1ab/0x880 block/partitions/core.c:348
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:451
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

Freed by task 13:
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
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:543
 bdev_disk_changed+0x238/0x430 fs/block_dev.c:1246
 loop_reread_partitions+0x29/0x50 drivers/block/loop.c:655
 loop_set_status+0x704/0x1050 drivers/block/loop.c:1418
 loop_set_status64 drivers/block/loop.c:1538 [inline]
 lo_ioctl+0x4ca/0x1620 drivers/block/loop.c:1706
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:583
 block_ioctl+0xf9/0x140 fs/block_dev.c:1667
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88801626b980
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff88801626b980, ffff88801626c468)
The buggy address belongs to the page:
page:ffffea0000589a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16268
head:ffffea0000589a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff8880101bdb40
raw: 0000000000000000 00000000800b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801626b880: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff88801626b900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801626b980: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88801626ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801626ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         a5f35387 block: Fix a race between reading and freeing par..
git tree:       https://github.com/bvanassche/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=13534e62d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5da36c3359b30d1
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
compiler:       

