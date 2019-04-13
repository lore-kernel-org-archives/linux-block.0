Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17202C10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 08:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD627208E4
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 08:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDMIQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:16:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39069 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMIQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 04:16:11 -0400
Received: by mail-io1-f70.google.com with SMTP id c17so9787999iot.6
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JYwa0fO1NtQQxeN51+orwtMJaSYdGsjlNAoUd8rz2OQ=;
        b=tOd0Qzg4igjs8N3nJ6v5FLj4Rc6kzVx+tnVp0+Qv+NzrB+6KkEwe/tLakBJYnicA2Y
         LOXhCQKvumTX/LP1CQjLbx1wkvShM0XMSaR7s5LRNIApsNTrfVx+IboPesdEQK7wthCu
         RFzMIn9HAZzY65cjn39KJ4eASZD8yn/LgNNb1r8FOxCt2A6B8CRaEXf/0lJ31uKruepO
         v87nolMEbO0qba+ZdN8Mc5ZYU8nKz86s44MvlCfYgKIj9di9pObdXhfKvipQ2bHtxYWN
         l1t1xCy7sQ8bnYVS3+GdbVyWfPs2S+uV3mQYBoOfqnZhAHeJRHdBdsGueGCLR0JDRlTu
         76Yg==
X-Gm-Message-State: APjAAAX47UnNFVEgR7Xlzgt49f6iegdQzfbwx8FSxOPW2F2quwTDaKrN
        Q3MzpblH9Tkz3rS8N3KlkuzitS0cEniQRnG7VFL98sSHM+K0
X-Google-Smtp-Source: APXvYqw7x4tx2VnF/fG0o2/iHwpHbtVdqt2T+HF0JxPCvxDZ98/fOAvN+GqhZ6Op4dgucBz1az+09NbHQtHKHNtBtZMPDa+Dp52k
MIME-Version: 1.0
X-Received: by 2002:a02:5a4a:: with SMTP id v71mr10917042jaa.22.1555143370974;
 Sat, 13 Apr 2019 01:16:10 -0700 (PDT)
Date:   Sat, 13 Apr 2019 01:16:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033aefc058665083c@google.com>
Subject: WARNING in __kthread_bind_mask
From:   syzbot <syzbot+6d4a92619eb0ad08602b@syzkaller.appspotmail.com>
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

HEAD commit:    bcb67f0f Add linux-next specific files for 20190412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=165912d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c479ecf64ba753
dashboard link: https://syzkaller.appspot.com/bug?extid=6d4a92619eb0ad08602b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c9ebbb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153f76dd200000

The bug was bisected to:

commit 6c271ce2f1d572f7fa225700a13cfe7ced492434
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Jan 10 18:22:30 2019 +0000

     io_uring: add submission polling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143498f3200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=163498f3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=123498f3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6d4a92619eb0ad08602b@syzkaller.appspotmail.com
Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")

WARNING: CPU: 0 PID: 7822 at kernel/kthread.c:399  
__kthread_bind_mask+0x3b/0xc0 kernel/kthread.c:399
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7822 Comm: syz-executor030 Not tainted 5.1.0-rc4-next-20190412  
#24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x72b kernel/panic.c:214
  __warn.cold+0x20/0x46 kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__kthread_bind_mask+0x3b/0xc0 kernel/kthread.c:399
Code: 48 89 fb e8 f7 ab 24 00 4c 89 e6 48 89 df e8 ac e1 02 00 31 ff 49 89  
c4 48 89 c6 e8 7f ad 24 00 4d 85 e4 75 15 e8 d5 ab 24 00 <0f> 0b e8 ce ab  
24 00 5b 41 5c 41 5d 41 5e 5d c3 e8 c0 ab 24 00 4c
RSP: 0018:ffff8880a89bfbb8 EFLAGS: 00010293
RAX: ffff88808ca7a280 RBX: ffff8880a98e4380 RCX: ffffffff814bdd11
RDX: 0000000000000000 RSI: ffffffff814bdd1b RDI: 0000000000000007
RBP: ffff8880a89bfbd8 R08: ffff88808ca7a280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff87691148 R14: ffff8880a98e43a0 R15: ffffffff81c91e10
  __kthread_bind kernel/kthread.c:412 [inline]
  kthread_unpark+0x123/0x160 kernel/kthread.c:480
  kthread_stop+0xfa/0x6c0 kernel/kthread.c:556
  io_sq_thread_stop fs/io_uring.c:2057 [inline]
  io_sq_thread_stop fs/io_uring.c:2052 [inline]
  io_finish_async+0xab/0x180 fs/io_uring.c:2064
  io_ring_ctx_free fs/io_uring.c:2534 [inline]
  io_ring_ctx_wait_and_kill+0x133/0x510 fs/io_uring.c:2591
  io_uring_release+0x42/0x50 fs/io_uring.c:2599
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x90a/0x2fa0 kernel/exit.c:876
  do_group_exit+0x135/0x370 kernel/exit.c:980
  __do_sys_exit_group kernel/exit.c:991 [inline]
  __se_sys_exit_group kernel/exit.c:989 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ee98
Code: Bad RIP value.
RSP: 002b:00007fff28656a18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ee98
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be6a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
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
