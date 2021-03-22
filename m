Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78EC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8996197F
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCVKJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:09:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52994 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCVKJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 06:09:05 -0400
Received: by mail-io1-f69.google.com with SMTP id v5so33623896ioq.19
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 03:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RGIGGjj93Nk1keEVOUpG9v/aWag/9X5l8p3JN6UvseU=;
        b=GGJMO0TAVJgiAJu1yeUqznybCXtMQNtfYy72s1/RMIrp+lKMkiBsPLJxEQJIGGVAgG
         m5VNfAYLtHH866MoCWb54F0Nr7e0ZUr3r5E2bESI6MoU/Y1HGOYJhpoTTIJdJJ63Vz5x
         b/aiVdcwKWN5q87qDi7TqkRyjnHFu690WOZNj/FJ8VTIS60/+80/Y2e0yoL1CddhcGrO
         VRTCsTgUx2anDezNGx0faHFjoSBywm+yGyHV1efD0mYaREpD8tbqHsVFRu5AHokN31ML
         QGYiGOKKAMuZ1t9GENTKDqbL7kkakutnyoR8jTDc/8OA5sZ9aBo/IGuX+f6WPrQaHMnB
         vzyg==
X-Gm-Message-State: AOAM532Vp+AkXmm2p8ihsIqEXJ7eK47W3R1+gFfyykTk5ZUnkXUBNd7i
        efRzEFH9eD0VMPZMCdwdt6wZ2bFBJaToYOFw51fQd6ekdGk7
X-Google-Smtp-Source: ABdhPJymD++n9MlsiAYgEBWMn5NbNxvkP8Q7uxgbL0W0QsZnDTPNPIVPKhDE5ytOML7mu1vKeSE8EvrXCM+qRYf2kEEt2p9t6c/N
MIME-Version: 1.0
X-Received: by 2002:a02:93e9:: with SMTP id z96mr10806694jah.73.1616407745184;
 Mon, 22 Mar 2021 03:09:05 -0700 (PDT)
Date:   Mon, 22 Mar 2021 03:09:05 -0700
In-Reply-To: <CACVXFVO-6A_u-zNvkUt4x57gAwxJBDHx=Arc6KPKh560X3G29w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076d01405be1d41e0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in bdgrab

==================================================================
BUG: KASAN: use-after-free in bdgrab+0x4c/0x50 fs/block_dev.c:938
Read of size 8 at addr ffff88814442d0a8 by task syz-executor.4/10282

CPU: 1 PID: 10282 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdgrab+0x4c/0x50 fs/block_dev.c:938
 disk_part_iter_next+0x1ce/0x530 block/genhd.c:206
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
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8adaa92188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 0000000000466459
RDX: 0000000020000240 RSI: 0000000000001269 RDI: 0000000000000003
RBP: 00000000004bf9fb R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffef77424cf R14: 00007f8adaa92300 R15: 0000000000022000

Allocated by task 10147:
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

Freed by task 346:
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
 disk_part_iter_exit block/genhd.c:236 [inline]
 disk_part_iter_next+0x9b/0x530 block/genhd.c:202
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:541
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

The buggy address belongs to the object at ffff88814442d080
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff88814442d080, ffff88814442db68)
The buggy address belongs to the page:
page:ffffea0005110a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x144428
head:ffffea0005110a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head)
raw: 057ff00000010200 dead000000000100 dead000000000122 ffff8880101bdb40
raw: 0000000000000000 00000000800b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88814442cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff88814442d000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814442d080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88814442d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814442d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         ee788c30 block: fix use-after-free in disk_part_iter_next
git tree:       https://github.com/ming1/linux.git v5.12-block-test
console output: https://syzkaller.appspot.com/x/log.txt?x=15f526d6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5da36c3359b30d1
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
compiler:       

