Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF475C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D38B64FBB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 20:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhBESYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:24:44 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54841 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhBEPTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 10:19:34 -0500
Received: by mail-io1-f72.google.com with SMTP id g7so6734220ion.21
        for <linux-block@vger.kernel.org>; Fri, 05 Feb 2021 09:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mSqK5+HT7sF9c5heDYaZYEXceuBiqepNDhzdp3OgxoU=;
        b=GNeCyfR8s7yzN6fGwWKXMowfFKTbjTJF71IhHfGxDiABZdJqBKG4KpXOTG41qLjfZb
         6tYAtyLXWvzJjSWE5LqsFCc5dHf8dMFpegyQZ9qam4OqSX41TMJGuuZflHOSi5ZJ3k0f
         l2y0EjOd40e2fIN6SR6WQg6Z6Tda8RaarbqraEh/J7peJvfDPYaBJJj++JfDo9mDxphn
         aeJvmboRkF1nzI3OQzDwUwMr0xaKuZdc5H9R17w8e3zLgZZmL+5bh21k5skGVq1TThPM
         2drJLk61bYwfDESZP6ZuQgvz9FmzGTqpqd+jenNf76xLnJTfHYVxFVYTgCFKzMfDncid
         DuAw==
X-Gm-Message-State: AOAM532oz9n1JMUlaHgCGgrQ4L9zgg/MQ7Z2d+BvH6HCpos4T5/lnKWi
        qfpTHeW+PfgKnC8wWULKhE3YVEKpH8dB04dvDUvwVCA+sEju
X-Google-Smtp-Source: ABdhPJzcJAj7a4ZLnxPRZwGXbaooH+OhaU4VrOI8vwAMCHaHgw4iYhWXgDWk19VBbEgadrXM4kIm6TAuaydgwH3eWlWh0wlBTxhi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr4642881ill.301.1612544421561;
 Fri, 05 Feb 2021 09:00:21 -0800 (PST)
Date:   Fri, 05 Feb 2021 09:00:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e8af605ba99c1af@google.com>
Subject: KCSAN: data-race in blk_stat_add / blk_stat_timer_fn (5)
From:   syzbot <syzbot+2b6452167d85a022bc6f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130e19b4d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38728258f37833e3
dashboard link: https://syzkaller.appspot.com/bug?extid=2b6452167d85a022bc6f
compiler:       clang version 12.0.0 (https://github.com/llvm/llvm-project.git 913f6005669cfb590c99865a90bc51ed0983d09d)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b6452167d85a022bc6f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in blk_stat_add / blk_stat_timer_fn

write to 0xffffe8ffffd35c80 of 8 bytes by interrupt on cpu 0:
 blk_rq_stat_init block/blk-stat.c:24 [inline]
 blk_stat_timer_fn+0x349/0x410 block/blk-stat.c:95
 call_timer_fn+0x2e/0x240 kernel/time/timer.c:1417
 expire_timers+0x116/0x260 kernel/time/timer.c:1462
 __run_timers+0x338/0x3d0 kernel/time/timer.c:1731
 run_timer_softirq+0x19/0x30 kernel/time/timer.c:1744
 __do_softirq+0x13c/0x2c3 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu+0xb4/0xc0 kernel/softirq.c:420
 sysvec_apic_timer_interrupt+0x74/0x90 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628

read to 0xffffe8ffffd35c80 of 8 bytes by interrupt on cpu 1:
 blk_rq_stat_add block/blk-stat.c:46 [inline]
 blk_stat_add+0x13d/0x230 block/blk-stat.c:74
 __blk_mq_end_request+0x142/0x230 block/blk-mq.c:546
 scsi_end_request+0x2a6/0x470 drivers/scsi/scsi_lib.c:604
 scsi_io_completion+0x104/0xfb0 drivers/scsi/scsi_lib.c:969
 scsi_finish_command+0x263/0x2b0 drivers/scsi/scsi.c:214
 scsi_softirq_done+0xdf/0x440 drivers/scsi/scsi_lib.c:1449
 blk_done_softirq+0x145/0x190 block/blk-mq.c:588
 __do_softirq+0x13c/0x2c3 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu+0xb4/0xc0 kernel/softirq.c:420
 common_interrupt+0xb5/0x130 arch/x86/kernel/irq.c:239
 asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:619
 check_access kernel/kcsan/core.c:633 [inline]
 __tsan_read1+0x156/0x180 kernel/kcsan/core.c:839
 tomoyo_get_mode security/tomoyo/util.c:1003 [inline]
 tomoyo_init_request_info+0xfc/0x160 security/tomoyo/util.c:1031
 tomoyo_path_perm+0x8b/0x330 security/tomoyo/file.c:815
 tomoyo_inode_getattr+0x18/0x20 security/tomoyo/tomoyo.c:123
 security_inode_getattr+0x7f/0xd0 security/security.c:1280
 vfs_getattr fs/stat.c:121 [inline]
 vfs_fstat+0x45/0x390 fs/stat.c:146
 __do_sys_newfstat fs/stat.c:386 [inline]
 __se_sys_newfstat+0x35/0x240 fs/stat.c:383
 __x64_sys_newfstat+0x2d/0x40 fs/stat.c:383
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 18199 Comm: modprobe Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
