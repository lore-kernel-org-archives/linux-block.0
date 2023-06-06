Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4FC7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 06:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjFFGuu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 02:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjFFGur (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 02:50:47 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F832E51
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 23:50:45 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-777b6a2582dso140234039f.2
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 23:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034244; x=1688626244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=du6lXZ2wzVmR8xlGtgqR3/tnDRrX5BVyGhvfJnhAl34=;
        b=PCY51Q6+ZZn9k8y2E+gEFAgQUcP7NV+KWkbYh0IaI92nZB12eZZnZoYb9owJwjJj3C
         izozGOj0V9ER28alEp5PH9uRVspYB8EBKi9pawxg62fnOudAakkc/y9n8p8q+8zM5ME7
         greyEQDAoZ0BRxTtizXu2OrFRWJggmD9Wt/hMV+nMgZoZ4C6YtXog3bDmmc17Q3A9WfQ
         OXyisvO2sTnkUwXOsQkFmFdCYeOPTXpdyb97S1g28XZsWWmLVWOFc1AlkQCbo0Sa1l+J
         zUrfiSh7i2LJMIc9Lf3vmexzegzSv4O184pYpH6J+kvtZsmvYWbuMh8GUdHqJ+ljAXXM
         dO9g==
X-Gm-Message-State: AC+VfDwCDEdTb7udqyYbM7kvg04CMWIXxMle/zw3HQUhIcuQknFS0Ena
        ijA0TIv9vW62qu9i/xx4qdqPUA/qLnwFT4Mlf+zTAm1MsD/f
X-Google-Smtp-Source: ACHHUZ6gj+X4ALzjVGuQygsdQoFoWzMtU0sCM5HDfKP7m6h4x17kc5wiNq4kqfXEsZemszHyJiNA3RJe1eL1rymwYTIUzxJzM/mP
MIME-Version: 1.0
X-Received: by 2002:a5e:c10b:0:b0:777:b315:f4fc with SMTP id
 v11-20020a5ec10b000000b00777b315f4fcmr680599iol.2.1686034244669; Mon, 05 Jun
 2023 23:50:44 -0700 (PDT)
Date:   Mon, 05 Jun 2023 23:50:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b9a8105fd7070b6@google.com>
Subject: [syzbot] [block?] kernel BUG in truncate_inode_pages_range (2)
From:   syzbot <syzbot+0c073c3b52d621befda9@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1874a42a7d74 Merge tag 'firewire-fixes-6.4-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11001fcd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=0c073c3b52d621befda9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367f7f99ae3f/disk-1874a42a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9366557db826/vmlinux-1874a42a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36e357c7b00e/bzImage-1874a42a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c073c3b52d621befda9@syzkaller.appspotmail.com

 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 exit_mmap+0x3da/0xaf0 mm/mmap.c:3123
 __mmput+0x115/0x3c0 kernel/fork.c:1351
 exit_mm+0x227/0x310 kernel/exit.c:564
 do_exit+0x612/0x2290 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 get_signal+0x1701/0x17e0 kernel/signal.c:2874
 arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
------------[ cut here ]------------
kernel BUG at mm/truncate.c:423!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10158 Comm: syz-executor.3 Not tainted 6.4.0-rc4-syzkaller-00099-g1874a42a7d74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:truncate_inode_pages_range+0xf82/0x11b0 mm/truncate.c:423
Code: 00 00 48 c7 c7 70 1b fd 8c 48 89 da e8 d7 a0 ab 02 e9 40 f7 ff ff e8 6d 38 ca ff 4c 89 e7 48 c7 c6 c0 08 f3 8a e8 7e ec 09 00 <0f> 0b e8 27 f9 ed 08 e8 52 38 ca ff 4c 89 ff 48 c7 c6 00 08 f3 8a
RSP: 0018:ffffc90015d97600 EFLAGS: 00010246
RAX: 2457790b5b1cdd00 RBX: 0000000000000005 RCX: ffffc90015d97403
RDX: 0000000000000001 RSI: ffffffff8aea9fa0 RDI: ffffffff8b384540
RBP: ffffc90015d97880 R08: dffffc0000000000 R09: fffffbfff1cab94e
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0000a6dfc0
R13: ffffc90015d976f0 R14: ffffc90015d97788 R15: 0000000000000006
FS:  00007f5529bfe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1849dc9000 CR3: 000000001e9ca000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_bdev block/bdev.c:76 [inline]
 set_blocksize+0x318/0x390 block/bdev.c:152
 sb_set_blocksize+0x48/0x100 block/bdev.c:161
 udf_load_vrs+0xe8/0x1100 fs/udf/super.c:1947
 udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2151
 mount_bdev+0x2d0/0x3f0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f552b08d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5529bfdf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000c10 RCX: 00007f552b08d69a
RDX: 0000000020000180 RSI: 0000000020000000 RDI: 00007f5529bfdfe0
RBP: 00007f5529bfe020 R08: 00007f5529bfe020 R09: 00000000020180c8
R10: 00000000020180c8 R11: 0000000000000202 R12: 0000000020000180
R13: 0000000020000000 R14: 00007f5529bfdfe0 R15: 0000000020002440
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:truncate_inode_pages_range+0xf82/0x11b0 mm/truncate.c:423
Code: 00 00 48 c7 c7 70 1b fd 8c 48 89 da e8 d7 a0 ab 02 e9 40 f7 ff ff e8 6d 38 ca ff 4c 89 e7 48 c7 c6 c0 08 f3 8a e8 7e ec 09 00 <0f> 0b e8 27 f9 ed 08 e8 52 38 ca ff 4c 89 ff 48 c7 c6 00 08 f3 8a
RSP: 0018:ffffc90015d97600 EFLAGS: 00010246
RAX: 2457790b5b1cdd00 RBX: 0000000000000005 RCX: ffffc90015d97403
RDX: 0000000000000001 RSI: ffffffff8aea9fa0 RDI: ffffffff8b384540
RBP: ffffc90015d97880 R08: dffffc0000000000 R09: fffffbfff1cab94e
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0000a6dfc0
R13: ffffc90015d976f0 R14: ffffc90015d97788 R15: 0000000000000006
FS:  00007f5529bfe700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f05f87ad988 CR3: 000000001e9ca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
