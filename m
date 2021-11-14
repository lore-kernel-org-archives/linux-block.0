Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB98C433F5
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C4F60FE7
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 07:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhKNGuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Nov 2021 01:50:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50844 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNGuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 01:50:11 -0500
Received: by mail-il1-f199.google.com with SMTP id d10-20020a92360a000000b002756b12323bso8051473ila.17
        for <linux-block@vger.kernel.org>; Sat, 13 Nov 2021 22:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LCwzLR4I63yDgwhrq1dWlJa+/GBTxd12sS+YpVFDcXs=;
        b=PT/xzlI6l/nEN3vQiN0a++FpklpPqLbqDpxJwca2VQkpIXOdTbI84VjnHY4wy0qxSh
         H8k7xDRGN2Hf70qXRV34tSaWBNsM+7cMiFXzwQz0GPo8s5OsfZBsaNbk8A5LpvJ+yar+
         I/4vVrj7dflH2YTh7loOEn83PZ1xaLc93ipEaps/upQPApsSzCMNo26ccMutj34ApTRV
         yhrc5V7LVfYx3e89ZzmDt070GNp70FqeytbNvJRNWNYYB8JI3kKmK3agw+IZrQx6CNQ1
         o6o7sfYLTYYdubZIS6HwuFCfsyLwjdB4+jJS+qxw/gmCHMLR92vs/YLf41R4l360yUFl
         L5nQ==
X-Gm-Message-State: AOAM5312x236fqvPqMRZZ612y5hKCFOIgh0UzJDUXfKObN6dixKfIk1Y
        J8ZckfDcpXhcNEIBqwrbxdaWqvqpTC++BvKh5KzMm4Y6Py/c
X-Google-Smtp-Source: ABdhPJwwTOOYHPAL+ZpWXWpvlEqGQoWNgRHMFSbeqmhUOyuNAwHFv+HIejP7cywip6RyjIBwbhDrg1RlwMafznDslU4FFiT9A4J/
MIME-Version: 1.0
X-Received: by 2002:a92:2a06:: with SMTP id r6mr16851877ile.34.1636872437900;
 Sat, 13 Nov 2021 22:47:17 -0800 (PST)
Date:   Sat, 13 Nov 2021 22:47:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000342e7105d0ba10d0@google.com>
Subject: [syzbot] WARNING in nbd_dev_add (2)
From:   syzbot <syzbot+5e8112c15ddb3db8416d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17736888b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=5e8112c15ddb3db8416d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e8112c15ddb3db8416d@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000000000005
RBP: 00007f2388d2e1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffcef734a5f R14: 00007f2388d2e300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5223 at block/genhd.c:547 device_add_disk+0x338/0xef0 block/genhd.c:547
Modules linked in:
CPU: 1 PID: 5223 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:device_add_disk+0x338/0xef0 block/genhd.c:547
Code: 74 08 3c 03 0f 8e 93 09 00 00 8b 5d 00 bf 03 01 00 00 89 de e8 39 ee ae fd 81 fb 03 01 00 00 0f 84 16 02 00 00 e8 08 ec ae fd <0f> 0b 41 bc 01 00 00 00 e8 fb eb ae fd 44 89 e0 48 83 c4 38 5b 5d
RSP: 0018:ffffc90019027460 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 000000000000002b RCX: ffffc9000fb72000
RDX: 0000000000040000 RSI: ffffffff83c8d798 RDI: 0000000000000003
RBP: ffff88807652f000 R08: 0000000000000103 R09: ffff888016beea43
R10: ffffffff83c8d787 R11: 0000000000000000 R12: 00000000ffffffea
R13: ffff88807652f080 R14: ffff88807652f008 R15: ffff888016beea08
FS:  00007f2388d2e700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc23000 CR3: 0000000034919000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 add_disk include/linux/genhd.h:212 [inline]
 nbd_dev_add+0x8d9/0xcd0 drivers/block/nbd.c:1818
 nbd_genl_connect+0x11f3/0x1930 drivers/block/nbd.c:1948
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2491
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f238b7b8ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2388d2e188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f238b8cbf60 RCX: 00007f238b7b8ae9
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000000000005
RBP: 00007f2388d2e1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffcef734a5f R14: 00007f2388d2e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
