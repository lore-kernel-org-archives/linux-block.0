Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC030F802
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698060; cv=none; b=a2GeQBAZweHumgV7Erf0aDCeCoDuUW4dP8S6bibwed4VGqxUs0NrmsB6/auv+tm2A+mQ86Jl/9Bq7arWHM40SiPptpBUJyha8V9na36moebVrgeLuf86C9zrWF18J5vwi8isLP4CcdyYPH5l21LCXjzOM13a6BEOiRw5shzaCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698060; c=relaxed/simple;
	bh=QOLwE9yKsz5lnjMBwPThXPhLN/5p+dXW3dZqdcLvkU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2NxlKrYqXcJ76CHBe0/tx0v+uMG5uapUnHvtnjbHx3asMQdHsEvT9xwywHQMlR2RJ+Jrs3suC1nnAklUJmG7Lto7UHLrY9ZO6FJGovoSHxFDtDq0RBWs8jPS9sZ49zngG2jXO9G6mlGC/qnvgFiCIkT0kfRjpcHuJvM0c14Suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuBQyE8V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuBQyE8V"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso12648405e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767698057; x=1768302857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVZKk5oU5K00jot4Bi+Ldjw0RUZal7DJ8vw00Z3l9Ao=;
        b=fuBQyE8VFjI56nbGVn3kCau7Cao5nMoyrAyV4pPDEk2Nut/B2FqfMiLZwvwtA8tRGc
         /6gSZnIqsmK0mfgUOGzq0qjEtiwxKncfGvQCB5qkmsn/LswzjtwKe6h3tCyK/Hgi6Mwi
         ngRIm6pI4lj4ingwyO4btF2rmmD0mG7bN97Yy9lb2mvoZczzRDXmr15uoRk9MfbCeMEd
         N9vwLkIVE5yXu5AfjEXMWTV/u4zjZjYQU7zracT2oMEiDZOJOVWo+QxB2W7p5+HXDBhZ
         PE+l/Ej651nZBi9fptFOE2hMXq6XgjFPUmNYNZvd8uwSzbQwALPRTjJ6T/LovAPCCHSk
         5fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767698057; x=1768302857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVZKk5oU5K00jot4Bi+Ldjw0RUZal7DJ8vw00Z3l9Ao=;
        b=trbaNK9VqrvV6kWEV/73rgwnmHyuyFGP4K4/wGrCm5ZHwleoCrqih/QN4q8WD/up0P
         FEwa8IHpnQ78/wJkUU7VD2rUwXOc/F20vJqWtigwYPHbR3T1709LrG1FMLuncQBIMVFE
         78qsjlPugBQla3XW57PrBG8wmiU4ER5pprrrpC1cDrKHdbhfn+r4p8OQKEjsjSBIMdMI
         ZDblSD5ZKcllw8cBlfd2wxv2SO6HghKCXw+RXqCXX97dJMgr7TIt8LURvcjC8CN3il4l
         VIP5uiWSGPC1+gBIDqyboKlf7dV2RZOEDuVUFSsiWfGkZ6IcYHLLg1uMjfWgRIcvC3Za
         CaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn1cr2UTiVDu1ek/ba0nxsuOdFDTx6hOgzkR9zh87a2vwbAjU35GFzgl5vKZtgW0I0OldojjL6RdIfWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxECbtikKaWu6JMiluAUNLQ/0nRk2EnNEEjpfYRicVhniwolHDd
	jqdxV9V4oh5D41SlOTp8ZMzGNNQwckjG6z83V1ltv2nlkFTj9ESprMx/
X-Gm-Gg: AY/fxX4Pw9YojNHCTlSO41yg/WID5ckyst7qccqGwMbghbrilnfeLOOBhnANBJV5HmP
	oKGukV69Mh4EU8eoJsSz6Z9cV7QLp3VffPqxTc6OZBW+aUYU2mmvZgqgW1iSPHGEV+FDVJBt86L
	XfG7FHjPVtV1Bl62gk7kYNBNYlmvMpSZUCxYoC5fsfOpdy4jnygvscyIOQvpDxlF9PLCKIsShm1
	sxCkJSK4I9N513FWtZKvUEQbXap4Oofs3QPVOU84R/ZNVfQs/Bg3e/2NjkwTRrnMcjnk5fBqhTk
	ltQwWKKFeARtsidicNZ0aH3+5D/UBkeyPnSZjlsmBqPVv8dOwkTnjEIchpw09jh3GPStotzqcgf
	3kUmRz8rMe+wkKiFLp+GipnHfnhMrms5BZ7iY1anXE8eS+XETZuLpXC195D02+Fwmnp+uxKUnCG
	oSkUIoPWaUbPf4TYevGKdo72uwDgINT8Bg2/Ts9nJXBnLs
X-Google-Smtp-Source: AGHT+IG/t9UJd68fz0l1BGBLOMyHx0xQkUDFtE4j/3hcbemCE6oPqV9gYdA6M3tFBxVd6A1XGZr8cQ==
X-Received: by 2002:a05:600c:1f0f:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d7f422387mr26901935e9.15.1767698056740;
        Tue, 06 Jan 2026 03:14:16 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6f0e15sm35531705e9.10.2026.01.06.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:14:15 -0800 (PST)
From: djiony2011@gmail.com
X-Google-Original-From: ionut.nechita@windriver.com
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	djiony2011@gmail.com,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt context
Date: Tue,  6 Jan 2026 13:14:11 +0200
Message-ID: <20260106111411.6435-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aUnu1HdMqQbksLeY@fedora>
References: <aUnu1HdMqQbksLeY@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Ming,

Thank you for the review. You're absolutely right to ask for clarification - I need to
correct my commit message as it's misleading about the actual call path.

> Can you show the whole stack trace in the warning? The in-code doesn't
> indicate that freeze queue can be called from scsi's interrupt context.

Here's the complete stack trace from the WARNING at blk_mq_run_hw_queue:

[Mon Dec 22 10:18:18 2025] WARNING: CPU: 190 PID: 2041 at block/blk-mq.c:2291 blk_mq_run_hw_queue+0x1fa/0x260
[Mon Dec 22 10:18:18 2025] Modules linked in:
[Mon Dec 22 10:18:18 2025] CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
[Mon Dec 22 10:18:18 2025] Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
[Mon Dec 22 10:18:18 2025] Workqueue: events_unbound async_run_entry_fn
[Mon Dec 22 10:18:18 2025] RIP: 0010:blk_mq_run_hw_queue+0x1fa/0x260
[Mon Dec 22 10:18:18 2025] Code: ff 75 68 44 89 f6 e8 e5 45 c0 ff e9 ac fe ff ff e8 2b 70 c0 ff 48 89 ef e8 b3 a0 00 00 5b 5d 41 5c 41 5d 41 5e e9 26 9e c0 ff <0f> 0b e9 43 fe ff ff e8 0a 70 c0 ff 48 8b 85 d0 00 00 00 48 8b 80
[Mon Dec 22 10:18:18 2025] RSP: 0018:ff630f098528fb98 EFLAGS: 00010206
[Mon Dec 22 10:18:18 2025] RAX: 0000000000ff0000 RBX: 0000000000000000 RCX: 0000000000000000
[Mon Dec 22 10:18:18 2025] RDX: 0000000000ff0000 RSI: 0000000000000000 RDI: ff3edc0247159400
[Mon Dec 22 10:18:18 2025] RBP: ff3edc0247159400 R08: ff3edc0247159400 R09: ff630f098528fb60
[Mon Dec 22 10:18:18 2025] R10: 0000000000000000 R11: 0000000045069ed3 R12: 0000000000000000
[Mon Dec 22 10:18:18 2025] R13: ff3edc024715a828 R14: 0000000000000000 R15: 0000000000000000
[Mon Dec 22 10:18:18 2025] FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
[Mon Dec 22 10:18:18 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Dec 22 10:18:18 2025] CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
[Mon Dec 22 10:18:18 2025] PKRU: 55555554
[Mon Dec 22 10:18:18 2025] Call Trace:
[Mon Dec 22 10:18:18 2025]  <TASK>
[Mon Dec 22 10:18:18 2025]  ? __warn+0x89/0x140
[Mon Dec 22 10:18:18 2025]  ? blk_mq_run_hw_queue+0x1fa/0x260
[Mon Dec 22 10:18:18 2025]  ? report_bug+0x198/0x1b0
[Mon Dec 22 10:18:18 2025]  ? handle_bug+0x53/0x90
[Mon Dec 22 10:18:18 2025]  ? exc_invalid_op+0x18/0x70
[Mon Dec 22 10:18:18 2025]  ? asm_exc_invalid_op+0x1a/0x20
[Mon Dec 22 10:18:18 2025]  ? blk_mq_run_hw_queue+0x1fa/0x260
[Mon Dec 22 10:18:18 2025]  blk_mq_run_hw_queues+0x6c/0x130
[Mon Dec 22 10:18:18 2025]  blk_queue_start_drain+0x12/0x40
[Mon Dec 22 10:18:18 2025]  blk_mq_destroy_queue+0x37/0x70
[Mon Dec 22 10:18:18 2025]  __scsi_remove_device+0x6a/0x180
[Mon Dec 22 10:18:18 2025]  scsi_alloc_sdev+0x357/0x360
[Mon Dec 22 10:18:18 2025]  scsi_probe_and_add_lun+0x8ac/0xc00
[Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
[Mon Dec 22 10:18:18 2025]  ? dev_set_name+0x57/0x80
[Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
[Mon Dec 22 10:18:18 2025]  ? attribute_container_add_device+0x4d/0x130
[Mon Dec 22 10:18:18 2025]  __scsi_scan_target+0xf0/0x520
[Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
[Mon Dec 22 10:18:18 2025]  ? sched_clock_cpu+0x64/0x190
[Mon Dec 22 10:18:18 2025]  scsi_scan_channel+0x57/0x90
[Mon Dec 22 10:18:18 2025]  scsi_scan_host_selected+0xd4/0x110
[Mon Dec 22 10:18:18 2025]  do_scan_async+0x1c/0x190
[Mon Dec 22 10:18:18 2025]  async_run_entry_fn+0x2f/0x130
[Mon Dec 22 10:18:18 2025]  process_one_work+0x175/0x370
[Mon Dec 22 10:18:18 2025]  worker_thread+0x280/0x390
[Mon Dec 22 10:18:18 2025]  ? __pfx_worker_thread+0x10/0x10
[Mon Dec 22 10:18:18 2025]  kthread+0xdd/0x110
[Mon Dec 22 10:18:18 2025]  ? __pfx_kthread+0x10/0x10
[Mon Dec 22 10:18:18 2025]  ret_from_fork+0x31/0x50
[Mon Dec 22 10:18:18 2025]  ? __pfx_kthread+0x10/0x10
[Mon Dec 22 10:18:18 2025]  ret_from_fork_asm+0x1b/0x30
[Mon Dec 22 10:18:18 2025]  </TASK>
[Mon Dec 22 10:18:18 2025] ---[ end trace 0000000000000000 ]---

## Important clarifications:

1. **Not freeze queue, but drain during destroy**: My commit message was incorrect.
   The call path is:
   blk_mq_destroy_queue() -> blk_queue_start_drain() -> blk_mq_run_hw_queues(q, false)

   This is NOT during blk_freeze_queue_start(), but during queue destruction when a
   SCSI device probe fails and cleanup is triggered.

2. **Not true interrupt context**: You're correct that this isn't from an interrupt
   handler. The workqueue context is process context, not interrupt context.

3. **The actual problem on PREEMPT_RT**: There's a preceding "scheduling while atomic"
   error that provides the real context:

[Mon Dec 22 10:18:18 2025] BUG: scheduling while atomic: kworker/u385:1/2041/0x00000002
[Mon Dec 22 10:18:18 2025] Call Trace:
[Mon Dec 22 10:18:18 2025]  dump_stack_lvl+0x37/0x50
[Mon Dec 22 10:18:18 2025]  __schedule_bug+0x52/0x60
[Mon Dec 22 10:18:18 2025]  __schedule+0x87d/0xb10
[Mon Dec 22 10:18:18 2025]  rt_mutex_schedule+0x21/0x40
[Mon Dec 22 10:18:18 2025]  rt_mutex_slowlock_block.constprop.0+0x33/0x170
[Mon Dec 22 10:18:18 2025]  __rt_mutex_slowlock_locked.constprop.0+0xc4/0x1e0
[Mon Dec 22 10:18:18 2025]  mutex_lock+0x44/0x60
[Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance_cpuslocked+0x41/0x110
[Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance+0x48/0xd0
[Mon Dec 22 10:18:18 2025]  blk_mq_realloc_hw_ctxs+0x405/0x420
[Mon Dec 22 10:18:18 2025]  blk_mq_init_allocated_queue+0x10a/0x480

The context is atomic because on PREEMPT_RT, some spinlock earlier in the call chain has
been converted to an rt_mutex, and the code is holding that lock. When blk_mq_run_hw_queues()
is called with async=false, it triggers kblockd_mod_delayed_work_on(), which calls
in_interrupt(), and this returns true because preempt_count() is non-zero due to the
rt_mutex being held.

## What this means:

The issue is specific to PREEMPT_RT where:
- Spinlocks become sleeping mutexes (rt_mutex)
- Holding an rt_mutex sets preempt_count, making in_interrupt() return true
- blk_mq_run_hw_queues() with async=false hits WARN_ON_ONCE(!async && in_interrupt())

This is why the async parameter needs to be true when called in contexts that might
hold spinlocks on RT kernels.

I apologize for the confusion in my commit message. Should I:
1. Revise the commit message to accurately describe the blk_queue_start_drain() path?
2. Add details about the PREEMPT_RT context causing the atomic state?

Best regards,
Ionut
