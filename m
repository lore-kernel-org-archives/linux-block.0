Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507834;
	b=f94Iuv3r3k/I/VMxyH0PXH3flmUXcBfd69QqaMaoX3HJ8VmhiuoM99f96xVF4iEl327m
	 V8AZK/idmfg6yMw+YsgfWVxNN8uRQ0McK+LYa2c+t9/WiWfY8NmznvUk13ZqUogqkm5xc
	 H2mbpNUnV+N0U9QWSQV0KtDbsA5PRF0dMSXq7f3zYRACWysbMxMeqBqUw09fRCyaRDzQO
	 rMYO3/qnP5TsPB7Bk3w80Xvr6K/13lF4ZL4TmmrhPAnwPhgPZ8CPaNueHMV9An6Wl8GKa
	 iOqxXxE5Hy8OaJ0enY6QRv31MyXbQ+CM//53QyFu2nyHgr4KhhYoYRFgwMgzvpE/IvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507834;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=foCLJesoWm3QzBy9ELfsrdo+c6gGoGO3ipPAiXL9nOY=;
	b=RXzn1qE+WrpjQKcqtSiBgYzfiRXXyIZBAe3NNLHvYPoYQKaNaRBkQ5FQqmu4YsflOdlv
	 Hwf8B9KLbzRY12CIc3s9EgaSfZeF0wVXw7CrOgA50FcbnsIvMzGPXuUSAfLo7pmNJDxFb
	 6nIFjzo5x293T3PXfrQghauBeR1wcUxoq3R/54I8atGZwGAoMvW18IsnpAM13+PRKQUJ5
	 TYVWzpyuXTUKE8hGzOLP5VSB38aCxHbWOLKY4Ex2ABoCBYDYTx7olOM2FcBHOW/Mq4FLV
	 HlTsEg6/98lQ9ftDKPq2XAQm1f1DPXKmNkq19BZ1w8Aj31Kl+cnNxpasUwvVuf15wEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N1hpcRdY;
	arc=none smtp.remote-ip=95.215.58.130
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B7606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 08:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N1hpcRdY
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9PWFsZj6oW7Qk4IFGriVk9yj4L3NIraIxedXhb1M7oM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795507831; v=1; x=1796112631;
 b=N1hpcRdYqX5YzNPHmllr8epCYP/dSNs9i7iqowjunULOGH/cj/oJQxLqyOCRzu02ITiby349
 V8EhS4cpEzj0Ya+CFf9LDMEgbj5owXEcSnOevCfsvcV6XVHEHCh4DhBa8O3enNWhqpKXwO3kg7A
 +XEYLuV2gq8AUGWU6X/LDZ5Q=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a86c1e445007e1e;
	Tue, 24 Nov 2026 08:10:28 +0000
X-Mizu-Trace-ID: 2a86c1e445007e1e
X-Migadu-Flow: FLOW_OUT
Message-ID: <b48806fb-22a5-40da-a682-22e010c8316d@linux.dev>
Date: Tue, 24 Nov 2026 16:10:10 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v7] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20261124031238.555291-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261124031238.555291-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Bart,

在 2026/11/24 11:12, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs, such
> as bio splitting reading max_hw_sectors and the discard path reading
> max_hw_discard_sectors, letting them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue around the limits update.  The
> pending modes live under a new mutex, lo->clear_limits_lock, guarded
> by a backing-file check that drops records from a racing unbind or
> rebind.  Requests that arrive while the clear is in flight fail
> quietly, so the console report stays at the first failure.  The work
> item is cancelled before the backing file changes and before the
> device is freed.
> 
Sashiko's automated review pointed out a hole in the quiet marking in v7 [1], and after looking into it, I believe the report is correct.

Marking requests quiet at queue_rq() time misses two cases. Requests submitted in a batch can all pass loop_queue_rq() before the first failure records the verdict. Also, bios that are already inside submit_bio_noacct() when the queue freezes have already passed their limits check; they resume from bio_queue_enter() after loop_clear_limits_workfn() clears the pending flag and still report the same failure. Both cases can produce repeated console messages.

I can reproduce this with eight threads issuing concurrent write-zeroes to a tmpfs-backed loop device: v7 logs two errors where loop/011 expects exactly one.

For v8, my plan is to stop deciding whether to quiet a request at queue_rq() time and instead quiet repeated failures at the point of failure. The verdicts remain recorded for the lifetime of the backing file and are cleared only on rebind or unbind. loop_clear_limits() reports whether a verdict is new, and repeated failures mark only their own request quiet. That guarantees the first failure for each mode is reported, regardless of how dispatch and queue freezing interleave.

With this change, the same eight-thread test logs exactly one error.

Does this approach look reasonable to you? If so, I'll send the already tested patch as v8.

Thanks,
Tao

[1] https://sashiko.dev/#/patchset/20261124031238.555291-1-cui.tao@linux.dev

> Fixes: 5f75e081ab5c ("loop: Disable fallocate() zero and discard if not supported")
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/block/loop.c | 91 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 82 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 194f51d9dab6..d15ccb339f03 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -67,6 +67,10 @@ struct loop_device {
>  	struct list_head        rootcg_cmd_list;
>  	struct list_head        idle_worker_list;
>  	struct rb_root          worker_tree;
> +	struct work_struct      clear_limits_work;
> +	struct mutex		clear_limits_lock;
> +	unsigned int		clear_limits_mode;
> +	bool			clear_limits_pending;
>  	struct timer_list       timer;
>  	bool			sysfs_inited;
>  
> @@ -222,9 +226,25 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
>  		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  }
>  
> -static void loop_clear_limits(struct loop_device *lo, int mode)
> +static void loop_clear_limits_workfn(struct work_struct *work)
>  {
> +	struct loop_device *lo =
> +		container_of(work, struct loop_device, clear_limits_work);
>  	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> +	unsigned int memflags;
> +	int mode;
> +
> +	/*
> +	 * Requests that arrive while this clear is in flight are failed
> +	 * quietly (see loop_queue_rq); once the limits have been
> +	 * committed, further ones are rejected early at submission.
> +	 */
> +	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	mutex_lock(&lo->clear_limits_lock);
> +	mode = lo->clear_limits_mode;
> +	lo->clear_limits_mode = 0;
> +	WRITE_ONCE(lo->clear_limits_pending, false);
> +	mutex_unlock(&lo->clear_limits_lock);
>  
>  	if (mode & FALLOC_FL_ZERO_RANGE)
>  		lim.max_write_zeroes_sectors = 0;
> @@ -234,14 +254,27 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
>  		lim.discard_granularity = 0;
>  	}
>  
> -	/*
> -	 * XXX: this updates the queue limits without freezing the queue, which
> -	 * is against the locking protocol and dangerous.  But we can't just
> -	 * freeze the queue as we're inside the ->queue_rq method here.  So this
> -	 * should move out into a workqueue unless we get the file operations to
> -	 * advertise if they support specific fallocate operations.
> -	 */
>  	queue_limits_commit_update(lo->lo_queue, &lim);
> +	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +}
> +
> +static void loop_clear_limits(struct loop_device *lo, struct file *file,
> +			      int mode)
> +{
> +	mutex_lock(&lo->clear_limits_lock);
> +	if (lo->lo_backing_file != file) {
> +		/*
> +		 * The recording request was racing with an unbind or a
> +		 * rebinding; its verdict is about a backing file that is
> +		 * no longer current.  Drop it.
> +		 */
> +		mutex_unlock(&lo->clear_limits_lock);
> +		return;
> +	}
> +	lo->clear_limits_mode |= mode;
> +	WRITE_ONCE(lo->clear_limits_pending, true);
> +	mutex_unlock(&lo->clear_limits_lock);
> +	schedule_work(&lo->clear_limits_work);
>  }
>  
>  static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> @@ -269,7 +302,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	 * supported and clear them here if that turns out not to be true.
>  	 */
>  	if (unlikely(ret == -EOPNOTSUPP))
> -		loop_clear_limits(lo, mode);
> +		loop_clear_limits(lo, file, mode);
>  
>  	return ret;
>  }
> @@ -514,6 +547,15 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
>  {
>  	lo->lo_backing_file = file;
> +	/*
> +	 * Discard any modes recorded against the old backing file.  The
> +	 * paths that can race with a pending work item cancel it before
> +	 * they get here.
> +	 */
> +	mutex_lock(&lo->clear_limits_lock);
> +	lo->clear_limits_mode = 0;
> +	WRITE_ONCE(lo->clear_limits_pending, false);
> +	mutex_unlock(&lo->clear_limits_lock);
>  	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
>  	mapping_set_gfp_mask(file->f_mapping,
>  			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
> @@ -1035,6 +1077,21 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	lo->lo_backing_file = NULL;
>  	spin_unlock_irq(&lo->lo_lock);
>  
> +	/*
> +	 * Discard and write-zeroes requests are submitted synchronously,
> +	 * but a fatal signal can kill the submitting task between the
> +	 * per-bio completions of a multi-bio range, leaving requests in
> +	 * flight across this unbind.  Cancel any clear they have
> +	 * scheduled and reset the modes; loop_clear_limits() also drops
> +	 * records whose backing file is no longer current, so stragglers
> +	 * arriving after a later loop_configure() cannot affect it.
> +	 */
> +	cancel_work_sync(&lo->clear_limits_work);
> +	mutex_lock(&lo->clear_limits_lock);
> +	lo->clear_limits_mode = 0;
> +	WRITE_ONCE(lo->clear_limits_pending, false);
> +	mutex_unlock(&lo->clear_limits_lock);
> +
>  	lo->lo_device = NULL;
>  	lo->lo_offset = 0;
>  	lo->lo_sizelimit = 0;
> @@ -1700,6 +1757,7 @@ static void lo_free_disk(struct gendisk *disk)
>  	loop_free_idle_workers(lo, true);
>  	timer_shutdown_sync(&lo->timer);
>  	mutex_destroy(&lo->lo_mutex);
> +	mutex_destroy(&lo->clear_limits_lock);
>  	kfree(lo);
>  }
>  
> @@ -1802,9 +1860,19 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	switch (req_op(rq)) {
>  	case REQ_OP_FLUSH:
> +		cmd->use_aio = false;
> +		break;
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
>  		cmd->use_aio = false;
> +		/*
> +		 * A pending limits clear means this operation is already
> +		 * known to be unsupported and the commit will make later
> +		 * attempts fail early at submission.  Fail quietly so only
> +		 * the first failure reports to the console.
> +		 */
> +		if (READ_ONCE(lo->clear_limits_pending))
> +			rq->rq_flags |= RQF_QUIET;
>  		break;
>  	default:
>  		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
> @@ -2018,6 +2086,8 @@ static int loop_add(int i)
>  	spin_lock_init(&lo->lo_lock);
>  	spin_lock_init(&lo->lo_work_lock);
>  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
> +	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
> +	mutex_init(&lo->clear_limits_lock);
>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
>  	disk->major		= LOOP_MAJOR;
>  	disk->first_minor	= i << part_shift;
> @@ -2056,6 +2126,9 @@ static int loop_add(int i)
>  
>  static void loop_remove(struct loop_device *lo)
>  {
> +	/* Cancel before the queue becomes unreachable. */
> +	cancel_work_sync(&lo->clear_limits_work);
> +
>  	/* Make this loop device unreachable from pathname. */
>  	del_gendisk(lo->lo_disk);
>  	blk_mq_free_tag_set(&lo->tag_set);

