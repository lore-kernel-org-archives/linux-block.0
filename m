Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13731C4CECF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80742168B
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfIWS0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:13 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56098 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732993AbfIWS0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:13 -0400
Received: by mail-io1-f72.google.com with SMTP id r13so24741864ioj.22
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2019 11:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FanSXGQI5lw6yGFgc2B75WGYu1kp8UskH2qFwnqdt54=;
        b=RfwX91ClvzP1lMp262QIoNPrdiQa6h43Vo2f0Wfpi4lvzH3XJwY3/ukructRoqXJey
         eOC3OeNptIt+mmb8DGSLEY+5Rf+NmfbB9Wu2/UImoJ7xxnxmFtrSnFYCFKgaIeox0P6t
         EjiY7Bjnb7rMdf9XRVm0nFphN9MQuTgezBJIosi/T2VLxyJWMx7CPLiLEr89DnfbTWfv
         GBiDn4dfSdWZ1EkOj45m7wwrFwyjYzZuCHb5L08jHKDv1NMSiQBtbrkaCvTretq/wcb0
         B74q2xvzak2sSmjYRrVb5ubTRspAt19s5FfFb8QDqzDeimUOkqIj7UM6h2zLJmfBSS2l
         oKHw==
X-Gm-Message-State: APjAAAVCaAh9neJSJPsWgR3XS3cScAV1mAMgzrksjXu87mmbuYmlwrYY
        U6qaMlBHLxv1Mkk5Yb93OwJfQogosvxN4Un5vBGRr90gS49N
X-Google-Smtp-Source: APXvYqz+RF9YagAAYHdO3Dw8gF85oVxfTzC7UNEtjE/LDYjvsY8hDi+Wp/NsOAVaqNDCo7WiopdOgCPqjlTN+p/PZwRh06yBCxgN
MIME-Version: 1.0
X-Received: by 2002:a6b:7708:: with SMTP id n8mr768559iom.198.1569263171041;
 Mon, 23 Sep 2019 11:26:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:26:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de7f8c05933c8de0@google.com>
Subject: WARNING in blk_mq_sched_free_requests (2)
From:   syzbot <syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    574cc453 Merge tag 'drm-next-2019-09-18' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167c3c7e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c1d6bfa784bebea
dashboard link: https://syzkaller.appspot.com/bug?extid=da3b7677bb913dc1b737
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9291 at block/blk-mq-sched.c:558  
blk_mq_sched_free_requests.cold+0x11/0x21 block/blk-mq-sched.c:558
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9291 Comm: syz-executor.1 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:blk_mq_sched_free_requests.cold+0x11/0x21 block/blk-mq-sched.c:558
Code: fe 45 85 f6 0f 84 ab e9 ff ff e9 29 e8 ff ff 48 89 cf e8 43 0e 7d fe  
eb ce e8 bc c3 42 fe 48 c7 c7 00 65 e5 87 e8 84 47 2c fe <0f> 0b e9 47 f3  
ff ff 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57
RSP: 0018:ffff88805aa6f9e0 EFLAGS: 00010286
RAX: 0000000000000024 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c26d6 RDI: ffffed100b54df2e
RBP: ffff88805aa6fa30 R08: 0000000000000024 R09: ffffed1015d260d1
R10: ffffed1015d260d0 R11: ffff8880ae930687 R12: 00000000fffffff4
R13: ffff8880a3100100 R14: ffff88808521e1d8 R15: ffff8880a3100100
  blk_mq_init_sched+0x32c/0x766 block/blk-mq-sched.c:543
  elevator_init_mq+0x1d3/0x3f0 block/elevator.c:719
  __device_add_disk+0xd57/0x1230 block/genhd.c:705
  device_add_disk+0x2b/0x40 block/genhd.c:763
  add_disk include/linux/genhd.h:429 [inline]
  loop_add+0x635/0x8d0 drivers/block/loop.c:2051
  loop_control_ioctl drivers/block/loop.c:2152 [inline]
  loop_control_ioctl+0x165/0x360 drivers/block/loop.c:2134
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a09
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4830110c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000005
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f48301116d4
R13: 00000000004c3118 R14: 00000000004d69f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
