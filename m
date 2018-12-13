Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2316C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D97D20811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D97D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLMIYp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:24:45 -0500
Received: from verein.lst.de ([213.95.11.211]:39288 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMIYp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 03:24:45 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 52C7768D8D; Thu, 13 Dec 2018 09:24:44 +0100 (CET)
Date:   Thu, 13 Dec 2018 09:24:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/6] block: introduce blk_execute_rq_polled
Message-ID: <20181213082444.GA869@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me> <20181213063819.13614-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213063819.13614-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:13PM -0800, Sagi Grimberg wrote:
> Used forsynchronous requests that needs polling. If we are knowingly
> sending a request down to a poll queue, we need a synchronous interface
> to poll for its completion.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-exec.c       | 29 +++++++++++++++++++++++++++++
>  block/blk-mq.c         |  8 --------
>  include/linux/blk-mq.h |  8 ++++++++
>  include/linux/blkdev.h |  2 ++
>  4 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index a34b7d918742..572032d60001 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -90,3 +90,32 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
>  		wait_for_completion_io(&wait);
>  }
>  EXPORT_SYMBOL(blk_execute_rq);
> +
> +/**
> + * blk_execute_rq_polled - execute a request and poll for its completion
> + * @q:		queue to insert the request in
> + * @bd_disk:	matching gendisk
> + * @rq:		request to insert
> + * @at_head:    insert request at head or tail of queue
> + *
> + * Description:
> + *    Insert a fully prepared request at the back of the I/O scheduler queue
> + *    for execution and wait for completion.
> + */
> +void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
> +		   struct request *rq, int at_head)
> +{
> +	DECLARE_COMPLETION_ONSTACK(wait);
> +
> +	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> +
> +	rq->cmd_flags |= REQ_HIPRI;
> +	rq->end_io_data = &wait;
> +	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
> +
> +	while (!completion_done(&wait)) {
> +		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
> +		cond_resched();
> +	}

Can we just open code this in nvme for now?

> +static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)

Too long line.

> +{
> +	if (rq->tag != -1)
> +		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
> +
> +	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
> +}

Also these are only two users of blk_tag_to_qc_t, it might be worth
to fold it into request_to_qc_t:

static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
		struct request *rq)
{
	if (rq->tag != -1)
		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
			BLK_QC_T_INTERNAL;
}
