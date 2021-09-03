Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F826C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BDD61059
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 07:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbhICHeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhICHeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 03:34:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1229C061575;
        Fri,  3 Sep 2021 00:33:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c6so3111693pjv.1;
        Fri, 03 Sep 2021 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m/0cgjkZslnQ1OCjoolNSI2OK+EeZKpomVWDCO16f7s=;
        b=c0JUlp+Uk0f1D5e9lIiihNo3GElR/FiHaUHH0i568wOk7GZFUObiaBUYGIc4mmlaUo
         J+RnUbqxMtHm/rRYRAeSTnyqnimAPmWWXfi6Bm1S05vfExTNLzx8HF2Kba149fCh4TsP
         3bNQegMOIRSzAExnJFQNRKj4KIllEKAg34c7TZpOJXVj6WODDUyo/05gSClOIGKdGSbq
         i5K4RfCDFiVVP5H0palAfd35hgQv+QNwD4eALMTtYAN5jt1v1LOe2W4MoctQiOv6KI4H
         oJrdBgmCdV7BVt0mR4tdiDdjSXq+/l2LA6E97GdBsi8ROkC0LfICg8CdyT/tTRdYbHrH
         xL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m/0cgjkZslnQ1OCjoolNSI2OK+EeZKpomVWDCO16f7s=;
        b=JoIdWBmcp3otIEYpd8XlvodDqgM4TGg812e3QmomCJtbS5oXAg0Dcy8gcHrfszIFao
         pqcmkvB+NkCU7wrl+MHqZuBp7HgWmXgZNDhg03XtSeGmL+AE2UWC2CPCFfbJPWo/f6NH
         OB4y11rU6LaVlNWCUmfyBljgytx3wylGm0KqIglBjIRjq6cy6oKHmuw5apR4G2vEbAgm
         uENL6BAVfi0Za0ZoFymU/yESIAtExWyC5QqvyllRARTXvWtTmXw5NFAq1OB/xUAdCEMM
         og+q0qQTeukmhuI5Lv1hNsof3zV/RTLaE8bcGLhv3bQWowrxbZwD7VrNXBwN9qZAr7jH
         Ik/Q==
X-Gm-Message-State: AOAM530VfOrfhUQJ1vJ9Stfivc3Zj495ib6MpSWcZ9nih2YF2NogJDPW
        fi92OJpTp45Fi+SxivjND2lvbVoHLt3FI8mxsNTzC2hJoE+lYHg=
X-Google-Smtp-Source: ABdhPJxA012+IzaO93ulXiiKWS7FXXW/X5zfGWftj+xYIdqOC8aHYb/edSUz6nEWTqZrv7P72k1omgrVdIl3FXHA8dM=
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr8008765pjl.185.1630654399148;
 Fri, 03 Sep 2021 00:33:19 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 3 Sep 2021 15:33:08 +0800
Message-ID: <CACkBjsbufs8o_tovuq3s+-ij5443ZcKwTwrDRYR-mnSVPCdyJA@mail.gmail.com>
Subject: WARNING in do_syscall_64
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 7d2a07b76933 Linux 5.14
git tree: upstream
console output:
https://drive.google.com/file/d/16u3wNG5yzVrVg2JgCh02xnbl-Jhgixy9/view?usp=sharing
kernel config: https://drive.google.com/file/d/1XD9WYDViQLSXN7RGwH8AGGDvP9JvOghx/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1aRcBubQfi5DpLd4GF1B3b9SzHCh6kV8-/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1HWH_QhAdw0_llycc4qYMwSXhH17BqB-m/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop3: detected capacity change from 0 to 20480
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 PID: 8075 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:105
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1326
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:2880 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc_trace+0x62/0x350 mm/slub.c:2984
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 device_private_init drivers/base/core.c:3197 [inline]
 device_add+0x114a/0x2030 drivers/base/core.c:3247
 device_create_groups_vargs+0x203/0x280 drivers/base/core.c:4014
 device_create+0xdf/0x120 drivers/base/core.c:4056
 bdi_register_va.part.0+0x9c/0x800 mm/backing-dev.c:871
 bdi_register_va mm/backing-dev.c:906 [inline]
 bdi_register+0x12a/0x140 mm/backing-dev.c:903
 __device_add_disk+0x923/0xd10 block/genhd.c:521
 add_disk include/linux/genhd.h:217 [inline]
 loop_add+0x6ec/0x8c0 drivers/block/loop.c:2395
 loop_control_ioctl+0x130/0x3c0 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83625f8198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
R13: 00007ffc4876caff R14: 00007ffc4876cca0 R15: 00007f83625f8300
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8075 at block/genhd.c:523
__device_add_disk+0xba9/0xd10 block/genhd.c:523
Modules linked in:
CPU: 0 PID: 8075 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__device_add_disk+0xba9/0xd10 block/genhd.c:523
Code: fd ff ff 4c 89 ef 89 44 24 28 e8 22 a5 f3 fd 8b 44 24 28 e9 6f
fd ff ff 4c 89 ef e8 a1 a4 f3 fd e9 d5 fd ff ff e8 f7 b6 ac fd <0f> 0b
e9 8c fd ff ff 48 8b 7c 24 08 e8 96 a4 f3 fd e9 0a f6 ff ff
RSP: 0018:ffffc90005a27dc0 EFLAGS: 00010212
RAX: 000000000002e311 RBX: ffff88810d55c380 RCX: 0000000000040000
RDX: ffffc900012e9000 RSI: ffff888102aa9cc0 RDI: 0000000000000002
R10: 0000000000000005 R11: fffffbfff1eb371f R12: 0000000000000001
FS:  00007f83625f8700(0000) GS:ffff888119e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
PKRU: 55555554
Call Trace:
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f83625f81d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8075 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:105
 panic+0x306/0x73d kernel/panic.c:232
 __warn.cold+0x20/0x2f kernel/panic.c:606
 report_bug+0x273/0x300 lib/bug.c:199
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:259
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:566
RIP: 0010:__device_add_disk+0xba9/0xd10 block/genhd.c:523
Code: fd ff ff 4c 89 ef 89 44 24 28 e8 22 a5 f3 fd 8b 44 24 28 e9 6f
fd ff ff 4c 89 ef e8 a1 a4 f3 fd e9 d5 fd ff ff e8 f7 b6 ac fd <0f> 0b
e9 8c fd ff ff 48 8b 7c 24 08 e8 96 a4 f3 fd e9 0a f6 ff ff
RAX: 000000000002e311 RBX: ffff88810d55c380 RCX: 0000000000040000
RDX: ffffc900012e9000 RSI: ffff888102aa9cc0 RDI: 0000000000000002
RBP: ffff88810b438800 R08: ffffffff83c84189 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1eb371f R12: 0000000000000001
R13: ffff88810d55c85c R14: ffff88810b4388a0 R15: 0000000000000000
 add_disk include/linux/genhd.h:217 [inline]
 loop_add+0x6ec/0x8c0 drivers/block/loop.c:2395
 loop_control_ioctl+0x130/0x3c0 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83625f8198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f83625f81d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
R13: 00007ffc4876caff R14: 00007ffc4876cca0 R15: 00007f83625f8300
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
----------------
Code disassembly (best guess):
   0: 02 b8 ff ff ff ff    add    -0x1(%rax),%bh
   6: c3                    retq
   7: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
   d: f3 0f 1e fa          endbr64
  11: 48 89 f8              mov    %rdi,%rax
  14: 48 89 f7              mov    %rsi,%rdi
  17: 48 89 d6              mov    %rdx,%rsi
  1a: 48 89 ca              mov    %rcx,%rdx
  1d: 4d 89 c2              mov    %r8,%r10
  20: 4d 89 c8              mov    %r9,%r8
  23: 4c 8b 4c 24 08        mov    0x8(%rsp),%r9
  28: 0f 05                syscall
* 2a: 48 3d 01 f0 ff ff    cmp    $0xfffffffffffff001,%rax <--
trapping instruction
  30: 73 01                jae    0x33
  32: c3                    retq
  33: 48 c7 c1 bc ff ff ff mov    $0xffffffffffffffbc,%rcx
  3a: f7 d8                neg    %eax
  3c: 64 89 01              mov    %eax,%fs:(%rcx)
  3f: 48                    rex.W
