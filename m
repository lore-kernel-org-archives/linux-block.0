Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7989C6379F
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 10:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A100D20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 10:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgKWKFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 05:05:22 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:34320 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgKWKFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 05:05:20 -0500
Received: by mail-il1-f197.google.com with SMTP id q10so9327801ile.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 02:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zBgwzi68qzrXdjI3v6aoG522nFgE68o6wE8yIJVg79k=;
        b=QkSq7BIOcnLZw+NWHq0UtF6ruF17ARpUGuaqE0lgNASho+mjAwNfaVwUgNZq5vgAzE
         oPENvIWzw4E62C8SrKMfPTJbEZGqrbyXto25YeLKV6w9+Lida7ZC7l6mavmz5RHqgF9E
         uZVFNoPK6TrUocX8ROiMh2/eT4nKG/ewGFUpTUPPuI0dLeskNKg+qyq5rmz/B7T4HNzN
         zXk91CkYbNzZGMusx/VuIiULrM4y3N6ZzkLOEnowt075ojq2FFMNoNjXHQLRaJKd9BWA
         mM0zXwaG8zRim+9GNklh/RyA1SiqOxbZOtIiTViY7dqU6JWmy6gFdlGfew2MmBSGSJzY
         Uy6Q==
X-Gm-Message-State: AOAM532ZY4qcfdjqDuuoXt2e/Uto+4+6BlwEtaMiX614GAU3KtSphRuP
        NdZ3KMLxvHPmolYPSgXsdtlq6Xi1qvW+HeYq6HG9muqN0mFR
X-Google-Smtp-Source: ABdhPJy/m127PjSfJZCUQU/mwsLeNdRiRvVWiuIaQd1AajQ0eMm2H7W/z3v1a9fEx16vH1FVCnPRPmMkV8o3l0I68CN8QhiikeaB
MIME-Version: 1.0
X-Received: by 2002:a02:b146:: with SMTP id s6mr29551471jah.10.1606125917639;
 Mon, 23 Nov 2020 02:05:17 -0800 (PST)
Date:   Mon, 23 Nov 2020 02:05:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c91a4805b4c354d5@google.com>
Subject: WARNING in nbd_config_put
From:   syzbot <syzbot+547e604b2b1c65869d7f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27bba9c5 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffd94d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7f3c831f4536ec1
dashboard link: https://syzkaller.appspot.com/bug?extid=547e604b2b1c65869d7f
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+547e604b2b1c65869d7f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 27869 at kernel/workqueue.c:4396 destroy_workqueue.cold+0x5/0x71 kernel/workqueue.c:4396
Modules linked in:
CPU: 3 PID: 27869 Comm: syz-executor.3 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:destroy_workqueue.cold+0x5/0x71 kernel/workqueue.c:4396
Code: 00 90 4a 89 f7 f1 89 c6 e8 01 80 00 00 c6 44 24 37 01 e9 a1 a7 9b f8 48 c7 c7 80 f1 00 8b e8 9a f4 04 f9 eb c2 e8 63 76 c3 f8 <0f> 0b 48 c7 c6 00 95 4a 89 48 c7 c7 40 90 4a 89 49 8d 96 60 01 00
RSP: 0018:ffffc900009f7a30 EFLAGS: 00010046
RAX: 0000000000040000 RBX: 0000000000000002 RCX: ffffc90023698000
RDX: 0000000000040000 RSI: ffffffff88acb97d RDI: 0000000000000005
RBP: 000000000000000f R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888024e1dc00 R14: ffff88801270a000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cf00000(0063) knlGS:00000000f5524b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000001991fe8 CR3: 000000001216e000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nbd_config_put+0x3d3/0x870 drivers/block/nbd.c:1231
 nbd_release+0x103/0x190 drivers/block/nbd.c:1523
 __blkdev_put+0x642/0x890 fs/block_dev.c:1782
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1851
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:151
 get_signal+0xd89/0x1f00 kernel/signal.c:2562
 arch_do_signal+0x82/0x2390 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x100/0x1a0 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x38/0x260 kernel/entry/common.c:266
 __do_fast_syscall_32+0x62/0x80 arch/x86/entry/common.c:138
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f6c549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55240bc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 000000000000ab03
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
