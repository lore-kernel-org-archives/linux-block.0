Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B064C2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5880B20700
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgDXGPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:15:35 -0400
Received: from verein.lst.de ([213.95.11.211]:33314 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgDXGPf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 02:15:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E423A68CEC; Fri, 24 Apr 2020 08:15:29 +0200 (CEST)
Date:   Fri, 24 Apr 2020 08:15:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200424061529.GA23303@lst.de>
References: <20200423210523.52833-1-sqazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423210523.52833-1-sqazi@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> index 74cedea56034..b69b780351c1 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -84,12 +84,17 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>   * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
>   * its queue by itself in its completion handler, so we don't need to
>   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> + *
> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.  This is necessary to avoid
> + * starving flushes.
>   */

Please use up all 80 chars for your comments (just like the existing
part of the comment).

>   * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
>   * its queue by itself in its completion handler, so we don't need to
>   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> + *
> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.  This is necessary to avoid
> + * starving flushes.

Same here.

> +again:
> +	run_again = false;
> +
>  	/*
>  	 * If we have previous entries on our dispatch list, grab them first for
>  	 * more fair dispatch.
> @@ -208,19 +236,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  		blk_mq_sched_mark_restart_hctx(hctx);
>  		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
>  			if (has_sched_dispatch)
> -				blk_mq_do_dispatch_sched(hctx);
> +				run_again = blk_mq_do_dispatch_sched(hctx);
>  			else
> -				blk_mq_do_dispatch_ctx(hctx);
> +				run_again = blk_mq_do_dispatch_ctx(hctx);
>  		}
>  	} else if (has_sched_dispatch) {
> -		blk_mq_do_dispatch_sched(hctx);
> +		run_again = blk_mq_do_dispatch_sched(hctx);
>  	} else if (hctx->dispatch_busy) {
>  		/* dequeue request one by one from sw queue if queue is busy */
> -		blk_mq_do_dispatch_ctx(hctx);
> +		run_again = blk_mq_do_dispatch_ctx(hctx);
>  	} else {
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>  		blk_mq_dispatch_rq_list(q, &rq_list, false);
>  	}
> +
> +	if (run_again) {
> +		if (!restarted) {
> +			restarted = true;
> +			goto again;
> +		}
> +
> +		blk_mq_run_hw_queue(hctx, true);
> +	}

This is a weird loop.  I'd split the code betweem the again label and
the run_again check here into a __blk_mq_sched_dispatch_requests
helper, and then you can do:

	if (__blk_mq_sched_dispatch_requests()) {
		if (__blk_mq_sched_dispatch_requests())
			blk_mq_run_hw_queue(hctx, true);
	}

here.  Preferably with ha good comment explaining the logic.
