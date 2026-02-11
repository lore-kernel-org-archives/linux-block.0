Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561B318EF4
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854386; cv=none; b=WB15fbc/L0cDy+JisUhBW7DluOqja1JdXDDSsi0tA2kLJxeieUsep+0PKcnj8zNAFuSTFW3/jsgblhJ3dEgpdB9a0cPFb4empj3ADR8SZ9qrIBXecXAmyg3moRN7g8nKKFPdGSY/fEAqGKUrJKRn76TbQJaXiQ24KfR7kmtB2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854386; c=relaxed/simple;
	bh=zRx7nVRKQ/AqMAnuDevh7KAI929T7Vn6lCmq49SEt/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP8Xqs3J2+Aoo3wYEnKgx2EgY8Pn7MsMCpK1pOcwz1YQBna7a1WGx0qXwrmTAIoP6DaZbaAI9vsjEzRyYTqumFHtwWwDacMTn7o2XbcimxAJCuki1hpFl8UBq9ceCx4wpaftThiu03TukDnaBDRuUyxa7pbguN1/Uilfn0OrKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FHvkiBM8; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FHvkiBM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1770854379;
	bh=VlCa2ouJtJnz/hPOA2UW0zncffyUYX2V5/hDOAOwG88=;
	h=From:Subject:Date:Message-ID;
	b=FHvkiBM8LCucq3kRTynS6XuuC4aVo0AfGoIomVChX6TwlyerS9JcqRGJqcm2D4n8n
	 aWDKxYR9jskaitNkaXKSYGFFhgE6b48nQ14ylbZuRWeRDRTpfCmIPepQZbv3nAEEoL
	 A5hy18CUg2skD/mZDGuRNKUx3mVtWRUZQ0pUMHOY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 698D17E1000044C6; Wed, 12 Feb 2026 07:59:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7266036685202
X-SMAIL-UIID: 85A447C7E9224D86A19CBCA7C0B2540F-20260212-075930-1
From: Hillf Danton <hdanton@sina.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu, 12 Feb 2026 07:59:17 +0800
Message-ID: <20260211235919.2955-1-hdanton@sina.com>
In-Reply-To: <20260211203928.324307-2-ionut.nechita@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Feb 2026 22:39:29 +0200
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering
> between checking QUEUE_FLAG_QUIESCED request adding") causes severe
> performance regression on systems with multiple MSI-X interrupt
> vectors.
> 
> The above change introduced spinlock_t queue_lock usage in
> blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks
> with blk_mq_unquiesce_queue(). While this works correctly in
> standard kernel, it causes catastrophic serialization in RT kernel
> where spinlock_t converts to sleeping rt_mutex.
> 
> Problem in RT kernel:
> - blk_mq_run_hw_queue() is called from IRQ thread context
> - With multiple MSI-X vectors, all IRQ threads contend on
>   the same queue_lock
> - queue_lock becomes rt_mutex (sleeping) in RT kernel
> - IRQ threads serialize and enter D-state waiting for lock
> - Throughput drops from 640 MB/s to 153 MB/s
> 
> Solution:
> Convert quiesce_depth to atomic_t and use it directly for quiesce
> state checking, eliminating QUEUE_FLAG_QUIESCED entirely. This
> removes the need for any locking in the hot path.
> 
> The atomic counter serves as both the depth tracker and the quiesce
> indicator (depth > 0 means quiesced). This eliminates the race
> window that existed between updating the depth and the flag.
> 
> Memory ordering is ensured by:
> - smp_mb__after_atomic() after modifying quiesce_depth
> - smp_rmb() before re-checking quiesce state in
>   blk_mq_run_hw_queue()
> 
> Performance impact:
> - RT kernel: eliminates lock contention, restores full throughput
> - Non-RT kernel: atomic ops are similar cost to the previous
>   spinlock acquire/release, no regression expected
> 
> Test results on RT kernel:
> Hardware: Broadcom/LSI MegaRAID 12GSAS/PCIe Secure SAS39xx
>   (megaraid_sas driver, 128 MSI-X vectors, 120 hw queues)
> - Before: 153 MB/s, IRQ threads in D-state
> - After:  640 MB/s, no IRQ threads blocked
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  block/blk-core.c       |  1 +
>  block/blk-mq-debugfs.c |  1 -
>  block/blk-mq.c         | 45 ++++++++++++++++--------------------------
>  include/linux/blkdev.h |  9 ++++++---
>  4 files changed, 24 insertions(+), 32 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 8387fe50ea15..4eea19426cc6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  	mutex_init(&q->limits_lock);
>  	mutex_init(&q->rq_qos_mutex);
>  	spin_lock_init(&q->queue_lock);
> +	atomic_set(&q->quiesce_depth, 0);
>  
>  	init_waitqueue_head(&q->mq_freeze_wq);
>  	mutex_init(&q->mq_freeze_lock);
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 4896525b1c05..c63fe8864248 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -89,7 +89,6 @@ static const char *const blk_queue_flag_name[] = {
>  	QUEUE_FLAG_NAME(INIT_DONE),
>  	QUEUE_FLAG_NAME(STATS),
>  	QUEUE_FLAG_NAME(REGISTERED),
> -	QUEUE_FLAG_NAME(QUIESCED),
>  	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
>  	QUEUE_FLAG_NAME(HCTX_ACTIVE),
>  	QUEUE_FLAG_NAME(SQ_SCHED),
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 968699277c3d..1e0f5a311bef 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -260,12 +260,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
>   */
>  void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&q->queue_lock, flags);
> -	if (!q->quiesce_depth++)
> -		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	atomic_inc(&q->quiesce_depth);
> +	/*
> +	 * Ensure the store to quiesce_depth is visible before any
> +	 * subsequent loads in blk_mq_run_hw_queue().
> +	 */
> +	smp_mb__after_atomic();

Nope mb is not enough.

	int qd = atomic_read(&q->quiesce_depth);
	for (;;) {
		int v = qd + 1;
		if (atomic_try_cmpxchg(&q->quiesce_depth, &qd, v))
			break;
	}

More important however, why not send this patch to the RT tree instead, given
the spin lock is good and correct in mainline. By good I mean fixing RT stuff
in the mainline is not encouraged.

>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> @@ -314,21 +314,18 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>   */
>  void blk_mq_unquiesce_queue(struct request_queue *q)
>  {
> -	unsigned long flags;
> -	bool run_queue = false;
> +	int depth;
>  
> -	spin_lock_irqsave(&q->queue_lock, flags);
> -	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
> -		;
> -	} else if (!--q->quiesce_depth) {
> -		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> -		run_queue = true;
> -	}
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	depth = atomic_dec_if_positive(&q->quiesce_depth);
> +	if (WARN_ON_ONCE(depth < 0))
> +		return;
>  
> -	/* dispatch requests which are inserted during quiescing */
> -	if (run_queue)
> +	if (depth == 0) {
> +		/* Ensure the decrement is visible before running queues */
> +		smp_mb__after_atomic();
> +		/* dispatch requests which are inserted during quiescing */
>  		blk_mq_run_hw_queues(q, true);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>  
> @@ -2352,17 +2349,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  
>  	need_run = blk_mq_hw_queue_need_run(hctx);
>  	if (!need_run) {
> -		unsigned long flags;
> -
> -		/*
> -		 * Synchronize with blk_mq_unquiesce_queue(), because we check
> -		 * if hw queue is quiesced locklessly above, we need the use
> -		 * ->queue_lock to make sure we see the up-to-date status to
> -		 * not miss rerunning the hw queue.
> -		 */
> -		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> +		/* Pairs with smp_mb__after_atomic() in blk_mq_unquiesce_queue() */
> +		smp_rmb();
>  		need_run = blk_mq_hw_queue_need_run(hctx);
> -		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
>  
>  		if (!need_run)
>  			return;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 72e34acd439c..9ad725af81f6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -516,7 +516,8 @@ struct request_queue {
>  
>  	spinlock_t		queue_lock;
>  
> -	int			quiesce_depth;
> +	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
> +	atomic_t		quiesce_depth;
>  
>  	struct gendisk		*disk;
>  
> @@ -660,7 +661,6 @@ enum {
>  	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
>  	QUEUE_FLAG_STATS,		/* track IO start and completion times */
>  	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
> -	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
>  	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
>  	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
>  	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
> @@ -697,7 +697,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
>  #define blk_noretry_request(rq) \
>  	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
>  			     REQ_FAILFAST_DRIVER))
> -#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
> +static inline bool blk_queue_quiesced(struct request_queue *q)
> +{
> +	return atomic_read(&q->quiesce_depth) > 0;
> +}
>  #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>  #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
> -- 
> 2.53.0
