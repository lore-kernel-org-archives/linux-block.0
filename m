Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DADC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF20421582
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDWHwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:52:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56647 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgDWHwA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:52:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC276227A8C; Thu, 23 Apr 2020 09:51:56 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:51:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 8/9] blk-mq: handle requests dispatched from IO
 scheduler in case of inactive hctx
Message-ID: <20200423075155.GI10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-9-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:24AM +0800, Ming Lei wrote:
> If one hctx becomes inactive when its CPUs are all offline, all in-queue
> requests aimed at this hctx have to be re-submitted.
> 
> Re-submit requests from both sw queue or scheduler queue when the hctx
> is found as inactive.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 100 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 62 insertions(+), 38 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae1e57c64ca1..54ba8a9c3c93 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2456,6 +2456,52 @@ static void blk_mq_resubmit_io(struct request *rq)
>  		blk_mq_resubmit_fs_io(rq);
>  }
>  
> +static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx)
> +{
> +	LIST_HEAD(sched_tmp);
> +	LIST_HEAD(re_submit);
> +	LIST_HEAD(flush_in);
> +	LIST_HEAD(flush_out);
> +	struct request *rq, *nxt;
> +	struct elevator_queue *e = hctx->queue->elevator;
> +
> +	if (!e) {
> +		blk_mq_flush_busy_ctxs(hctx, &re_submit);
> +	} else {
> +		while ((rq = e->type->ops.dispatch_request(hctx))) {
> +			if (rq->mq_hctx != hctx)
> +				list_add(&rq->queuelist, &sched_tmp);
> +			else
> +				list_add(&rq->queuelist, &re_submit);
> +		}
> +	}
> +	while (!list_empty(&sched_tmp)) {
> +		rq = list_entry(sched_tmp.next, struct request,
> +				queuelist);
> +		list_del_init(&rq->queuelist);
> +		blk_mq_sched_insert_request(rq, true, true, true);
> +	}
> +
> +	/* requests in dispatch list have to be re-submitted too */
> +	spin_lock(&hctx->lock);
> +	list_splice_tail_init(&hctx->dispatch, &re_submit);
> +	spin_unlock(&hctx->lock);
> +
> +	/* blk_end_flush_machinery will cover flush request */
> +	list_for_each_entry_safe(rq, nxt, &re_submit, queuelist) {
> +		if (rq->rq_flags & RQF_FLUSH_SEQ)
> +			list_move(&rq->queuelist, &flush_in);
> +	}
> +	blk_end_flush_machinery(hctx, &flush_in, &flush_out);
> +	list_splice_tail(&flush_out, &re_submit);
> +
> +	while (!list_empty(&re_submit)) {
> +		rq = list_first_entry(&re_submit, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		blk_mq_resubmit_io(rq);
> +	}
> +}
> +
>  /*
>   * 'cpu' has gone away. If this hctx is inactive, we can't dispatch request
>   * to the hctx any more, so steal bios from requests of this hctx, and
> @@ -2463,54 +2509,32 @@ static void blk_mq_resubmit_io(struct request *rq)
>   */
>  static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  {
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_dead);
>  
>  	if (!cpumask_test_cpu(cpu, hctx->cpumask))
>  		return 0;
>  
> +	if (test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
> +		blk_mq_hctx_deactivate(hctx);

Actually it probably also makes sense to introduce the
blk_mq_hctx_deactivate helper in the previous patch to avoid some
churn here.

> +	} else if (!hctx->queue->elevator) {
> +		struct blk_mq_ctx *ctx = __blk_mq_get_ctx(hctx->queue, cpu);
> +		enum hctx_type type = hctx->type;
> +		LIST_HEAD(tmp);
> +
> +		spin_lock(&ctx->lock);
> +		if (!list_empty(&ctx->rq_lists[type])) {
> +			list_splice_init(&ctx->rq_lists[type], &tmp);
> +			blk_mq_hctx_clear_pending(hctx, ctx);
> +		}
> +		spin_unlock(&ctx->lock);
>  
>  		if (!list_empty(&tmp)) {
>  			spin_lock(&hctx->lock);
>  			list_splice_tail_init(&tmp, &hctx->dispatch);
>  			spin_unlock(&hctx->lock);
>  
> +			blk_mq_run_hw_queue(hctx, true);
>  		}

And another helper for the !inactive case.
