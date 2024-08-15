Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDA39AEB
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692883; cv=none; b=Ry3SOY6lCLx11hJn/Mhpe/r5EyGWz6Yd0EMnHLX256zOvL+Cn6mr3eqRdp7zibPVaqMVlKgQRG1sMmwCE9M9UI0Wtgvem+twKqrRt6YpZ69OVjrGVOdjsaXGmuQDMpxS4ZIcV0cLc9jzw8L/vNFjEemUeH8ibhrHxzE2T7azT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692883; c=relaxed/simple;
	bh=jc9sBh8DnOYiFOcaqDcoGd3baG4qz+wX3LpE+ghM+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhoUZao+w38wtjBsxGsq5LTxQ9z/lht7iGtk0t8YOLPqDrD2tIOy/s3qul4hHArV7NS0wbyjsU+pu8EW7l37EI7y7kEYxb08v2ViqfxLqFt8PGptTJ8q6ykNHByl2xZEsQcsyJaSjXbXvIY+VqmfzjkXSqoVwI1dPOB8gmRTJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqFw0TFK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqFw0TFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723692879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6K1TI3jnfsF1USfFDB2QIyPomo8kjJEpGvQ1xDYo0cg=;
	b=hqFw0TFKS0DugC1AVIvSSdo0268jjdtJOnB3ML+WVXxaqxq6ov/pkEy2S6G2phP+uZy8AG
	GOzQUTf35wCrsitNzyY3Hq+MaN28mFzSjKk9QWSLCbVtfLFYkKgy+ahoxDgE5dXBd9J956
	G671pfaHRfv/k1WpwZKfeS0jPDEry7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-z-y9NpPmOIqFoDPIrUtwRg-1; Wed,
 14 Aug 2024 23:34:34 -0400
X-MC-Unique: z-y9NpPmOIqFoDPIrUtwRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAD8F1944EBA;
	Thu, 15 Aug 2024 03:34:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 672E619560AA;
	Thu, 15 Aug 2024 03:34:19 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:34:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH v2] block: Fix lockdep warning in blk_mq_mark_tag_wait
Message-ID: <Zr13NpFfPgMtGJas@fedora>
References: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Aug 15, 2024 at 10:47:36AM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Lockdep reported a warning in Linux version 6.6:
> 
> [  414.344659] ================================
> [  414.345155] WARNING: inconsistent lock state
> [  414.345658] 6.6.0-07439-gba2303cacfda #6 Not tainted
> [  414.346221] --------------------------------
> [  414.346712] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  414.347545] kworker/u10:3/1152 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [  414.349245] ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.351204] {IN-SOFTIRQ-W} state was registered at:
> [  414.351751]   lock_acquire+0x18d/0x460
> [  414.352218]   _raw_spin_lock_irqsave+0x39/0x60
> [  414.352769]   __wake_up_common_lock+0x22/0x60
> [  414.353289]   sbitmap_queue_wake_up+0x375/0x4f0
> [  414.353829]   sbitmap_queue_clear+0xdd/0x270
> [  414.354338]   blk_mq_put_tag+0xdf/0x170
> [  414.354807]   __blk_mq_free_request+0x381/0x4d0
> [  414.355335]   blk_mq_free_request+0x28b/0x3e0
> [  414.355847]   __blk_mq_end_request+0x242/0xc30
> [  414.356367]   scsi_end_request+0x2c1/0x830
> [  414.345155] WARNING: inconsistent lock state
> [  414.345658] 6.6.0-07439-gba2303cacfda #6 Not tainted
> [  414.346221] --------------------------------
> [  414.346712] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  414.347545] kworker/u10:3/1152 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [  414.349245] ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.351204] {IN-SOFTIRQ-W} state was registered at:
> [  414.351751]   lock_acquire+0x18d/0x460
> [  414.352218]   _raw_spin_lock_irqsave+0x39/0x60
> [  414.352769]   __wake_up_common_lock+0x22/0x60
> [  414.353289]   sbitmap_queue_wake_up+0x375/0x4f0
> [  414.353829]   sbitmap_queue_clear+0xdd/0x270
> [  414.354338]   blk_mq_put_tag+0xdf/0x170
> [  414.354807]   __blk_mq_free_request+0x381/0x4d0
> [  414.355335]   blk_mq_free_request+0x28b/0x3e0
> [  414.355847]   __blk_mq_end_request+0x242/0xc30
> [  414.356367]   scsi_end_request+0x2c1/0x830
> [  414.356863]   scsi_io_completion+0x177/0x1610
> [  414.357379]   scsi_complete+0x12f/0x260
> [  414.357856]   blk_complete_reqs+0xba/0xf0
> [  414.358338]   __do_softirq+0x1b0/0x7a2
> [  414.358796]   irq_exit_rcu+0x14b/0x1a0
> [  414.359262]   sysvec_call_function_single+0xaf/0xc0
> [  414.359828]   asm_sysvec_call_function_single+0x1a/0x20
> [  414.360426]   default_idle+0x1e/0x30
> [  414.360873]   default_idle_call+0x9b/0x1f0
> [  414.361390]   do_idle+0x2d2/0x3e0
> [  414.361819]   cpu_startup_entry+0x55/0x60
> [  414.362314]   start_secondary+0x235/0x2b0
> [  414.362809]   secondary_startup_64_no_verify+0x18f/0x19b
> [  414.363413] irq event stamp: 428794
> [  414.363825] hardirqs last  enabled at (428793): [<ffffffff816bfd1c>] ktime_get+0x1dc/0x200
> [  414.364694] hardirqs last disabled at (428794): [<ffffffff85470177>] _raw_spin_lock_irq+0x47/0x50
> [  414.365629] softirqs last  enabled at (428444): [<ffffffff85474780>] __do_softirq+0x540/0x7a2
> [  414.366522] softirqs last disabled at (428419): [<ffffffff813f65ab>] irq_exit_rcu+0x14b/0x1a0
> [  414.367425]
>                other info that might help us debug this:
> [  414.368194]  Possible unsafe locking scenario:
> [  414.368900]        CPU0
> [  414.369225]        ----
> [  414.369548]   lock(&sbq->ws[i].wait);
> [  414.370000]   <Interrupt>
> [  414.370342]     lock(&sbq->ws[i].wait);
> [  414.370802]
>                 *** DEADLOCK ***
> [  414.371569] 5 locks held by kworker/u10:3/1152:
> [  414.372088]  #0: ffff88810130e938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x357/0x13f0
> [  414.373180]  #1: ffff88810201fdb8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x3a3/0x13f0
> [  414.374384]  #2: ffffffff86ffbdc0 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x637/0xa00
> [  414.375342]  #3: ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.376377]  #4: ffff888106205a08 (&hctx->dispatch_wait_lock){+.-.}-{2:2}, at: blk_mq_dispatch_rq_list+0x1337/0x1ee0
> [  414.378607]
>                stack backtrace:
> [  414.379177] CPU: 0 PID: 1152 Comm: kworker/u10:3 Not tainted 6.6.0-07439-gba2303cacfda #6
> [  414.380032] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  414.381177] Workqueue: writeback wb_workfn (flush-253:0)
> [  414.381805] Call Trace:
> [  414.382136]  <TASK>
> [  414.382429]  dump_stack_lvl+0x91/0xf0
> [  414.382884]  mark_lock_irq+0xb3b/0x1260
> [  414.383367]  ? __pfx_mark_lock_irq+0x10/0x10
> [  414.383889]  ? stack_trace_save+0x8e/0xc0
> [  414.384373]  ? __pfx_stack_trace_save+0x10/0x10
> [  414.384903]  ? graph_lock+0xcf/0x410
> [  414.385350]  ? save_trace+0x3d/0xc70
> [  414.385808]  mark_lock.part.20+0x56d/0xa90
> [  414.386317]  mark_held_locks+0xb0/0x110
> [  414.386791]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  414.387320]  lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.387901]  ? _raw_spin_unlock_irq+0x28/0x50
> [  414.388422]  trace_hardirqs_on+0x58/0x100
> [  414.388917]  _raw_spin_unlock_irq+0x28/0x50
> [  414.389422]  __blk_mq_tag_busy+0x1d6/0x2a0
> [  414.389920]  __blk_mq_get_driver_tag+0x761/0x9f0
> [  414.390899]  blk_mq_dispatch_rq_list+0x1780/0x1ee0
> [  414.391473]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
> [  414.392070]  ? sbitmap_get+0x2b8/0x450
> [  414.392533]  ? __blk_mq_get_driver_tag+0x210/0x9f0
> [  414.393095]  __blk_mq_sched_dispatch_requests+0xd99/0x1690
> [  414.393730]  ? elv_attempt_insert_merge+0x1b1/0x420
> [  414.394302]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
> [  414.394970]  ? lock_acquire+0x18d/0x460
> [  414.395456]  ? blk_mq_run_hw_queue+0x637/0xa00
> [  414.395986]  ? __pfx_lock_acquire+0x10/0x10
> [  414.396499]  blk_mq_sched_dispatch_requests+0x109/0x190
> [  414.397100]  blk_mq_run_hw_queue+0x66e/0xa00
> [  414.397616]  blk_mq_flush_plug_list.part.17+0x614/0x2030
> [  414.398244]  ? __pfx_blk_mq_flush_plug_list.part.17+0x10/0x10
> [  414.398897]  ? writeback_sb_inodes+0x241/0xcc0
> [  414.399429]  blk_mq_flush_plug_list+0x65/0x80
> [  414.399957]  __blk_flush_plug+0x2f1/0x530
> [  414.400458]  ? __pfx___blk_flush_plug+0x10/0x10
> [  414.400999]  blk_finish_plug+0x59/0xa0
> [  414.401467]  wb_writeback+0x7cc/0x920
> [  414.401935]  ? __pfx_wb_writeback+0x10/0x10
> [  414.402442]  ? mark_held_locks+0xb0/0x110
> [  414.402931]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  414.403462]  ? lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.404062]  wb_workfn+0x2b3/0xcf0
> [  414.404500]  ? __pfx_wb_workfn+0x10/0x10
> [  414.404989]  process_scheduled_works+0x432/0x13f0
> [  414.405546]  ? __pfx_process_scheduled_works+0x10/0x10
> [  414.406139]  ? do_raw_spin_lock+0x101/0x2a0
> [  414.406641]  ? assign_work+0x19b/0x240
> [  414.407106]  ? lock_is_held_type+0x9d/0x110
> [  414.407604]  worker_thread+0x6f2/0x1160
> [  414.408075]  ? __kthread_parkme+0x62/0x210
> [  414.408572]  ? lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.409168]  ? __kthread_parkme+0x13c/0x210
> [  414.409678]  ? __pfx_worker_thread+0x10/0x10
> [  414.410191]  kthread+0x33c/0x440
> [  414.410602]  ? __pfx_kthread+0x10/0x10
> [  414.411068]  ret_from_fork+0x4d/0x80
> [  414.411526]  ? __pfx_kthread+0x10/0x10
> [  414.411993]  ret_from_fork_asm+0x1b/0x30
> [  414.412489]  </TASK>
> 
> When interrupt is turned on while a lock holding by spin_lock_irq it
> throws a warning because of potential deadlock.
> 
> blk_mq_prep_dispatch_rq
>  blk_mq_get_driver_tag
>   __blk_mq_get_driver_tag
>    __blk_mq_alloc_driver_tag
>     blk_mq_tag_busy -> tag is already busy
>     // failed to get driver tag
>  blk_mq_mark_tag_wait
>   spin_lock_irq(&wq->lock) -> lock A (&sbq->ws[i].wait)
>   __add_wait_queue(wq, wait) -> wait queue active
>   blk_mq_get_driver_tag
>   __blk_mq_tag_busy
> -> 1) tag must be idle, which means there can't be inflight IO
>    spin_lock_irq(&tags->lock) -> lock B (hctx->tags)
>    spin_unlock_irq(&tags->lock) -> unlock B, turn on interrupt accidentally
> -> 2) context must be preempt by IO interrupt to trigger deadlock.
> 
> As shown above, the deadlock is not possible in theory, but the warning
> still need to be fixed.
> 
> Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
> 
> Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

