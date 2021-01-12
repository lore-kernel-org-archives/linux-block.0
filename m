Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD43EC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 02:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB84D22EBF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 02:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbhALCP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728245AbhALCP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 21:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610417670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0N0Em+g5f3nLG689T4n6jOsf8tWKuKWMNClMO3/JdQ=;
        b=ecQKvhKJwuS89Zlm8sh5pAZ5g9Wtg6QpGt9xrgrwEwGMFjRcmDnE7f9+GQMg2p5VJe5bH+
        5wbsou03aJoAeDtQQYbT1qZHtqJaj9aW2xjfVWirDe/Eg+MUcqQJBBE7Tr8UfAmr44MC/L
        B8F91s4Jfi7cRBuHDN0mYXQXKX/NqhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-GWtroUFdObmU4EnyKqhvyQ-1; Mon, 11 Jan 2021 21:14:26 -0500
X-MC-Unique: GWtroUFdObmU4EnyKqhvyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 327271005D4C;
        Tue, 12 Jan 2021 02:14:25 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C97F150DD5;
        Tue, 12 Jan 2021 02:14:19 +0000 (UTC)
Date:   Tue, 12 Jan 2021 10:14:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "blk-mq, elevator: Count requests per hctx to
 improve performance"
Message-ID: <20210112021414.GB60605@T590>
References: <20210111164717.21937-1-jack@suse.cz>
 <20210111164717.21937-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111164717.21937-2-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 11, 2021 at 05:47:16PM +0100, Jan Kara wrote:
> This reverts commit b445547ec1bbd3e7bf4b1c142550942f70527d95.
> 
> Since both mq-deadline and BFQ completely ignore hctx they are passed to
> their dispatch function and dispatch whatever request they deem fit
> checking whether any request for a particular hctx is queued is just
> pointless since we'll very likely get a request from a different hctx
> anyway. In the following commit we'll deal with lock contention in these
> IO schedulers in presence of multiple HW queues in a different way.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/bfq-iosched.c    | 5 -----
>  block/blk-mq.c         | 1 -
>  block/mq-deadline.c    | 6 ------
>  include/linux/blk-mq.h | 4 ----
>  4 files changed, 16 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e81d1052091..a99dfaa75a8c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4640,9 +4640,6 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>  
> -	if (!atomic_read(&hctx->elevator_queued))
> -		return false;
> -
>  	/*
>  	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>  	 * most a call to dispatch for nothing
> @@ -5557,7 +5554,6 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
>  		rq = list_first_entry(list, struct request, queuelist);
>  		list_del_init(&rq->queuelist);
>  		bfq_insert_request(hctx, rq, at_head);
> -		atomic_inc(&hctx->elevator_queued);
>  	}
>  }
>  
> @@ -5925,7 +5921,6 @@ static void bfq_finish_requeue_request(struct request *rq)
>  
>  		bfq_completed_request(bfqq, bfqd);
>  		bfq_finish_requeue_request_body(bfqq);
> -		atomic_dec(&rq->mq_hctx->elevator_queued);
>  
>  		spin_unlock_irqrestore(&bfqd->lock, flags);
>  	} else {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f285a9123a8b..57f3482b2c26 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2653,7 +2653,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
>  		goto free_hctx;
>  
>  	atomic_set(&hctx->nr_active, 0);
> -	atomic_set(&hctx->elevator_queued, 0);
>  	if (node == NUMA_NO_NODE)
>  		node = set->numa_node;
>  	hctx->numa_node = node;
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 800ac902809b..b57470e154c8 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -386,8 +386,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	spin_lock(&dd->lock);
>  	rq = __dd_dispatch_request(dd);
>  	spin_unlock(&dd->lock);
> -	if (rq)
> -		atomic_dec(&rq->mq_hctx->elevator_queued);
>  
>  	return rq;
>  }
> @@ -535,7 +533,6 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  		rq = list_first_entry(list, struct request, queuelist);
>  		list_del_init(&rq->queuelist);
>  		dd_insert_request(hctx, rq, at_head);
> -		atomic_inc(&hctx->elevator_queued);
>  	}
>  	spin_unlock(&dd->lock);
>  }
> @@ -582,9 +579,6 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>  
> -	if (!atomic_read(&hctx->elevator_queued))
> -		return false;
> -
>  	return !list_empty_careful(&dd->dispatch) ||
>  		!list_empty_careful(&dd->fifo_list[0]) ||
>  		!list_empty_careful(&dd->fifo_list[1]);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d705b174d346..b4b9604bbfd7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -140,10 +140,6 @@ struct blk_mq_hw_ctx {
>  	 * shared across request queues.
>  	 */
>  	atomic_t		nr_active;
> -	/**
> -	 * @elevator_queued: Number of queued requests on hctx.
> -	 */
> -	atomic_t                elevator_queued;
>  
>  	/** @cpuhp_online: List to store request if CPU is going to die */
>  	struct hlist_node	cpuhp_online;
> -- 
> 2.26.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

