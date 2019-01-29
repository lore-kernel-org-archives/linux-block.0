Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C5C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AFB214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfA2QnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:43:12 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:36510 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfA2QnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:43:06 -0500
Received: by mail-it1-f197.google.com with SMTP id w15so15975553ita.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 08:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sIv6+AT+ptrB8WA7KqnI7Nd9IMqv1oGR0TAfAAvgzLc=;
        b=gvGDOxeQJoGK2wHXgGvkP8Hp8Aks+WoLp50cocyVqpfKQd9qflVCkcQD98+9mwUiW1
         r6s/KiORTMK/JTx7miuB/1Cg3KrDvVT60u/VXA/ib+8dTRf293/wBH6KSuFFVWAQFvHh
         5APFsJotUqmu/ImEFhH7CA0kyTLnOpvo41mp/azz79PPVjGVEh3CplHuJabOQznBEFmi
         0DbxUefz0IUiSTMjShhF7mHHH+ZPoPZuCdazbbVLPijYJ0hIW2Cc0DFf8xbAqZ7HIUbE
         ZsoX5HqA3M+DoaCv5CRHeEyQhxqXo3sSRM1i4E+UozU7dMTgzu7VzFcIpKFKu8tqosHx
         vMmA==
X-Gm-Message-State: AHQUAuZ1AT6PyDY6VxwEEsNCleDkObrywzW+sES2Ke8UezLxNY9kKDK3
        qYCpZxbK5fSQrc66hKJXJ7nsHVqf7+dMpah/Nny9gih8M0Cc
X-Google-Smtp-Source: AHgI3IZDSiECho2XEWtPtepGJVuAmtbe5BrO7Ydqn3l4lQUcq5ZkBO/yoRvYshw1DaIdrMO60KSJ2pdIxnnS/rAXY4EnkvKo2mld
MIME-Version: 1.0
X-Received: by 2002:a02:8785:: with SMTP id t5mr3514769jai.10.1548780184904;
 Tue, 29 Jan 2019 08:43:04 -0800 (PST)
Date:   Tue, 29 Jan 2019 08:43:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1ac2805809b7cf6@google.com>
Subject: WARNING in __flush_work
From:   syzbot <syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    39ad1c1b6bb8 Add linux-next specific files for 20190129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=135e382f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=ba2a929dcf8e704c180e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cc2298c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176c96ef400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 3472 at kernel/workqueue.c:2911  
__flush_work+0x880/0xa60 kernel/workqueue.c:2911
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3472 Comm: kworker/1:2 Not tainted 5.0.0-rc4-next-20190129 #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: md_misc mddev_delayed_delete
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__flush_work+0x880/0xa60 kernel/workqueue.c:2911
Code: 74 58 e8 93 54 2e 00 fb 66 0f 1f 44 00 00 45 31 e4 e9 7d fd ff ff e8  
7f 54 2e 00 0f 0b 45 31 e4 e9 6e fd ff ff e8 70 54 2e 00 <0f> 0b 45 31 e4  
e9 5f fd ff ff e8 61 54 2e 00 4c 89 ff 45 31 e4 e8
RSP: 0018:ffff88809acb7558 EFLAGS: 00010293
RAX: ffff88809acc4580 RBX: ffff88809acb76e8 RCX: ffffffff8153bde9
RDX: 0000000000000000 RSI: ffffffff8153c5c0 RDI: 0000000000000001
RBP: ffff88809acb7710 R08: ffff88809acc4580 R09: ffff88809acc4e48
R10: ffff88809acc4580 R11: 0000000000000000 R12: ffff88809dd24628
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000001
  __cancel_work_timer+0x48d/0x810 kernel/workqueue.c:3007
  cancel_work_sync+0x18/0x20 kernel/workqueue.c:3043
  blk_sync_queue+0x33/0x190 block/blk-core.c:234
  blk_cleanup_queue+0x100/0x200 block/blk-core.c:367
  md_free+0xcb/0x1b0 drivers/md/md.c:5215
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  mddev_delayed_delete+0x34/0x40 drivers/md/md.c:5243
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
