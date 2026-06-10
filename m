Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7C385D8C
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075144; cv=pass; b=FE1rXZ3TB82dR/G+IqR9/X49vJ5zOkd8Nrzqk9zEwwncbU+SeXPqfgnysUvxsKUPfs0k008FJoel8ZU7M7n8RHM7or9MLbxgX3mIGkHENrtgs4Dg7WX6uYfRbMqhUU9YGGl49DqLCjHrDudFP3K7a8Gz6frbGWWKwDzGWRNKurA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075144; c=relaxed/simple;
	bh=0JuASJVyuF2HOcSFqqgli9sYFccM2q1b7bwBl1NMwjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ00YDfBxBGI4p6G/HCJNt6HI5BBzPI/6XdnWCLpppSfl/JAwiloxrqc3W0Bmt9xdmMBdfR+rTHxwK+bj4fuyqZ8QN5OXOEqkadltz20m8/BhKGNBcU1juq2azKv/00kcLKRrQxCTmkVLqSiTy9nVyJMblkxdRDqzOZxo6qI1Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODk8t5Bz; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODk8t5Bz"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5177b1a7441so90194461cf.3
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 00:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781075142; cv=none;
        d=google.com; s=arc-20240605;
        b=C8eLHoKgw/8GtbWFnhnSGtgpZVqCJbNZRZPITXExccX45EnXMDevdQTmIylYI1Uz8a
         soQoeyV78XZp4JgjCPBFyjV19Nj365rfLG+0Yh9WyD56byTBK9+3Wb9PdckVcHoB5zce
         oLvZOzzIhoYC/bBrlXlqsDOJyy3zEFlALacw4Udpb9l/mgDqmi5KgBTvSr676GhDCaB6
         r5J53V10vInPPqQPb8mq+W+vqIaX9fvn8VgM/pG8CQOpMnDAMx02sV8yMNbwRywhZiLG
         3SICpvBbGVrzKkqQEMvfO77YCSh4nOsiVDot0lZx54YhIA18CUkCw076SuvsNqzankNV
         lTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSVOpgTqd22pPIAGtURTDILzXDQyNoaWUqZBW0f1Z/Q=;
        fh=H4O4hGbckv4nHi+s16ub3cRuFgJUVtPukJxxyrMvPKE=;
        b=PrNX7uI/qbzMJ/OMFVfI2HIUOkzD4zVBEEu7NscbqknR2c71CG99YcADGYmTDJaq9H
         zUHYeJWRD6KbwQ6OLAwjRqS0GuNnHgmEB0w1Xsh2ZXCw8xLdTr6q3k0Zajl22t/Z9JSI
         ALkDN02Y7qys+RRXxfz69FyleY3gqU8m4dD00tya4GZVaq6/UZjM71XcJ7Mjfs2+69Iz
         GCTNMAveb/3V6zNIKfVazJbSjxQJwfi4ePDYcq6lNFb5wh+rJoP0i75zydVgrh+1EpZg
         F349nwUOQU7VrScY6tkrkm8Bo9OD9kk8Kp4fATgUPnwSjNgHbSAQ8T59yLtZ9TWQXCc/
         KgQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075142; x=1781679942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSVOpgTqd22pPIAGtURTDILzXDQyNoaWUqZBW0f1Z/Q=;
        b=ODk8t5BzF6s2kX+2xL/DX0FlCqfSLUr9LlhYqP2s4I/sReLjP/v52ehdPMx5DaDSHn
         MFqf7I5g/bAImKoYnMi3qKUKpu6HP21T67x287Xo7J7h1S0ujgr1yZ3KuW1B3eTaDOhI
         BiyUAM2myxAhqpbozSzntAMUqlxD0Npv2cU9Omkqde1myHjRFpKwG9UjNzLDGP7reV8e
         aUrw9SVmKmm+KEJHYEP1UuAiC9JSeHE3CX14Xq+qp22HcYTz95X07+cHervDWybHTHIp
         w4QChhxDiP2jem39GP1BDEhmvFzr7yOQS+om4wsa0yaOocb7tL0KTq3SDKPH0C8p6XuY
         1Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075142; x=1781679942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSVOpgTqd22pPIAGtURTDILzXDQyNoaWUqZBW0f1Z/Q=;
        b=CGvA07gP6NL4N1kU/Z3L3B+JFY0wrTluME8Zs6FPFRspSHbism09Xj8WSqcfS5316C
         KTDSFPBibgoCAOJ7+eq0eWjhOoIEgUWaojFpPfnG5vXFQRWN1mc6L820lsVdarH3rcAk
         7HAV2sjG2ydf9i7wC5JK9wIm6+lL88cfkI6A2g0DMBGn+taFNHstgPyANlAfpUWf1fKA
         sy+zgY+Iug7cRzKhZxoO2nXN9XHPLuWDmHr8LyV/5jVHvm1ad+rVFear0Ih/lwdzYnnq
         +ddcdZqZgDByKnCF65VYGxsFEoRzVatmoy9DCpWbVArWocnRfByD9/1n3XXiacFpnqR7
         6XYA==
X-Forwarded-Encrypted: i=1; AFNElJ9sCFoKOEWSZQ48m56mK/9kETNj4VXeiZ5bRNX6x27/SBglEv3fcay+krVFrzSf2i61G5n9J4y43iy17Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNc2MPY+mPMQ8ArztRK/rZfzWame7Z9r1K30esP6oQrj5ojGo
	+4zCIEavFg3p9IFkncQqV4OhlNQW4yGl9JT7W6OfrtFqPoCB402bzDzEMJx6yx9VEbA4f9RDvol
	9khoY2gGq9CZkK7RzIgPm/mdxfzwZHTQ+ulwo3FQG5w==
X-Gm-Gg: Acq92OGLyiU289Lmbn+Pgm228Fj1/P+VPzwgLhIs6boSDCZoQmTTx4zyFJrU5r5p917
	ZSa5mzBJF5Hh835h1F/1nZ4AgZIpjTXvR+tk2fTefEL0t8FrnhoRi+M5h36hGVL6G1H6oz7KNO6
	aTTQ2wDCZU9wc9qHj7S+7gbwTMrLTEua38ZJ6q53IaMCCqdoOUQdaO9u7jfblg3UuthSTs1531f
	U9Ols1D7MGD5N93LjIqhKGkZgsVvqnCCMLayL/YVYzGqPTuj0VYpmFTkbUQXXmV3FpMZYpMyEJP
	XvMf2C8hGaMsy4NXA4NU
X-Received: by 2002:a05:622a:4d86:b0:517:6afc:b644 with SMTP id
 d75a77b69052e-51795cb31bamr374261191cf.47.1781075141517; Wed, 10 Jun 2026
 00:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmzE6bcNb3T+nJavn-mg=w2B0F1YCv47qv-Tsbn4xOrGmw@mail.gmail.com>
 <8b2f0830-23cf-4f6f-89a4-1390cb0f2e88@kernel.dk>
In-Reply-To: <8b2f0830-23cf-4f6f-89a4-1390cb0f2e88@kernel.dk>
From: Longxing Li <coregee2000@gmail.com>
Date: Wed, 10 Jun 2026 15:05:31 +0800
X-Gm-Features: AVVi8Cce6xpN420yU7tvPbD8MmUOTDR9TopspeE2m-FCyjTzCe4wuKFchoFoCfo
Message-ID: <CAHPqNmy+faz0=hweWGH=VX9UA9HLrueedwStxvAFinrnSuPLYQ@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: rcu detected stall in disk_check_events
To: Jens Axboe <axboe@kernel.dk>
Cc: syzkaller@googlegroups.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sorry for not containing the report text in last email. the report is
as follows:

hrtimer: interrupt took 4316899 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: Tasks blocked on level-0 rcu_node (CPUs 0-0): P10/1:b..l
rcu: (detected by 0, t=3D13059 jiffies, g=3D30961, q=3D723 ncpus=3D1)
task:kworker/0:1     state:R  running task     stack:21112 pid:10
tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_freezable_pwr_efficient disk_events_workfn
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7238
 irqentry_exit+0x1e4/0x740 kernel/entry/common.c:239
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
697
RIP: 0010:sbitmap_get+0x0/0x370 lib/sbitmap.c:282
Code: fd eb a0 48 89 ef e8 6f 19 43 fd eb db 48 89 ef e8 75 18 43 fd
eb b1 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f
1e fa 41 57 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 18 e8
RSP: 0018:ffffc900001bf538 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff84924c1d
RDX: ffff88801da925c0 RSI: ffffffff86168ec8 RDI: ffff888024fea030
RBP: ffff888024fea000 R08: ffff88801dba68d8 R09: ffffed1004a0150a
R10: 0000000000000001 R11: 00000000000003f1 R12: ffff88802500a800
R13: ffff888020e95348 R14: ffff888024fea030 R15: ffff888024fea040
 scsi_dev_queue_ready drivers/scsi/scsi_lib.c:1376 [inline]
 scsi_mq_get_budget+0x74/0x4d0 drivers/scsi/scsi_lib.c:1787
 blk_mq_get_dispatch_budget block/blk-mq.h:274 [inline]
 blk_mq_prep_dispatch_rq block/blk-mq.c:2052 [inline]
 blk_mq_dispatch_rq_list+0x1dc/0x1bc0 block/blk-mq.c:2139
 __blk_mq_sched_dispatch_requests+0x215/0x1470 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xd7/0x1b0 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x3da/0x650 block/blk-mq.c:2386
 blk_execute_rq+0x194/0x410 block/blk-mq.c:1523
 scsi_execute_cmd+0x42e/0xeb0 drivers/scsi/scsi_lib.c:332
 sr_get_events drivers/scsi/sr.c:177 [inline]
 sr_check_events+0x1b3/0xad0 drivers/scsi/sr.c:218
 cdrom_update_events drivers/cdrom/cdrom.c:1464 [inline]
 cdrom_check_events+0x68/0x110 drivers/cdrom/cdrom.c:1474
 sr_block_check_events+0xc3/0x100 drivers/scsi/sr.c:573
 disk_check_events+0xc7/0x420 block/disk-events.c:193
 process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
 process_scheduled_works kernel/workqueue.c:3371 [inline]
 worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 13059 jiffies! g30961 f0x0
RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26712 pid:16
tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7008
 schedule_timeout+0x113/0x280 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x18c/0x7e0 kernel/rcu/tree.c:2095
 rcu_gp_kthread+0x1aa/0x260 kernel/rcu/tree.c:2297
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 9798 Comm: syz-executor.6 Not tainted 7.0.6 #1 PREEMPT(f=
ull)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:228 [inline]
RIP: 0010:unwind_next_frame+0x1f9/0x20c0 arch/x86/kernel/unwind_orc.c:510
Code: 41 89 c2 39 d0 0f 83 0d 16 00 00 48 ba 00 00 00 00 00 fc ff df
89 c1 48 8d 3c 8d 70 fb 0f 92 48 89 fe 48 c1 ee 03 0f b6 34 16 <48> 89
fa 83 e2 07 83 c2 03 40 38 f2 7c 31 40 84 f6 74 2c 48 89 4c
RSP: 0018:ffffc900000072d0 EFLAGS: 00000a06
RAX: 0000000000011bf6 RBX: 0000000000000002 RCX: 0000000000011bf6
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff92146b48
RBP: ffffc90000007388 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000011bf6 R11: 00000000000a7f57 R12: ffffc90000007390
R13: ffffc90000007340 R14: ffffc90000007375 R15: ffffffff821bf607
FS:  00000000281a7480(0000) GS:ffff888097781000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000031883988 CR3: 000000004ec61000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 arch_stack_walk+0x86/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 save_stack+0x151/0x1e0 mm/page_owner.c:165
 __set_page_owner+0x8f/0x570 mm/page_owner.c:341
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x134/0x160 mm/page_alloc.c:1897
 prep_new_page mm/page_alloc.c:1905 [inline]
 get_page_from_freelist+0xde8/0x2ae0 mm/page_alloc.c:3970
 __alloc_pages_slowpath mm/page_alloc.c:4813 [inline]
 __alloc_frozen_pages_noprof+0x653/0x27e0 mm/page_alloc.c:5271
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3481 [inline]
 new_slab+0xa6/0x6b0 mm/slub.c:3539
 refill_objects+0x256/0x3f0 mm/slub.c:7179
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1b1/0x690 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_node_noprof+0x4d7/0x6e0 mm/slub.c:4918
 __alloc_skb+0x14c/0x740 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 ndisc_alloc_skb+0xd7/0x530 net/ipv6/ndisc.c:420
 ndisc_send_rs+0x70/0x690 net/ipv6/ndisc.c:706
 addrconf_rs_timer+0x3ee/0x860 net/ipv6/addrconf.c:4041
 call_timer_fn+0x1a5/0x670 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x6d2/0xb20 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0xc5/0x120 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2404
 handle_softirqs+0x1d3/0x9b0 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:395 [inline]
 crypto_acomp_unlock_stream_bh include/crypto/internal/acompress.h:201 [inl=
ine]
 scomp_acomp_comp_decomp+0x574/0xd50 crypto/scompress.c:257
 crypto_acomp_compress+0x14c/0x540 crypto/acompress.c:287
 zswap_compress mm/zswap.c:885 [inline]
 zswap_store_page mm/zswap.c:1422 [inline]
 zswap_store+0xa25/0x2710 mm/zswap.c:1533
 swap_writeout+0x3d8/0xd80 mm/page_io.c:275
 writeout mm/vmscan.c:652 [inline]
 pageout mm/vmscan.c:699 [inline]
 shrink_folio_list+0x3d4e/0x4b10 mm/vmscan.c:1425
 evict_folios+0x79a/0x1b20 mm/vmscan.c:4718
 try_to_shrink_lruvec+0x59a/0x9d0 mm/vmscan.c:4881
 shrink_one+0x309/0x690 mm/vmscan.c:4926
 shrink_many mm/vmscan.c:4989 [inline]
 lru_gen_shrink_node mm/vmscan.c:5067 [inline]
 shrink_node+0x24ee/0x3c90 mm/vmscan.c:6047
 shrink_zones mm/vmscan.c:6300 [inline]
 do_try_to_free_pages+0x373/0x1830 mm/vmscan.c:6362
 try_to_free_pages+0x24e/0x6a0 mm/vmscan.c:6601
 __perform_reclaim mm/page_alloc.c:4432 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4454 [inline]
 __alloc_pages_slowpath mm/page_alloc.c:4854 [inline]
 __alloc_frozen_pages_noprof+0x8e0/0x27e0 mm/page_alloc.c:5271
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3489 [inline]
 new_slab+0x264/0x6b0 mm/slub.c:3539
 refill_objects+0x256/0x3f0 mm/slub.c:7179
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1b1/0x690 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_noprof+0x68b/0x850 mm/slub.c:5272
 kmalloc_noprof include/linux/slab.h:954 [inline]
 tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x298/0x3a0 security/tomoyo/file.c:776
 tomoyo_file_open+0x69/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x88/0x200 security/security.c:2739
 do_dentry_open+0x576/0x1680 fs/open.c:926
 vfs_open+0x82/0x3f0 fs/open.c:1081
 do_open fs/namei.c:4677 [inline]
 path_openat+0x1fc5/0x2cf0 fs/namei.c:4836
 do_file_open+0x216/0x470 fs/namei.c:4865
 do_sys_openat2+0xe6/0x250 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x470aa4
Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 16 db 02 00 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 58 db 02 00 8b 44
RSP: 002b:00007ffd1fccdce0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffd1fccddd0 RCX: 0000000000470aa4
RDX: 0000000000000002 RSI: 00007ffd1fccde10 RDI: 00000000ffffff9c
RBP: 00007ffd1fccde10 R08: 0000000000000000 R09: 00007ffd1fccdbf0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 000000000002c3ab R14: 000000000002c398 R15: 0000000000000005
 </TASK>

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2026=E5=B9=B46=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=8C 20:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/9/26 5:52 AM, Longxing Li wrote:
> > Dear Linux kernel developers and maintainers,
> >
> > We would like to report a new kernel bug found by our tool. INFO: rcu
> > detected stall in disk_check_events. Details are as follows.
> >
> > Kernel commit: v7.0.6
> > Kernel config: see attachment
> > report: see attachment
> >
> > We are currently analyzing the root cause and  working on a
> > reproducible PoC. We will provide further updates in this thread as
> > soon as we have more information.
>
> Please include pertinent information in the email rather than some
> shared drive somewhere.
>
> --
> Jens Axboe
>
