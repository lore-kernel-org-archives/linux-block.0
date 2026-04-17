Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B82566F7
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438945; cv=none; b=p3mXpJQO6Ljg1uquyhgPzhkJfigUoBi7cn804GzLVrnqhDmNuisq5k9U6pYD6uz7lMgwuCY3pv1m32+jX5xTvYl5wQ4l+PptyOJ0sVAc8eDPCrEZH7rp+4oFwmLCdNlTtv6PzFU8ZzdHd6XJGRqHS1WC+CEL8Mf0EckhBXWZHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438945; c=relaxed/simple;
	bh=RJkOf5CDUIBk2ozK175hlJPLWWxty9134RuVHe3gPDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOqLWBcXYN24JHZOsm59nQVkMd/wTxS7kakFaRmURQrpgLpxWqp5KxbeI6HpmAqhlzMl01tklbBQoknxdf0WPYxg+bDT9D3mIhCR43VYMNNE/4aC0Abv+8eKr7wfbub8UDYjoJmnhxC0yt8m80acESi4XljeIbP6UNEFwDRurJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRyx3gLr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRyx3gLr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso9456805e9.2
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776438941; x=1777043741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnSnTQuZj0MSBfRtYHAPLqTmapVao/3BioDEmxEz/lU=;
        b=DRyx3gLr1ouYTOlEFniuMpivCvaL66fkmUQ1m9UV/GzhZsvOIS5mis5cCWhd7Wa6qc
         IDdfHfi3h5J+S3uL9T4tcnZNHCYUr4A1g9WL8Jm3Ft36qUzCpom5vq3VUcz0LK3sGMqc
         ZTY4i3a4Puw/JmRMtmUbQq8VOuP0ybGyFKdwTAgjmyzU/bXx2j6NSJsSLbqMW3UEoyXH
         lsjZpnPU1NneoJLmV//IFt6zjZtossNo3MwAdRNK9uJwriQ5J3aOqqJUXTEch6meETpK
         MkmUIJZqZNTBME3nhvpQCqj74dBsMtb/rt/n94mEXyTciC3A8UMUh+7HczJtbxiW/Yiq
         WU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438941; x=1777043741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnSnTQuZj0MSBfRtYHAPLqTmapVao/3BioDEmxEz/lU=;
        b=bqOiDKjO14FylZICnVaeRsMTvTANoptk8xNsJerDQdH42XIW91xOD/Qr4O2Cu6pb2p
         GYbSyvu8EM9abeNDffk+DfYXzIRVoJ0+A4Dpw7GDgQPHw+sRb/rGjXwPADTxo3gm1jRK
         fVNlU/Ef3dInOFrbvPXbNiD73EW7+W+UZVr+b2x36MRiq51hkHzdcmyV3GBgAUaMp9HN
         JbIjEDnNhGIAc4bOFGJMKTB+LabYTlwCvK9qbruRz2nJdCkaWCOuwv6INsz7jmaXlUM9
         HSy/Iebnzw54HMubuFgHqYa7pkrqJMhVjPtq8dU4vwWgAhDHX1Hwkf835AgoGaaQKy2t
         DasQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wqFkckI45rF3ULn2OMK+ea9JXGRn4njdjmWvwmJAJKphoDDcE5IfYS+1wWfUmaxkElXRZE4xIpTFBiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoWyHo2RdAF6+lgWX5Zmk/yXgcuC+McInDfc1x9efx2EOLkZu
	99NtcNp+fH5yc0C9thcQ/MdDbHOVbR8yRoL1xXCXHXrmnUP3FI4xSPCM
X-Gm-Gg: AeBDiesjP/kwKN9lJvnr7yjX9a+Q+ssFpk4MFuUHx9b+TLnDEqgp80LgGyULoHZXrtk
	StviDMXh9L0Of3dcR2sKSIWKlwxBC0HW0nTSWvXPs9YxATbkgI+gWgbgQvwu6MpEgXWMvv9du2v
	gGEBjcLH9OdbJomfJeve7Q1UbBdNEBsVBk7jUWgT2c3GQ8TrR00U4A0Hj6w2dGvvvOVAnJFB+BP
	Ezmt8Ewskzs02V4KuN1p0SXKOxcXcjtY68a9pumWvjh2XQw/oGv8c4arZ1zS8jm8TuuLxhvWEOt
	EKHqzio7ZcgN6NQEvvd8XhAchaI0CrcreQGs3NcKDsKhfIsFh5Ex9S7KmDfMcw/i8yzWyB+vMR1
	iUK8qTjph8+bDw4LVFR3TTXQnOmLE40RDME8rzp8T0pe0cn3HceH4AGQXoPj/ocHuSqqJtYA/HX
	PV30aCosQrFdXz/bT4ZlVtNNIFDGLYKMBzkwGIC+zjYqyc4GdaPeN0Tbye0Pdd3sPBoqpbqoIDB
	/gVnE4+MnddfUHnkkE=
X-Received: by 2002:a05:600c:5246:b0:487:219e:42d with SMTP id 5b1f17b1804b1-488fb750a1dmr49873175e9.11.1776438941279;
        Fri, 17 Apr 2026 08:15:41 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm19611425e9.3.2026.04.17.08.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:15:39 -0700 (PDT)
Date: Fri, 17 Apr 2026 23:15:33 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Michael Wu <michael@allwinnertech.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix deadlock between blk_mq_freeze_queue and
 blk_mq_dispatch_list
Message-ID: <aeJOlfc8ofjnXByU@fedora>
References: <20260417082744.30124-1-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417082744.30124-1-michael@allwinnertech.com>

On Fri, Apr 17, 2026 at 04:27:44PM +0800, Michael Wu wrote:
> Kernel: Linux version 6.18.16
> Platform: Android
> 
> A three-way deadlock can occur between blk_mq_freeze_queue and
> blk_mq_dispatch_list involving percpu_ref reference counting and rwsem
> synchronization:
> 
> - Task A holds io_rwsem (e.g., F2FS write path) and enters __bio_queue_enter(),
>   where it acquires percpu_ref and waits for mq_freeze_depth==0
> - Task B holds mq_freeze_depth=1 (elevator_change) and waits for
>   q_usage_counter to reach zero in blk_mq_freeze_queue_wait()
> - Task C is scheduled out via schedule() while waiting for io_rwsem.
>   Before switching, __blk_flush_plug() triggers blk_mq_dispatch_list()
>   which acquires percpu_ref via percpu_ref_get(). If preempt_schedule_notrace()
>   is triggered before percpu_ref_put(), Task C holds the reference while
>   blocked on the rwsem.
> 
> Since Task C cannot release its percpu_ref while blocked, Task B cannot
> unfreeze the queue, and Task A cannot proceed to release the io_rwsem,
> creating a circular dependency deadlock.
> 
> Change:
> Fix by disabling preemption in blk_mq_dispatch_list() when called from
> schedule() (from_sched=true), ensuring percpu_ref_get() and percpu_ref_put()
> are atomic with respect to context switches. With from_sched=true,
> blk_mq_run_hw_queue() dispatches asynchronously via kblockd, so no driver
> callbacks run in this context and preempt_disable() is safe.
> 
> Detailed scenario description:
> When process 1838 performs f2fs_submit_page_write, it obtains io_rwsem via
> f2fs_down_write_trace. When process 1865 performs f2fs_down_write_trace and
> wants to obtain io_rwsem, it needs to wait for process 1838 to release it,
> so it can only be scheduled out via schedule. Before being scheduled out,
> it clears the plug via __blk_flush_plug, so it will run to blk_mq_dispatch_list.
> Process 619 is modifying the I/O scheduling algorithm, calling elevator_change
> to set mq_freeze_depth=1. After that, blk_mq_freeze_queue_wait will wait for
> the reference count of q_usage_counter to return to zero. Coincidentally,
> process 1838 needs to wait for mq_freeze_depth=0 when it reaches
> __bio_queue_enter, so it can only wait to be woken up after q_freeze_depth=0.
> At this time, process 1865, when blk_mq_dispatch_list reaches the point where
> percpu_ref_get increments the q_usage_counter reference, and before
> percpu_ref_put, it calls preempt_schedule_notrace to schedule the process out
> due to preemption, causing q_usage_counter to never reach zero.
> 
> At this point, process 1865 depends on io_rwsem to wake up, process 1838
> depends on mq_freeze_depth=0 to wake up, and process 619 depends on
> q_usage_counter being zero to wake up and unfreeze (setting mq_freeze_depth=0),
> resulting in a deadlock between these three processes.
> 
> Stack traces from the deadlock:
> 
> Task 1838 (Back-P10-3) - holds io_rwsem, waiting for queue unfreeze:
> Call trace:
>  __switch_to+0x1a4/0x35c
>  __schedule+0x8e0/0xec4
>  schedule+0x54/0xf8
>  __bio_queue_enter+0xbc/0x19c
>  blk_mq_submit_bio+0x118/0x814
>  __submit_bio+0x9c/0x234
>  submit_bio_noacct_nocheck+0x10c/0x2d4
>  submit_bio_noacct+0x354/0x544
>  submit_bio+0x1e8/0x208
>  f2fs_submit_write_bio+0x44/0xe4
>  __submit_merged_bio+0x40/0x114
>  f2fs_submit_page_write+0x3f0/0x7e0
>  do_write_page+0x180/0x2fc
>  f2fs_outplace_write_data+0x78/0x100
>  f2fs_do_write_data_page+0x3b8/0x500
>  f2fs_write_single_data_page+0x1ac/0x6e0
>  f2fs_write_data_pages+0x838/0xdfc
>  do_writepages+0xd0/0x19c
>  filemap_write_and_wait_range+0x204/0x274
>  f2fs_commit_atomic_write+0x54/0x960
>  __f2fs_ioctl+0x2128/0x42c8
>  f2fs_ioctl+0x38/0xb4
>  __arm64_sys_ioctl+0xa0/0xf4
> 
> Task 619 (android.hardwar) - holds mq_freeze_depth=1, waiting for percpu_ref:
> Call trace:
>  __switch_to+0x1a4/0x35c
>  __schedule+0x8e0/0xec4
>  schedule+0x54/0xf8
>  blk_mq_freeze_queue_wait+0x68/0xb0
>  blk_mq_freeze_queue_nomemsave+0x68/0x7c
>  elevator_change+0x70/0x14c
>  elv_iosched_store+0x1b0/0x234
>  queue_attr_store+0xe0/0x134
>  sysfs_kf_write+0x98/0xbc
>  kernfs_fop_write_iter+0x118/0x1e8
>  vfs_write+0x2e8/0x448
>  ksys_write+0x78/0xf0
>  __arm64_sys_write+0x1c/0x2c
> 
> Task 1865 (sp-control-1) - holds percpu_ref, preempted in dispatch_list:
> Call trace:
>  __switch_to+0x1a4/0x35c
>  __schedule+0x8e0/0xec4
>  preempt_schedule_notrace+0x60/0x7c
>  blk_mq_dispatch_list+0x5c0/0x690
>  blk_mq_flush_plug_list+0x13c/0x170
>  __blk_flush_plug+0x11c/0x17c
>  schedule+0x40/0xf8
>  schedule_preempt_disabled+0x24/0x40
>  rwsem_down_write_slowpath+0x61c/0xc88
>  down_write+0x3c/0x158
>  f2fs_down_write_trace+0x30/0x84
>  f2fs_submit_page_write+0x78/0x7e0
>  do_write_page+0x180/0x2fc
>  f2fs_outplace_write_data+0x78/0x100
>  f2fs_do_write_data_page+0x3b8/0x500
>  f2fs_write_single_data_page+0x1ac/0x6e0
>  f2fs_write_data_pages+0x838/0xdfc
>  do_writepages+0xd0/0x19c
>  filemap_write_and_wait_range+0x204/0x274
>  f2fs_commit_atomic_write+0x54/0x960
>  __f2fs_ioctl+0x2128/0x42c8
>  f2fs_ioctl+0x38/0xb4
>  __arm64_sys_ioctl+0xa0/0xf4
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  block/blk-mq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8f..c290bb12c1ecb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2936,6 +2936,14 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
>  	*rqs = requeue_list;
>  	trace_block_unplug(this_hctx->queue, depth, !from_sched);
> 
> +	/*
> +	 * When called from schedule(), prevent preemption and interrupts between
> +	 * ref_get and ref_put. This ensures percpu_ref_get() and percpu_ref_put()
> +	 * are atomic with respect to context switches, avoiding a deadlock with
> +	 * blk_mq_freeze_queue where a blocked task holds a percpu_ref reference.
> +	 */
> +	if (from_sched)
> +		local_irq_disable();
>  	percpu_ref_get(&this_hctx->queue->q_usage_counter);
>  	/* passthrough requests should never be issued to the I/O scheduler */
>  	if (is_passthrough) {
> @@ -2951,6 +2959,8 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
>  		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
>  	}
>  	percpu_ref_put(&this_hctx->queue->q_usage_counter);
> +	if (from_sched)
> +		local_irq_enable();
>  }

It looks one strange scheduler behavior, io_schedule_prepare() is scheduled out, and never scheduled
back. But the above code block can't sleep, so question why it doesn't get
chance to schedule back.

Can this issue be triggered on upstream kernel?

If it is really the reason, the fix may not work, because it can be
preempted before calling percpu_ref_get(), when requests in the plug list
actually grab queue usage counter too.

BTW, preempt_disable() should be enough. If it is really needed, the proper
callsite may be io_schedule_prepare().


Thanks, 
Ming
