Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2DC35247
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93716214AF
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCbHpq+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGCHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:07:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgBGCHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Feb 2020 21:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581041262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4iPZgZxpkB9JtkTPYm/bLkl0k6K+GzxSdaOpeHw5LsE=;
        b=ZCbHpq+ntC20d/bKTcrNhLxiQBwwEGi8UaU3tc8wGgVKcM/vVcl5sXCXmF330DUgQC36Hb
        6IkzQ8DNXAa/jD/deH0lj6d5TD0HXT60PUrbRVPQP5/EVEMeJCN4vKiZD+ZqXz1/tEag2b
        qCu/+iJaM58dIHtoI7Ipppr0OKryj3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-F60I2gHHMbCvXzVDoBvNRg-1; Thu, 06 Feb 2020 21:07:40 -0500
X-MC-Unique: F60I2gHHMbCvXzVDoBvNRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E726B8010F5;
        Fri,  7 Feb 2020 02:07:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E9B75DA7E;
        Fri,  7 Feb 2020 02:07:31 +0000 (UTC)
Date:   Fri, 7 Feb 2020 10:07:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200207020727.GA9900@ming.t460p>
References: <20200206101833.GA20943@ming.t460p>
 <20200206211222.83170-1-sqazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206211222.83170-1-sqazi@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 06, 2020 at 01:12:22PM -0800, Salman Qazi wrote:
> Flushes bypass the I/O scheduler and get added to hctx->dispatch
> in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
> hctx->run_work work item and is past the point in
> blk_mq_sched_dispatch_requests where hctx->dispatch is checked.
> 
> The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
> because the I/O scheduler can feed an arbitrary number of commands.
> 
> Since we have only one hctx->run_work, the commands waiting in
> hctx->dispatch will wait an arbitrary length of time for run_work to be
> rerun.
> 
> A similar phenomenon exists with dispatches from the software queue.
> 
> The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
> blk_mq_do_dispatch_ctx and return from the run_work handler and let it
> rerun.
> 
> Signed-off-by: Salman Qazi <sqazi@google.com>
> ---
>  block/blk-mq-sched.c | 47 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd47b3d..84dde147f646 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -84,12 +84,16 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>   * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
>   * its queue by itself in its completion handler, so we don't need to
>   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> + *
> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.
>   */
> -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
>  	struct elevator_queue *e = q->elevator;
>  	LIST_HEAD(rq_list);
> +	bool ret = false;
>  
>  	do {
>  		struct request *rq;
> @@ -97,6 +101,11 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
>  			break;
>  
> +		if (!list_empty_careful(&hctx->dispatch)) {
> +			ret = true;
> +			break;
> +		}
> +
>  		if (!blk_mq_get_dispatch_budget(hctx))
>  			break;
>  
> @@ -113,6 +122,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		 */
>  		list_add(&rq->queuelist, &rq_list);
>  	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> +
> +	return ret;
>  }
>  
>  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> @@ -130,16 +141,25 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
>   * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
>   * its queue by itself in its completion handler, so we don't need to
>   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> + *
> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.
>   */
> -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
>  	LIST_HEAD(rq_list);
>  	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> +	bool ret = false;
>  
>  	do {
>  		struct request *rq;
>  
> +		if (!list_empty_careful(&hctx->dispatch)) {
> +			ret = true;
> +			break;
> +		}
> +
>  		if (!sbitmap_any_bit_set(&hctx->ctx_map))
>  			break;
>  
> @@ -165,6 +185,7 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
>  	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
>  
>  	WRITE_ONCE(hctx->dispatch_from, ctx);
> +	return ret;
>  }
>  
>  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> @@ -172,6 +193,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	struct request_queue *q = hctx->queue;
>  	struct elevator_queue *e = q->elevator;
>  	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> +	bool run_again;
> +	bool restarted = false;
>  	LIST_HEAD(rq_list);
>  
>  	/* RCU or SRCU read lock is needed before checking quiesced flag */
> @@ -180,6 +203,9 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  
>  	hctx->run++;
>  
> +again:
> +	run_again = false;
> +
>  	/*
>  	 * If we have previous entries on our dispatch list, grab them first for
>  	 * more fair dispatch.
> @@ -208,19 +234,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  		blk_mq_sched_mark_restart_hctx(hctx);
>  		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
>  			if (has_sched_dispatch)
> -				blk_mq_do_dispatch_sched(hctx);
> +				run_again = blk_mq_do_dispatch_sched(hctx);
>  			else
> -				blk_mq_do_dispatch_ctx(hctx);
> +				run_again = blk_mq_do_dispatch_ctx(hctx);
>  		}
>  	} else if (has_sched_dispatch) {
> -		blk_mq_do_dispatch_sched(hctx);
> +		run_again = blk_mq_do_dispatch_sched(hctx);
>  	} else if (hctx->dispatch_busy) {
>  		/* dequeue request one by one from sw queue if queue is busy */
> -		blk_mq_do_dispatch_ctx(hctx);
> +		run_again = blk_mq_do_dispatch_ctx(hctx);
>  	} else {
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>  		blk_mq_dispatch_rq_list(q, &rq_list, false);
>  	}
> +
> +	if (run_again) {
> +		if (!restarted) {
> +			restarted = true;
> +			goto again;
> +		}
> +
> +		blk_mq_run_hw_queue(hctx, true);
> +	}
>  }
>  
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

