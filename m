Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A00CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 14:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiF2Osf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiF2Osd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 10:48:33 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCBB4B6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:48:31 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bw12-20020a056602398c00b00675895c2e24so695829iob.19
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=piY2rqjjpLSURcBVOJ67ylQE4JJjSD/EdRDbwcjkkEw=;
        b=rhHkh7Z9AaT0sqE+yS0aGiateJPKGa59yPNOba8HW3x5jqLKYRYusYiYTbnTPj4E/Y
         iinMDfR218eVBUlQEQ09Cg4WwvJ/+WnKS0Q23GsOzK9OI8tbMTqnZ/RusP6zXaW5gMlE
         RprmTNsxz9sc4+KG5jKD8FarHMzx9TOgh9lFa8KnOoGyOAcaWOJ5L65oILRrO4PboXW2
         /k88dw3eWmnBwqkJQseYiO3DvAE87h4j4cp4+M1ti723Su7QK14arK1PcoZgUJUulRqi
         yxgBy8LqMcYscj3e1sDwCne04NrZwxedcD7xZxACcz6hseo1SwjWjhLbj+pfSjFfkjw1
         kHVw==
X-Gm-Message-State: AJIora+u+3Jb2P05Oi5bEy4lBFFJ94ct3dXzUZaIrWJa2HeU1JntgjSq
        mvVybeMB0pQ0/J4/yBuKq0p6GnFmqBUSkr1Rj8h3CeDIIwl1
X-Google-Smtp-Source: AGRyM1sUZ9tCojVibTV7y72NWNfIQpGOeRuHkb2gvuxp3tttZu+oPGZn5RsZrt2EH9ny3swAAA0KvfrzRFhuhwRVzPQt0CMJrniG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dc4:b0:33c:c2c5:50ab with SMTP id
 m4-20020a0566380dc400b0033cc2c550abmr2093334jaj.26.1656514110924; Wed, 29 Jun
 2022 07:48:30 -0700 (PDT)
Date:   Wed, 29 Jun 2022 07:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025abbc05e2973f52@google.com>
Subject: [syzbot] linux-next boot error: WARNING in blk_mq_release
From:   syzbot <syzbot+7582a7c7cf0affa6c9be@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c4ef528bd006 Add linux-next specific files for 20220629
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=115f9f4c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39ac31f5c81daa7c
dashboard link: https://syzkaller.appspot.com/bug?extid=7582a7c7cf0affa6c9be
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7582a7c7cf0affa6c9be@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2226 at block/blk-mq.c:3876 blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3876
Modules linked in:
CPU: 0 PID: 2226 Comm: kworker/0:3 Not tainted 5.19.0-rc4-next-20220629-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events blkg_free_workfn
RIP: 0010:blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3876
Code: fd 4c 8d a3 a8 02 00 00 4c 89 e0 48 c1 e8 03 80 3c 28 00 0f 85 14 02 00 00 48 8b 83 a8 02 00 00 49 39 c4 75 b1 e8 28 af 97 fd <0f> 0b eb a8 e8 1f af 97 fd 48 8b 44 24 10 48 05 38 05 00 00 48 89
RSP: 0000:ffffc90009837ba0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801bd5c000 RCX: 0000000000000000
RDX: ffff888024193a80 RSI: ffffffff83e307e8 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801bd5c2a8
R13: ffff88801d898190 R14: ffff88801d898048 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_release_queue+0x15b/0x280 block/blk-sysfs.c:782
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1be/0x4c0 lib/kobject.c:721
 blkg_free_workfn+0x128/0x210 block/blk-cgroup.c:96
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
