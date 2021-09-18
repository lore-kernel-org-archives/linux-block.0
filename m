Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A83C433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 01:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073D961019
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 01:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhIRBga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Sep 2021 21:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIRBga (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 21:36:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B27C061574;
        Fri, 17 Sep 2021 18:35:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw14so8103128pjb.1;
        Fri, 17 Sep 2021 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PYMBYMhbn7LOSXJQ2Th6WiKk3P9QiN00hsFFk/xCucY=;
        b=g2POHH5P0ZK6Ttaq8PDX3VMFDTl+rgtX+4L6EN1k5s2pCQkX6UpEBLW7OEMsce9aKS
         929lwk8q78Jb4Orhts5xGuLBTolGD19vmYmFN0goDvLCxEPezhHa+qHy9B5SlKaXJeny
         IRQA6yuMa5tSdxyukuGJig/T9oJpCjLZyb49tdsvhv1EWkr3RVE50B6AHHX+avm5U2VP
         wdS/LIf4tLZcnfsWM1hdVdet71+6ETd8kP7kiUjPKgzxwzhpZKfbico3w+Nn4mKGTOB2
         EskqTw9IevTE+R8qDAYfJubVtml+mXb3Pkh08fpAvAUa8yBaaY52RstMne7vMHFNglDk
         gDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PYMBYMhbn7LOSXJQ2Th6WiKk3P9QiN00hsFFk/xCucY=;
        b=OjYgjqXFwaan0DXTYQqY79ZBaGlRQSJy5GQkX84VTkr13ZU4CjmY2WhrDBiNfysPN/
         NJCmIZ8A6rf1mK4lDrD9qY/T2e/dRyfRau1K9o0wQKJ/wfLSNy/vb6RYCUa7eeae8LqM
         Xm8Jke3/RVUHjGWYoEjrt+amdjwcEW6RFcgnAC3r/R+BS9HJiKolj5nesqkv1IrS6Vxn
         RrC6bPcPUM8VUuCuXhi4+/rIJetM+eqm4AZjr6BCYCAbDWqi8PMnkswSHizlTzHCVYq/
         9Eo8bhZmGuz21kk6V9PpOano30se8iN56r0SR55oPW4xoEwJAMWCWl39riMWiLAcFuwr
         Znxw==
X-Gm-Message-State: AOAM5335jZ/xQ/kArxhalkpqQ1JrKOTPWNrLY9zfVW1iaj1kcoL3FHJ5
        MFWXMz4Hj0SBP975rfkDtPyLV3aXLtVHxBQTpA==
X-Google-Smtp-Source: ABdhPJw/hZ//sPmc8cRBJ6wFwKBlOUrh2xxKtxq+ui4ovYuH7bN7IgcOycKiFwkfTKYBWHpG/Ae2lamQ/qiF/BxmSQI=
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr15588905pjb.112.1631928906892;
 Fri, 17 Sep 2021 18:35:06 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 18 Sep 2021 09:34:55 +0800
Message-ID: <CACkBjsZPDdnz-UgeQKrUrxxV9dT3j2MyE1jxXoiE2-Jd09sa2w@mail.gmail.com>
Subject: INFO: task hung in nbd_ioctl
To:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915
git tree: upstream
console output:
https://drive.google.com/file/d/1Htx96ZZ5dAxLIr-4jNJ62iQdstmHnliH/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zXpDhs-IdE7tX17B7MhaYP0VGUfP6m9B/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:25816 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27872 pid:25816 ppid: 24814 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fe430645c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000007
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0a0
R13: 00007ffcaa94abdf R14: 00007ffcaa94ad80 R15: 00007fe430645dc0
INFO: task syz-executor:25822 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:25822 ppid: 24814 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 blk_mq_freeze_queue_wait+0x114/0x160 block/blk-mq.c:151
 nbd_add_socket+0x102/0x7c0 drivers/block/nbd.c:1050
 __nbd_ioctl drivers/block/nbd.c:1405 [inline]
 nbd_ioctl+0x391/0x9c0 drivers/block/nbd.c:1462
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fe430603c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c210 RCX: 00000000004739cd
RDX: 0000000000000005 RSI: 000000000000ab00 RDI: 0000000000000004
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c210
R13: 00007ffcaa94abdf R14: 00007ffcaa94ad80 R15: 00007fe430603dc0
INFO: task syz-executor:25823 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27408 pid:25823 ppid: 24814 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 blk_queue_enter+0x956/0xdb0 block/blk-core.c:462
 bio_queue_enter block/blk-core.c:477 [inline]
 __submit_bio_noacct_mq block/blk-core.c:989 [inline]
 submit_bio_noacct+0xd32/0x1460 block/blk-core.c:1031
 submit_bio+0x10a/0x460 block/blk-core.c:1093
 submit_bio_wait+0x106/0x230 block/bio.c:1248
 blkdev_issue_flush+0xd7/0x120 block/blk-flush.c:458
 blkdev_fsync+0x8e/0xd0 block/fops.c:420
 vfs_fsync_range+0x13a/0x220 fs/sync.c:200
 vfs_fsync fs/sync.c:214 [inline]
 do_fsync+0x4d/0x90 fs/sync.c:224
 __do_sys_fsync fs/sync.c:232 [inline]
 __se_sys_fsync fs/sync.c:230 [inline]
 __x64_sys_fsync+0x2f/0x40 fs/sync.c:230
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000014c
RSP: 002b:00007fe4305e2bb8 EFLAGS: 00000213 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000014c
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000000000b9 R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000213 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007fe4305e2dc0

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8b97e9a0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/6298:
 #0: ffff88801c9d19f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:990
3 locks held by kworker/u8:2/6743:
1 lock held by syz-executor/25816:
 #0: ffff88801ae63208 (&nbd->config_lock){+.+.}-{3:3}, at:
nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
1 lock held by syz-executor/25822:
 #0: ffff88801ae63208 (&nbd->config_lock){+.+.}-{3:3}, at:
nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0
CPU: 0 PID: 3022 Comm: systemd-journal Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__orc_find+0x0/0xf0 arch/x86/kernel/unwind_orc.c:35
Code: 7f 8b e8 63 a6 c8 02 e9 60 fb ff ff e8 b9 96 8a 00 e9 cf fb ff
ff cc cc cc cc 48 8b 07 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 <41> 57
89 d0 41 56 41 55 41 54 4c 8d 64 87 fc 55 53 48 83 ec 10 85
RSP: 0018:ffffc9000121f980 EFLAGS: 00000212
RAX: 000000000002c858 RBX: 1ffff92000243f39 RCX: ffffffff81bdbadf
RDX: 000000000000000b RSI: ffffffff8df4036c RDI: ffffffff8d82b228
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8df4036c
R10: ffffc9000121fadf R11: 0000000000086088 R12: ffffc9000121fac8
R13: ffffc9000121fab5 R14: ffffc9000121fa80 R15: ffffffff81bdbadf
FS:  00007f13812868c0(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f137ce35000 CR3: 0000000018bf1000 CR4: 0000000000350ef0
Call Trace:
 orc_find arch/x86/kernel/unwind_orc.c:173 [inline]
 unwind_next_frame+0x33a/0x1770 arch/x86/kernel/unwind_orc.c:443
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0x100/0x140 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook mm/slub.c:1725 [inline]
 slab_free mm/slub.c:3483 [inline]
 kmem_cache_free+0xa0/0x670 mm/slub.c:3499
 putname+0xfe/0x140 fs/namei.c:270
 do_mkdirat+0x18a/0x2b0 fs/namei.c:3920
 __do_sys_mkdir fs/namei.c:3931 [inline]
 __se_sys_mkdir fs/namei.c:3929 [inline]
 __x64_sys_mkdir+0x61/0x80 fs/namei.c:3929
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1380542687
Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 09 d8 2b 00 64 c7 00
5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d e1 d7 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffcb3a1e5b8 EFLAGS: 00000293 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffcb3a214d0 RCX: 00007f1380542687
RDX: 00007f1380fb3a00 RSI: 00000000000001ed RDI: 00005567696f38a0
RBP: 00007ffcb3a1e5f0 R08: 000000000000c000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffcb3a214d0 R15: 00007ffcb3a1eae0
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 2
CPU: 2 PID: 6743 Comm: kworker/u8:2 Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4693 [inline]
RIP: 0010:__lock_acquire+0x4b6/0x57e0 kernel/locking/lockdep.c:4965
Code: 06 49 81 c7 40 fd cf 8f 45 84 e4 0f 84 f8 02 00 00 48 8d 7d 21
48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 04 01 <48> 89
f9 83 e1 07 38 c8 7f 08 84 c0 0f 85 62 33 00 00 44 0f b6 4d
RSP: 0018:ffffc9000308f8f0 EFLAGS: 00000012
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 1ffff11005adb152
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802d6d8a91
RBP: ffff88802d6d8a70 R08: 0000000000000001 R09: fffffbfff1f9ff25
R10: ffffffff8fcff927 R11: fffffbfff1f9ff24 R12: 0000000000000002
R13: ffff88802d6d8000 R14: ffffffff8b97e9a0 R15: ffffffff8fd00280
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002a6ac48 CR3: 000000000b68e000 CR4: 0000000000350ee0
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5590
 rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 inet_twsk_purge+0x117/0x7b0 net/ipv4/inet_timewait_sock.c:268
 ops_exit_list.isra.0+0x103/0x150 net/core/net_namespace.c:171
 cleanup_net+0x511/0xa90 net/core/net_namespace.c:591
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess):
   0: 7f 8b                jg     0xffffff8d
   2: e8 63 a6 c8 02        callq  0x2c8a66a
   7: e9 60 fb ff ff        jmpq   0xfffffb6c
   c: e8 b9 96 8a 00        callq  0x8a96ca
  11: e9 cf fb ff ff        jmpq   0xfffffbe5
  16: cc                    int3
  17: cc                    int3
  18: cc                    int3
  19: cc                    int3
  1a: 48 8b 07              mov    (%rdi),%rax
  1d: c3                    retq
  1e: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  25: 00 00 00 00
  29: 90                    nop
* 2a: 41 57                push   %r15 <-- trapping instruction
  2c: 89 d0                mov    %edx,%eax
  2e: 41 56                push   %r14
  30: 41 55                push   %r13
  32: 41 54                push   %r12
  34: 4c 8d 64 87 fc        lea    -0x4(%rdi,%rax,4),%r12
  39: 55                    push   %rbp
  3a: 53                    push   %rbx
  3b: 48 83 ec 10          sub    $0x10,%rsp
  3f: 85                    .byte 0x85
