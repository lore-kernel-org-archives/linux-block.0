Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90582CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69849206D6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgEMMVw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:21:52 -0400
Received: from verein.lst.de ([213.95.11.211]:46191 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbgEMMVv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:21:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3437C68BEB; Wed, 13 May 2020 14:21:48 +0200 (CEST)
Date:   Wed, 13 May 2020 14:21:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200513122147.GF6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-12-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use of the BLK_MQ_REQ_FORCE is pretty bogus here..

> +	if (rq->rq_flags & RQF_PREEMPT)
> +		flags |= BLK_MQ_REQ_PREEMPT;
> +	if (reserved)
> +		flags |= BLK_MQ_REQ_RESERVED;
> +	/*
> +	 * Queue freezing might be in-progress, and wait freeze can't be
> +	 * done now because we have request not completed yet, so mark this
> +	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
> +	 * freeze hung forever.
> +	 */
> +	flags |= BLK_MQ_REQ_FORCE;
> +
> +	/* avoid allocation failure by clearing NOWAIT */
> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> +	if (!nrq)
> +		return;

blk_get_request returns an ERR_PTR.

But I'd rather avoid the magic new BLK_MQ_REQ_FORCE hack when we can
just open code it and document what is going on:

static struct blk_mq_tags *blk_mq_rq_tags(struct request *rq)
{
	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;

	if (rq->q->elevator)
		return hctx->sched_tags;
	return hctx->tags;
}

static void blk_mq_resubmit_rq(struct request *rq)
{
	struct blk_mq_alloc_data alloc_data = {
		.cmd_flags	= rq->cmd_flags & ~REQ_NOWAIT;
	};
	struct request *nrq;

	if (rq->rq_flags & RQF_PREEMPT)
		alloc_data.flags |= BLK_MQ_REQ_PREEMPT;
	if (blk_mq_tag_is_reserved(blk_mq_rq_tags(rq), rq->internal_tag))
		alloc_data.flags |= BLK_MQ_REQ_RESERVED;

	/*
	 * We must still be able to finish a resubmission due to a hotplug
	 * even even if a queue freeze is in progress.
	 */
	percpu_ref_get(&q->q_usage_counter);
	nrq = blk_mq_get_request(rq->q, NULL, &alloc_data);
	blk_queue_exit(q);

	if (!nrq)
		return; // XXX: warn?
	if (nrq->q->mq_ops->initialize_rq_fn)
		rq->mq_ops->initialize_rq_fn(nrq);

	blk_rq_copy_request(nrq, rq);
	...

