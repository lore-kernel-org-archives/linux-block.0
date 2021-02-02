Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD916C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CEA64F37
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhBBK3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:29:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37584 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBBK3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 05:29:01 -0500
Received: by mail-io1-f69.google.com with SMTP id e10so1464681ioc.4
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 02:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MlUXTuM6nOcMNaAgBlcrcz9jVk5WWusj8rtcdYwVnH0=;
        b=gpBO+jY5x1vfj9EfWfNuq70KKHOuQT2A06jUjwf/ejJ2kx+ekgKyR5wKU3LWG5c2xM
         mI74h5++U/jdAk/tNiW8/B8J/KfzYnMUMTHgfqI5dI+sUqCJbu2AkJqpCVOKuUPSziKV
         H4JnQeDL9KOu1wpLwFt0fFNVlPtP7Gj6gWaph1Gq23vs1qt/8Vwx3CKrVWSrZXm/NqEu
         NAQXONJZUBtCvfFXaS4jNSPpoithuxql28aBoVCNO4DvaoWfo/uqlMN7eCy2GSA+y+uY
         ++9XiKpg1M9Xmzr7ifzmaQ4Bxm/itDYm81zhhpj3kjOSER6v/R35EnqPmyLkxxvUHsbj
         54IA==
X-Gm-Message-State: AOAM5303BzjSdZD6WiLzLIy60LU7UW9rPIoBqMTy2ALHFqwZne/sxFDv
        sdkGzhd/Q71i0kPbrSnKPUA4ihGOKtQ40SNTlEMMtXIJCtA+
X-Google-Smtp-Source: ABdhPJwnAECBIuQx27J1xbO7XYer3HeB5Yjm9r18gXGnE5ccgp1BfxHjFaIEJucRIGDX/UirKlMvZBw2fbApYc7qlEFB6ZY8Hrlj
MIME-Version: 1.0
X-Received: by 2002:a92:8e4b:: with SMTP id k11mr16677869ilh.192.1612261700570;
 Tue, 02 Feb 2021 02:28:20 -0800 (PST)
Date:   Tue, 02 Feb 2021 02:28:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f296a705ba57ed59@google.com>
Subject: KASAN: use-after-free Read in recv_work
From:   syzbot <syzbot+f91dbbabacae745d334f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b01f250d Add linux-next specific files for 20210129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14366378d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=725bc96dc234fda7
dashboard link: https://syzkaller.appspot.com/bug?extid=f91dbbabacae745d334f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f91dbbabacae745d334f@syzkaller.appspotmail.com

block nbd5: Receive control failed (result -107)
==================================================================
BUG: KASAN: use-after-free in recv_work+0x2a2/0x2c0 drivers/block/nbd.c:787
Read of size 8 at addr ffff88801181ed20 by task kworker/u5:2/8465

CPU: 1 PID: 8465 Comm: kworker/u5:2 Not tainted 5.11.0-rc5-next-20210129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: knbd5-recv recv_work
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 recv_work+0x2a2/0x2c0 drivers/block/nbd.c:787
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 17044:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:403 [inline]
 ____kasan_kmalloc mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:406
 kasan_slab_alloc include/linux/kasan.h:208 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 __kmalloc_track_caller+0x16c/0x2e0 mm/slub.c:4550
 __do_krealloc mm/slab_common.c:1149 [inline]
 krealloc+0x60/0xa0 mm/slab_common.c:1178
 nbd_add_socket+0x263/0x6a0 drivers/block/nbd.c:1044
 __nbd_ioctl drivers/block/nbd.c:1369 [inline]
 nbd_ioctl+0x388/0xa50 drivers/block/nbd.c:1425
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:576
 block_ioctl+0xf9/0x140 fs/block_dev.c:1650
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 17044:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:364
 kasan_slab_free include/linux/kasan.h:191 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7b0 mm/slub.c:4202
 krealloc+0x45/0xa0 mm/slab_common.c:1180
 nbd_add_socket+0x263/0x6a0 drivers/block/nbd.c:1044
 __nbd_ioctl drivers/block/nbd.c:1369 [inline]
 nbd_ioctl+0x388/0xa50 drivers/block/nbd.c:1425
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:576
 block_ioctl+0xf9/0x140 fs/block_dev.c:1650
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88801181ed20
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88801181ed20, ffff88801181ed28)
The buggy address belongs to the page:
page:00000000e0a0f4b5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1181e
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea000053d180 0000000500000005 ffff88800fc41280
raw: ffff88801181ef28 0000000080660062 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801181ec00: fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc fc
 ffff88801181ec80: fa fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00
>ffff88801181ed00: fc fc fc fc fa fc fc fc fc 00 fc fc fc fc 00 fc
                               ^
 ffff88801181ed80: fc fc fc 00 fc fc fc fc 00 fc fc fc fc fa fc fc
 ffff88801181ee00: fc fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
