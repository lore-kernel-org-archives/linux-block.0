Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2709C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 06:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjEPGYH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEPGYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 02:24:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CAD4C2C
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 23:23:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CBEB68BEB; Tue, 16 May 2023 08:22:21 +0200 (CEST)
Date:   Tue, 16 May 2023 08:22:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH V2 1/2] blk-mq: don't queue plugged passthrough
 requests into scheduler
Message-ID: <20230516062221.GA7325@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com> <20230515144601.52811-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515144601.52811-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 10:46:00PM +0800, Ming Lei wrote:
> +		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> +				pt != blk_rq_is_passthrough(rq)) {

Can your format this as:

		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
			   pt != blk_rq_is_passthrough(rq)) {

for readability?

> +			/*
> +			 * Both passthrough and flush request don't belong to
> +			 * scheduler, but flush request won't be added to plug
> +			 * list, so needn't handle here.
> +			 */
>  			rq_list_add_tail(&requeue_lastp, rq);

This comment confuses the heck out of me.  The check if for passthrough
vs non-passthrough and doesn't involved flush requests at all.

I'd prefer to drop it, and instead comment on passthrough requests
not going to the scheduled below where we actually issue other requests
to the scheduler.

> +	if (pt) {
> +		spin_lock(&this_hctx->lock);
> +		list_splice_tail_init(&list, &this_hctx->dispatch);
> +		spin_unlock(&this_hctx->lock);
> +		blk_mq_run_hw_queue(this_hctx, from_sched);

.. aka here.  But why can't we just use the blk_mq_insert_requests
for this case anyway?

As in just doing a:


-	if (this_hctx->queue->elevator) {
+	if (this_hctx->queue->elevator && !pt) {

?
