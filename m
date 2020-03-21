Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A63C4332E
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11AD20739
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 07:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCUHMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:12:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42502 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgCUHMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 03:12:14 -0400
Received: by mail-il1-f200.google.com with SMTP id j88so7265876ilg.9
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 00:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5fORrCMcUVv02/Y+9ZE3yapdwsGW5vGCompBoCUqjEE=;
        b=ieUaJHsKJp5u3jSTz0P9I3hYZihXUPra1bZ089X+oRSFkjf+/8ZHS2FxAe3WFyJrF1
         DcOhprAnJf2BKPBUFWaqH26y+zD+JXd6kgXxOHRbHS0XF0RXfg6X7IdPGHtstl6g03Ub
         1s11mGKqAND4/meuwBfDyupXezl+hlf03R8d2URCbXN17Q3mivcRrBRWSfwJO9Gw4gf1
         6E+3+pgZRLlFwkz1SWlE9Kja7qJ0LmSbFykdZuHYmCj04aPtv/NETgaIQtzSu46MSQjb
         hJJwJ9gsmboah64iHCZOmBFo03lqc7oVF5np9u/HwEUiBJhEi7btF64xQYwfCfqJuLi7
         vEZA==
X-Gm-Message-State: ANhLgQ2kIf8g4NnLSNEU9BJUxNIYDPzDPE8U8abmDsCOt4g6Un/GBr5s
        0aj06b86rTdQ7MOq8v3Y27mDn/AAiBO+4xYapBGyeXJxcWKr
X-Google-Smtp-Source: ADFU+vtNRxM1JULqvGWELdQcLGXPhAyyWEUBlMS3oYzGf4ILen7MSZM4JxFaGpQpsOVWjni9n8a//IQ/Pr2aVCrJDAK1ISsDAQUt
MIME-Version: 1.0
X-Received: by 2002:a92:a1c6:: with SMTP id b67mr5879710ill.27.1584774733620;
 Sat, 21 Mar 2020 00:12:13 -0700 (PDT)
Date:   Sat, 21 Mar 2020 00:12:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bec9805a1581f05@google.com>
Subject: INFO: task hung in blk_trace_remove
From:   syzbot <syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fb33c651 Linux 5.6-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140688d3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=c07afbbb410e9f712273
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com

INFO: task syz-executor.4:7237 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D26576  7237   9609 0x00004004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 blk_trace_remove+0x1e/0x40 kernel/trace/blktrace.c:361
 sg_ioctl_common+0x221/0x2710 drivers/scsi/sg.c:1125
 sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: Bad RIP value.
RSP: 002b:00007f5ba5a3bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5ba5a3c6d4 RCX: 000000000045c849
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000022b R14: 00000000004c4526 R15: 000000000076bf0c
INFO: task syz-executor.4:7266 blocked for more than 146 seconds.
      Not tainted 5.6.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D27752  7266   9609 0x00004004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
 sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
 sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: Bad RIP value.
RSP: 002b:00007f5ba5a1ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5ba5a1b6d4 RCX: 000000000045c849
RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000008
RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000228 R14: 00000000004c44eb R15: 000000000076bfac
INFO: task syz-executor.5:7265 blocked for more than 149 seconds.
      Not tainted 5.6.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D26736  7265   9613 0x00004004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
 sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
 sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: Bad RIP value.
RSP: 002b:00007f576f48ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f576f48b6d4 RCX: 000000000045c849
RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000006


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
