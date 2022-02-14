Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 12:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiBNMlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:41:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBNMlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:31 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85358B845
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 04:41:21 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id y124-20020a6bc882000000b0060fbfe14d03so10412822iof.2
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 04:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/ogNVkQPxmgCJgiz3r7sJ/UoZMagbKaZs2wZ+gXktvo=;
        b=USPpz0iu5MlCA7O92WvLpRt+OK0pincj438kXJx6aV5MVoiiecsd/s+TFPoxTZTRZp
         m3EpCI6ZiemQKGuL3uE5ggVIA2Fi84wCy9ayYYDBG4SzQIqCkwp+BV3Snk+va2/4URBm
         zZxiLIMTSjyURJK5CaOrIRkHPFdKNeIcF95BeQ8liDseI39dTuIR7uKCzXOs12YzGh8a
         h70cvSCqfDnAr2p+Rd7hmFWxAWGDKH69uWqgyNaSKBcH7Mikzxh56XOUTuF6FhC4hIrE
         r/sdKYSADaS8ExR7nKc4gQd++QORpZgOdMsMU71ZNcY2cPbAiygRXvosQyL8fVmNfXB5
         vr3A==
X-Gm-Message-State: AOAM531dG2a0iZcMiJnA7h/eBjvw5xDuEJmeeMGsKSzNDLGS3lkW9Mf9
        Qvtg4ZSuHfiW+NWXemcaeKdc2tS6yOtYwfEQrd/pKLZ3xS+6
X-Google-Smtp-Source: ABdhPJy9LdtYSZVCagL6TVsGo5yLocufVDaumwa8kWvPToRWkHxtPQzNWMqPtbYEXEzY2H7Cu9Bx+wL30elaG0rho4XWgeTFXtJx
MIME-Version: 1.0
X-Received: by 2002:a02:3b24:: with SMTP id c36mr8103245jaa.148.1644842480871;
 Mon, 14 Feb 2022 04:41:20 -0800 (PST)
Date:   Mon, 14 Feb 2022 04:41:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8aedf05d7f9bb9c@google.com>
Subject: [syzbot] INFO: task can't die in submit_bio_wait (2)
From:   syzbot <syzbot+b8c45d4034039b7ce03e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ef6b35306dd8 Add linux-next specific files for 20220204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed552c700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c45d4034039b7ce03e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108cb306700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bed71c700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8c45d4034039b7ce03e@syzkaller.appspotmail.com

INFO: task syz-executor157:3633 can't die for more than 143 seconds.
task:syz-executor157 state:D stack:28120 pid: 3633 ppid:  3629 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5000 [inline]
 __schedule+0xab2/0x4db0 kernel/sched/core.c:6309
 schedule+0xd2/0x1f0 kernel/sched/core.c:6381
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
 io_schedule_timeout+0xcb/0x140 kernel/sched/core.c:8406
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common_io kernel/sched/completion.c:123 [inline]
 wait_for_completion_io_timeout+0x16f/0x280 kernel/sched/completion.c:191
 submit_bio_wait+0x158/0x230 block/bio.c:1308
 blkdev_issue_flush+0x95/0xd0 block/blk-flush.c:464
 blkdev_fsync+0x68/0xa0 block/fops.c:471
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:225 [inline]
 __se_sys_fdatasync fs/sync.c:223 [inline]
 __x64_sys_fdatasync+0xc5/0x140 fs/sync.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcb854986d9
RSP: 002b:00007ffd575ac058 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 0000000000076c12 RCX: 00007fcb854986d9
RDX: 00007fcb854986d9 RSI: 0000000000000005 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd575ac1f8 R09: 00007ffd575ac1f8
R10: 00007ffd575ac1f8 R11: 0000000000000246 R12: 00007ffd575ac06c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb83a60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6463
2 locks held by getty/3275:
 #0: ffff88807f051098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b662e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
