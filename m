Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD09C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5944664DE5
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBVJGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:06:18 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41478 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBVJGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 04:06:00 -0500
Received: by mail-il1-f199.google.com with SMTP id d11so7197238ilu.8
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 01:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J59NEsdnKt/7aOqTj63pAI6TpGTWhIOirl4bzlLfxDo=;
        b=a02M42dvQpqgiszwWhiHSu68Y8PFLUfetGrcoFjkVvS7IoUxXN6tH24xtDEP/FGCYi
         2JigPYDFDglSX8NvM3DvaPWNDXZzpgwlLw9ywoRXXgzmyWDsdeCrAWzSlcBlNl0H218g
         QwkJsMM0ZZ//tYMWDWyszlbF9Jw4mq+Z6HygP0rHoHo9IRKENOi8GHfKjEUNHEvGSzX7
         KMHgBuKz+w8daOB+nNZzTpuFsvjnhEh9pUozo2j9dP6DlOCJZnAJ7XOQ30WiKP1JK0VO
         g0unXlul0xwL/Gxt0gfTlEYllD7aCijhwuC2MAVXyUaAmqvdyXbhBzVmgitYFkIgVhQR
         4WIg==
X-Gm-Message-State: AOAM530BcH0MWXuH4aiz2oZ6oI+uTcp4AYI39GUhijWKnbKJJFMHq54X
        I9WgAjyvHUHnauAMLH2mlF9o8nF4QK8BpNYrNO5YnbsP72/d
X-Google-Smtp-Source: ABdhPJxy6E4FR8bHOVbu3XyDQTP6xcj/uRe69WTyb9A3ddbhdXm5Ts8P3/ACJ+lE9BlaVzpPeOJwvfeYQAMoVPLRLJjvRcvXKXa3
MIME-Version: 1.0
X-Received: by 2002:a92:cd09:: with SMTP id z9mr6763449iln.223.1613984719867;
 Mon, 22 Feb 2021 01:05:19 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:05:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e692c905bbe9192c@google.com>
Subject: general protection fault in nbd_disconnect_and_put
From:   syzbot <syzbot+db0c9917f71539bc4ad1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17494c6cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b919ebed7b4902
dashboard link: https://syzkaller.appspot.com/bug?extid=db0c9917f71539bc4ad1
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d7c8b8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a2dd22d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db0c9917f71539bc4ad1@syzkaller.appspotmail.com

block nbd0: NBD_DISCONNECT
general protection fault, probably for non-canonical address 0xdffffc0000000027: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000138-0x000000000000013f]
CPU: 0 PID: 8395 Comm: systemd-udevd Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0x8a/0x5e90 kernel/locking/lockdep.c:4702
Code: ff df 8a 04 30 84 c0 0f 85 3b 26 00 00 83 3d c0 40 58 0c 00 0f 84 b1 41 00 00 83 3d cf 7b 02 0b 00 74 2b 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 78 ce 5f 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90001a2f8f0 EFLAGS: 00010006
RAX: 0000000000000027 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000138
RBP: ffffc90001a2faa0 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1b6727e R11: 0000000000000000 R12: ffff888022c3d340
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000138
FS:  00007fce26a608c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2589efe8 CR3: 0000000013a4a000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x114/0x5e0 kernel/locking/lockdep.c:5442
 flush_workqueue+0x120/0x1620 kernel/workqueue.c:2786
 nbd_disconnect_and_put+0x124/0x1f0 drivers/block/nbd.c:1995
 nbd_release+0xeb/0x120 drivers/block/nbd.c:1505
 __blkdev_put+0x516/0x670 fs/block_dev.c:1579
 blkdev_put+0x2cd/0x440 fs/block_dev.c:1632
 blkdev_close+0x7a/0xa0 fs/block_dev.c:1640
 __fput+0x34d/0x7a0 fs/file_table.c:280
 task_work_run+0x137/0x1c0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x10b/0x1e0 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x48/0x180 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fce25ba6270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffddcf33578 EFLAGS: 00000246
 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fce25ba6270
RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fce26a60710 R08: 000000000000004a R09: 0000000000000008
R10: 000055ed6e37e9a8 R11: 0000000000000246 R12: 0000000000000000
R13: 000055ed6e390fd0 R14: 0000000000000003 R15: 000000000000000e
Modules linked in:

---[ end trace aae642bbdfc14982 ]---
RIP: 0010:__lock_acquire+0x8a/0x5e90 kernel/locking/lockdep.c:4702
Code: ff df 8a 04 30 84 c0 0f 85 3b 26 00 00 83 3d c0 40 58 0c 00 0f 84 b1 41 00 00 83 3d cf 7b 02 0b 00 74 2b 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 78 ce 5f 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90001a2f8f0 EFLAGS: 00010006
RAX: 0000000000000027 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000138
RBP: ffffc90001a2faa0 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1b6727e R11: 0000000000000000 R12: ffff888022c3d340
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000138
FS:  00007fce26a608c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2589efe8 CR3: 0000000013a4a000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
