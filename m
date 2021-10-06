Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7AC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4B6610C9
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 08:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhJFIOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhJFIOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 04:14:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5DC061749;
        Wed,  6 Oct 2021 01:12:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so1737242pjb.0;
        Wed, 06 Oct 2021 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P2QMvNboRciBmJaz6KQZe0gQg4iVEULw1TeHChRcqGw=;
        b=J+rDbILUAWBpmBqPSH0ZCbK3K0rv9FpJO/muJRj6m2VsBUQDc5CuAPRChPPIq3DU28
         DdT8Blacig4zXSno7XcvnPvj+yL2q53y6Da2BHmAJUE3rU4bdrHqlQY2/ff7FLdDZ61N
         VyLkUIQjna4AoN3Bhv23Wp/gN1MemhrwwaWq2c3tR9RWKaItXmvhrU9rwXzJxqvBAR2b
         tH00W1CA2mfUzAu0rCtvtlA+qyFMSj9vt6AF7OcqvaFIaV+AqRAluHSf912ZztSAzCHc
         LFfdV9fcBe7+JlTYmXXQQ6Q8N5KCGd4Vc4sYfRhHwgdfuvLEnGiL03W+7+4MUOchFPX0
         MGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P2QMvNboRciBmJaz6KQZe0gQg4iVEULw1TeHChRcqGw=;
        b=4YH+hlFW0jb0bZOQg0VEMDsxVggY6XBUxPpRLaABIXDNRkXVbkjcGPDh7LvlPux19i
         7aBn8DuU4IZ+gE9+X+n1wjFlRfZe+cjib6AXj/wQvTXkE+dtoGFMsXQig3jpeU+PQudA
         PhmljQtA2qm69TnjXEiL9uZ4KSIj2nCLb/NM2j6tFCPi5/7SAYNrjPZNL1s/Y8bzuBV4
         jFDZd3NQMv8bw0De3ihOmOqUR0BIwWlwij9SbDoHj1RSuUvQdHqKxDu7Ksv89VJR9xIW
         jg+8JN38czPOK3pmZ2E9FnY3K3vSgkUnuW25mZSPbc+l1bwqtLu8OjsPxiImgf0TvsXK
         kMOg==
X-Gm-Message-State: AOAM5317Jlawk9Ds/nXAJDEASoYXAKjWMb0jQEsQYr5Ej6LBUDKXbJNP
        FdXFlg+3Ey9jd3EL5sAtKJi5B3Tx4Z6yyABytA==
X-Google-Smtp-Source: ABdhPJyindIUZz8sf3gTfb99rEeQYAdBz2eb/Qm1uiEZBwXNEY/3z0WCwqW1NrliBz4d53IYOhAswTqvTcAOQallxyw=
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id
 w4-20020a1709027b8400b0013b90a7e270mr9734786pll.21.1633507927871; Wed, 06 Oct
 2021 01:12:07 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 16:11:56 +0800
Message-ID: <CACkBjsbDy4gq1NP1vtorCiYXd+4YhhWvMcqQik7KSb9sp-qqww@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in reset_interrupt
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     efremov@linux.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/1Vg4qLPbcjILoerGfzKXlEpdmagBonsn1/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

84 90 4295172491
last result at 4295172491
last redo_fd_request at 4295166102
40 00 00 e2 1e e5 02                             @......
status=80
fdc_busy=1
floppy_work.func=floppy_work_workfn
timer_function=ffffffff82653f90 expires=294
cont=ffffffff84a34480
current_req=0000000000000000
command_status=-1

floppy0: Unable to send byte 1e to FDC. Fdc=0 Status=d0

floppy driver state
-------------------
now=4295172495 last interrupt=4295172491 diff=4 last called
handler=main_command_interrupt
timeout_message=floppy start
last output bytes:
 f 80 4295166093
 0 90 4295166093
 1 90 4295166093
 8 80 4295166093
 4 80 4295166099
 0 90 4295166099
 f 80 4295166099
 0 90 4295166099
 0 90 4295166099
 8 80 4295166099
31 80 4295172491
e4 90 4295172491
e2 90 4295172491
1e 90 4295172491
e5 90 4295172491
af 90 4295172491
2e 90 4295172491
25 90 4295172491
84 90 4295172491
6b 80 4295172495
last result at 4295172491
last redo_fd_request at 4295166102
40 00 00 e2 1e e5 02                             @......
status=d0
fdc_busy=1
floppy_work.func=floppy_work_workfn
timer_function=ffffffff82653f90 expires=288
cont=ffffffff84a34480
current_req=0000000000000000
command_status=-1

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 7832 Comm: kworker/u8:3 Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt+0x60/0xf0 drivers/block/floppy.c:1792
Code: 1d 35 c6 30 06 48 83 fb 01 0f 87 8c 00 00 00 48 8d 04 9b f6 04
c5 f8 04 96 88 04 75 42 e8 b8 52 d2 fe 48 8b 05 89 c6 30 06 5b <48> 8b
40 08 ff e0 e8 a5 52 d2 fe 48 8b 0d be 72 1b 03 48 c7 c2 16
RSP: 0018:ffffc90005097e48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888104398000 RSI: ffffffff82653ea8 RDI: 0000000000000000
RBP: ffffc90005097ec8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90005097d18 R11: 0000000000000001 R12: ffff888016f6bd80
R13: ffff888008c5cc00 R14: ffff888009860c00 R15: ffffffff85c70b00
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000001912b000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000008
---[ end trace c4cbac3b36a74da5 ]---
RIP: 0010:reset_interrupt+0x60/0xf0 drivers/block/floppy.c:1792
Code: 1d 35 c6 30 06 48 83 fb 01 0f 87 8c 00 00 00 48 8d 04 9b f6 04
c5 f8 04 96 88 04 75 42 e8 b8 52 d2 fe 48 8b 05 89 c6 30 06 5b <48> 8b
40 08 ff e0 e8 a5 52 d2 fe 48 8b 0d be 72 1b 03 48 c7 c2 16
RSP: 0018:ffffc90005097e48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888104398000 RSI: ffffffff82653ea8 RDI: 0000000000000000
RBP: ffffc90005097ec8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90005097d18 R11: 0000000000000001 R12: ffff888016f6bd80
R13: ffff888008c5cc00 R14: ffff888009860c00 R15: ffffffff85c70b00
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000001912b000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 1d 35 c6 30 06        sbb    $0x630c635,%eax
   5: 48 83 fb 01          cmp    $0x1,%rbx
   9: 0f 87 8c 00 00 00    ja     0x9b
   f: 48 8d 04 9b          lea    (%rbx,%rbx,4),%rax
  13: f6 04 c5 f8 04 96 88 testb  $0x4,-0x7769fb08(,%rax,8)
  1a: 04
  1b: 75 42                jne    0x5f
  1d: e8 b8 52 d2 fe        callq  0xfed252da
  22: 48 8b 05 89 c6 30 06 mov    0x630c689(%rip),%rax        # 0x630c6b2
  29: 5b                    pop    %rbx
* 2a: 48 8b 40 08          mov    0x8(%rax),%rax <-- trapping instruction
  2e: ff e0                jmpq   *%rax
  30: e8 a5 52 d2 fe        callq  0xfed252da
  35: 48 8b 0d be 72 1b 03 mov    0x31b72be(%rip),%rcx        # 0x31b72fa
  3c: 48                    rex.W
  3d: c7                    .byte 0xc7
  3e: c2                    .byte 0xc2
  3f: 16                    (bad)
