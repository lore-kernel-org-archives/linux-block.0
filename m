Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168CFC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB08D21582
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDWHuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:16 -0400
Received: from verein.lst.de ([213.95.11.211]:56633 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgDWHuP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:50:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE08468BEB; Thu, 23 Apr 2020 09:50:11 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:50:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 7/9] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200423075011.GH10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static void blk_mq_resubmit_passthrough_io(struct request *rq)
> +{
> +	struct request *nrq;
> +	unsigned int flags = 0, cmd_flags = 0;
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
> +		hctx->tags;
> +	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
> +
> +	if (rq->rq_flags & RQF_PREEMPT)
> +		flags |= BLK_MQ_REQ_PREEMPT;
> +	if (reserved)
> +		flags |= BLK_MQ_REQ_RESERVED;
> +
> +	/* avoid allocation failure & IO merge */
> +	cmd_flags = (rq->cmd_flags & ~REQ_NOWAIT) | REQ_NOMERGE;
> +
> +	nrq = blk_get_request(rq->q, cmd_flags, flags);
> +	if (!nrq)
> +		return;
> +
> +	nrq->__sector = blk_rq_pos(rq);
> +	nrq->__data_len = blk_rq_bytes(rq);
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> +		nrq->rq_flags |= RQF_SPECIAL_PAYLOAD;
> +		nrq->special_vec = rq->special_vec;
> +	}
> +#if defined(CONFIG_BLK_DEV_INTEGRITY)
> +	nrq->nr_integrity_segments = rq->nr_integrity_segments;
> +#endif
> +	nrq->nr_phys_segments = rq->nr_phys_segments;
> +	nrq->ioprio = rq->ioprio;
> +	nrq->extra_len = rq->extra_len;
> +	nrq->rq_disk = rq->rq_disk;
> +	nrq->part = rq->part;
> +	nrq->write_hint = rq->write_hint;
> +	nrq->timeout = rq->timeout;

This should share code with blk_rq_prep_clone() using a helper.
Note that blk_rq_prep_clone seems to miss things like the
write_hint and timeout, which we should fix as well.

> +static void blk_mq_resubmit_fs_io(struct request *rq)
> +{
> +	struct bio_list list;
> +	struct bio *bio;
> +
> +	bio_list_init(&list);
> +	blk_steal_bios(&list, rq);
> +
> +	while (true) {
> +		bio = bio_list_pop(&list);
> +		if (!bio)
> +			break;
> +
> +		generic_make_request(bio);
> +	}

This could be simplified to:

	while ((bio = bio_list_pop(&list)))
		generic_make_request(bio);

but then again the generic_make_request seems weird.  Do we need
actually need any of the checks in generic_make_request?  Shouldn't
we call into blk_mq_make_request directly?

Then again I wonder why the passthrough case doesn't work for
FS requests?

>  static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  {
> @@ -2394,14 +2482,38 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	}
>  	spin_unlock(&ctx->lock);
>  
> +	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
> +		if (!list_empty(&tmp)) {
> +			spin_lock(&hctx->lock);
> +			list_splice_tail_init(&tmp, &hctx->dispatch);
> +			spin_unlock(&hctx->lock);
> +			blk_mq_run_hw_queue(hctx, true);
> +		}
> +	} else {

What about an early return or two here to save a level of indentation
later?

	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
		if (list_empty(&tmp))
			return 0;

		spin_lock(&hctx->lock);
		list_splice_tail_init(&tmp, &hctx->dispatch);
		spin_unlock(&hctx->lock);
		blk_mq_run_hw_queue(hctx, true);
		return 0;
	}

	...
