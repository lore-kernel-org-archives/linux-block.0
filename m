Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FF2C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 02:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8847422510
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 02:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhALCRF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbhALCRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 21:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610417737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgKPBduqRysl0E0nB/9cv+OQX+mWuuzaD8tbbZgBaK4=;
        b=g3o1yhTDFhYtGFV/fYz/zlhIp67UnwRdSWNgVQmCFrttpgDQG417tzzVAxrd1uBznxUte4
        h+x9kdM+p9DsHDlbQdsDBAUeROozaETzOoWsgOxiuKA3gNcNDAHjSewuoqEKozvwCUujed
        5wh1zN2OE2BTeSUCIqss60h3TNkpzd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-MglOTa3xMQKGk1L8EzNzdg-1; Mon, 11 Jan 2021 21:15:36 -0500
X-MC-Unique: MglOTa3xMQKGk1L8EzNzdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247BD9CC03;
        Tue, 12 Jan 2021 02:15:35 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71D7810013BD;
        Tue, 12 Jan 2021 02:15:30 +0000 (UTC)
Date:   Tue, 12 Jan 2021 10:15:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers
 with multiple HW queues
Message-ID: <20210112021526.GC60605@T590>
References: <20210111164717.21937-1-jack@suse.cz>
 <20210111164717.21937-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111164717.21937-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 11, 2021 at 05:47:17PM +0100, Jan Kara wrote:
> Currently when non-mq aware IO scheduler (BFQ, mq-deadline) is used for
> a queue with multiple HW queues, the performance it rather bad. The
> problem is that these IO schedulers use queue-wide locking and their
> dispatch function does not respect the hctx it is passed in and returns
> any request it finds appropriate. Thus locality of request access is
> broken and dispatch from multiple CPUs just contends on IO scheduler
> locks. For these IO schedulers there's little point in dispatching from
> multiple CPUs. Instead dispatch always only from a single CPU to limit
> contention.
> 
> Below is a comparison of dbench runs on XFS filesystem where the storage
> is a raid card with 64 HW queues and to it attached a single rotating
> disk. BFQ is used as IO scheduler:
> 
>       clients           MQ                     SQ             MQ-Patched
> Amean 1      39.12 (0.00%)       43.29 * -10.67%*       36.09 *   7.74%*
> Amean 2     128.58 (0.00%)      101.30 *  21.22%*       96.14 *  25.23%*
> Amean 4     577.42 (0.00%)      494.47 *  14.37%*      508.49 *  11.94%*
> Amean 8     610.95 (0.00%)      363.86 *  40.44%*      362.12 *  40.73%*
> Amean 16    391.78 (0.00%)      261.49 *  33.25%*      282.94 *  27.78%*
> Amean 32    324.64 (0.00%)      267.71 *  17.54%*      233.00 *  28.23%*
> Amean 64    295.04 (0.00%)      253.02 *  14.24%*      242.37 *  17.85%*
> Amean 512 10281.61 (0.00%)    10211.16 *   0.69%*    10447.53 *  -1.61%*
> 
> Numbers are times so lower is better. MQ is stock 5.10-rc6 kernel. SQ is
> the same kernel with megaraid_sas.host_tagset_enable=0 so that the card
> advertises just a single HW queue. MQ-Patched is a kernel with this
> patch applied.
> 
> You can see multiple hardware queues heavily hurt performance in
> combination with BFQ. The patch restores the performance.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq.c           | 66 ++++++++++++++++++++++++++++++++++++----
>  block/kyber-iosched.c    |  1 +
>  include/linux/elevator.h |  2 ++
>  3 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 57f3482b2c26..580601787f7a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1646,6 +1646,42 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  }
>  EXPORT_SYMBOL(blk_mq_run_hw_queue);
>  
> +/*
> + * Is the request queue handled by an IO scheduler that does not respect
> + * hardware queues when dispatching?
> + */
> +static bool blk_mq_has_sqsched(struct request_queue *q)
> +{
> +	struct elevator_queue *e = q->elevator;
> +
> +	if (e && e->type->ops.dispatch_request &&
> +	    !(e->type->elevator_features & ELEVATOR_F_MQ_AWARE))
> +		return true;
> +	return false;
> +}
> +
> +/*
> + * Return prefered queue to dispatch from (if any) for non-mq aware IO
> + * scheduler.
> + */
> +static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	/*
> +	 * If the IO scheduler does not respect hardware queues when
> +	 * dispatching, we just don't bother with multiple HW queues and
> +	 * dispatch from hctx for the current CPU since running multiple queues
> +	 * just causes lock contention inside the scheduler and pointless cache
> +	 * bouncing.
> +	 */
> +	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
> +				     raw_smp_processor_id());
> +	if (!blk_mq_hctx_stopped(hctx))
> +		return hctx;
> +	return NULL;
> +}
> +
>  /**
>   * blk_mq_run_hw_queues - Run all hardware queues in a request queue.
>   * @q: Pointer to the request queue to run.
> @@ -1653,14 +1689,23 @@ EXPORT_SYMBOL(blk_mq_run_hw_queue);
>   */
>  void blk_mq_run_hw_queues(struct request_queue *q, bool async)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_hw_ctx *hctx, *sq_hctx;
>  	int i;
>  
> +	sq_hctx = NULL;
> +	if (blk_mq_has_sqsched(q))
> +		sq_hctx = blk_mq_get_sq_hctx(q);
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (blk_mq_hctx_stopped(hctx))
>  			continue;
> -
> -		blk_mq_run_hw_queue(hctx, async);
> +		/*
> +		 * Dispatch from this hctx either if there's no hctx preferred
> +		 * by IO scheduler or if it has requests that bypass the
> +		 * scheduler.
> +		 */
> +		if (!sq_hctx || sq_hctx == hctx ||
> +		    !list_empty_careful(&hctx->dispatch))
> +			blk_mq_run_hw_queue(hctx, async);
>  	}
>  }
>  EXPORT_SYMBOL(blk_mq_run_hw_queues);
> @@ -1672,14 +1717,23 @@ EXPORT_SYMBOL(blk_mq_run_hw_queues);
>   */
>  void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_hw_ctx *hctx, *sq_hctx;
>  	int i;
>  
> +	sq_hctx = NULL;
> +	if (blk_mq_has_sqsched(q))
> +		sq_hctx = blk_mq_get_sq_hctx(q);
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (blk_mq_hctx_stopped(hctx))
>  			continue;
> -
> -		blk_mq_delay_run_hw_queue(hctx, msecs);
> +		/*
> +		 * Dispatch from this hctx either if there's no hctx preferred
> +		 * by IO scheduler or if it has requests that bypass the
> +		 * scheduler.
> +		 */
> +		if (!sq_hctx || sq_hctx == hctx ||
> +		    !list_empty_careful(&hctx->dispatch))
> +			blk_mq_delay_run_hw_queue(hctx, msecs);
>  	}
>  }
>  EXPORT_SYMBOL(blk_mq_delay_run_hw_queues);
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index dc89199bc8c6..c25c41d0d061 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -1029,6 +1029,7 @@ static struct elevator_type kyber_sched = {
>  #endif
>  	.elevator_attrs = kyber_sched_attrs,
>  	.elevator_name = "kyber",
> +	.elevator_features = ELEVATOR_F_MQ_AWARE,
>  	.elevator_owner = THIS_MODULE,
>  };
>  
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index bacc40a0bdf3..1fe8e105b83b 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -172,6 +172,8 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
>  
>  /* Supports zoned block devices sequential write constraint */
>  #define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
> +/* Supports scheduling on multiple hardware queues */
> +#define ELEVATOR_F_MQ_AWARE		(1U << 1)
>  
>  #endif /* CONFIG_BLOCK */
>  #endif
> -- 
> 2.26.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

