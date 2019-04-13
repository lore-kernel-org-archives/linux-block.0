Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA61CC10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FA32082E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 08:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDMI0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:26:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46615 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfDMI0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 04:26:10 -0400
Received: by mail-io1-f70.google.com with SMTP id k5so9892478ioh.13
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 01:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e9g1krkAwHK3KYFTuQi9dQszIvg0OZDEl6uJteFptC8=;
        b=nULDwf5OKCCwKNtpyvX43l3HYiKigJNTIUye4/jO8x9CfKt8NcwGLe8T4c1YZLvSdE
         bpGBNO7P5pfnKsydQwI5+Vg4Kn/GI+ywyf0JD5bnXYNfas3tX3VL9weCY/TPAdNITEOC
         tehGuj/RMXEBtRN6OikuYagpfNM3YC82Yu/aF2zKVY9LrFRs/sNTUM1VhYlaYYL3fFFc
         nGUWJvqrmdp38gfne2siYIK35BjsgAGVPL3lYfzPRTLQ6oRsx0S0JdZp9ir4WVRIF0+/
         z16o8UxvNzGQ6/r48QqBfH1/LsLGuT2sIwOrmKULNOCvUAtPNn91NjsgK7Qp2Jb7ga09
         JGdQ==
X-Gm-Message-State: APjAAAVgL0aBesJPILbdgLBUp3Rmr0q96FHHSJpr4KWei3i8g8wI4QSS
        UvPHIEp53o5vw64Y/ASTdBTL5asLZsbeaZmIsQGGFw4rdVan
X-Google-Smtp-Source: APXvYqxyQyJaZciKDObAZh+bS4szMDY/u10FOphDIZB/ZtxK7i+3HdhVUHIxOPlxtc5Tohx3FKm+8E3o6l7hAjpD8slJMOknHo8M
MIME-Version: 1.0
X-Received: by 2002:a24:c743:: with SMTP id t64mr4456079itg.37.1555143969459;
 Sat, 13 Apr 2019 01:26:09 -0700 (PDT)
Date:   Sat, 13 Apr 2019 01:26:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfd87b0586652bf3@google.com>
Subject: WARNING in io_uring_setup
From:   syzbot <syzbot+cd714a07c6de2bc34293@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hare@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ee15f32 Merge tag 'dma-mapping-5.1-1' of git://git.infrad..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146b7cd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=cd714a07c6de2bc34293
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d8b397200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b62ab7200000

The bug was bisected to:

commit 6c271ce2f1d572f7fa225700a13cfe7ced492434
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Jan 10 18:22:30 2019 +0000

     io_uring: add submission polling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170a286b200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=148a286b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=108a286b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd714a07c6de2bc34293@syzkaller.appspotmail.com
Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")

WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpu_max_bits_warn  
include/linux/cpumask.h:121 [inline]
WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpumask_check  
include/linux/cpumask.h:128 [inline]
WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpumask_test_cpu  
include/linux/cpumask.h:344 [inline]
WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121  
io_sq_offload_start fs/io_uring.c:2244 [inline]
WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 io_uring_create  
fs/io_uring.c:2851 [inline]
WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121  
io_uring_setup+0x13b2/0x1990 fs/io_uring.c:2903
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7600 Comm: syz-executor594 Not tainted 5.1.0-rc4+ #65
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:128 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:344 [inline]
RIP: 0010:io_sq_offload_start fs/io_uring.c:2244 [inline]
RIP: 0010:io_uring_create fs/io_uring.c:2851 [inline]
RIP: 0010:io_uring_setup+0x13b2/0x1990 fs/io_uring.c:2903
Code: 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 84 18 fe ff  
ff 48 89 df e8 e8 80 e0 ff e9 0b fe ff ff e8 2e 79 a8 ff <0f> 0b e9 db f8  
ff ff e8 22 79 a8 ff 49 8d 9c 24 88 00 00 00 48 b8
RSP: 0018:ffff8880a8eb7dc0 EFLAGS: 00010293
RAX: ffff88808cdd8700 RBX: 0000000000000400 RCX: ffffffff81c80eab
RDX: 0000000000000000 RSI: ffffffff81c815d2 RDI: 0000000000000005
RBP: ffff8880a8eb7ef0 R08: ffff88808cdd8700 R09: ffffed1011c75244
R10: ffffed1011c75243 R11: ffff88808e3a921f R12: ffff88808d34a480
R13: ffff8880a8eb7ec8 R14: ffff88808d34a4c0 R15: ffff88808d34a4d4
  __do_sys_io_uring_setup fs/io_uring.c:2916 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:2913 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:2913
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440239
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff32156718 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440239
RDX: 0000000000400b60 RSI: 0000000020000200 RDI: 0000000000000c9f
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401ac0
R13: 0000000000401b50 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
