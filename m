Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AAFC433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 01:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FFF61353
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 01:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhEUBbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 21:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236147AbhEUBbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 21:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621560588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adyU3Yp8ARJNEdABtgBhAlN06swtjVp82xZSU1GhQWI=;
        b=LF+sfiwDUiXv9riNQfyYK89bowmUqTlC5YVAnat9JD31y5+2/um5l5WJxbIwFRr1y0QPD9
        DiydbOtaUJ/HuP+PBN2qmoucIZMFXBZ3ecdI0FAV5R+TVJs245Z+EchvY0BiD+5VOSmdNR
        3MehdwoFz+93j8BCz2JX1ta5SYZMWKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-tTw7YtKhPFKCRcR0QxfmGg-1; Thu, 20 May 2021 21:29:47 -0400
X-MC-Unique: tTw7YtKhPFKCRcR0QxfmGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9095F180FD69;
        Fri, 21 May 2021 01:29:45 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 522735D76F;
        Fri, 21 May 2021 01:29:38 +0000 (UTC)
Date:   Fri, 21 May 2021 09:29:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not pull requests from the scheduler when we
 cannot dispatch them
Message-ID: <YKcM/TWxSAQv7KHg@T590>
References: <20210520112528.16250-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520112528.16250-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 20, 2021 at 01:25:28PM +0200, Jan Kara wrote:
> Provided the device driver does not implement dispatch budget accounting
> (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> requests from the IO scheduler as long as it is willing to give out any.
> That defeats scheduling heuristics inside the scheduler by creating
> false impression that the device can take more IO when it in fact
> cannot.

So hctx->dispatch_busy isn't set as true in this case?

> 
> For example with BFQ IO scheduler on top of virtio-blk device setting
> blkio cgroup weight has barely any impact on observed throughput of
> async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> when that is all dispatched, it will give out IO of lower weight cgroups
> as well. And then we have to wait for all this IO to be dispatched to
> the disk (which means lot of it actually has to complete) before the
> IO scheduler is queried again for dispatching more requests. This
> completely destroys any service differentiation.
> 
> So grab request tag for a request pulled out of the IO scheduler already
> in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> cannot get it because we are unlikely to be able to dispatch it. That
> way only single request is going to wait in the dispatch list for some
> tag to free.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq-sched.c | 12 +++++++++++-
>  block/blk-mq.c       |  2 +-
>  block/blk-mq.h       |  2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 996a4b2f73aa..714e678f516a 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		 * in blk_mq_dispatch_rq_list().
>  		 */
>  		list_add_tail(&rq->queuelist, &rq_list);
> +		count++;
>  		if (rq->mq_hctx != hctx)
>  			multi_hctxs = true;
> -	} while (++count < max_dispatch);
> +
> +		/*
> +		 * If we cannot get tag for the request, stop dequeueing
> +		 * requests from the IO scheduler. We are unlikely to be able
> +		 * to submit them anyway and it creates false impression for
> +		 * scheduling heuristics that the device can take more IO.
> +		 */
> +		if (!blk_mq_get_driver_tag(rq))
> +			break;

At default BFQ's queue depth is same with virtblk_queue_depth, both are
256, so looks you use non-default setting?

Also in case of running out of driver tag, hctx->dispatch_busy should have
been set as true for avoiding batching dequeuing, does the following
patch make a difference for you?


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 045b6878b8c5..c2ce3091ad6e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -107,6 +107,13 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
+static int blk_mq_sched_max_disaptch(struct blk_mq_hw_ctx *hctx)
+{
+	if (!hctx->dispatch_busy)
+		return hctx->queue->nr_requests;
+	return 1;
+}
+
 /*
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
@@ -121,15 +128,9 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	struct elevator_queue *e = q->elevator;
 	bool multi_hctxs = false, run_queue = false;
 	bool dispatched = false, busy = false;
-	unsigned int max_dispatch;
 	LIST_HEAD(rq_list);
 	int count = 0;
 
-	if (hctx->dispatch_busy)
-		max_dispatch = 1;
-	else
-		max_dispatch = hctx->queue->nr_requests;
-
 	do {
 		struct request *rq;
 		int budget_token;
@@ -170,7 +171,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		list_add_tail(&rq->queuelist, &rq_list);
 		if (rq->mq_hctx != hctx)
 			multi_hctxs = true;
-	} while (++count < max_dispatch);
+	} while (++count < blk_mq_sched_max_disaptch(hctx));
 
 	if (!count) {
 		if (run_queue)


Thanks,
Ming

