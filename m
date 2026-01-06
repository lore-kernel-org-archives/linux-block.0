Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97428D8E8
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711959; cv=none; b=BrBCYiu5LF+mRMtf34xjYr3GP+G0XMO7kgkm1UloXtKcLR6O9IN1C1S+i1/HQP1UklrPiOX2HVRuWCNW6TbJ/asjKnS/MrNTmKI6YY0vjedSAI+nJDVoooVAGv83IVG9iECdq8KETMrrlZJB7j7KfTZ4qsWoS3+TmwBeL5wJHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711959; c=relaxed/simple;
	bh=AuF0ZNWNX8tx+EqQ6ge6AqRotPQTjft/0huFQJnmnwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCA4ZWu28q4coqQj8fQYngnDWjYmG10gkXzAG728bIQq6hChH5KwQSuIcGNYpNiViyU4BYOx71NDFJynESZ65d0CeiguxVh6BHrua/TkoYudBm3zMGt1VgXfCom5RWsdMNZ/RryMZr1gu7gUwODmyaidVLJT8yvkq0PYrRUldyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyaU07wl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyaU07wl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767711949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bndakk8tV+THlPhBiVbOCDHYYU6NOemGYWdM8KPqmKE=;
	b=MyaU07wl+bShJpD0TF6/53cIudCLNYA2pqWLIJTEildm+XYMP/ehGfgrf+5+ytWkj36v5c
	8PTlKeH2Ql8FLiJyqKe4JvI9rWkob9BRSnu5OQ+bGC28uLfTodVRee883HF31n/mAegxX+
	Wem6qr5tB/70q33q5iTIXdY0aiZSqho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-c5fQlrvFMJqIfzUET8KE7A-1; Tue,
 06 Jan 2026 10:05:19 -0500
X-MC-Unique: c5fQlrvFMJqIfzUET8KE7A-1
X-Mimecast-MFC-AGG-ID: c5fQlrvFMJqIfzUET8KE7A_1767711901
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93ADC197732A;
	Tue,  6 Jan 2026 15:04:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A601819560A7;
	Tue,  6 Jan 2026 15:04:25 +0000 (UTC)
Date: Tue, 6 Jan 2026 23:04:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: djiony2011@gmail.com
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when
 called from interrupt context
Message-ID: <aV0kdKSvufPFflQ8@fedora>
References: <aUnu1HdMqQbksLeY@fedora>
 <20260106111411.6435-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106111411.6435-1-ionut.nechita@windriver.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 06, 2026 at 01:14:11PM +0200, djiony2011@gmail.com wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> Hi Ming,
> 
> Thank you for the review. You're absolutely right to ask for clarification - I need to
> correct my commit message as it's misleading about the actual call path.
> 
> > Can you show the whole stack trace in the warning? The in-code doesn't
> > indicate that freeze queue can be called from scsi's interrupt context.
> 
> Here's the complete stack trace from the WARNING at blk_mq_run_hw_queue:
> 
> [Mon Dec 22 10:18:18 2025] WARNING: CPU: 190 PID: 2041 at block/blk-mq.c:2291 blk_mq_run_hw_queue+0x1fa/0x260
> [Mon Dec 22 10:18:18 2025] Modules linked in:
> [Mon Dec 22 10:18:18 2025] CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1

There is so big change between 6.6.0-1-rt and 6.19, because Real-Time "PREEMPT_RT" Support Merged For Linux 6.12

https://www.phoronix.com/news/Linux-6.12-Does-Real-Time


> [Mon Dec 22 10:18:18 2025] Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
> [Mon Dec 22 10:18:18 2025] Workqueue: events_unbound async_run_entry_fn
> [Mon Dec 22 10:18:18 2025] RIP: 0010:blk_mq_run_hw_queue+0x1fa/0x260
> [Mon Dec 22 10:18:18 2025] Code: ff 75 68 44 89 f6 e8 e5 45 c0 ff e9 ac fe ff ff e8 2b 70 c0 ff 48 89 ef e8 b3 a0 00 00 5b 5d 41 5c 41 5d 41 5e e9 26 9e c0 ff <0f> 0b e9 43 fe ff ff e8 0a 70 c0 ff 48 8b 85 d0 00 00 00 48 8b 80
> [Mon Dec 22 10:18:18 2025] RSP: 0018:ff630f098528fb98 EFLAGS: 00010206
> [Mon Dec 22 10:18:18 2025] RAX: 0000000000ff0000 RBX: 0000000000000000 RCX: 0000000000000000
> [Mon Dec 22 10:18:18 2025] RDX: 0000000000ff0000 RSI: 0000000000000000 RDI: ff3edc0247159400
> [Mon Dec 22 10:18:18 2025] RBP: ff3edc0247159400 R08: ff3edc0247159400 R09: ff630f098528fb60
> [Mon Dec 22 10:18:18 2025] R10: 0000000000000000 R11: 0000000045069ed3 R12: 0000000000000000
> [Mon Dec 22 10:18:18 2025] R13: ff3edc024715a828 R14: 0000000000000000 R15: 0000000000000000
> [Mon Dec 22 10:18:18 2025] FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
> [Mon Dec 22 10:18:18 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Dec 22 10:18:18 2025] CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
> [Mon Dec 22 10:18:18 2025] PKRU: 55555554
> [Mon Dec 22 10:18:18 2025] Call Trace:
> [Mon Dec 22 10:18:18 2025]  <TASK>
> [Mon Dec 22 10:18:18 2025]  ? __warn+0x89/0x140
> [Mon Dec 22 10:18:18 2025]  ? blk_mq_run_hw_queue+0x1fa/0x260
> [Mon Dec 22 10:18:18 2025]  ? report_bug+0x198/0x1b0
> [Mon Dec 22 10:18:18 2025]  ? handle_bug+0x53/0x90
> [Mon Dec 22 10:18:18 2025]  ? exc_invalid_op+0x18/0x70
> [Mon Dec 22 10:18:18 2025]  ? asm_exc_invalid_op+0x1a/0x20
> [Mon Dec 22 10:18:18 2025]  ? blk_mq_run_hw_queue+0x1fa/0x260
> [Mon Dec 22 10:18:18 2025]  blk_mq_run_hw_queues+0x6c/0x130
> [Mon Dec 22 10:18:18 2025]  blk_queue_start_drain+0x12/0x40
> [Mon Dec 22 10:18:18 2025]  blk_mq_destroy_queue+0x37/0x70
> [Mon Dec 22 10:18:18 2025]  __scsi_remove_device+0x6a/0x180
> [Mon Dec 22 10:18:18 2025]  scsi_alloc_sdev+0x357/0x360
> [Mon Dec 22 10:18:18 2025]  scsi_probe_and_add_lun+0x8ac/0xc00
> [Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
> [Mon Dec 22 10:18:18 2025]  ? dev_set_name+0x57/0x80
> [Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
> [Mon Dec 22 10:18:18 2025]  ? attribute_container_add_device+0x4d/0x130
> [Mon Dec 22 10:18:18 2025]  __scsi_scan_target+0xf0/0x520
> [Mon Dec 22 10:18:18 2025]  ? srso_alias_return_thunk+0x5/0xfbef5
> [Mon Dec 22 10:18:18 2025]  ? sched_clock_cpu+0x64/0x190
> [Mon Dec 22 10:18:18 2025]  scsi_scan_channel+0x57/0x90
> [Mon Dec 22 10:18:18 2025]  scsi_scan_host_selected+0xd4/0x110
> [Mon Dec 22 10:18:18 2025]  do_scan_async+0x1c/0x190
> [Mon Dec 22 10:18:18 2025]  async_run_entry_fn+0x2f/0x130
> [Mon Dec 22 10:18:18 2025]  process_one_work+0x175/0x370
> [Mon Dec 22 10:18:18 2025]  worker_thread+0x280/0x390
> [Mon Dec 22 10:18:18 2025]  ? __pfx_worker_thread+0x10/0x10
> [Mon Dec 22 10:18:18 2025]  kthread+0xdd/0x110
> [Mon Dec 22 10:18:18 2025]  ? __pfx_kthread+0x10/0x10
> [Mon Dec 22 10:18:18 2025]  ret_from_fork+0x31/0x50
> [Mon Dec 22 10:18:18 2025]  ? __pfx_kthread+0x10/0x10
> [Mon Dec 22 10:18:18 2025]  ret_from_fork_asm+0x1b/0x30
> [Mon Dec 22 10:18:18 2025]  </TASK>
> [Mon Dec 22 10:18:18 2025] ---[ end trace 0000000000000000 ]---
> 
> ## Important clarifications:
> 
> 1. **Not freeze queue, but drain during destroy**: My commit message was incorrect.
>    The call path is:
>    blk_mq_destroy_queue() -> blk_queue_start_drain() -> blk_mq_run_hw_queues(q, false)
> 
>    This is NOT during blk_freeze_queue_start(), but during queue destruction when a
>    SCSI device probe fails and cleanup is triggered.
> 
> 2. **Not true interrupt context**: You're correct that this isn't from an interrupt
>    handler. The workqueue context is process context, not interrupt context.
> 
> 3. **The actual problem on PREEMPT_RT**: There's a preceding "scheduling while atomic"
>    error that provides the real context:
> 
> [Mon Dec 22 10:18:18 2025] BUG: scheduling while atomic: kworker/u385:1/2041/0x00000002
> [Mon Dec 22 10:18:18 2025] Call Trace:
> [Mon Dec 22 10:18:18 2025]  dump_stack_lvl+0x37/0x50
> [Mon Dec 22 10:18:18 2025]  __schedule_bug+0x52/0x60
> [Mon Dec 22 10:18:18 2025]  __schedule+0x87d/0xb10
> [Mon Dec 22 10:18:18 2025]  rt_mutex_schedule+0x21/0x40
> [Mon Dec 22 10:18:18 2025]  rt_mutex_slowlock_block.constprop.0+0x33/0x170
> [Mon Dec 22 10:18:18 2025]  __rt_mutex_slowlock_locked.constprop.0+0xc4/0x1e0
> [Mon Dec 22 10:18:18 2025]  mutex_lock+0x44/0x60
> [Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance_cpuslocked+0x41/0x110
> [Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance+0x48/0xd0
> [Mon Dec 22 10:18:18 2025]  blk_mq_realloc_hw_ctxs+0x405/0x420

Why is the above warning related with your patch?

> [Mon Dec 22 10:18:18 2025]  blk_mq_init_allocated_queue+0x10a/0x480
> 
> The context is atomic because on PREEMPT_RT, some spinlock earlier in the call chain has
> been converted to an rt_mutex, and the code is holding that lock. When blk_mq_run_hw_queues()
> is called with async=false, it triggers kblockd_mod_delayed_work_on(), which calls
> in_interrupt(), and this returns true because preempt_count() is non-zero due to the
> rt_mutex being held.
> 
> ## What this means:
> 
> The issue is specific to PREEMPT_RT where:
> - Spinlocks become sleeping mutexes (rt_mutex)
> - Holding an rt_mutex sets preempt_count, making in_interrupt() return true
> - blk_mq_run_hw_queues() with async=false hits WARN_ON_ONCE(!async && in_interrupt())

If you think the same issue exists on recent kernel, show the stack trace.

Or please share how preempt is disabled in the above blk_mq_run_hw_queues code
path.


Thanks,
Ming

