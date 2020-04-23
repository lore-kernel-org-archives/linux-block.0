Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D80FC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86377208E4
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgDWHim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:38:42 -0400
Received: from verein.lst.de ([213.95.11.211]:56510 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWHim (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:38:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 278D368BEB; Thu, 23 Apr 2020 09:38:39 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:38:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 5/9] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200423073838.GF10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:21AM +0800, Ming Lei wrote:
> -static bool blk_mq_get_driver_tag(struct request *rq)
> +static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
>  {
>  	struct blk_mq_alloc_data data = {
>  		.q = rq->q,
> @@ -1054,6 +1054,23 @@ static bool blk_mq_get_driver_tag(struct request *rq)
>  		data.hctx->tags->rqs[rq->tag] = rq;
>  	}
>  allocated:
> +	/*
> +	 * Add one memory barrier in case that direct issue IO process
> +	 * is migrated to other CPU which may not belong to this hctx,
> +	 * so we can order driver tag assignment and checking
> +	 * BLK_MQ_S_INACTIVE. Otherwise, barrier() is enough given the
> +	 * two code paths are run on single CPU in case that
> +	 * BLK_MQ_S_INACTIVE is set.

Please use up all 80 characters for the comments (also elsewhere). That
being said I fail to see what the barrier() as a pure compiler barrier
even buys us here.

> +	 */
> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +		smp_mb();
> +	else
> +		barrier();
> +
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))) {
> +		blk_mq_put_driver_tag(rq);
> +		return false;
> +	}
>  	return rq->tag != -1;

Also if you take my cleanup to patch 2, we could just open code the
direct_issue case in the only caller instead of having the magic in the
common routine.

> +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
> +			(cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask)
> +			 < nr_cpu_ids))

No need for the inner braces.  Also in this case I think something like:

	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu ||
	    cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)

might be a tad more readable, but then again this might even be worth
a little inline helper once we start bike shedding.

> +	/*
> +	 * The current CPU is the last one in this hctx, S_INACTIVE
> +	 * can be observed in dispatch path without any barrier needed,
> +	 * cause both are run on one same CPU.
> +	 */
> +	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> +	/*
> +	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
> +	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
> +	 */
> +	smp_mb();
> +	blk_mq_hctx_drain_inflight_rqs(hctx);
> +	return 0;

FYI, Documentation/core-api/atomic_ops.rst asks for using
smp_mb__before_atomic / smp_mb__after_atomic around the bitops.

> +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
> +	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>  	return 0;
>  }

Why not simply:

	if (cpumask_test_cpu(cpu, hctx->cpumask))
		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
	return 0;

Conceptually the changes look fine.
