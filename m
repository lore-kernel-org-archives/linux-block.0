Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E9C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 02:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4926108E
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 02:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhIMCv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhIMCvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 22:51:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9277AC061574;
        Sun, 12 Sep 2021 19:50:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f65so7436183pfb.10;
        Sun, 12 Sep 2021 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SJy6j8xHJf2UWlDGKr4t0U01qfCqbFHlSGdSCMVDUaA=;
        b=e8RtgZYL/h/VeYDitlbzBgPtSuJRmI/4Ze+6DW9J/azYE9l7RhDT9pBHCaUkKNCJzs
         PspgZIg10DBmDnamC/WXmcdO5buq/WmZ4As09YUsn6sFfzapMZ1xLajox0gGAI9tNzsU
         5JFAlxNaJfuKt6jh10NOqhRQRO+IxWiPkibS+b/+ZH/Ed0ABQYdYAddpJogJZZIcmrHQ
         nRZJfSGvu4L4p4R6QmTwtI2DkbZtC1lp/38MAr7HED2Vgbf2jZWXR5boBAMtXGhF/Zpi
         ESC0/uBkO9+9Ry0GPFUVdXn9jkEjfCGvhMUEEqn48OLiObj30FHFGsyQzLf+N6nGaF0N
         JflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SJy6j8xHJf2UWlDGKr4t0U01qfCqbFHlSGdSCMVDUaA=;
        b=PC4ThP5mnzLQFWSJuM82ndyGiRmFRfB+XYYeyxtVDel9tKQIPi0mmsR9PTrLeg5ejF
         FiESQemv3YqjqtuHwKKBJxJG7ITIF02WhcgqASPQnjv5TCzTzNVyqBhdHE+rLGxla+7r
         zQLMc7yQ5fwuh1neXkm38jipJZsfdHlxRQFMMWPgn9gnAkoNkMaR6eH9OTLyyCNJpxHm
         ZgRcWlvwQtoZOkyG0ed0L5wxpay6SMl1f5XWJiJho+Md+lj4mRcAEiDDCCLUAfQG1K/Y
         23WE6CR/z+bMUrUkGrdRCyFmA9ML30V7K8UxKrF0qB/231ZUTzlhvqY+8PvqCoIfh5T+
         Bvvg==
X-Gm-Message-State: AOAM531c/mCKUh0iwJohxhOyz/Y6fKVQQH0ix96W2ciFpfSDWAcZ6TDW
        aFrJrqwYTb73dcGiG7bWvCwUsW3a58SC0yCRyR2fd+0h5a5n
X-Google-Smtp-Source: ABdhPJxK6LeoLmoTjR5chnRS8zZhOYbRI2wwd6HSMCXly+/oXflD7LlP8Hu6bXEgSkYE5TsP+HiQPk0IIBipVfznxv4=
X-Received: by 2002:a65:6389:: with SMTP id h9mr9161683pgv.83.1631501408784;
 Sun, 12 Sep 2021 19:50:08 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 10:49:57 +0800
Message-ID: <CACkBjsa-Ng+ayABMe_L6=Jf-L3LuF7ohXraf0i5R-67sLhwh2g@mail.gmail.com>
Subject: WARNING in schedule_bh
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     efremov@linux.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4b93c544e90e-thunderbolt: test: split up test cases
git tree: upstream
console output:
https://drive.google.com/file/d/1hPcef9aADlFdNS6_ujlRpU-HoebC2uXF/view?usp=sharing
kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6kfg-p/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1zvo1s72quEdpM5xQ7zQxU8oOLiZpoFTN/view?usp=sharing
Similar report:
[1] https://groups.google.com/g/syzkaller-bugs/c/B8I1zHVqoxk/m/8PlQrZRbAwAJ
[2] https://groups.google.com/g/syzkaller-bugs/c/NLim2pbuazk/m/xd3MD-Q-BQAJ

Sorry, I don't have a C reproducer for this crash but have a Syzlang
reproducer. Also, hope the symbolized report can help.
Here are the instructions on how to execute Syzlang prog:
https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 3 PID: 8715 at drivers/block/floppy.c:999
schedule_bh+0x5f/0x70 drivers/block/floppy.c:999
Modules linked in:
CPU: 3 PID: 8715 Comm: kworker/u8:2 Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:schedule_bh+0x5f/0x70 drivers/block/floppy.c:999
Code: 27 67 ff fc 48 89 2d 40 d9 db 0b 5b 48 c7 c2 40 69 48 8c 48 8b
35 11 de db 0b bf 08 00 00 00 5d e9 56 d5 d4 fc e8 01 67 ff fc <0f> 0b
eb d1 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 e8 eb 66 ff fc
RSP: 0018:ffffc900008a0dc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88801badd580
RDX: 0000000000000000 RSI: ffff88801badd580 RDI: 0000000000000002
RBP: ffffffff8476e0d0 R08: ffffffff8476b93f R09: 0000000000000000
R10: 0000000000000007 R11: fffffbfff1890d28 R12: 0000000000000001
R13: ffffffff8476e0d0 R14: 0000000000000000 R15: ffff888010c75000
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000048b8e0 CR3: 000000002ee93000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 floppy_interrupt+0x228/0x340 drivers/block/floppy.c:1765
 floppy_hardint+0x256/0x320 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0xfd/0x900 kernel/irq/handle.c:156
 handle_irq_event_percpu+0x76/0x160 kernel/irq/handle.c:196
 handle_irq_event+0xa1/0x130 kernel/irq/handle.c:213
 handle_edge_irq+0x24a/0x8a0 kernel/irq/chip.c:822
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
 common_interrupt+0x9f/0xd0 arch/x86/kernel/irq.c:240
 </IRQ>
 asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
RIP: 0010:slow_down_io arch/x86/include/asm/paravirt.h:55 [inline]
RIP: 0010:outb_p arch/x86/include/asm/io.h:334 [inline]
RIP: 0010:fdc_outb drivers/block/floppy.c:602 [inline]
RIP: 0010:reset_fdc+0x328/0x8a0 drivers/block/floppy.c:1817
Code: ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 0f
85 e8 04 00 00 48 8d 14 9b 48 8b 14 d5 d0 97 52 90 83 c2 04 ee <48> c7
c3 e0 47 7f 8b 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1
RSP: 0018:ffffc90001d0fcf8 EFLAGS: 00000202
RAX: 00000000ffffff83 RBX: 0000000000000000 RCX: 1ffffffff20a52fa
RDX: 00000000000003f4 RSI: ffff88801badd580 RDI: ffffffff905297d0
RBP: 0000000000000062 R08: ffffffff8476f60f R09: 0000000000000044
R10: 0000000000000001 R11: fffffbfff1fa0127 R12: 0000000000000001
R13: 0000000000000000 R14: dffffc0000000000 R15: 000000000000fffd
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess):
   0: ba 00 00 00 00        mov    $0x0,%edx
   5: 00 fc                add    %bh,%ah
   7: ff                    (bad)
   8: df 48 89              fisttps -0x77(%rax)
   b: f9                    stc
   c: 48 c1 e9 03          shr    $0x3,%rcx
  10: 80 3c 11 00          cmpb   $0x0,(%rcx,%rdx,1)
  14: 0f 85 e8 04 00 00    jne    0x502
  1a: 48 8d 14 9b          lea    (%rbx,%rbx,4),%rdx
  1e: 48 8b 14 d5 d0 97 52 mov    -0x6fad6830(,%rdx,8),%rdx
  25: 90
  26: 83 c2 04              add    $0x4,%edx
  29: ee                    out    %al,(%dx)
* 2a: 48 c7 c3 e0 47 7f 8b mov    $0xffffffff8b7f47e0,%rbx <--
trapping instruction
  31: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  38: fc ff df
  3b: 48 89 da              mov    %rbx,%rdx
  3e: 48                    rex.W
  3f: c1                    .byte 0xc1
