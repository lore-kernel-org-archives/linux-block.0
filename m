Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CCC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA06127A
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhDZOg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:36:28 -0400
Received: from verein.lst.de ([213.95.11.211]:41526 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDZOg2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:36:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17FA668C4E; Mon, 26 Apr 2021 16:35:44 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:35:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
Message-ID: <20210426143543.GA20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:54PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..b960ad187ba5 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>  
> +static bool blk_rq_is_poll(struct request *rq)
> +{
> +	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +}
> +
>  /**
>   * blk_execute_rq - insert a request into queue for execution
>   * @bd_disk:	matching gendisk
> @@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  
>  	/* Prevent hang_check timer from firing at us during very long I/O */
>  	hang_check = sysctl_hung_task_timeout_secs;
> -	if (hang_check)
> +	if (blk_rq_is_poll(rq)) {
> +		do {
> +			blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
> +			cond_resched();
> +		} while (!completion_done(&wait));

I think it would be nice to split this into a little helper.

> +	} else if (hang_check)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));

And while we're at it, it would be nice to split this out as well and
document this mess..
