Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B14C433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF68C207DE
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHUUOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:14:47 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37247 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgHUUOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:14:45 -0400
Received: by mail-pj1-f67.google.com with SMTP id mw10so1284218pjb.2
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faLgJdBzkG9FIKDxfxy2Y68WPY6vw9Aur6g1fJSjBdQ=;
        b=TfAq/svoRuwpsEPdChhp0XhNG8Dfecd9jD0G3K/P+ydq9kVOi+NjsofFanKIAaHWLg
         wUrT8b3bRCjEZF7pnh7l6QQ/Zj/3v43lbSZ2ZQl3lqDhatJJR26WeUuYvyy+Zis5Sx0d
         d1KhJInk3ReC+j+2KPXQux4GWpUo0BxTTGZRub41tnfN9Jg20Z2dNpmVrjX/UH6/cXFX
         Os++au02K1vpEXnjphEvfRe44FY0kG0x7/Oh9MfQb9G1p9rlC73TCNe9mUv6mQ8t4r5o
         ME3R0xS5muZugYj9t5Dq4SwbvKzQRJljGBal0ewpoPEObGvtz1WodmY14MT9vG2q74OO
         ylNQ==
X-Gm-Message-State: AOAM530UJ0HKgPS0gMPSh4+QIkMGgeE57vEHmBXYX9auF9Wa2Rh5vFPg
        w4g6SugbpneDuqkouxkptlI=
X-Google-Smtp-Source: ABdhPJxHp0hnW6NvlMq6i30IZ5FSYcur3PStDsQNIkYTzdQ+YLsAxUJBiy6uoaocQh6JFmUrriQHdg==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr2878308pjh.230.1598040883755;
        Fri, 21 Aug 2020 13:14:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712? ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
        by smtp.gmail.com with ESMTPSA id c15sm3438098pfo.115.2020.08.21.13.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:14:43 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
Date:   Fri, 21 Aug 2020 13:14:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820030248.2809559-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
> section during dispatching request, then request queue quiesce is based on
> SRCU. What we want to get is low cost added in fast path.
> 
> With percpu-ref, it is cleaner and simpler & enough for implementing queue
> quiesce. The main requirement is to make sure all read sections to observe
> QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
> 
> Also it becomes much easier to add interface of async queue quiesce.
> 
> Meantime memory footprint can be reduced with per-request-queue percpu-ref.
> 
>  From implementation viewpoint, in fast path, not see percpu_ref is
> slower than SRCU, and srcu tree(default option in most distributions)
> could be slower since memory barrier is required in both lock & unlock,
> and rcu_read_lock()/rcu_read_unlock() should be much cheap than
> smp_mb().
> 
> 1) percpu_ref just hold the rcu_read_lock, then run a check &
>     increase/decrease on the percpu variable:
> 
>     rcu_read_lock()
>     if (__ref_is_percpu(ref, &percpu_count))
> 	this_cpu_inc(*percpu_count);
>     rcu_read_unlock()
> 
> 2) srcu tree:
>          idx = READ_ONCE(ssp->srcu_idx) & 0x1;
>          this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
>          smp_mb(); /* B */  /* Avoid leaking the critical section. */
> 
> Also from my test on null_blk(blocking), not observe percpu-ref performs
> worse than srcu, see the following test:
> 
> 1) test steps:
> 
> rmmod null_blk > /dev/null 2>&1
> modprobe null_blk nr_devices=1 submit_queues=1 blocking=1
> fio --bs=4k --size=512G  --rw=randread --norandommap --direct=1 --ioengine=libaio \
> 	--iodepth=64 --runtime=60 --group_reporting=1  --name=nullb0 \
> 	--filename=/dev/nullb0 --numjobs=32
> 
> test machine: HP DL380, 16 cpu cores, 2 threads per core, dual
> sockets/numa, Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz
> 
> 2) test result:
> - srcu quiesce: 6063K IOPS
> - percpu-ref quiesce: 6113K IOPS
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>
> 
> ---
> V1:
> 	- remove SRCU related comment
> 	- remove RFC
> 	- not dispatch when the dispatch percpu ref becomes not live
> 	- add test result on commit log
> 
>   block/blk-mq-sysfs.c   |   2 -
>   block/blk-mq.c         | 104 ++++++++++++++++++++---------------------
>   block/blk-sysfs.c      |   6 ++-
>   include/linux/blk-mq.h |   7 ---
>   include/linux/blkdev.h |   4 ++
>   5 files changed, 61 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 062229395a50..799db7937105 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -38,8 +38,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
>   
>   	cancel_delayed_work_sync(&hctx->run_work);
>   
> -	if (hctx->flags & BLK_MQ_F_BLOCKING)
> -		cleanup_srcu_struct(hctx->srcu);
>   	blk_free_flush_queue(hctx->fq);
>   	sbitmap_free(&hctx->ctx_map);
>   	free_cpumask_var(hctx->cpumask);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6294fa5c7ed9..e198bd565109 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -220,19 +220,13 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>    */
>   void blk_mq_quiesce_queue(struct request_queue *q)
>   {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> -
>   	blk_mq_quiesce_queue_nowait(q);
>   
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> -	}
> -	if (rcu)
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING) {
> +		percpu_ref_kill(&q->dispatch_counter);
> +		wait_event(q->mq_quiesce_wq,
> +				percpu_ref_is_zero(&q->dispatch_counter));

Looking at the q_usage_counter percpu, it's protected with the
mq_freeze_lock and mq_freeze_depth, the fact that it's not protected
here makes this non-nesting, which scares me... We had issues before
in this area...

> +	} else
>   		synchronize_rcu();
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
> @@ -248,6 +242,9 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   {
>   	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>   
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +		percpu_ref_resurrect(&q->dispatch_counter);

Same comment here...

> +
>   	/* dispatch requests which are inserted during quiescing */
>   	blk_mq_run_hw_queues(q, true);
>   }
> @@ -699,24 +696,21 @@ void blk_mq_complete_request(struct request *rq)
>   }
>   EXPORT_SYMBOL(blk_mq_complete_request);
>   
> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
>   {
>   	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>   		rcu_read_unlock();
>   	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> +		percpu_ref_put(&hctx->queue->dispatch_counter);
>   }
>   
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> -	__acquires(hctx->srcu)
> +static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
>   {
>   	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
>   		rcu_read_lock();
> +		return true;
>   	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> +		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
>   }
>   
>   /**
> @@ -1495,8 +1489,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>    */
>   static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   {
> -	int srcu_idx;
> -
>   	/*
>   	 * We should be running this queue from one of the CPUs that
>   	 * are mapped to it.
> @@ -1530,9 +1522,10 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   
>   	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
>   
> -	hctx_lock(hctx, &srcu_idx);
> -	blk_mq_sched_dispatch_requests(hctx);
> -	hctx_unlock(hctx, srcu_idx);
> +	if (hctx_lock(hctx)) {
> +		blk_mq_sched_dispatch_requests(hctx);
> +		hctx_unlock(hctx);
> +	}

Maybe invert?
	if (!hctx_lock(hctx))
		return;
	blk_mq_sched_dispatch_requests(hctx);
	hctx_unlock(hctx);

I think we need a comment to why this is OK, both in the change log
and in the code.

>   }
>   
>   static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> @@ -1644,7 +1637,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>    */
>   void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   {
> -	int srcu_idx;
>   	bool need_run;
>   
>   	/*
> @@ -1655,10 +1647,12 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>   	 * quiesced.
>   	 */
> -	hctx_lock(hctx, &srcu_idx);
> +	if (!hctx_lock(hctx))
> +		return;
> +
>   	need_run = !blk_queue_quiesced(hctx->queue) &&
>   		blk_mq_hctx_has_pending(hctx);
> -	hctx_unlock(hctx, srcu_idx);
> +	hctx_unlock(hctx);
>   
>   	if (need_run)
>   		__blk_mq_delay_run_hw_queue(hctx, async, 0);
> @@ -1997,7 +1991,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   	bool run_queue = true;
>   
>   	/*
> -	 * RCU or SRCU read lock is needed before checking quiesced flag.
> +	 * hctx_lock() is needed before checking quiesced flag.
>   	 *
>   	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
>   	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
> @@ -2045,11 +2039,13 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   		struct request *rq, blk_qc_t *cookie)
>   {
>   	blk_status_t ret;
> -	int srcu_idx;
>   
>   	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
>   
> -	hctx_lock(hctx, &srcu_idx);
> +	if (!hctx_lock(hctx)) {
> +		blk_mq_sched_insert_request(rq, false, false, false);
> +		return;
> +	}

I think we want the same flow for both modes. Maybe a preparation patch
that lifts the checks in __blk_mq_try_issue_directly to do this, and
then have the same flow with the hctx_lock failure (with a comment
explaining this).

>   
>   	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
>   	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> @@ -2057,19 +2053,21 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   	else if (ret != BLK_STS_OK)
>   		blk_mq_end_request(rq, ret);
>   
> -	hctx_unlock(hctx, srcu_idx);
> +	hctx_unlock(hctx);
>   }
>   
>   blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>   {
>   	blk_status_t ret;
> -	int srcu_idx;
>   	blk_qc_t unused_cookie;
>   	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>   
> -	hctx_lock(hctx, &srcu_idx);
> +	if (!hctx_lock(hctx)) {
> +		blk_mq_sched_insert_request(rq, false, false, false);
> +		return BLK_STS_OK;
> +	}

Same comment here.

>   	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
> -	hctx_unlock(hctx, srcu_idx);
> +	hctx_unlock(hctx);
>   
>   	return ret;
>   }
> @@ -2600,20 +2598,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>   	}
>   }
>   
> -static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
> -{
> -	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> -
> -	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
> -			   __alignof__(struct blk_mq_hw_ctx)) !=
> -		     sizeof(struct blk_mq_hw_ctx));
> -
> -	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> -		hw_ctx_size += sizeof(struct srcu_struct);
> -
> -	return hw_ctx_size;
> -}
> -
>   static int blk_mq_init_hctx(struct request_queue *q,
>   		struct blk_mq_tag_set *set,
>   		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
> @@ -2651,7 +2635,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
>   	struct blk_mq_hw_ctx *hctx;
>   	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>   
> -	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
> +	hctx = kzalloc_node(sizeof(struct blk_mq_hw_ctx), gfp, node);
>   	if (!hctx)
>   		goto fail_alloc_hctx;
>   
> @@ -2693,8 +2677,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
>   	if (!hctx->fq)
>   		goto free_bitmap;
>   
> -	if (hctx->flags & BLK_MQ_F_BLOCKING)
> -		init_srcu_struct(hctx->srcu);
>   	blk_mq_hctx_kobj_init(hctx);
>   
>   	return hctx;
> @@ -3171,6 +3153,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>   	mutex_unlock(&q->sysfs_lock);
>   }
>   
> +static void blk_mq_dispatch_counter_release(struct percpu_ref *ref)
> +{
> +	struct request_queue *q = container_of(ref, struct request_queue,
> +				dispatch_counter);
> +	wake_up_all(&q->mq_quiesce_wq);
> +}
> +
>   struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   						  struct request_queue *q,
>   						  bool elevator_init)
> @@ -3187,6 +3176,14 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	if (blk_mq_alloc_ctxs(q))
>   		goto err_poll;
>   
> +	if (set->flags & BLK_MQ_F_BLOCKING) {
> +		init_waitqueue_head(&q->mq_quiesce_wq);
> +		if (percpu_ref_init(&q->dispatch_counter,
> +					blk_mq_dispatch_counter_release,
> +					PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
> +			goto err_hctxs;
> +	}
> +
>   	/* init q->mq_kobj and sw queues' kobjects */
>   	blk_mq_sysfs_init(q);
>   
> @@ -3195,7 +3192,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   
>   	blk_mq_realloc_hw_ctxs(set, q);
>   	if (!q->nr_hw_queues)
> -		goto err_hctxs;
> +		goto err_dispatch_counter;
>   
>   	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
>   	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
> @@ -3229,6 +3226,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   
>   	return q;
>   
> +err_dispatch_counter:
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		percpu_ref_exit(&q->dispatch_counter);
>   err_hctxs:
>   	kfree(q->queue_hw_ctx);
>   	q->nr_hw_queues = 0;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7dda709f3ccb..56b6c045e30c 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -941,9 +941,13 @@ static void blk_release_queue(struct kobject *kobj)
>   
>   	blk_queue_free_zone_bitmaps(q);
>   
> -	if (queue_is_mq(q))
> +	if (queue_is_mq(q)) {
>   		blk_mq_release(q);
>   
> +		if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +			percpu_ref_exit(&q->dispatch_counter);
> +	}
> +
>   	blk_trace_shutdown(q);
>   	mutex_lock(&q->debugfs_mutex);
>   	debugfs_remove_recursive(q->debugfs_dir);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 9d2d5ad367a4..ea3461298de5 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -169,13 +169,6 @@ struct blk_mq_hw_ctx {
>   	 * q->unused_hctx_list.
>   	 */
>   	struct list_head	hctx_list;
> -
> -	/**
> -	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
> -	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
> -	 * blk_mq_hw_ctx_size().
> -	 */
> -	struct srcu_struct	srcu[];
>   };
>   
>   /**
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bb5636cc17b9..5fa8bc1bb7a8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -572,6 +572,10 @@ struct request_queue {
>   	struct list_head	tag_set_list;
>   	struct bio_set		bio_split;
>   
> +	/* only used for BLK_MQ_F_BLOCKING */
> +	struct percpu_ref	dispatch_counter;

Can this be moved to be next to the q_usage_counter? they
will be taken together for blocking drivers...

Also maybe a better name is needed here since it's just
for blocking hctxs.

> +	wait_queue_head_t	mq_quiesce_wq;
> +
>   	struct dentry		*debugfs_dir;
>   
>   #ifdef CONFIG_BLK_DEBUG_FS
> 

What I think is needed here is at a minimum test quiesce/unquiesce loops
during I/O. code auditing is not enough, there may be driver assumptions
broken with this change (although I hope there shouldn't be).
