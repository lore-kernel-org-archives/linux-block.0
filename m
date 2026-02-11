Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D00313E0D;
	Wed, 11 Feb 2026 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809481; cv=none; b=UqslqKiy3pC4dnn1CBe5vQm4TK5KknCaEyE87OFpIEIW6bm5dcAgvtShVP80IEgeDAzLD5MdwqfNGKNoOmliObECOYVUGvbXSQ0xGeHCEpIa106gO4qXZJBRmJqPNmE3pWT5FhJFjiDRrN8vUSZ+0y5H1y3eViWuitV56sC9jeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809481; c=relaxed/simple;
	bh=r6Oj5uSMc1lzIWi/mj5FIh7uqMehtkOa6MRoztKgJFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8ztHOfdUds3IyE2rW4BQJfcv8cKHS7+uH7Lap4faMriWJW9Cx7MKNQDPXQFEblU2j3CqpYcoeZlfGIFruwrUtGiw8g6WK/otUA/DwrdWJodfaVUJ1HoixeMsCBKbWYkoCrPAnNF276J3TkxyNll6CyShrVrYYehVxB732uBKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sXGHG1T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPcwiIyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sXGHG1T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPcwiIyx"
Date: Wed, 11 Feb 2026 12:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770809469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KNAYpsr5sQNu+uU2DhYy3Ytlt/Qx3h50xN9qAwhfg3Q=;
	b=0sXGHG1T0hKhVFy0Xc0FuppkYJ+mihrldsIu/Nw3sGMS4955Y1s+w2yOJlOL7EMC9TZgQ1
	xz7H+uNEppsA6gTNTIilzVwMgWeeEAljq1lcURTpO9pGsdl3uiNrwPgVbisDScM8JMhuyE
	IN5rj+nwXNPlUbz5LxN/nylxY1OkDvNV03TQUZeW2xV7auZAp2nYXi91LF3eyuVYy69OfR
	1Sp5q4jA+RYWAghnuyaiVsOZDgFM5feaFwRv6jPJ9485ZH03iel7N02Lmp6yjBq5nRcFIu
	bO3AE34/EDK5KiEovSLv8VLxva/41fYe4f8aT25NrcDzqxL12iIYPX0Tkc1nvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770809469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KNAYpsr5sQNu+uU2DhYy3Ytlt/Qx3h50xN9qAwhfg3Q=;
	b=yPcwiIyx4Ft1OHoFej6cBLlvAzRLr18f+CbpRKPhkNe4zlPcK4iWYXZXr22+sXRg+B4khD
	ZXj+HQzIR6i5tgBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, sunlightlinux@gmail.com,
	chris.friesen@windriver.com, stable@vger.kernel.org,
	ionut_n2001@yahoo.com
Subject: Re: [PATCH v2 1/1] block/blk-mq: fix RT kernel regression with
 dedicated quiesce_sync_lock
Message-ID: <20260211113107.NjjnR0HT@linutronix.de>
References: <20260210204943.21709-3-ionut.nechita@windriver.com>
 <20260210204943.21709-5-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210204943.21709-5-ionut.nechita@windriver.com>

On 2026-02-10 22:49:46 [+0200], Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering
> between checking QUEUE_FLAG_QUIESCED request adding") causes severe
> performance regression on systems with multiple MSI-X interrupt vectors.
> 
> The above change added spinlock_t queue_lock to blk_mq_run_hw_queue()
> to synchronize QUEUE_FLAG_QUIESCED checks with blk_mq_unquiesce_queue().
> While this works correctly in standard kernel, it causes catastrophic
> serialization in RT kernel where spinlock_t converts to sleeping
> rt_mutex.

So !RT has the same synchronisation on the lock but spinning on the lock
makes it less dramatic?

> Problem in RT kernel:
> - blk_mq_run_hw_queue() is called from IRQ thread context (I/O completion)
> - With 8 MSI-X vectors, all 8 IRQ threads contend on the same queue_lock
> - queue_lock becomes rt_mutex (sleeping) in RT kernel
> - IRQ threads serialize and enter D-state waiting for lock
> - Throughput drops from 640 MB/s to 153 MB/s
> 
> The original commit message noted that memory barriers were considered
> but rejected because "memory barrier is not easy to be maintained" -
> barriers would need to be added at multiple call sites throughout the
> block layer where work is added before calling blk_mq_run_hw_queue().
> 
> Solution:
> Instead of using the general-purpose queue_lock or attempting complex
> memory barrier pairing across many call sites, introduce a dedicated
> raw_spinlock_t quiesce_sync_lock specifically for synchronizing the
> quiesce state between:
> - blk_mq_quiesce_queue_nowait()
> - blk_mq_unquiesce_queue()
> - blk_mq_run_hw_queue()
> 
> Why raw_spinlock is safe:
> - Critical section is provably short (only flag and counter checks)
> - No sleeping operations under lock
> - raw_spinlock does not convert to rt_mutex in RT kernel
> - Provides same ordering guarantees as original queue_lock approach

Okay.

> This approach:
> - Maintains correctness of original synchronization
> - Avoids sleeping in RT kernel's IRQ thread context
> - Limits scope to only quiesce-related synchronization
> - Simpler than auditing all call sites for memory barrier pairing
> 
> Additionally, change blk_freeze_queue_start to use async=true for better
> performance in RT kernel by avoiding synchronous queue runs during freeze.
> 
> Test results on RT kernel (megaraid_sas with 8 MSI-X vectors):
> - Before: 153 MB/s, 6-8 IRQ threads in D-state
> - After:  640 MB/s, 0 IRQ threads blocked
> 
> Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  block/blk-core.c       |  1 +
>  block/blk-mq.c         | 27 ++++++++++++++++-----------
>  include/linux/blkdev.h |  6 ++++++
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 474700ffaa1c8..fd615aeb5c463 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  	mutex_init(&q->limits_lock);
>  	mutex_init(&q->rq_qos_mutex);
>  	spin_lock_init(&q->queue_lock);
> +	raw_spin_lock_init(&q->quiesce_sync_lock);
>  
>  	init_waitqueue_head(&q->mq_freeze_wq);
>  	mutex_init(&q->mq_freeze_lock);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0ad3dd3329db7..888718a782f88 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -171,7 +171,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
>  		percpu_ref_kill(&q->q_usage_counter);
>  		mutex_unlock(&q->mq_freeze_lock);
>  		if (queue_is_mq(q))
> -			blk_mq_run_hw_queues(q, false);
> +			blk_mq_run_hw_queues(q, true);

I read what you wrote to Keith here and still don't get it. If the goal
is to have the same lock contention on RT as on !RT (where we spin on
the lock) why not keep everything else as-is? Why is important to spread
it across multiple CPUs? This looks unrelated. It could be added as a
second optimisation.

Another thing: If you have multiple interrupts, why don't you have one
queue per interrupt? Wouldn't this also avoid the spinning here?

>  	} else {
>  		mutex_unlock(&q->mq_freeze_lock);
>  	}
> @@ -262,10 +262,10 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&q->queue_lock, flags);
> +	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);
>  	if (!q->quiesce_depth++)
>  		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);

Since you have only "inc and set bit if was zero" and below "dec and
clear bit if become zero" what about using atomic_t for quiesce_depth?
There is atomic_inc_return() mostly doing the same thing with one atomic
op. That flag could be avoided if the the blk_queue_quiesced() condition
is "quiesce_depth > 0". That could avoid the lock.

>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> @@ -317,14 +317,14 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>  	unsigned long flags;
>  	bool run_queue = false;
>  
> -	spin_lock_irqsave(&q->queue_lock, flags);
> +	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);
>  	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
>  		;
>  	} else if (!--q->quiesce_depth) {
>  		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>  		run_queue = true;
>  	}
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);
>  
>  	/* dispatch requests which are inserted during quiescing */
>  	if (run_queue)
> @@ -2368,14 +2368,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  		unsigned long flags;
>  
>  		/*
> -		 * Synchronize with blk_mq_unquiesce_queue(), because we check
> -		 * if hw queue is quiesced locklessly above, we need the use
> -		 * ->queue_lock to make sure we see the up-to-date status to
> -		 * not miss rerunning the hw queue.
> +		 * Synchronize with blk_mq_unquiesce_queue(). We check if hw
> +		 * queue is quiesced locklessly above, so we need to use
> +		 * quiesce_sync_lock to ensure we see the up-to-date status
> +		 * and don't miss rerunning the hw queue.
> +		 *
> +		 * Uses raw_spinlock to avoid sleeping in RT kernel's IRQ
> +		 * thread context during I/O completion. Critical section is
> +		 * short (only flag and counter checks), making raw_spinlock
> +		 * safe.
>  		 */
> -		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> +		raw_spin_lock_irqsave(&hctx->queue->quiesce_sync_lock, flags);
>  		need_run = blk_mq_hw_queue_need_run(hctx);
> -		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> +		raw_spin_unlock_irqrestore(&hctx->queue->quiesce_sync_lock, flags);

but here I am unsure. If the above operation (setting/ clearing the bit)
is lockless it might require a handshake if the counter goes back to 0
before it is visible here. Maybe not since it could be observed before
the lock was acquired. That is why I am unsure.

>  		if (!need_run)
>  			return;

Sebastian
