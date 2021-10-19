Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB5360EB4
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSWXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:23:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52932 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJSWXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:23:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 6A7951F43E76
Subject: Re: [PATCH 06/14] block: store elevator state in request
To:     Jens Axboe <axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-7-axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <1a08141a-407f-0fda-4b27-e9dd350c6e79@collabora.com>
Date:   Tue, 19 Oct 2021 23:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211017013748.76461-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 17/10/2021 02:37, Jens Axboe wrote:
> Add an rq private RQF_ELV flag, which tells the block layer that this
> request was initialized on a queue that has an IO scheduler attached.
> This allows for faster checking in the fast path, rather than having to
> deference rq->q later on.
> 
> Elevator switching does full quiesce of the queue before detaching an
> IO scheduler, so it's safe to cache this in the request itself.

A kernelci.org automated bisection found that this patch
introduced a regression in next-20211019 with a NULL pointer
dereference, which only seems to be affecting QEMU but across all
architectures.

More details about the regression can be found here:

  https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20211019/plan/baseline/
  https://linux.kernelci.org/test/case/id/616ea20eb7104071c43358ea/

See also all the test jobs involved in the automated bisection:

  https://lava.collabora.co.uk/scheduler/device_type/qemu?dt_search=bisection-287

If you do send a fix, please include this trailer:

  Reported-by: "kernelci.org bot" <bot@kernelci.org>


Please let us know if this seems like a valid bisection result
and if you need any help to debug the issue or try a fix.

Best wishes,
Guillaume


GitHub: https://github.com/kernelci/kernelci-project/issues/68


> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-sched.h   | 27 ++++++++++++++++-----------
>  block/blk-mq.c         | 20 +++++++++++---------
>  include/linux/blk-mq.h |  2 ++
>  3 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index fe252278ed9a..98836106b25f 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -56,29 +56,34 @@ static inline bool
>  blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
>  			 struct bio *bio)
>  {
> -	struct elevator_queue *e = q->elevator;
> -
> -	if (e && e->type->ops.allow_merge)
> -		return e->type->ops.allow_merge(q, rq, bio);
> +	if (rq->rq_flags & RQF_ELV) {
> +		struct elevator_queue *e = q->elevator;
>  
> +		if (e->type->ops.allow_merge)
> +			return e->type->ops.allow_merge(q, rq, bio);
> +	}
>  	return true;
>  }
>  
>  static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
>  {
> -	struct elevator_queue *e = rq->q->elevator;
> +	if (rq->rq_flags & RQF_ELV) {
> +		struct elevator_queue *e = rq->q->elevator;
>  
> -	if (e && e->type->ops.completed_request)
> -		e->type->ops.completed_request(rq, now);
> +		if (e->type->ops.completed_request)
> +			e->type->ops.completed_request(rq, now);
> +	}
>  }
>  
>  static inline void blk_mq_sched_requeue_request(struct request *rq)
>  {
> -	struct request_queue *q = rq->q;
> -	struct elevator_queue *e = q->elevator;
> +	if (rq->rq_flags & RQF_ELV) {
> +		struct request_queue *q = rq->q;
> +		struct elevator_queue *e = q->elevator;
>  
> -	if ((rq->rq_flags & RQF_ELVPRIV) && e && e->type->ops.requeue_request)
> -		e->type->ops.requeue_request(rq);
> +		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
> +			e->type->ops.requeue_request(rq);
> +	}
>  }
>  
>  static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fa5b12200404..5d22c228f6df 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -299,7 +299,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
>   */
>  static inline bool blk_mq_need_time_stamp(struct request *rq)
>  {
> -	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
> +	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
>  }
>  
>  static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
> @@ -309,9 +309,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	struct request *rq = tags->static_rqs[tag];
>  
>  	if (data->q->elevator) {
> +		rq->rq_flags = RQF_ELV;
>  		rq->tag = BLK_MQ_NO_TAG;
>  		rq->internal_tag = tag;
>  	} else {
> +		rq->rq_flags = 0;
>  		rq->tag = tag;
>  		rq->internal_tag = BLK_MQ_NO_TAG;
>  	}
> @@ -320,7 +322,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	rq->q = data->q;
>  	rq->mq_ctx = data->ctx;
>  	rq->mq_hctx = data->hctx;
> -	rq->rq_flags = 0;
>  	rq->cmd_flags = data->cmd_flags;
>  	if (data->flags & BLK_MQ_REQ_PM)
>  		rq->rq_flags |= RQF_PM;
> @@ -356,11 +357,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
>  	refcount_set(&rq->ref, 1);
>  
> -	if (!op_is_flush(data->cmd_flags)) {
> +	if (!op_is_flush(data->cmd_flags) && (rq->rq_flags & RQF_ELV)) {
>  		struct elevator_queue *e = data->q->elevator;
>  
>  		rq->elv.icq = NULL;
> -		if (e && e->type->ops.prepare_request) {
> +		if (e->type->ops.prepare_request) {
>  			if (e->type->icq_cache)
>  				blk_mq_sched_assign_ioc(rq);
>  
> @@ -575,12 +576,13 @@ static void __blk_mq_free_request(struct request *rq)
>  void blk_mq_free_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct elevator_queue *e = q->elevator;
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> -	if (rq->rq_flags & RQF_ELVPRIV) {
> -		if (e && e->type->ops.finish_request)
> +	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
> +		struct elevator_queue *e = q->elevator;
> +
> +		if (e->type->ops.finish_request)
>  			e->type->ops.finish_request(rq);
>  		if (rq->elv.icq) {
>  			put_io_context(rq->elv.icq->ioc);
> @@ -2239,7 +2241,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	if (q->elevator && !bypass_insert)
> +	if ((rq->rq_flags & RQF_ELV) && !bypass_insert)
>  		goto insert;
>  
>  	budget_token = blk_mq_get_dispatch_budget(q);
> @@ -2475,7 +2477,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  		}
>  
>  		blk_add_rq_to_plug(plug, rq);
> -	} else if (q->elevator) {
> +	} else if (rq->rq_flags & RQF_ELV) {
>  		/* Insert the request at the IO scheduler queue */
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	} else if (plug && !blk_queue_nomerges(q)) {
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index a9c1d0882550..3a399aa372b5 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -55,6 +55,8 @@ typedef __u32 __bitwise req_flags_t;
>  #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
>  /* ->timeout has been called, don't expire again */
>  #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
> +/* queue has elevator attached */
> +#define RQF_ELV			((__force req_flags_t)(1 << 22))
>  
>  /* flags that prevent us from merging requests: */
>  #define RQF_NOMERGE_FLAGS \
> 

