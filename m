Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78957C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE876138B
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 07:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhHYHNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:13:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47922 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbhHYHND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 03:13:03 -0400
Received: by mail-io1-f70.google.com with SMTP id f1-20020a5edf01000000b005b85593f933so13917037ioq.14
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 00:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qr4rg0drxCa5TZhMN5ot1Xlomx3O22gGuoMzR1+wxl4=;
        b=Y7oXCa1b5gvE3IYfvQhWo+DS2A3ki3MllVKceyVUMH51S4JGtBGafIskv6KioREAWI
         USdfTLAHY+IORhvDYwZLx7S+tD2CFHw1N1+h5z7Qzz25DYA6QeswbYCxhM6ZDuidqz/7
         yh3d2N+2ebgaXsmniNqITh8ldwap378AXjE2a4myHChlOkLDix015p8DaK5gUXEOiu3h
         qIZVeQL75DEqRixsRtN9DWrp/SLE2aiqdccognIXTdOHGvC3VxmaMYY8178AoI2ATeyO
         2Wf8XwFsP+faqrnblpFXICKAOUwDkd2nlJTRvx4qqhdTpqOrit3Yf21oz3kqUQDabbMm
         aIyg==
X-Gm-Message-State: AOAM533YP0cKE9ARlWWHjeMrruED/LQXlfsLt3T3QKNb3/DczyNghIFg
        xOys0bOawtKNQWCTJnoBhYdFnR6EeWyXQefU8ugabrW06skA
X-Google-Smtp-Source: ABdhPJw+sfVhlJKIL4C0mIDgjvd8HJTY4rZinoIIvqupyaisDvxLwT/hirNTxski5Ref8OMlfz8CjgeaFkchq+uNcW6r9ajYTxYX
MIME-Version: 1.0
X-Received: by 2002:a5e:a81a:: with SMTP id c26mr34558737ioa.15.1629875538033;
 Wed, 25 Aug 2021 00:12:18 -0700 (PDT)
Date:   Wed, 25 Aug 2021 00:12:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007900bd05ca5cf80b@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nbd_genl_connect (2)
From:   syzbot <syzbot+2c98885bcd769f56b6d6@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    86ed57fd8c93 Add linux-next specific files for 20210820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11196189300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64eccb415bd479d
dashboard link: https://syzkaller.appspot.com/bug?extid=2c98885bcd769f56b6d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158e3711300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14371b11300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c98885bcd769f56b6d6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: use-after-free in nbd_genl_connect+0x235/0x16a0 drivers/block/nbd.c:1869
Read of size 8 at addr ffff8881463eeab0 by task syz-executor010/6561

CPU: 1 PID: 6561 Comm: syz-executor010 Not tainted 5.14.0-rc6-next-20210820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 nbd_genl_connect+0x235/0x16a0 drivers/block/nbd.c:1869
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x32d/0x590 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x154/0x430 net/netlink/af_netlink.c:2504
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2403
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2457
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4406d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec8655a78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000000103b8 RCX: 00000000004406d9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffec8655c18
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffec8655a8c
R13: 431bde82d7b634db R14: 00000000004ae018 R15: 00000000004004a0

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa8/0xe0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:731 [inline]
 nbd_dev_add+0x54/0xaf0 drivers/block/nbd.c:1696
 nbd_init+0x297/0x2a7 drivers/block/nbd.c:2457
 do_one_initcall+0x103/0x650 init/main.c:1292
 do_initcall_level init/main.c:1367 [inline]
 do_initcalls init/main.c:1383 [inline]
 do_basic_setup init/main.c:1402 [inline]
 kernel_init_freeable+0x6b4/0x73d init/main.c:1604
 kernel_init+0x1a/0x1d0 init/main.c:1496
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 10:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0x103/0x140 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1681 [inline]
 slab_free_freelist_hook+0x85/0x190 mm/slub.c:1706
 slab_free mm/slub.c:3459 [inline]
 kfree+0xea/0x540 mm/slub.c:4519
 process_one_work+0x9c9/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x65b/0x1200 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xed/0x120 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1353
 __queue_work+0x5d1/0xf30 kernel/workqueue.c:1519
 queue_work_on+0xf6/0x110 kernel/workqueue.c:1546
 queue_work include/linux/workqueue.h:502 [inline]
 nbd_put drivers/block/nbd.c:283 [inline]
 nbd_put+0xd7/0x120 drivers/block/nbd.c:276
 nbd_genl_connect+0xc73/0x16a0 drivers/block/nbd.c:2019
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x32d/0x590 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x154/0x430 net/netlink/af_netlink.c:2504
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2403
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2457
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8881463ee800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 688 bytes inside of
 1024-byte region [ffff8881463ee800, ffff8881463eec00)
The buggy address belongs to the page:
page:ffffea000518fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881463ef800 pfn:0x1463e8
head:ffffea000518fa00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000010200 ffffea00050c7a08 ffffea00050fe608 ffff888010c41dc0
raw: ffff8881463ef800 000000000010000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, ts 7639818470, free_ts 0
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa76/0x2f90 mm/page_alloc.c:4151
 __alloc_pages+0x1ba/0x510 mm/page_alloc.c:5373
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2033
 alloc_pages+0x29f/0x300 mm/mempolicy.c:2183
 alloc_slab_page mm/slub.c:1744 [inline]
 allocate_slab mm/slub.c:1881 [inline]
 new_slab+0x321/0x490 mm/slub.c:1944
 ___slab_alloc+0x937/0x1000 mm/slub.c:2970
 __slab_alloc.constprop.0+0x51/0xa0 mm/slub.c:3057
 slab_alloc_node mm/slub.c:3148 [inline]
 kmem_cache_alloc_node_trace+0x187/0x400 mm/slub.c:3232
 kmalloc_node include/linux/slab.h:613 [inline]
 kzalloc_node include/linux/slab.h:743 [inline]
 blk_throtl_init+0x7c/0x660 block/blk-throttle.c:2420
 blkcg_init_queue+0x199/0x770 block/blk-cgroup.c:1193
 blk_alloc_queue+0x451/0x630 block/blk-core.c:567
 blk_mq_init_queue_data block/blk-mq.c:3120 [inline]
 __blk_mq_alloc_disk+0x47/0x190 block/blk-mq.c:3143
 loop_add+0x324/0x940 drivers/block/loop.c:2344
 loop_init+0x1f5/0x218 drivers/block/loop.c:2575
 do_one_initcall+0x103/0x650 init/main.c:1292
 do_initcall_level init/main.c:1367 [inline]
 do_initcalls init/main.c:1383 [inline]
 do_basic_setup init/main.c:1402 [inline]
 kernel_init_freeable+0x6b4/0x73d init/main.c:1604
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881463ee980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881463eea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881463eea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8881463eeb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881463eeb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
