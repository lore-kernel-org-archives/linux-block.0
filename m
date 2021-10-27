Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52320C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F53461090
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhJ0BjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhJ0BjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB954C061570;
        Tue, 26 Oct 2021 18:36:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om14so819192pjb.5;
        Tue, 26 Oct 2021 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2IHNA2fXYADlXjRPovEvAoEBKPPVrmHJ+49kPrQUUx8=;
        b=anh7nkq/rB4GJmVgoZIrzaWeld/r6WvQGJJdmKqeioG0hqJAKO01NRWZEjms30q7fH
         zyGk/6HTxDd+JptB/hLnKP48yLs1LHUhJX8e1A7/hg+VYxEqEzCybi6C2Fx04dDHgTCz
         Dv6lKCpnmNlebfDv7Oqv5mjHKJys3ne55IhDgS3E8p1L7HPMUpjl1i3oXVCZXiXZH2TK
         Zb+kXYrpEMTgecmmnn8rzOR8hUkV8Ycuy2goYeprHwyr+3s7LSdslX+Phsh7DtunADWg
         r9OV8/Nh6ol8klqecPh7N1WksiPkvtqskwmRAg49Tpecw+2akUXB2gSH8UJJe4t47kWh
         rWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2IHNA2fXYADlXjRPovEvAoEBKPPVrmHJ+49kPrQUUx8=;
        b=Wg24fA7vtPNHg757esxXqKwlrq8tz5tnIGUzuldDlOgev7x+2v/zn4LaDkea8k3Fds
         c4xqWroKcrObDJfZ2ezAdh2G+Ogm1140cwK590rEi6yRwoGwdomemVXncjRwt2LO79uJ
         L/82DPqh1AbJZ/d2QVLvR5z+KRid+3hX5n0H/Uc+vV0rq0w488n1QY6vzzQOQsiy0Ocb
         BoGrGL2VKjlsWtnHLvRRbwhopAPI6600zvNVSswf0GLFSIWE2bZJsImrHPiij88LxVbX
         YRnVaibhEXTMau0yf8TordVN92mhUBGB84F6V8UMTtQe1K2WK/Shx6pJFRurD0wzcMbD
         bAog==
X-Gm-Message-State: AOAM530MM8gl0RJXvbJqmPm9wQkSCeTp5LrhZTOFziDPk/pASDl4XQtC
        qZoq1yfiC6VCKTLe/JJsFigzL16GlWUJs5gZggC54xKypkE7VXec0g==
X-Google-Smtp-Source: ABdhPJz4d/y3JFLggkil9NvSLSDyNevf2mCsaDGNHos7ck/vbXXC58jf4jhfcHXff2s4GwRLH7BJSY1lftTKLLSgLv4=
X-Received: by 2002:a17:90a:6b0b:: with SMTP id v11mr2603478pjj.178.1635298600994;
 Tue, 26 Oct 2021 18:36:40 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:36:27 +0800
Message-ID: <CACkBjsZbCD-UfwDyggifu5DWugrYOhECbiqQu_MdquOqyz5iew@mail.gmail.com>
Subject: general protection fault in reset_interrupt
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        efremov@linux.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1bzxncErwj8l-KA-R-jLCUajYQMReiAWX/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1IOQR_MqiSkN8y0m3UjFZcP9l5QcBnCIv/view?usp=sharing

Sorry, I don't have a C reproducer for this crash, hope the Syzlang
reproducer and symbolized report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

floppy0: Unable to send byte 6f to FDC. Fdc=0 Status=d0

floppy driver state
-------------------
now=4295008404 last interrupt=4295008403 diff=1 last called
handler=reset_interrupt
timeout_message=floppy start
last output bytes:
10 90 4294978780
 7 80 4294978780
 0 90 4294978780
 8 80 4294978780
 f 80 4294978780
 0 90 4294978780
 1 90 4294978780
 8 80 4294978780
 4 80 4294978785
 0 90 4294978785
 f 80 4294978785
 0 90 4294978785
 8 80 4294978785
 0 90 4294978785
d8 80 4295008402
 8 80 4295008403
 8 80 4295008403
 8 80 4295008403
 8 80 4295008403
d8 80 4295008404
last result at 4295008403
last redo_fd_request at 4295008403
status=d0
fdc_busy=1
floppy_work.func=floppy_work_workfn
timer_function=ffffffff8476f5f0 expires=298
cont=ffffffff89fe0d80
current_req=0000000000000000
command_status=-1

general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 10 Comm: kworker/u8:1 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt+0xef/0x140 drivers/block/floppy.c:1792
Code: fc 84 db 0f 85 71 58 8e 04 e8 4d 4d ff fc 48 8b 1d 86 47 db 0b
48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c
02 00 75 40 48 8b 43 08 5b ff e0 e8 0f dd 46 fd eb a8 e8 08
RSP: 0018:ffffc900006d7d28 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880118d9c80
RDX: 0000000000000001 RSI: ffff8880118d9c80 RDI: 0000000000000008
RBP: ffffffff8c482f00 R08: ffffffff84771173 R09: 0000000000000000
R10: 0000000000000001 R11: fffffbfff1adb1ba R12: ffffc900006d7dc8
R13: ffffffff8c482f10 R14: ffff888011968000 R15: ffff888010c71800
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3397e36db8 CR3: 0000000020a83000 CR4: 0000000000350ee0
Call Trace:
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 24ebcf9665bb7032 ]---
RIP: 0010:reset_interrupt+0xef/0x140 drivers/block/floppy.c:1792
Code: fc 84 db 0f 85 71 58 8e 04 e8 4d 4d ff fc 48 8b 1d 86 47 db 0b
48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c
02 00 75 40 48 8b 43 08 5b ff e0 e8 0f dd 46 fd eb a8 e8 08
RSP: 0018:ffffc900006d7d28 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880118d9c80
RDX: 0000000000000001 RSI: ffff8880118d9c80 RDI: 0000000000000008
RBP: ffffffff8c482f00 R08: ffffffff84771173 R09: 0000000000000000
R10: 0000000000000001 R11: fffffbfff1adb1ba R12: ffffc900006d7dc8
R13: ffffffff8c482f10 R14: ffff888011968000 R15: ffff888010c71800
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000000 CR3: 00000000277d1000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0: fc                    cld
   1: 84 db                test   %bl,%bl
   3: 0f 85 71 58 8e 04    jne    0x48e587a
   9: e8 4d 4d ff fc        callq  0xfcff4d5b
   e: 48 8b 1d 86 47 db 0b mov    0xbdb4786(%rip),%rbx        # 0xbdb479b
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 48 8d 7b 08          lea    0x8(%rbx),%rdi
  23: 48 89 fa              mov    %rdi,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 75 40                jne    0x70
  30: 48 8b 43 08          mov    0x8(%rbx),%rax
  34: 5b                    pop    %rbx
  35: ff e0                jmpq   *%rax
  37: e8 0f dd 46 fd        callq  0xfd46dd4b
  3c: eb a8                jmp    0xffffffe6
  3e: e8                    .byte 0xe8
  3f: 08                    .byte 0x8
