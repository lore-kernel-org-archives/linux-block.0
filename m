Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7928C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FD460F6B
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 13:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhISNgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:36:44 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:57025 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhISNgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Sep 2021 09:36:44 -0400
Received: by mail-il1-f198.google.com with SMTP id d11-20020a92d78b000000b0022c670da306so33048394iln.23
        for <linux-block@vger.kernel.org>; Sun, 19 Sep 2021 06:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FAn6wYlGaJIFZjOfzqVsuUaOAA34Zuaol6Zjsby8oEc=;
        b=Wrs3oRyFusdvCYE83tGf8XNdicLQ/F0Zn6e/iNboz1Me0grr+FPP6siNY3E++5B+NH
         tQFlwnZwPlqq1L2DfxHytyiNeagNQUQthMYBOGwYPZ+DSeoM2Mx0mvUuL4wk0DaY6fhw
         0seG68SwIqE0bHBN5zd6Nmnk5JdPMdcJUNh44rnAcu9lzt2NL0Z1imASRvWq2YUvUfaT
         d2NhxdrG6XHFBE/H5/rbXNm9htqb2jTyEbJgXeHEPHfWNELn2g0FbejgnuJ9g/8vmDlc
         JZAUKV7bmZJuvJu1jAtd9L2uffdJyqXYiHEENMTc8Hr6kfPm/VwiiVGnQMQpLmh0dhHM
         1CwA==
X-Gm-Message-State: AOAM5323oyjvJdzLmzGL8aMlBJVVEQy3CQaQ+tEdnKS9kBBI5jQl1GQ8
        GE/XMflTluJkTzfcOrgiQGamC29Cg/JCCTf+RyHb0sSA8Rve
X-Google-Smtp-Source: ABdhPJywNOZanW45rhZDLBpINIjmDL4Jngodb/9wo5SWbBxrVURhQ/mnLaYaFp5XhKSVFTSQRnG4oO0WO30jVQrLtCmVdk/9Ixcd
MIME-Version: 1.0
X-Received: by 2002:a02:6d10:: with SMTP id m16mr16079886jac.60.1632058519213;
 Sun, 19 Sep 2021 06:35:19 -0700 (PDT)
Date:   Sun, 19 Sep 2021 06:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a5adf05cc593ca9@google.com>
Subject: [syzbot] KASAN: use-after-free Read in bdev_free_inode
From:   syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b7213ffa0e58 qnx4: avoid stringop-overread errors
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107afc79300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=8281086e8a6fbfbd952a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdev_free_inode+0x202/0x220 block/bdev.c:407
Read of size 8 at addr ffff88807b26d948 by task ksoftirqd/0/13

CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 bdev_free_inode+0x202/0x220 block/bdev.c:407
 i_callback+0x3f/0x70 fs/inode.c:224
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2743
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 9035:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc_node include/linux/slab.h:609 [inline]
 kzalloc_node include/linux/slab.h:732 [inline]
 __alloc_disk_node+0x77/0x580 block/genhd.c:1238
 __blk_mq_alloc_disk+0xed/0x160 block/blk-mq.c:3140
 loop_add+0x340/0x960 drivers/block/loop.c:2344
 loop_control_ioctl+0x130/0x4a0 drivers/block/loop.c:2512
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 9035:
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
 __alloc_disk_node+0x474/0x580 block/genhd.c:1275
 __blk_mq_alloc_disk+0xed/0x160 block/blk-mq.c:3140
 loop_add+0x340/0x960 drivers/block/loop.c:2344
 loop_control_ioctl+0x130/0x4a0 drivers/block/loop.c:2512
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807b26d800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 1024-byte region [ffff88807b26d800, ffff88807b26dc00)
The buggy address belongs to the page:
page:ffffea0001ec9a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b268
head:ffffea0001ec9a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c41dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6541, ts 204759478755, free_ts 204758542274
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
 __kmalloc_node_track_caller+0x2d2/0x340 mm/slub.c:4936
 kmalloc_reserve net/core/skbuff.c:355 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1116 [inline]
 __tcp_send_ack.part.0+0x67/0x7a0 net/ipv4/tcp_output.c:3946
 __tcp_send_ack net/ipv4/tcp_output.c:3978 [inline]
 tcp_send_ack+0x7d/0xa0 net/ipv4/tcp_output.c:3978
 tcp_cleanup_rbuf+0x464/0x5a0 net/ipv4/tcp.c:1601
 tcp_recvmsg_locked+0x7a2/0x2320 net/ipv4/tcp.c:2522
 tcp_recvmsg+0x134/0x550 net/ipv4/tcp.c:2552
 inet_recvmsg+0x11b/0x5e0 net/ipv4/af_inet.c:852
 sock_recvmsg_nosec net/socket.c:944 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 sock_recvmsg net/socket.c:958 [inline]
 sock_read_iter+0x353/0x490 net/socket.c:1035
 call_read_iter include/linux/fs.h:2157 [inline]
 new_sync_read+0x590/0x6b0 fs/read_write.c:404
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 __put_page+0x105/0x400 mm/swap.c:127
 put_page include/linux/mm.h:1247 [inline]
 __skb_frag_unref include/linux/skbuff.h:3107 [inline]
 skb_release_data+0x49d/0x790 net/core/skbuff.c:671
 skb_release_all net/core/skbuff.c:741 [inline]
 __kfree_skb+0x46/0x60 net/core/skbuff.c:755
 sk_eat_skb include/net/sock.h:2596 [inline]
 tcp_recvmsg_locked+0x12f7/0x2320 net/ipv4/tcp.c:2506
 tcp_recvmsg+0x134/0x550 net/ipv4/tcp.c:2552
 inet_recvmsg+0x11b/0x5e0 net/ipv4/af_inet.c:852
 sock_recvmsg_nosec net/socket.c:944 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 sock_recvmsg net/socket.c:958 [inline]
 sock_read_iter+0x353/0x490 net/socket.c:1035
 call_read_iter include/linux/fs.h:2157 [inline]
 new_sync_read+0x590/0x6b0 fs/read_write.c:404
 vfs_read+0x35c/0x600 fs/read_write.c:485
 ksys_read+0x1ee/0x250 fs/read_write.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88807b26d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b26d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807b26d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88807b26d980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b26da00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
