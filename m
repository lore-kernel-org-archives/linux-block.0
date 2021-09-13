Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C840C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 02:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E02860FDA
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 02:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhIMCBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 22:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbhIMCBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 22:01:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F52C061574;
        Sun, 12 Sep 2021 19:00:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n18so7921815pgm.12;
        Sun, 12 Sep 2021 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4ccl1k3P07W6L8aj5e7gEo7XqRtL2P1zxmjc/ch+QoM=;
        b=gGTBQf0LKZkTNDGJ1X8RSzlwdgcJgTaqw/FfiNRO40j5GKEnUkdcG+t8rEr1k7u6th
         TKwBIi4WgdXGW/NcR9tCMAUE8uTkjEA5/ZZl9y6pqmRqGdnN+VdnhIhEnhbJ4tT7fRVE
         RFKMnb4obIF7xygdQl0LPxVQ5dXQGYAJ83zAXoxDwWm0ng1pbjeb4KA1dZzyHea0Jt8T
         qslO98fwOns7/hLK0/IWw7ocSUTFbPIXPBuY0jVawZmtdDqgzR25704SjmwTWAceTIyB
         TqNLJ5OUfMHs7QyC4ikiS+jCr9WNl3t30FOH+10aPOB6mlQVylnv7CikY8XFxMr1g/eP
         b9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ccl1k3P07W6L8aj5e7gEo7XqRtL2P1zxmjc/ch+QoM=;
        b=V4ApynQbRQY9ANWTQ2oMEI9shhsMWtBvq2cVFT7bdlbR9rbO+LjEBkZ1zYaIXjbkOK
         w+ULbcs7D+VlxvmrddXPjR/RBEgq4kQ3kR1pMA+LP00Pi2v+qGnxw5nbz+Es+bbyrKAn
         7rfYsbeXf4Y9bxxR/FuqGYUfu4BVFTIonSjkBI/CAyy9FVnLdLtq9wmM7p4LdxsYBSG8
         vM7FgWRVf+mVJKF8TLDk5SqBZlZ9dqckz5Xa1nT8ny90oFFBGY+hyH4WVeIU5MLzl3JF
         Cref29hFEei7iZoa38RZWQpvhpma4nf4RzrM9zZvkCYh4QjXOW70zxe7Q4qR4lSaFS9a
         QFxQ==
X-Gm-Message-State: AOAM530M9Ke0WFTnV/G/41HVIdEYm9OJRDffBHATaouVRUcW3qAhIJDj
        wDY4aK4oRJKjBxv1CpWksTjuXCk64dE4CNDBOpHqTjttZD1v
X-Google-Smtp-Source: ABdhPJxfZW1oYcujWGh47uuvif+f2/JCEvYR/9W+YguXcdU8FfW19mVOOAVWdX1t7UpkdiEWbr+ZJu7aRg3CEAfBROI=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr5043478pfj.43.1631498438002; Sun, 12 Sep
 2021 19:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 10:00:27 +0800
Message-ID: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
Subject: general protection fault in wb_timer_fn
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit:  4b93c544e90e-thunderbolt: test: split up test cases
git tree: upstream
console output:
https://drive.google.com/file/d/1naN-5p-rFgKpHrshO_kQr5f_KlhvFGGU/view?usp=sharing
kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6kfg-p/view?usp=sharing
C reproducer: https://drive.google.com/file/d/19EDhssGw_V1oO2vWOPrgQqve0TdFSgvh/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/13EGCCoaMe9oitrQCfy44BkGVLbKKFP6X/view?usp=sharing
Similar report:
https://groups.google.com/g/syzkaller-bugs/c/H7fKH_5GVSE/m/-1aj5-d1BAAJ

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

general protection fault, probably for non-canonical address
0xdffffc0000000029: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
CPU: 2 PID: 8539 Comm: syz-executor Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:latency_exceeded block/blk-wbt.c:237 [inline]
RIP: 0010:wb_timer_fn+0x149/0x2080 block/blk-wbt.c:360
Code: 03 80 3c 02 00 0f 85 08 1c 00 00 48 8b 9b b0 00 00 00 48 b8 00
00 00 00 00 fc ff df 48 8d bb 48 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 d5 1b 00 00 48 8b 83 48 01 00 00 48 8d 7d 28 48
RSP: 0018:ffffc90000848cd0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888014e79c80
RDX: 0000000000000029 RSI: ffff888014e79c80 RDI: 0000000000000148
RBP: ffff88801e2adc00 R08: ffffffff83de2dfd R09: 0000000000000003
R10: 0000000000000005 R11: ffffed1003c55bb0 R12: 0000000000000003
R13: 0000000000000000 R14: ffff8881053bc800 R15: ffff88801e2adcd0
FS:  0000000003176940(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000014d53ad CR3: 000000002e5ff000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x6b0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:write_comp_data+0xe/0x70 kernel/kcov.c:217
Code: 00 8b 89 1c 15 00 00 48 8b 02 48 83 c0 01 48 39 c1 76 07 4c 89
04 c2 48 89 02 c3 90 49 89 fa bf 03 00 00 00 49 89 f1 49 89 d0 <65> 48
8b 34 25 40 f0 01 00 e8 34 ff ff ff 84 c0 74 44 48 8b 86 20
RSP: 0018:ffffc9000106f7f8 EFLAGS: 00000246
RAX: 000000000d0444bb RBX: 80000000fd589217 RCX: ffffffff81ac95bd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: ffffed100247709c R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff88802e806788
 copy_present_pte mm/memory.c:976 [inline]
 copy_pte_range mm/memory.c:1070 [inline]
 copy_pmd_range mm/memory.c:1156 [inline]
 copy_pud_range mm/memory.c:1193 [inline]
 copy_p4d_range mm/memory.c:1217 [inline]
 copy_page_range+0xf4d/0x4750 mm/memory.c:1290
 dup_mmap kernel/fork.c:610 [inline]
 dup_mm+0xa50/0x13d0 kernel/fork.c:1454
 copy_mm kernel/fork.c:1506 [inline]
 copy_process+0x6c23/0x73d0 kernel/fork.c:2195
 kernel_clone+0xe7/0x10d0 kernel/fork.c:2585
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2702
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x471f0f
Code: ed 0f 85 64 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d
91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d
00 f0 ff ff 0f 87 f5 00 00 00 41 89 c5 85 c0 0f 85 fc 00 00
RSP: 002b:00007ffc62d06000 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000471f0f
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000003176940
R10: 0000000003176c10 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000005 R14: 00007ffc62d060b0 R15: 00007ffc62d0606c
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace ef2331b2238dd17a ]---
RIP: 0010:latency_exceeded block/blk-wbt.c:237 [inline]
RIP: 0010:wb_timer_fn+0x149/0x2080 block/blk-wbt.c:360
Code: 03 80 3c 02 00 0f 85 08 1c 00 00 48 8b 9b b0 00 00 00 48 b8 00
00 00 00 00 fc ff df 48 8d bb 48 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 d5 1b 00 00 48 8b 83 48 01 00 00 48 8d 7d 28 48
RSP: 0018:ffffc90000848cd0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888014e79c80
RDX: 0000000000000029 RSI: ffff888014e79c80 RDI: 0000000000000148
RBP: ffff88801e2adc00 R08: ffffffff83de2dfd R09: 0000000000000003
R10: 0000000000000005 R11: ffffed1003c55bb0 R12: 0000000000000003
R13: 0000000000000000 R14: ffff8881053bc800 R15: ffff88801e2adcd0
FS:  0000000003176940(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000014d53ad CR3: 000000002e5ff000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0: 03 80 3c 02 00 0f    add    0xf00023c(%rax),%eax
   6: 85 08                test   %ecx,(%rax)
   8: 1c 00                sbb    $0x0,%al
   a: 00 48 8b              add    %cl,-0x75(%rax)
   d: 9b                    fwait
   e: b0 00                mov    $0x0,%al
  10: 00 00                add    %al,(%rax)
  12: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  19: fc ff df
  1c: 48 8d bb 48 01 00 00 lea    0x148(%rbx),%rdi
  23: 48 89 fa              mov    %rdi,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 0f 85 d5 1b 00 00    jne    0x1c09
  34: 48 8b 83 48 01 00 00 mov    0x148(%rbx),%rax
  3b: 48 8d 7d 28          lea    0x28(%rbp),%rdi
  3f: 48                    rex.W%
