Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C40C4360F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8117C20872
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfCRDgG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:36:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49147 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRDgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 23:36:06 -0400
Received: by mail-io1-f72.google.com with SMTP id w19so12482966ioa.15
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 20:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=morH9Kcq7W+GD/BZ5/IcndI6yLmG52mfSNJ6mTI7vK4=;
        b=QNkFKlNe/JYmz17VEEuIhX6v8ZVBrpd/6fRfZXZAXWUirXKIgfvBvR+8A8bx3ek4h7
         E0uyYt/aCFVqZ7cR9XpCICPLVjILjKrx3Fp1rVbEE4e+nJqCE7khO3QjYVVAIrLEKrbZ
         Zo6lfoSA4MRrFtpP2lZNZpGUIZo86tAu88VvvFh6AQ8Y3C+ZdYj9sBcrZoQ930BM+mtW
         5sNE/OFT7I43mybHP/aqgelQ086qT8kxIfN/IANKJRw4xg2tW/m64p3seYipJizQKlYn
         Ggnv43mGchy7qWz1IVNtV8Rqh0eyuuvhfCIC9RyH+dnn/0K+t8U2oZO9n8hM6OD4/WOt
         wr7w==
X-Gm-Message-State: APjAAAWeqW3+AXyuPmYGSgIWuBRP5ZuIrD12ZtnziZUyl6X/PeAh+3HS
        yTJ4mKtJBjtzfEsIpFrR/7YoK2UkYxfQVIpZBvIxmhQAaETS
X-Google-Smtp-Source: APXvYqx57rZSIUj0MtRaGCTthqH2HN/Nyhaz4ehwiu5PtmvBW3yE6dYMMBGi8ec+dVwS5bdSr6ZwAgUrj+D8i7mgTNvjD3ozsqTw
MIME-Version: 1.0
X-Received: by 2002:a24:78c:: with SMTP id f134mr9043752itf.30.1552880164713;
 Sun, 17 Mar 2019 20:36:04 -0700 (PDT)
Date:   Sun, 17 Mar 2019 20:36:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098bf7d05845616d7@google.com>
Subject: general protection fault in loop_validate_file (2)
From:   syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9c7dc824 Merge tag '5.1-rc-smb3' of git://git.samba.org/sf..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148a35fb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc1adc1c55e7fe765b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9499 Comm: syz-executor.4 Not tainted 5.0.0+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24  
f0 00 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 a8 00 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
Call Trace:
  loop_set_fd drivers/block/loop.c:930 [inline]
  lo_ioctl+0x99d/0x2150 drivers/block/loop.c:1542
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0xee8/0x1c40 block/ioctl.c:605
  block_ioctl+0xee/0x130 fs/block_dev.c:1931
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458079
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f04b0c90c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f04b0c916d4
R13: 00000000004c1252 R14: 00000000004d3160 R15: 00000000ffffffff
Modules linked in:
---[ end trace 81b29486bae7280a ]---
RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24  
f0 00 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 a8 00 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
