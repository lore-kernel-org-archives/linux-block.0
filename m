Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BCC77B70
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 12:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDKMir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjDKMiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 08:38:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37349C6
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 05:38:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF7F268BFE; Tue, 11 Apr 2023 14:38:06 +0200 (CEST)
Date:   Tue, 11 Apr 2023 14:38:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 03/12] block: Send requeued requests to the I/O
 scheduler
Message-ID: <20230411123806.GA14106@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407235822.1672286-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 04:58:13PM -0700, Bart Van Assche wrote:
> -		/*
> -		 * If RQF_DONTPREP, rq has contained some driver specific
> -		 * data, so insert it to hctx dispatch list to avoid any
> -		 * merge.
> -		 */
> -		if (rq->rq_flags & RQF_DONTPREP)
> -			blk_mq_request_bypass_insert(rq, false, false);
> -		else
> -			blk_mq_sched_insert_request(rq, true, false, false);
> +		blk_mq_sched_insert_request(rq, /*at_head=*/true, false, false);

This effectively undoes commit aef1897cd36d, and instead you add
RQF_DONTPREP to RQF_NOMERGE_FLAGS.  This makes sense to be, but should
probably be more clearly documented in the commit log.

> @@ -2065,9 +2057,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  		if (nr_budgets)
>  			blk_mq_release_budgets(q, list);
>  
> -		spin_lock(&hctx->lock);
> -		list_splice_tail_init(list, &hctx->dispatch);
> -		spin_unlock(&hctx->lock);
> +		if (!q->elevator) {
> +			spin_lock(&hctx->lock);
> +			list_splice_tail_init(list, &hctx->dispatch);
> +			spin_unlock(&hctx->lock);
> +		} else {
> +			q->elevator->type->ops.insert_requests(hctx, list,
> +							/*at_head=*/true);
> +		}

But I have no idea how this is related in any way.
