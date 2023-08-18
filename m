Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BBC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 16:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378524AbjHRQPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378597AbjHRQPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 12:15:09 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF044215
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2023 09:15:04 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5633ad8446bso1423196a12.1
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2023 09:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375304; x=1692980104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZXTzYhH/QokR/Ca1TtaJrXoB6xfiXR3zkEVWXsprDg=;
        b=LdfD8QKe4f9/zDfty7RLPIxUoiQb+qHvkl9qa4DNcpNUzo1qR2ptlcOoeMVlXJCM91
         e9ZyrioOhlvnevsR4CUdP6XLj/J7VLZSEQ2xVT8N6emeFbz4JjO+PKJNSEawhxpDayag
         r8JPZ+wh4GQmMuU9aKsOONR6171/Yngk8PRfHz5Tomr5B7At75o2EfsRC1DALJT2KNsv
         xCARJo4HyepSiBw/aNGDKRHKdfYnmimpfKOmYAwMZ7Y9oPg6Mi/PujkSfsSbd+SGVuEN
         1WjMhOOcntvfMXRaQVS1UsVPl2xg3JR8FByfwwNM61J5DxB2WSNJ9g2uSvDvYrAZ3LuN
         5bIg==
X-Gm-Message-State: AOJu0YwpJdGisn1GwfUMlmyqSsDQDZKsIw075sGLo9BcBrkFg/WA1+YI
        u1KKKZPtxlnekQVldYrWZy/L73w+s8FTEeBHbp/4LJuIiuP2
X-Google-Smtp-Source: AGHT+IHd/1ELFzzKWV7wTV5GChQtToCpSe/lkmsPL1ggv8ZD/3vYEBUhgXRBq0mGnHSUZXago2yTT1i+R+jJf96f+IfPhUxSCgzg
MIME-Version: 1.0
X-Received: by 2002:a17:902:e842:b0:1bc:1b01:894e with SMTP id
 t2-20020a170902e84200b001bc1b01894emr1011219plg.10.1692375303711; Fri, 18 Aug
 2023 09:15:03 -0700 (PDT)
Date:   Fri, 18 Aug 2023 09:15:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdf3e7060334d4a8@google.com>
Subject: [syzbot] [block?] WARNING in user_reset_fdc
From:   syzbot <syzbot+233dd451466273c18ef0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    16931859a650 Merge tag 'nfsd-6.5-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f58a4ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=233dd451466273c18ef0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-16931859.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdf15da7f883/vmlinux-16931859.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3793fa211ca9/bzImage-16931859.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+233dd451466273c18ef0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 26006 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 2 PID: 26006 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 2 PID: 26006 at drivers/block/floppy.c:999 user_reset_fdc+0x1a1/0x1e0 drivers/block/floppy.c:2945
Modules linked in:
CPU: 2 PID: 26006 Comm: syz-executor.3 Not tainted 6.5.0-rc6-syzkaller-00038-g16931859a650 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:user_reset_fdc+0x1a1/0x1e0 drivers/block/floppy.c:2945
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 02 7e 27 48 8d 04 9b 80 0c c5 38 37 42 92 04 e9 b4 fe ff ff e8 bf e8 4f fc <0f> 0b e9 3d ff ff ff e8 93 f5 a3 fc e9 d8 fe ff ff e8 29 f6 a3 fc
RSP: 0018:ffffc900283af978 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801ccec800 RSI: ffffffff85361fe1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000001 R14: 0000000000000012 R15: 0000000000000012
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:00000000f7fb4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f731c268 CR3: 0000000069b30000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fd_locked_ioctl+0xa78/0x1a10 drivers/block/floppy.c:3542
 fd_ioctl drivers/block/floppy.c:3576 [inline]
 fd_compat_ioctl+0x90b/0x1d00 drivers/block/floppy.c:3890
 compat_blkdev_ioctl+0x2fe/0x7c0 block/ioctl.c:677
 __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:968
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fb9579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fb45ac EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000254
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
