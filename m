Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8863CCA478
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 10:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiFBKCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiFBKCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 06:02:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CD25E9
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 03:02:21 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id s15-20020a056e02216f00b002d3d5e41565so2803516ilv.10
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PlXyMH9yroMr86joJkDazD6M1cZkidX1eo+3QNu0Ks0=;
        b=zfclWILD7V4t/68emKuv+uGhJ9pBBsZkTOpNBAjVLa363Lrt3beOav7Utk9Q7J+44d
         u90b2NschuBDtNOFXCoqm3Gi0LLSe3JPwbEeU/iIaNt1nOuBxDLitVuM3F/LwaobDsDH
         /cnQbftVz9Q1avsmT65SCR5ARML7Txe73pvd3RfMO17RnH3kjWXblOwAYeEcmDN5BHEc
         fsPewkv8/PgzJXztr0VE/fe6cQVbUB6ZwV8w/CH4P2pIlEL3AmGeo3+1fKXXfrliQpC7
         vnCTEaNc4TlM2uofD8SoTry+h9jIqp6Hpoa3Sn5QEaWkFSLRBXSqJqvHplnS2kQ8t8mS
         8lsQ==
X-Gm-Message-State: AOAM530ZhjBTth1RCS8HA69tq67apcwyr0ObuDTY/tlt/Qj/j1vIi4au
        hIenla27K3E6mb0ANUkFFKZKHzjits+7kI37oUD3INETcqHz
X-Google-Smtp-Source: ABdhPJzqQ55gAWfuzGONGd07P+o5i1tRB1eL/ZTHM2UomwBl6hJUahKq1mY2x/7hMV7bcfDVutkx1vrRegtJpg7tHboJ8hR+5wdk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d14:b0:2d3:a75e:140b with SMTP id
 i20-20020a056e021d1400b002d3a75e140bmr2599005ila.61.1654164140868; Thu, 02
 Jun 2022 03:02:20 -0700 (PDT)
Date:   Thu, 02 Jun 2022 03:02:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000044cc505e0741a4b@google.com>
Subject: [syzbot] riscv/fixes boot error: BUG: soft lockup in corrupted
From:   syzbot <syzbot+1d1952c211a38ac43f10@syzkaller.appspotmail.com>
To:     aou@eecs.berkeley.edu, axboe@kernel.dk, justin@coraid.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg property..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14de11edf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa6b5702bdf14a17
dashboard link: https://syzkaller.appspot.com/bug?extid=1d1952c211a38ac43f10
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d1952c211a38ac43f10@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:1]
Modules linked in:
irq event stamp: 410297
hardirqs last  enabled at (410296): [<ffffffff8000ee74>] __trace_hardirqs_on+0x18/0x20 arch/riscv/kernel/trace_irq.c:19
hardirqs last disabled at (410297): [<ffffffff8000ee94>] __trace_hardirqs_off+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
softirqs last  enabled at (405886): [<ffffffff83207a08>] softirq_handle_end kernel/softirq.c:401 [inline]
softirqs last  enabled at (405886): [<ffffffff83207a08>] __do_softirq+0x618/0x8fc kernel/softirq.c:587
softirqs last disabled at (405891): [<ffffffff8006164a>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (405891): [<ffffffff8006164a>] invoke_softirq kernel/softirq.c:439 [inline]
softirqs last disabled at (405891): [<ffffffff8006164a>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:637
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc1-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
epc : arch_static_branch arch/riscv/include/asm/jump_label.h:20 [inline]
epc : kfence_alloc include/linux/kfence.h:120 [inline]
epc : slab_alloc_node mm/slub.c:3135 [inline]
epc : kmem_cache_alloc_node+0xa0/0x3c6 mm/slub.c:3267
 ra : slab_pre_alloc_hook mm/slab.h:724 [inline]
 ra : slab_alloc_node mm/slub.c:3131 [inline]
 ra : kmem_cache_alloc_node+0x66/0x3c6 mm/slub.c:3267
epc : ffffffff8047df56 ra : ffffffff8047df1c sp : ff200000002273b0
 gp : ffffffff85a76440 tp : ff60000007430000 t0 : 0000000000046000
 t1 : ffebffff014d10b7 t2 : ffffffff80668f62 s0 : ff20000000227450
 s1 : ff600000075a93c0 a0 : 0000000000000000 a1 : 0000000000000007
 a2 : 1ffffffff09c876c a3 : ffffffff80bec434 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ff6000000a6885bb
 s2 : 0000000000000a20 s3 : 0000000000000000 s4 : 0000000000000a20
 s5 : ffffffffffffffff s6 : ffffffff8271f756 s7 : ffffffff85a9c780
 s8 : 00000000000000e8 s9 : ffffffff85a7c2c0 s10: 00000000000000ff
 s11: ffffffffffffa288 t3 : fffffffff3f3f300 t4 : ffebffff014d10b7
 t5 : ffebffff014d10b8 t6 : ff6000001239fc00
status: 0000000000000120 badaddr: 0000000000000000 cause: 8000000000000005
[<ffffffff8271f756>] __alloc_skb+0x234/0x2e4 net/core/skbuff.c:414
[<ffffffff81a42954>] alloc_skb include/linux/skbuff.h:1300 [inline]
[<ffffffff81a42954>] new_skb+0x2c/0xcc drivers/block/aoe/aoecmd.c:66
[<ffffffff81a48ab2>] aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:425 [inline]
[<ffffffff81a48ab2>] aoecmd_cfg+0x1f6/0x5c6 drivers/block/aoe/aoecmd.c:1362
[<ffffffff81a4bdfc>] discover_timer+0x4a/0x54 drivers/block/aoe/aoemain.c:24
[<ffffffff8016c084>] call_timer_fn+0x164/0x694 kernel/time/timer.c:1421
[<ffffffff8016ca9a>] expire_timers kernel/time/timer.c:1466 [inline]
[<ffffffff8016ca9a>] __run_timers.part.0+0x4e6/0x76e kernel/time/timer.c:1734
[<ffffffff8016cda8>] __run_timers kernel/time/timer.c:1715 [inline]
[<ffffffff8016cda8>] run_timer_softirq+0x86/0x100 kernel/time/timer.c:1747
[<ffffffff83207664>] __do_softirq+0x274/0x8fc kernel/softirq.c:558
[<ffffffff8006164a>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
[<ffffffff8006164a>] invoke_softirq kernel/softirq.c:439 [inline]
[<ffffffff8006164a>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:637
[<ffffffff80061958>] irq_exit+0x10/0x7a kernel/softirq.c:661
[<ffffffff831f7c8e>] generic_handle_arch_irq+0x48/0x54 kernel/irq/handle.c:240
[<ffffffff800057b2>] ret_from_exception+0x0/0x10
[<ffffffff8047df1c>] slab_pre_alloc_hook mm/slab.h:724 [inline]
[<ffffffff8047df1c>] slab_alloc_node mm/slub.c:3131 [inline]
[<ffffffff8047df1c>] kmem_cache_alloc_node+0x66/0x3c6 mm/slub.c:3267


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
