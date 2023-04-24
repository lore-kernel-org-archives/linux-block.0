Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB292C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 07:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDXHVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDXHVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 03:21:05 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01835A6
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7606d6b2fddso694771839f.2
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320846; x=1684912846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PemElVUZPDUlSEqORBOOBPYv/4pd8BGjx60bDqC5Fd0=;
        b=B1/N5k/Ul3OQvYUhCoRbPLnkZtEj89eAJRDn8yboUbnbjMI9lcdbUvshrnyJeV6Fta
         /0TGIkRKUG6VYcOS0Qxyzb3TVnTxRJ7BHaJI7pS9joEWWMVjUZcoXtKY1G5hAPsJUmur
         qeFE7pL0FZoZbBGQKVX5pmGgwjGbfEhg2BTaBHB9wtoiC+sQ9kNbrsG9J84EynLK+qLr
         raAMtLCamUTrPWX65R7sDSoO5hsvWMnta6PyegZmZaRzGJ8c36UuLbOb3GcjB1hcpOc3
         YaNlIwj9DFatYkbK3zw6ddF5Ivj1fY+0/sVb3QmE50XAq3vfWNAVEkfnnss/EYf6FmO6
         Y89g==
X-Gm-Message-State: AAQBX9d3848a0aB8Gebb532adaqGW1EKF1jCDbDFw0G7qv9zICUULFhI
        1nXF73RRUBUb3mEoheCtDYUXPZPbh69SqeKeY5ASa2JbnEXO
X-Google-Smtp-Source: AKy350Zm6j/ODxfO39PwH9P/0e7nkeWgN5FOdVmKrARV+imtnemEVPFoovMLXBeUeF/QT1K23d7kXScRuWN/hmfGXRymDW/JANOh
MIME-Version: 1.0
X-Received: by 2002:a6b:c407:0:b0:760:efd4:9583 with SMTP id
 y7-20020a6bc407000000b00760efd49583mr4136641ioa.1.1682320846333; Mon, 24 Apr
 2023 00:20:46 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:20:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071af7a05fa0fd8dc@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in __get_task_ioprio / set_task_ioprio
From:   syzbot <syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147afc8fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
dashboard link: https://syzkaller.appspot.com/bug?extid=28ed267c18c614a9376f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __get_task_ioprio / set_task_ioprio

write to 0xffff888108c83888 of 8 bytes by task 15748 on cpu 0:
 set_task_ioprio+0x23b/0x260 block/blk-ioc.c:291
 __do_sys_ioprio_set block/ioprio.c:124 [inline]
 __se_sys_ioprio_set+0x272/0x5a0 block/ioprio.c:68
 __x64_sys_ioprio_set+0x43/0x50 block/ioprio.c:68
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888108c83888 of 8 bytes by task 15749 on cpu 1:
 __get_task_ioprio+0x1c/0x110 block/ioprio.c:150
 get_current_ioprio include/linux/ioprio.h:60 [inline]
 init_sync_kiocb include/linux/fs.h:2003 [inline]
 __kernel_write_iter+0xe2/0x380 fs/read_write.c:515
 dump_emit_page fs/coredump.c:885 [inline]
 dump_user_range+0x258/0x480 fs/coredump.c:912
 elf_core_dump+0x1a73/0x1b90 fs/binfmt_elf.c:2142
 do_coredump+0xfeb/0x1840 fs/coredump.c:762
 get_signal+0xd65/0xff0 kernel/signal.c:2845
 arch_do_signal_or_restart+0x89/0x2a0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6f/0xe0 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:310
 irqentry_exit+0x12/0x40 kernel/entry/common.c:413
 exc_general_protection+0x339/0x4c0 arch/x86/kernel/traps.c:728
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564

value changed: 0x0000000000000000 -> 0xffff8881049b5c90

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15749 Comm: syz-executor.5 Tainted: G        W          6.3.0-rc6-syzkaller-00138-g44149752e998 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
