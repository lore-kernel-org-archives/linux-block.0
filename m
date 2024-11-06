Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5641D61B5
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881395; cv=none; b=dCapRDWmfpwSx6odnuIKmQPTtTphkWww4ElMLRPE2upud150Q0g8kF3kFYI2pJ1ZIj1QECV1R5eDIdWPnMmXMIhlGk1RHnVVauT0zP1Uzsrs3jYMJGj6dIep+el/3vI/uF6PQpS4vOKYy29neHAcHQ+DPZbaNgCJ9bpPlnIHbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881395; c=relaxed/simple;
	bh=Ms1gyWNpLm201iGnKwOWxdy3BXU0f10F0iZjnR35paU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k8T1UDOGNUIL+FeNpYw7crIQtVx0lV189wrGQjqFxBZTXNwfv7G1Ovu8Xd6O0XBzYsxTDobTVR98AG2vyTaflcfG8++jgydG9za7m/I2jPKvHwmH7ul20PUPSL9aLFrlm55/gINhdr1fnVHmSqhXnnl3aTMNSnBVy+TotN4x728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHPpYidz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHPpYidz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730881392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pB55iKThaxHFJ/PAZ/jJAWfKijWOFYsba+8GbOcZlSE=;
	b=DHPpYidzf5zvCPW906nMiFt41LEa8ThpCpSmMx19Jo9AEDmDyE10pNCuxY1RKElT0E6aSG
	OYA1obnjnaQa2JdexjLINlqM9rKRyj9ptxsDt1lTXRpU8KAvujf1f3zeC48nFKBisYR29B
	l0qNvE7lBn/ZyxfGxnAFzcNARZLcAEw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-SVZBbKTvOVy-Uc0Fj8tSUg-1; Wed, 06 Nov 2024 03:23:10 -0500
X-MC-Unique: SVZBbKTvOVy-Uc0Fj8tSUg-1
X-Mimecast-MFC-AGG-ID: SVZBbKTvOVy-Uc0Fj8tSUg
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb4e2da8baso37317181fa.0
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 00:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881387; x=1731486187;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB55iKThaxHFJ/PAZ/jJAWfKijWOFYsba+8GbOcZlSE=;
        b=uKs/RnPoPht7WUmxf/m6/u6l6ENmaFszr0u/BGSK/jxzEFFdOAUnmXeSpgO8+7gzkY
         R/Qzr6rK+gRhsKtAyYGqid/9NLGqnMWf9W2bZ+u6OLeyyl57oR6E920MgBwTBcli2m6m
         GWVg0RSNYlSeionjTCGvVs/QmDoIoVDUTRL0ZOCWjTXm9ej71MAqFBr5gPVPBFw4resS
         9v7qJ2CtIN5WGL6g02fQhcBkJ32n8miqa2EwqK+/i69Mn0PyMGVoYYPzJtSZcFM/VJXB
         ZOgPykgQI6F1gEPB5Uw4Y6I1s78aNMxpOo62YCsfAJiYtCpxt7ljebNlAEFjj2AR/GnF
         U0zQ==
X-Gm-Message-State: AOJu0YzGq9OboNZ3uTqS+vXz03SP5/oJIwSv7kCt0jtafSaR3DYT1PSH
	O70v7+BTr1NfglaW51GqrJulgjEqbKO+crZ8DSI/e+YaX3jeXI57eVkIXaDWDRJkYumllBoXdOO
	81tm77SFB8lDfmQkpdFpcFJd03k7c6ufAAYwt4zLYbDwMA8do+3lE31tray87JcSkfxpHGX2wcA
	e0ieTnupDMUWxpc7g1mCyNZ9aLcjB1So9Lj0nlKT6IFiNZ1puu
X-Received: by 2002:a2e:be85:0:b0:2fb:5392:cfd0 with SMTP id 38308e7fff4ca-2fcbe005e38mr194395421fa.22.1730881386981;
        Wed, 06 Nov 2024 00:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBi4fDbnxmuxHn/4/0WafOhZ+Clo8FVewRAUHS/V9K3oexs69+yxRNS9s43lCdHTcYGHgkWd8Pglavz5ggS8E=
X-Received: by 2002:a2e:be85:0:b0:2fb:5392:cfd0 with SMTP id
 38308e7fff4ca-2fcbe005e38mr194395211fa.22.1730881386417; Wed, 06 Nov 2024
 00:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Nov 2024 16:22:54 +0800
Message-ID: <CAHj4cs-61uwDYDdMduh+UNp5er9x3=1snH6j78JGP7uWF2V5YA@mail.gmail.com>
Subject: [bug report] possible circular locking dependency detected with
 blktests block/002
To: linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello
I found this circular locking with blktests block/002 on the latest
linux-block/for-next, please help check it, thanks.

# ./check block/002
block/002 (remove a device while running blktrace)           [failed]
    runtime  7.680s  ...  6.431s
    something found in dmesg:
    [  428.095052] run blktests block/002 at 2024-11-06 03:17:20
    [  429.087377] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
    [  430.585186] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
    [  430.594304] scsi host15: scsi_debug: version 0191 [20210520]
                     dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
    [  430.606534] scsi 15:0:0:0: Direct-Access     Linux
scsi_debug       0191 PQ: 0 ANSI: 7
    [  430.614964] scsi 15:0:0:0: Power-on or device reset occurred
    [  430.630053] sd 15:0:0:0: Attached scsi generic sg1 type 0
    [  430.637952] sd 15:0:0:0: [sdb] 16384 512-byte logical blocks:
(8.39 MB/8.00 MiB)
    [  430.639447] sd 15:0:0:0: [sdb] Write Protect is off
    ...
    (See '/root/blktests/results/nodev/block/002.dmesg' for the entire message)

dmesg:
[  428.095052] run blktests block/002 at 2024-11-06 03:17:20
[  429.087377] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
[  430.585186] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  430.594304] scsi host15: scsi_debug: version 0191 [20210520]
                 dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[  430.606534] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  430.614964] scsi 15:0:0:0: Power-on or device reset occurred
[  430.630053] sd 15:0:0:0: Attached scsi generic sg1 type 0
[  430.637952] sd 15:0:0:0: [sdb] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[  430.639447] sd 15:0:0:0: [sdb] Write Protect is off
[  430.639541] sd 15:0:0:0: [sdb] Mode Sense: 73 00 10 08
[  430.642819] sd 15:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  430.653489] sd 15:0:0:0: [sdb] permanent stream count = 5
[  430.658069] sd 15:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[  430.658176] sd 15:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  430.745022] sd 15:0:0:0: [sdb] Attached SCSI disk

[  431.969279] ======================================================
[  431.975456] WARNING: possible circular locking dependency detected
[  431.981639] 6.12.0-rc5+ #3 Not tainted
[  431.985387] ------------------------------------------------------
[  431.991566] blktrace/2277 is trying to acquire lock:
[  431.996534] ffff88ae46450bb0 (&mm->mmap_lock){++++}-{3:3}, at:
__might_fault+0xbf/0x170
[  432.004548]
               but task is already holding lock:
[  432.010380] ffff88ada6814858 (&q->debugfs_mutex){+.+.}-{3:3}, at:
blk_trace_ioctl+0x8d/0x240
[  432.018822]
               which lock already depends on the new lock.

[  432.026995]
               the existing dependency chain (in reverse order) is:
[  432.034474]
               -> #3 (&q->debugfs_mutex){+.+.}-{3:3}:
[  432.040746]        __lock_acquire+0xc53/0x1bf0
[  432.045199]        lock_acquire+0x177/0x3e0
[  432.049386]        __mutex_lock+0x154/0x14a0
[  432.053668]        blk_mq_init_sched+0x3b3/0x5f0
[  432.058296]        elevator_init_mq+0x214/0x330
[  432.062837]        add_disk_fwnode+0xfa/0x1200
[  432.067281]        sd_probe+0x826/0xdb0 [sd_mod]
[  432.071908]        really_probe+0x1e0/0x920
[  432.076094]        __driver_probe_device+0x18a/0x3d0
[  432.081060]        driver_probe_device+0x49/0x120
[  432.085768]        __driver_attach_async_helper+0x102/0x260
[  432.091339]        async_run_entry_fn+0x93/0x4f0
[  432.095967]        process_one_work+0xe61/0x16a0
[  432.100586]        worker_thread+0x588/0xce0
[  432.104856]        kthread+0x2f3/0x3e0
[  432.108609]        ret_from_fork+0x2d/0x70
[  432.112707]        ret_from_fork_asm+0x1a/0x30
[  432.117155]
               -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[  432.123949]        __lock_acquire+0xc53/0x1bf0
[  432.128393]        lock_acquire+0x177/0x3e0
[  432.132578]        bio_queue_enter+0x228/0x360
[  432.137025]        blk_mq_submit_bio+0x44f/0x1a10
[  432.141731]        __submit_bio+0x154/0x420
[  432.145916]        __submit_bio_noacct+0x145/0x530
[  432.150709]        submit_bio_noacct_nocheck+0x525/0x650
[  432.156019]        iomap_readahead+0x492/0x6a0
[  432.160467]        read_pages+0x177/0xbe0
[  432.164486]        page_cache_ra_order+0x4a9/0xa10
[  432.169278]        filemap_get_pages+0x2bc/0xaa0
[  432.173897]        filemap_read+0x301/0x9e0
[  432.178083]        xfs_file_buffered_read+0x104/0x160 [xfs]
[  432.184030]        xfs_file_read_iter+0x274/0x560 [xfs]
[  432.189559]        vfs_read+0x74a/0xc30
[  432.193405]        ksys_read+0xf1/0x1d0
[  432.197243]        do_syscall_64+0x8c/0x180
[  432.201438]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.207018]
               -> #1 (mapping.invalidate_lock#2){++++}-{3:3}:
[  432.213987]        __lock_acquire+0xc53/0x1bf0
[  432.218440]        lock_acquire+0x177/0x3e0
[  432.222628]        down_read+0xa1/0x4c0
[  432.226475]        filemap_fault+0x70b/0x12a0
[  432.230842]        __xfs_filemap_fault+0x121/0x290 [xfs]
[  432.236449]        __do_fault+0xf1/0x7f0
[  432.240384]        do_pte_missing+0x413/0x940
[  432.244743]        __handle_mm_fault+0xafb/0x1280
[  432.249447]        handle_mm_fault+0x26b/0x5f0
[  432.253892]        do_user_addr_fault+0x236/0xb90
[  432.258600]        exc_page_fault+0x59/0xe0
[  432.262794]        asm_exc_page_fault+0x22/0x30
[  432.267324]        rep_stos_alternative+0x40/0x80
[  432.272031]        elf_load+0x498/0x700
[  432.275871]        load_elf_binary+0x9ca/0x2a30
[  432.280403]        search_binary_handler+0x161/0x560
[  432.285378]        exec_binprm+0x119/0x430
[  432.289475]        bprm_execve+0x1e4/0x520
[  432.293573]        do_execveat_common.isra.0+0x404/0x540
[  432.298887]        __x64_sys_execve+0x88/0xb0
[  432.303246]        do_syscall_64+0x8c/0x180
[  432.307431]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.313005]
               -> #0 (&mm->mmap_lock){++++}-{3:3}:
[  432.319020]        check_prev_add+0x1b7/0x2360
[  432.323473]        validate_chain+0xa42/0xe00
[  432.327831]        __lock_acquire+0xc53/0x1bf0
[  432.332277]        lock_acquire+0x177/0x3e0
[  432.336462]        __might_fault+0xef/0x170
[  432.340649]        _copy_from_user+0x22/0xa0
[  432.344929]        __blk_trace_setup+0x8e/0x130
[  432.349469]        blk_trace_ioctl+0x118/0x240
[  432.353917]        blkdev_ioctl+0xf0/0x5c0
[  432.358024]        __x64_sys_ioctl+0x128/0x1a0
[  432.362479]        do_syscall_64+0x8c/0x180
[  432.366673]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.372244]
               other info that might help us debug this:

[  432.380242] Chain exists of:
                 &mm->mmap_lock --> &q->q_usage_counter(io) -->
&q->debugfs_mutex

[  432.391804]  Possible unsafe locking scenario:

[  432.397721]        CPU0                    CPU1
[  432.402255]        ----                    ----
[  432.406786]   lock(&q->debugfs_mutex);
[  432.410539]                                lock(&q->q_usage_counter(io));
[  432.417323]                                lock(&q->debugfs_mutex);
[  432.423590]   rlock(&mm->mmap_lock);
[  432.427168]
                *** DEADLOCK ***

[  432.433088] 1 lock held by blktrace/2277:
[  432.437099]  #0: ffff88ada6814858 (&q->debugfs_mutex){+.+.}-{3:3},
at: blk_trace_ioctl+0x8d/0x240
[  432.445974]
               stack backtrace:
[  432.450333] CPU: 39 UID: 0 PID: 2277 Comm: blktrace Kdump: loaded
Not tainted 6.12.0-rc5+ #3
[  432.458765] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[  432.466332] Call Trace:
[  432.468784]  <TASK>
[  432.470888]  dump_stack_lvl+0x7e/0xc0
[  432.474564]  print_circular_bug+0x1b7/0x240
[  432.478751]  check_noncircular+0x2f6/0x3e0
[  432.482849]  ? __pfx_check_noncircular+0x10/0x10
[  432.487470]  ? validate_chain+0x148/0xe00
[  432.491491]  ? alloc_chain_hlocks+0x33c/0x530
[  432.495856]  check_prev_add+0x1b7/0x2360
[  432.499784]  validate_chain+0xa42/0xe00
[  432.503634]  ? __pfx_validate_chain+0x10/0x10
[  432.507997]  ? mark_lock.part.0+0x77/0x880
[  432.512100]  __lock_acquire+0xc53/0x1bf0
[  432.516034]  ? rcu_is_watching+0x11/0xb0
[  432.519968]  lock_acquire+0x177/0x3e0
[  432.523638]  ? __might_fault+0xbf/0x170
[  432.527478]  ? __pfx_lock_acquire+0x10/0x10
[  432.531664]  ? blk_trace_ioctl+0x8d/0x240
[  432.535681]  ? __might_fault+0xbf/0x170
[  432.539525]  __might_fault+0xef/0x170
[  432.543197]  ? __might_fault+0xbf/0x170
[  432.547037]  _copy_from_user+0x22/0xa0
[  432.550791]  __blk_trace_setup+0x8e/0x130
[  432.554812]  ? __pfx___blk_trace_setup+0x10/0x10
[  432.559437]  ? snprintf+0x9e/0xd0
[  432.562757]  ? __pfx_snprintf+0x10/0x10
[  432.566601]  blk_trace_ioctl+0x118/0x240
[  432.570531]  ? __pfx_blk_trace_ioctl+0x10/0x10
[  432.574974]  ? __lock_release+0x486/0x960
[  432.578988]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  432.585004]  ? rcu_is_watching+0x11/0xb0
[  432.588930]  blkdev_ioctl+0xf0/0x5c0
[  432.592515]  ? __pfx_blkdev_ioctl+0x10/0x10
[  432.596704]  __x64_sys_ioctl+0x128/0x1a0
[  432.600637]  do_syscall_64+0x8c/0x180
[  432.604303]  ? ktime_get_coarse_real_ts64+0x130/0x170
[  432.609363]  ? rcu_is_watching+0x11/0xb0
[  432.613288]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.618424]  ? do_syscall_64+0x98/0x180
[  432.622266]  ? lockdep_hardirqs_on+0x78/0x100
[  432.626624]  ? do_syscall_64+0x98/0x180
[  432.630463]  ? do_user_addr_fault+0x4b7/0xb90
[  432.634823]  ? do_user_addr_fault+0x4b7/0xb90
[  432.639181]  ? rcu_is_watching+0x11/0xb0
[  432.643107]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.648248]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.653307] RIP: 0033:0x7fdb8110375b
[  432.656896] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 56 0f 00 f7 d8 64 89
01 48
[  432.675646] RSP: 002b:00007fffc3175998 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  432.683213] RAX: ffffffffffffffda RBX: 000055cefc56c860 RCX: 00007fdb8110375b
[  432.690344] RDX: 00007fffc3175a40 RSI: 00000000c0481273 RDI: 0000000000000003
[  432.697475] RBP: 00000000c0481273 R08: 00007fdb811faf30 R09: 0000000000000000
[  432.704607] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fffc3175a40
[  432.711741] R13: 0000000000000000 R14: 000055cf3205d650 R15: 0000000000000000
[  432.718880]  </TASK>
[  432.918796] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
[root@storageqe-31 blktests]#
[  432.547037]  _copy_from_user+0x22/0xa0
[  432.550791]  __blk_trace_setup+0x8e/0x130
[  432.554812]  ? __pfx___blk_trace_setup+0x10/0x10
[  432.559437]  ? snprintf+0x9e/0xd0
[  432.562757]  ? __pfx_snprintf+0x10/0x10
[  432.566601]  blk_trace_ioctl+0x118/0x240
[  432.570531]  ? __pfx_blk_trace_ioctl+0x10/0x10
[  432.574974]  ? __lock_release+0x486/0x960
[  432.578988]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  432.585004]  ? rcu_is_watching+0x11/0xb0
[  432.588930]  blkdev_ioctl+0xf0/0x5c0
[  432.592515]  ? __pfx_blkdev_ioctl+0x10/0x10
[  432.596704]  __x64_sys_ioctl+0x128/0x1a0
[  432.600637]  do_syscall_64+0x8c/0x180
[  432.604303]  ? ktime_get_coarse_real_ts64+0x130/0x170
[  432.609363]  ? rcu_is_watching+0x11/0xb0
[  432.613288]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.618424]  ? do_syscall_64+0x98/0x180
[  432.622266]  ? lockdep_hardirqs_on+0x78/0x100
[  432.626624]  ? do_syscall_64+0x98/0x180
[  432.630463]  ? do_user_addr_fault+0x4b7/0xb90
[  432.634823]  ? do_user_addr_fault+0x4b7/0xb90
[  432.639181]  ? rcu_is_watching+0x11/0xb0
[  432.643107]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.648248]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.653307] RIP: 0033:0x7fdb8110375b
[  432.656896] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 56 0f 00 f7 d8 64 89
01 48
[  432.675646] RSP: 002b:00007fffc3175998 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  432.683213] RAX: ffffffffffffffda RBX: 000055cefc56c860 RCX: 00007fdb8110375b
[  432.690344] RDX: 00007fffc3175a40 RSI: 00000000c0481273 RDI: 0000000000000003
[  432.697475] RBP: 00000000c0481273 R08: 00007fdb811faf30 R09: 0000000000000000
[  432.704607] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fffc3175a40
[  432.711741] R13: 0000000000000000 R14: 000055cf3205d650 R15: 0000000000000000
[  432.718880]  </TASK>
[  432.918796] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
[root@storageqe-31 blktests]#
[  432.547037]  _copy_from_user+0x22/0xa0
[  432.550791]  __blk_trace_setup+0x8e/0x130
[  432.554812]  ? __pfx___blk_trace_setup+0x10/0x10
[  432.559437]  ? snprintf+0x9e/0xd0
[  432.562757]  ? __pfx_snprintf+0x10/0x10
[  432.566601]  blk_trace_ioctl+0x118/0x240
[  432.570531]  ? __pfx_blk_trace_ioctl+0x10/0x10
[  432.574974]  ? __lock_release+0x486/0x960
[  432.578988]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  432.585004]  ? rcu_is_watching+0x11/0xb0
[  432.588930]  blkdev_ioctl+0xf0/0x5c0
[  432.592515]  ? __pfx_blkdev_ioctl+0x10/0x10
[  432.596704]  __x64_sys_ioctl+0x128/0x1a0
[  432.600637]  do_syscall_64+0x8c/0x180
[  432.604303]  ? ktime_get_coarse_real_ts64+0x130/0x170
[  432.609363]  ? rcu_is_watching+0x11/0xb0
[  432.613288]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.618424]  ? do_syscall_64+0x98/0x180
[  432.622266]  ? lockdep_hardirqs_on+0x78/0x100
[  432.626624]  ? do_syscall_64+0x98/0x180
[  432.630463]  ? do_user_addr_fault+0x4b7/0xb90
[  432.634823]  ? do_user_addr_fault+0x4b7/0xb90
[  432.639181]  ? rcu_is_watching+0x11/0xb0
[  432.643107]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.648248]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.653307] RIP: 0033:0x7fdb8110375b
[  432.656896] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 56 0f 00 f7 d8 64 89
01 48
[  432.675646] RSP: 002b:00007fffc3175998 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  432.683213] RAX: ffffffffffffffda RBX: 000055cefc56c860 RCX: 00007fdb8110375b
[  432.690344] RDX: 00007fffc3175a40 RSI: 00000000c0481273 RDI: 0000000000000003
[  432.697475] RBP: 00000000c0481273 R08: 00007fdb811faf30 R09: 0000000000000000
[  432.704607] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fffc3175a40
[  432.711741] R13: 0000000000000000 R14: 000055cf3205d650 R15: 0000000000000000
[  432.718880]  </TASK>
[  432.918796] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
[root@storageqe-31 blktests]#
[  432.547037]  _copy_from_user+0x22/0xa0
[  432.550791]  __blk_trace_setup+0x8e/0x130
[  432.554812]  ? __pfx___blk_trace_setup+0x10/0x10
[  432.559437]  ? snprintf+0x9e/0xd0
[  432.562757]  ? __pfx_snprintf+0x10/0x10
[  432.566601]  blk_trace_ioctl+0x118/0x240
[  432.570531]  ? __pfx_blk_trace_ioctl+0x10/0x10
[  432.574974]  ? __lock_release+0x486/0x960
[  432.578988]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  432.585004]  ? rcu_is_watching+0x11/0xb0
[  432.588930]  blkdev_ioctl+0xf0/0x5c0
[  432.592515]  ? __pfx_blkdev_ioctl+0x10/0x10
[  432.596704]  __x64_sys_ioctl+0x128/0x1a0
[  432.600637]  do_syscall_64+0x8c/0x180
[  432.604303]  ? ktime_get_coarse_real_ts64+0x130/0x170
[  432.609363]  ? rcu_is_watching+0x11/0xb0
[  432.613288]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.618424]  ? do_syscall_64+0x98/0x180
[  432.622266]  ? lockdep_hardirqs_on+0x78/0x100
[  432.626624]  ? do_syscall_64+0x98/0x180
[  432.630463]  ? do_user_addr_fault+0x4b7/0xb90
[  432.634823]  ? do_user_addr_fault+0x4b7/0xb90
[  432.639181]  ? rcu_is_watching+0x11/0xb0
[  432.643107]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[  432.648248]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  432.653307] RIP: 0033:0x7fdb8110375b
[  432.656896] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 56 0f 00 f7 d8 64 89
01 48
[  432.675646] RSP: 002b:00007fffc3175998 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  432.683213] RAX: ffffffffffffffda RBX: 000055cefc56c860 RCX: 00007fdb8110375b
[  432.690344] RDX: 00007fffc3175a40 RSI: 00000000c0481273 RDI: 0000000000000003
[  432.697475] RBP: 00000000c0481273 R08: 00007fdb811faf30 R09: 0000000000000000
[  432.704607] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fffc3175a40
[  432.711741] R13: 0000000000000000 R14: 000055cf3205d650 R15: 0000000000000000
[  432.718880]  </TASK>
[  432.918796] sd 15:0:0:0: [sdb] Synchronizing SCSI cache

-- 
Best Regards,
  Yi Zhang

