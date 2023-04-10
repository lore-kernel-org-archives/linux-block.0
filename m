Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EABEC77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDJIBx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDJIBw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A043593
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A07618BC
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05C4C433EF;
        Mon, 10 Apr 2023 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681113710;
        bh=mNTekm5XNL9uM/tjbbfziluRjZ3mhJ3VQzZ8QutB9Qw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z6pOJd6gBEGF670zl6h4EEeNs+3L3b/YjpE2fwA3IfpytF+QnYdYf2pdkIKmalqss
         7nY9dFo+eqTR+/LIwAHV6MOQUnyq0WTYDNi9iRDOQbA+mzjlEmDXgyWO1tYJpI6pE7
         uL5ViHjJ1cmCtqgS54+WwEm1pe/jqujuqXJ/3PcHcpJ4jqQhPRF+PRYEPJdCrV8h0K
         n1Rw7fvP6sffjeW7iEHpiRtDoXxoV+74tc74yFQ/8086Duv/xW+lnIeXqeiGCANe0k
         z2PqghktbohbdYLZ0oxrVYyPzupnUtCMIULTYw+xBQ1UULxzdIQYJat79WdorEYOvQ
         U7KJvHJbsjWAw==
Message-ID: <22023693-a34b-08e0-ac00-71dabdb8a023@kernel.org>
Date:   Mon, 10 Apr 2023 17:01:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 06/12] block: Preserve the order of requeued requests
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-7-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> If a queue is run before all requeued requests have been sent to the I/O
> scheduler, the I/O scheduler may dispatch the wrong request. Fix this by
> making __blk_mq_run_hw_queue() process the requeue_list instead of
> blk_mq_requeue_work().

I think that the part of patch 5 that move the requeue work to per hctx should
be together with this patch. That would make the review easier.
I am guessing that the move to per hctx is to try to reduce lock contention ?
That is not clearly explained. Given that requeue events should be infrequent
exceptions, is that really necessary ?

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c         | 35 ++++++++++-------------------------
>  include/linux/blk-mq.h |  1 -
>  2 files changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index deb3d08a6b26..562868dff43f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -64,6 +64,7 @@ static inline blk_qc_t blk_rq_to_qc(struct request *rq)
>  static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>  {
>  	return !list_empty_careful(&hctx->dispatch) ||
> +		!list_empty_careful(&hctx->requeue_list) ||
>  		sbitmap_any_bit_set(&hctx->ctx_map) ||
>  			blk_mq_sched_has_work(hctx);
>  }
> @@ -1409,10 +1410,8 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
>  }
>  EXPORT_SYMBOL(blk_mq_requeue_request);
>  
> -static void blk_mq_requeue_work(struct work_struct *work)
> +static void blk_mq_process_requeue_list(struct blk_mq_hw_ctx *hctx)
>  {
> -	struct blk_mq_hw_ctx *hctx =
> -		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
>  	LIST_HEAD(rq_list);
>  	struct request *rq, *next;
>  
> @@ -1437,8 +1436,6 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  		list_del_init(&rq->queuelist);
>  		blk_mq_sched_insert_request(rq, false, false, false);
>  	}
> -
> -	blk_mq_run_hw_queue(hctx, false);
>  }
>  
>  void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
> @@ -1464,30 +1461,19 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
>  	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
>  
>  	if (kick_requeue_list)
> -		blk_mq_kick_requeue_list(rq->q);
> +		blk_mq_run_hw_queue(hctx, /*async=*/true);
>  }
>  
>  void blk_mq_kick_requeue_list(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned long i;
> -
> -	queue_for_each_hw_ctx(q, hctx, i)
> -		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> -					    &hctx->requeue_work, 0);
> +	blk_mq_run_hw_queues(q, true);
>  }
>  EXPORT_SYMBOL(blk_mq_kick_requeue_list);
>  
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>  				    unsigned long msecs)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned long i;
> -
> -	queue_for_each_hw_ctx(q, hctx, i)
> -		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> -					    &hctx->requeue_work,
> -					    msecs_to_jiffies(msecs));
> +	blk_mq_delay_run_hw_queues(q, msecs);
>  }
>  EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>  
> @@ -2146,6 +2132,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	WARN_ON_ONCE(in_interrupt());
>  
> +	blk_mq_process_requeue_list(hctx);
> +
>  	blk_mq_run_dispatch_ops(hctx->queue,
>  			blk_mq_sched_dispatch_requests(hctx));
>  }
> @@ -2317,7 +2305,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
>  		 * scheduler.
>  		 */
>  		if (!sq_hctx || sq_hctx == hctx ||
> -		    !list_empty_careful(&hctx->dispatch))
> +		    blk_mq_hctx_has_pending(hctx))
>  			blk_mq_run_hw_queue(hctx, async);
>  	}
>  }
> @@ -2353,7 +2341,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
>  		 * scheduler.
>  		 */
>  		if (!sq_hctx || sq_hctx == hctx ||
> -		    !list_empty_careful(&hctx->dispatch))
> +		    blk_mq_hctx_has_pending(hctx))
>  			blk_mq_delay_run_hw_queue(hctx, msecs);
>  	}
>  }
> @@ -3608,7 +3596,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
>  {
> -	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
>  	INIT_LIST_HEAD(&hctx->requeue_list);
>  	spin_lock_init(&hctx->requeue_lock);
>  
> @@ -4771,10 +4758,8 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		cancel_delayed_work_sync(&hctx->requeue_work);
> +	queue_for_each_hw_ctx(q, hctx, i)
>  		cancel_delayed_work_sync(&hctx->run_work);
> -	}
>  }
>  
>  static int __init blk_mq_init(void)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0157f1569980..e62feb17af96 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -313,7 +313,6 @@ struct blk_mq_hw_ctx {
>  
>  	struct list_head	requeue_list;
>  	spinlock_t		requeue_lock;
> -	struct delayed_work	requeue_work;
>  
>  	/**
>  	 * @run_work: Used for scheduling a hardware queue run at a later time.

