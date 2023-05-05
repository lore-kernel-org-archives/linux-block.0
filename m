Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B048C77B7D
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 05:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjEEF4d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 01:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEF4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 01:56:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BEF1734
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 22:56:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E32E68AA6; Fri,  5 May 2023 07:56:27 +0200 (CEST)
Date:   Fri, 5 May 2023 07:56:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 08/11] block: mq-deadline: Reduce lock contention
Message-ID: <20230505055626.GD11748@lst.de>
References: <20230503225208.2439206-1-bvanassche@acm.org> <20230503225208.2439206-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503225208.2439206-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 03:52:05PM -0700, Bart Van Assche wrote:
> blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
> nested locking of dd->lock and dd->zone_lock by unlocking dd->lock
> before calling blk_mq_free_requests().

Do you have a reproducer for this that we could wire up in blktests?
Also please add a Fixes tag and move it to the beginning of the series.

>  static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  			      blk_insert_t flags)
> +	__must_hold(dd->lock)
>  {
>  	struct request_queue *q = hctx->queue;
>  	struct deadline_data *dd = q->elevator->elevator_data;
> @@ -784,7 +785,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	}
>  
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
> +		spin_unlock(&dd->lock);
>  		blk_mq_free_requests(&free);
> +		spin_lock(&dd->lock);
>  		return;

Fiven that free is a list, why don't we declare the free list in
dd_insert_requests and just pass it to dd_insert_request and then do
one single blk_mq_free_requests call after the loop?
