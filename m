Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2EEC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23C761973
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 08:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVIBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:01:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55612 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVIBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 04:01:05 -0400
Received: by mail-io1-f70.google.com with SMTP id e15so33488128ioe.22
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 01:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eMhzoyUhmnkUQM/d9deweN5U363WaslaUrLhrrqxZQE=;
        b=gB/oLglLx4vEpOyK5deZ+hAdu2v+C7M29PG9ITSAxA1CWr5SXg8MqmNNEYCHeUIHFy
         lZ7hwaImv4NZL6VXWJYSug7aegYo3e10hVnMx/5RMFBGfT/Coxx0z3GoCEnO1uG1VV+B
         2cU/r1Wl+Wea3CXsuzXCCK6S+f4BFEJolq/rkKxY1FwTzv0fINW8r3oq+R8El2bEASFy
         +sDhxTP5GFZytvUPB0dKlxObAAVba/47YWhiRMkCpdBoQ09JIBjnRlbSycQceGBBwjKR
         Yyx6Ii5sGwkvmKcCUXtgqYDZ/w/wqqrfNoRHKSOBaDJrb9Jqd20HFUU9/yTBb5blsK+4
         34AA==
X-Gm-Message-State: AOAM532potBmoH51ClMy+Ap8GLxA2QArNoC2k40HRf/7gI6wjLEPQtxw
        vXQNposIjGyet03kNNlA+DpUFROz9mOeit7WfnTrazLXtAMM
X-Google-Smtp-Source: ABdhPJygSFEqdCo0KLClNkVcr7dSfoJblCboacjhqv5cLogCuZ5KWemfhk0tbSB7p/IYqi3lHuuOpmEPKp0gf9YG5TXMcfiXCKbS
MIME-Version: 1.0
X-Received: by 2002:a6b:b5c2:: with SMTP id e185mr10080122iof.204.1616400064543;
 Mon, 22 Mar 2021 01:01:04 -0700 (PDT)
Date:   Mon, 22 Mar 2021 01:01:04 -0700
In-Reply-To: <CACT4Y+bDdmUH4eJV0P7OwT_z1pSi3CWs9fFrtiO89obtK6mpcw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a989e205be1b7771@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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
Read of size 8 at addr ffff88814403d0a8 by task syz-executor.0/10269

CPU: 1 PID: 10269 Comm: syz-executor.0 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdev_nr_sectors include/linux/genhd.h:266 [inline]
 disk_part_iter_next+0x49d/0x530 block/genhd.c:206
 partition_overlaps+0x96/0x200 block/partitions/core.c:422
 bdev_add_partition+0x66/0x130 block/partitions/core.c:441
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
RSP: 002b:00007f65eb831188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 0000000000466459
RDX: 0000000020000240 RSI: 0000000000001269 RDI: 0000000000000003
RBP: 00000000004bf9fb R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffc7d37ce9f R14: 00007f65eb831300 R15: 0000000000022000

Allocated by task 10226:
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
 add_partition+0x1ab/0x880 block/partitions/core.c:343
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:446
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

Freed by task 10255:
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
 blk_drop_partitions+0x10a/0x180 block/partitions/core.c:538
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

The buggy address belongs to the object at ffff88814403d080
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff88814403d080, ffff88814403db68)
The buggy address belongs to the page:
page:ffffea0005100e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x144038
head:ffffea0005100e00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head)
raw: 057ff00000010200 dead000000000100 dead000000000122 ffff8880101bdb40
raw: 0000000000000000 00000000000b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88814403cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff88814403d000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814403d080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88814403d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814403d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         0d02ec6b Linux 5.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127b4506d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b6433fa3370faed
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d738bed00000

