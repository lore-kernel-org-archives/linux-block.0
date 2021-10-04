Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93DC433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031D96121F
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 21:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhJDVjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:39:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:36410 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhJDVjN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 17:39:13 -0400
Received: by mail-il1-f197.google.com with SMTP id l15-20020a92700f000000b0024a1248ff32so11578568ilc.3
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 14:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=t4T9wzn/orBhsSmsQx6/9HBbFcmW+UieVb16SY2VCyM=;
        b=1GXeiN4/rlIlsvRrsFgTXSrM0eS7mdxOGqEHu3i8USiBpARTZqu6zycEdudloBNrEB
         SXDfirAvkJc91XzDSc2jiTctbDz7rcIDrLzFDy7+77e3H0Pk6cEYbBfilNdMluo9xJEU
         tpe+s1TDjaxiYb/zo4QGIpw7qvYFE4Zl/vfhnomCYjuXoDhpyJdAaZbDkr6E04NGCoMC
         1sgZAuY/SQFb7pAo9E5QgE7eiKPw0LWkjwAPH0jPQ8J1EZ13RVgyVZYmg/+O146m93b1
         9zTl30A+W/8oVwYmbjnREKQQOax8Hx1jyCIIHv2J1Xx42jepvbrVH1esiQFu2JC2MvcK
         z+hQ==
X-Gm-Message-State: AOAM532grNkcWVgGaLLDtjUQQ6lmXeo46LZ/gl+7BFUD1AlaHTlpZq2R
        RHVHCwEjrLz9Oeof9o/DISXZcW59ZR2hziLj5YrJv5WuUzP4
X-Google-Smtp-Source: ABdhPJxNERWcMEF/D5VXNva36/CnYVsS1LARUGf5K+pPsVFXnvxp4RoB0d1jYxxVoY8toS6jtw/nHHA0ZqVAirALfMiVRyJAhBKw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:: with SMTP id y7mr315308ill.172.1633383443973;
 Mon, 04 Oct 2021 14:37:23 -0700 (PDT)
Date:   Mon, 04 Oct 2021 14:37:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5ccbf05cd8db7b0@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __dev_queue_xmit (5)
From:   syzbot <syzbot+b7be9429f37d15205470@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a4e6f95a891a Merge tag 'pinctrl-v5.15-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cc68cf300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=b7be9429f37d15205470
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7be9429f37d15205470@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: use-after-free in skb_update_prio net/core/dev.c:3882 [inline]
BUG: KASAN: use-after-free in __dev_queue_xmit+0x3225/0x36e0 net/core/dev.c:4144
Read of size 8 at addr ffff88807da2abd0 by task aoe_tx0/1356

CPU: 1 PID: 1356 Comm: aoe_tx0 Not tainted 5.15.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 skb_update_prio net/core/dev.c:3882 [inline]
 __dev_queue_xmit+0x3225/0x36e0 net/core/dev.c:4144
 tx+0x68/0xb0 drivers/block/aoe/aoenet.c:63
 kthread+0x1e7/0x3b0 drivers/block/aoe/aoecmd.c:1230
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 9678:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc_node include/linux/slab.h:614 [inline]
 kvmalloc_node+0x61/0x120 mm/util.c:587
 kvmalloc include/linux/mm.h:805 [inline]
 kvzalloc include/linux/mm.h:813 [inline]
 alloc_netdev_mqs+0x98/0xe80 net/core/dev.c:10794
 sixpack_open+0xfa/0xa50 drivers/net/hamradio/6pack.c:558
 tty_ldisc_open+0x9b/0x110 drivers/tty/tty_ldisc.c:449
 tty_set_ldisc+0x2f1/0x680 drivers/tty/tty_ldisc.c:579
 tiocsetd drivers/tty/tty_io.c:2455 [inline]
 tty_ioctl+0xae0/0x1670 drivers/tty/tty_io.c:2741
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 9678:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x81/0x190 mm/slub.c:1725
 slab_free mm/slub.c:3483 [inline]
 kfree+0xe4/0x530 mm/slub.c:4543
 kvfree+0x42/0x50 mm/util.c:620
 device_release+0x9f/0x240 drivers/base/core.c:2195
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 netdev_run_todo+0x75a/0xa80 net/core/dev.c:10604
 sixpack_close+0x1c7/0x230 drivers/net/hamradio/6pack.c:679
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:474
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:629
 tty_ldisc_hangup+0x30b/0x680 drivers/tty/tty_ldisc.c:749
 __tty_hangup.part.0+0x40a/0x830 drivers/tty/tty_io.c:639
 __tty_hangup drivers/tty/tty_io.c:594 [inline]
 tty_vhangup drivers/tty/tty_io.c:711 [inline]
 tty_ioctl+0xcda/0x1670 drivers/tty/tty_io.c:2745
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807da2a000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3024 bytes inside of
 4096-byte region [ffff88807da2a000, ffff88807da2b000)
The buggy address belongs to the page:
page:ffffea0001f68a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7da28
head:ffffea0001f68a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c4c280
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7020, ts 75669255352, free_ts 70639867067
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0x921/0xfe0 mm/slub.c:2994
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 __kmalloc_node+0x2d2/0x370 mm/slub.c:4435
 kmalloc_node include/linux/slab.h:614 [inline]
 kvmalloc_node+0x61/0x120 mm/util.c:587
 kvmalloc include/linux/mm.h:805 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x7e7/0x1240 fs/seq_file.c:210
 kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
 call_read_iter include/linux/fs.h:2157 [inline]
 new_sync_read+0x421/0x6e0 fs/read_write.c:404
 vfs_read+0x35c/0x600 fs/read_write.c:485
 ksys_read+0x12d/0x250 fs/read_write.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x95/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x209/0x390 mm/slub.c:3219
 prepare_creds+0x3f/0x7b0 kernel/cred.c:262
 access_override_creds fs/open.c:351 [inline]
 do_faccessat+0x3f4/0x850 fs/open.c:415
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88807da2aa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807da2ab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807da2ab80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88807da2ac00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807da2ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
