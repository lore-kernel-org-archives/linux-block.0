Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB7C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ED360FD9
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJWRRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 13:17:44 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:44989 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJWRRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 13:17:44 -0400
Received: by mail-il1-f199.google.com with SMTP id k11-20020a92c24b000000b00259faad3693so3454930ilo.11
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 10:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DV/MOHQ2co/CAzFUt/mzNaZB34djLqxLLJWPVD/n/f0=;
        b=HaNYVWLTJcplNWZymnunhbIjlH3TDw++fvhnzykblTPUY0393erCAEjef/NB47+06+
         nE8XjxSLNOZkA6D+End6w1rcgZXQx5blPm1nXEvKPhtwMIbDsRhVdhwCTbMf4cjHENyA
         pw1LFuuwvR8TPJ3QdgdlK3mCtov/oY0+8cgYwdS3YcVdpTvv4fdiyzRGLNL230oQ8WDy
         NBx3v6K2ptPf38tFAcz8j3R2XzQemSh4J9ECuKSZhVCjMejgz4bHNyP4SM0VrjUQzVxm
         GdDjkljQFX488OmxRlhRbr4dYj1OpN/XYpLuPLrvirwcI8XLrFMrPIvtA3vScUkJALcA
         xX7w==
X-Gm-Message-State: AOAM532aRhmE1vK5M1c1AeywVpKDC/XT+yQnFw+QagdDwdGIemCBJMP+
        ZnyyAHEhr1LE8GiYWCaJUAsFOhlGTsFrg7HUhUbg/MlsOGpc
X-Google-Smtp-Source: ABdhPJxQiYdY2Ge3I/CZfGVj3hnnOQjjvPSuufHe16qPTseoy5wI1aATM1VWW/22Eq+2N2YbFstqGS+qVn2UxowoJ8oGzlNIKaux
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4236775ilj.110.1635009324846;
 Sat, 23 Oct 2021 10:15:24 -0700 (PDT)
Date:   Sat, 23 Oct 2021 10:15:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003129805cf0846c0@google.com>
Subject: [syzbot] WARNING in cleanup_srcu_struct (3)
From:   syzbot <syzbot+86a4d699d56e1efda543@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    519d81956ee2 Linux 5.15-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1003f734b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d95853dad8472c91
dashboard link: https://syzkaller.appspot.com/bug?extid=86a4d699d56e1efda543
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86a4d699d56e1efda543@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 484 at lib/debugobjects.c:508 debug_print_object lib/debugobjects.c:505 [inline]
WARNING: CPU: 0 PID: 484 at lib/debugobjects.c:508 debug_object_assert_init+0x1fa/0x250 lib/debugobjects.c:895
Modules linked in:
CPU: 0 PID: 484 Comm: syz-executor.3 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object lib/debugobjects.c:505 [inline]
RIP: 0010:debug_object_assert_init+0x1fa/0x250 lib/debugobjects.c:895
Code: e8 2b 16 b8 fd 4c 8b 45 00 48 c7 c7 a0 2f b4 8a 48 c7 c6 00 2c b4 8a 48 c7 c2 e0 31 b4 8a 31 c9 49 89 d9 31 c0 e8 b6 c7 36 fd <0f> 0b ff 05 7a 59 c5 09 48 83 c5 38 48 89 e8 48 c1 e8 03 42 80 3c
RSP: 0018:ffffc90012ae6e78 EFLAGS: 00010246
RAX: 4660acffeccb0800 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90010531000 RSI: 000000000000a7fa RDI: 000000000000a7fb
RBP: ffffffff8a512d00 R08: ffffffff81693402 R09: ffffed10173857a8
R10: ffffed10173857a8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880b9c00110 R14: 0000000000000003 R15: ffffffff90c0a0a0
FS:  00007f5227fd9700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555c92708 CR3: 000000008b078000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 debug_timer_assert_init kernel/time/timer.c:739 [inline]
 debug_assert_init kernel/time/timer.c:784 [inline]
 try_to_del_timer_sync+0xa5/0x3c0 kernel/time/timer.c:1229
 del_timer_sync+0x238/0x2f0 kernel/time/timer.c:1382
 cleanup_srcu_struct+0x2ca/0x580 kernel/rcu/srcutree.c:379
 blk_mq_hw_sysfs_release+0x6c/0x130 block/blk-mq-sysfs.c:40
 kobject_cleanup+0x1c0/0x280 lib/kobject.c:705
 blk_mq_release+0x255/0x2d0 block/blk-mq.c:3101
 blk_release_queue+0x306/0x420 block/blk-sysfs.c:823
 kobject_cleanup+0x1c0/0x280 lib/kobject.c:705
 __blk_mq_alloc_disk+0x101/0x150 block/blk-mq.c:3149
 nbd_dev_add+0x34d/0x940 drivers/block/nbd.c:1721
 nbd_genl_connect+0xa66/0x1f50 drivers/block/nbd.c:1889
 genl_family_rcv_msg_doit net/netlink/genetlink.c:731 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x1032/0x1480 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x200/0x470 net/netlink/af_netlink.c:2510
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x814/0x9f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0xa29/0xe50 net/netlink/af_netlink.c:1935
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg net/socket.c:724 [inline]
 ____sys_sendmsg+0x5b9/0x910 net/socket.c:2409
 ___sys_sendmsg net/socket.c:2463 [inline]
 __sys_sendmsg+0x36f/0x450 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f522aa84a39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5227fd9188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f522ab88020 RCX: 00007f522aa84a39
RDX: 0000000000000000 RSI: 0000000020000700 RDI: 0000000000000004
RBP: 00007f522aadec5f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe58c753ff R14: 00007f5227fd9300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
