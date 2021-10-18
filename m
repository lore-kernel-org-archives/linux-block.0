Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3266610A6
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhJRJVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:21:23 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A5C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGxETEHB3K+2eHoz0+COshOGj+NzkhcpyVNNz4s8VGk=; b=akW5E6npV3mX3X796uPnjt92pp
        LtaQIoy2ufsLfgFVJfPirmaC3kB5Xhm1CWgI1RwLbrp/DW6J6eHO7aeacMyrwAWC4XmIEqb7ngsM3
        ul1GSY3Pccj95847yXJjJdkHMfF1AMQdKWol+tTCzeD+dxuHkhhI+X8/5lxhUyNN4mtPpPYzCG4CP
        5nXRKwU9N6/ZW0jtvzDP3X/uQ8U1nN40UM7PFnnPojIMqdJa7I96dAJSvFPCSPgs67BbAbLQju4S3
        NQb31Kl3QL28M57ZqkUE9cdqS61hZ5oxXsGYh3QRgq47Yo1BMXKed9idNqboVo1+0n0kpha2YHhg9
        HNfrn9EQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOnY-00EmcD-AE; Mon, 18 Oct 2021 09:19:12 +0000
Date:   Mon, 18 Oct 2021 02:19:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 07/14] block: change plugging to use a singly linked list
Message-ID: <YW08EPYhH73m7nUj@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-8-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:41PM -0600, Jens Axboe wrote:
> Use a singly linked list for the blk_plug. This saves 8 bytes in the
> blk_plug struct, and makes for faster list manipulations than doubly
> linked lists. As we don't use the doubly linked lists for anything,
> singly linked is just fine.

This patch also does a few other thing, like changing the same_queue_rq
type and adding a has_elevator flag to the plug.  Can you please split
this out and document the changes better?

>static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  {
> +	struct blk_mq_hw_ctx *hctx = NULL;
> +	int queued = 0;
> +	int errors = 0;
> +
> +	while (!rq_list_empty(plug->mq_list)) {
> +		struct request *rq;
> +		blk_status_t ret;
> +
> +		rq = rq_list_pop(&plug->mq_list);
>  
> +		if (!hctx)
> +			hctx = rq->mq_hctx;
> +		else if (hctx != rq->mq_hctx && hctx->queue->mq_ops->commit_rqs) {
> +			trace_block_unplug(hctx->queue, queued, !from_schedule);
> +			hctx->queue->mq_ops->commit_rqs(hctx);
> +			queued = 0;
> +			hctx = rq->mq_hctx;
> +		}
> +
> +		ret = blk_mq_request_issue_directly(rq,
> +						rq_list_empty(plug->mq_list));
> +		if (ret != BLK_STS_OK) {
> +			if (ret == BLK_STS_RESOURCE ||
> +					ret == BLK_STS_DEV_RESOURCE) {
> +				blk_mq_request_bypass_insert(rq, false,
> +						rq_list_empty(plug->mq_list));
> +				break;
> +			}
> +			blk_mq_end_request(rq, ret);
> +			errors++;
> +		} else
> +			queued++;
> +	}

This all looks a bit messy to me.  I'd suggest reordering this a bit
including a new helper:

static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
		bool from_schedule)
{
	if (hctx->queue->mq_ops->commit_rqs) {
		trace_block_unplug(hctx->queue, *queued, !from_schedule);
		hctx->queue->mq_ops->commit_rqs(hctx);
	}
	*queued = 0;
}

static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
{
	struct blk_mq_hw_ctx *hctx = NULL;
	int queued = 0;
	int errors = 0;

	while ((rq = rq_list_pop(&plug->mq_list))) {
		bool last = rq_list_empty(plug->mq_list);
		blk_status_t ret;

		if (hctx != rq->mq_hctx) {
			if (hctx)
				blk_mq_commit_rqs(hctx, &queued, from_schedule);
			hctx = rq->mq_hctx;
		}

		ret = blk_mq_request_issue_directly(rq, last);
		switch (ret) {
		case BLK_STS_OK:
			queued++;
			break;
		case BLK_STS_RESOURCE:
		case BLK_STS_DEV_RESOURCE:
			blk_mq_request_bypass_insert(rq, false, last);
			blk_mq_commit_rqs(hctx, &queued, from_schedule);
			return;
		default:
			blk_mq_end_request(rq, ret);
			errors++;
			break;
		}
	}

	/*
	 * If we didn't flush the entire list, we could have told the driver
	 * there was more coming, but that turned out to be a lie.
	 */
	if (errors)
		blk_mq_commit_rqs(hctx, &queued, from_schedule);
}
