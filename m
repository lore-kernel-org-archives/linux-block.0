Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B4C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9170421783
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440024AbfIYQ4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:56:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43920 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392184AbfIYQ4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 12:56:09 -0400
Received: by mail-io1-f70.google.com with SMTP id i2so539955ioo.10
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 09:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C4r9LDbF2p0HwPfpAWk2w9xf+quUQCDipCG0hOvAJdU=;
        b=WdD2pHftjZveEqF7b5fAzd3VtnYtreAhCoI2xoNOe+m2g8T1SWHNOddN/8VyHyf/v2
         o5hUjKKOOSD9MYbNP34mjzpkGEPhDCR3qAdk9/NxCrpH9EbCKIzZuqge+3su+eLxcO+Q
         ol6SgPIWlOTMTBTeRUZ4ORin4WXLSx6fKshE9pTiyz8cJmCYCUEoZQ6juqqtkGZNDjCw
         DlhmvP4qgcgFyGBcRwJ38JObtKvaNS4EGuQy1di1mWxS3dyVN6WOC44yuLs3Y1cs9wNV
         drzG8Ilvn+RU3ONJRUMEaTpNIVwni80JXNKFRtCIOcNX95LkmgTjHHWo/0wsrDNDQgRt
         ct9g==
X-Gm-Message-State: APjAAAWHNqeeHk5pfmbkTfj+5RxIEYe6m9OtV8wWoveUmm5mQnt6Fs/1
        kqFthzHp5SuZskoxODWqjBjHRBylyd5G9nIH0XJX4362mtEs
X-Google-Smtp-Source: APXvYqz8c2QD+R45NIU3/aPah4UBs0Fm8y5Bqs+vlTYLf+07+Gbcc+VtP5vHvhUiFSRw4S4JvGec2FQmF4WZYsbu857WEpmV9ncw
MIME-Version: 1.0
X-Received: by 2002:a6b:b942:: with SMTP id j63mr346113iof.69.1569430567452;
 Wed, 25 Sep 2019 09:56:07 -0700 (PDT)
Date:   Wed, 25 Sep 2019 09:56:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007909bf059363878e@google.com>
Subject: WARNING in blk_mq_init_sched
From:   syzbot <syzbot+b2c197f98f86543b69c8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f7c3bf8f Merge tag 'gfs2-for-5.4' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f5baf9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50d4af03d68a470c
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c197f98f86543b69c8
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b2c197f98f86543b69c8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  
blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]
WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  
blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 25817 Comm: syz-executor.4 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x25c/0x799 kernel/panic.c:219
  __warn+0x22f/0x230 kernel/panic.c:576
  report_bug+0x190/0x290 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]
RIP: 0010:blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543
Code: f6 e8 9e 03 00 00 49 83 c6 10 4c 89 f7 e8 82 08 37 04 e9 ce fd ff ff  
e8 c8 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8 1d ae 28 fe <0f> 0b e9 ce f9  
ff ff e8 ae 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8
RSP: 0018:ffff88802225fbb8 EFLAGS: 00010246
RAX: 0000000000000024 RBX: 0000000000000000 RCX: 489d2508ed9c7100
RDX: ffffc9000e9a6000 RSI: 0000000000009af7 RDI: 0000000000009af8
RBP: ffff88802225fc50 R08: ffffffff815c9744 R09: ffffed1015d66090
R10: ffffed1015d66090 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888026958990 R14: ffff888026958080 R15: ffff8880269580d0
  elevator_init_mq+0x317/0x450 block/elevator.c:719
  __device_add_disk+0x6d/0x1140 block/genhd.c:705
  device_add_disk+0x2a/0x40 block/genhd.c:763
  add_disk include/linux/genhd.h:429 [inline]
  loop_add+0x5d1/0x780 drivers/block/loop.c:2051
  loop_control_ioctl+0x422/0x640 drivers/block/loop.c:2174
  do_vfs_ioctl+0x744/0x1730 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a09
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fce60497c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000006
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fce604986d4
R13: 00000000004c3118 R14: 00000000004d69f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
