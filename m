Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C945C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941C164ED3
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBYDr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:47:59 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:48973 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhBYDr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 22:47:59 -0500
Received: by mail-il1-f198.google.com with SMTP id n12so3266923ili.15
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 19:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WqS9rOcx9yS17LIpvXVzxUWXWLEmGt7NJ28w5bEBMqI=;
        b=Mw8hrtGrMnyZVEkxK2BFDS1Pk90W8IuId7QF6kOHS8q7xTL+7VaWpEVVKY58TxR486
         cLxgHdLBi9dAM+S6Oga8Br+VpwahBHYOmCFM+ewJtHCgFf/dXJi3sLiHLMgKI0HHEduy
         0bNGIt3NyCB80Hjd0aEqJdCUJ5JjxGmbLbM6GDhpRk3ogj7FqBZsmOAfR7QyAGOTRmKe
         tqNXbP+kAI4ancWYKMDfmGBaisISeppZQuQeYsHIpzSo4OUeGGn4KeYQmbAvu1eqjaji
         atV7OInQO5dbr4TiEUmkneGQjOlS3G57OjIHw1jdlosKpD7Ywfj+DvzhfwBQx+MQonEr
         vmYA==
X-Gm-Message-State: AOAM5334J/MjzILXaaCNvC/pV9ik9HQAUecbbOp9w1fi8/C9fFxbXXoe
        F4OizrTtIG38bATx3oXVKI1yMNIni/7NJ0lKZ3WiViKU+44h
X-Google-Smtp-Source: ABdhPJyVhZVWrlYNayYRCvIGqvB4QPlmNcHBH1HWkDe9dZ572NP3ON+nvyZqclZMvzGxuNbDKAjgev96eW2MhGH7k9cXjgwB1BbZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2191:: with SMTP id b17mr331549iob.114.1614224838526;
 Wed, 24 Feb 2021 19:47:18 -0800 (PST)
Date:   Wed, 24 Feb 2021 19:47:18 -0800
In-Reply-To: <000000000000251ce705bbe91ddb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000168cb405bc210223@google.com>
Subject: Re: WARNING in nbd_dev_add
From:   syzbot <syzbot+9b658439133becd38da1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6fbd15c0 Merge branch '100GbE' of git://git.kernel.org/pub..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17a009a8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8307379601586a
dashboard link: https://syzkaller.appspot.com/bug?extid=9b658439133becd38da1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101ff9b6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c9a5cad00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b658439133becd38da1@syzkaller.appspotmail.com

RBP: 0000000000403430 R08: 00000000004004a0 R09: 00000000004004a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004034c0
R13: 0000000000000000 R14: 00000000004ad018 R15: 00000000004004a0
kobject_add_internal failed for 43:0 with -EEXIST, don't try to register things with the same name in the same directory.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8421 at block/genhd.c:620 __device_add_disk+0x1030/0x1300 block/genhd.c:620
Modules linked in:
CPU: 0 PID: 8421 Comm: syz-executor614 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__device_add_disk+0x1030/0x1300 block/genhd.c:620
Code: f1 ff ff e8 42 c4 c1 fd 0f 0b e9 e6 f6 ff ff 48 89 7c 24 20 e8 31 c4 c1 fd 0f 0b 48 8b 7c 24 20 e9 9b f4 ff ff e8 20 c4 c1 fd <0f> 0b e9 dd fb ff ff 4c 89 ef e8 a1 fc 04 fe e9 28 f1 ff ff 48 8b
RSP: 0018:ffffc9000163f340 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888015548000 RSI: ffffffff83b11590 RDI: 0000000000000003
RBP: ffff888025956000 R08: 0000000000000000 R09: ffffffff8fa9a837
R10: ffffffff83b1116b R11: 0000000000000000 R12: 00000000ffffffef
R13: ffff8880259560a0 R14: ffff888016fa97d0 R15: ffff8880171ae000
FS:  0000000001b2c300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000380 CR3: 0000000015534000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 add_disk include/linux/genhd.h:231 [inline]
 nbd_dev_add+0x720/0x910 drivers/block/nbd.c:1719
 nbd_genl_connect+0x557/0x1570 drivers/block/nbd.c:1829
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2348
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2402
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2435
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43f9c9
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2bb97998 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 000000000043f9c9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 0000000000403430 R08: 00000000004004a0 R09: 00000000004004a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004034c0
R13: 0000000000000000 R14: 00000000004ad018 R15: 00000000004004a0

