Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51515 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998698AbdD1Oth (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:49:37 -0400
Date: Fri, 28 Apr 2017 16:49:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH 5/6] mtip32xx: convert internal command issue to block
        IO path
Message-ID: <20170428144936.GA1519@lst.de>
References: <1493389911-19512-1-git-send-email-axboe@fb.com> <1493389911-19512-6-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493389911-19512-6-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> @@ -1088,6 +1088,13 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
>  	return -EFAULT;
>  }
>  
> +struct mtip_int_cmd {
> +	int fis_len;
> +	dma_addr_t buffer;
> +	int buf_len;
> +	u32 opts;
> +};

I know passing the dma_addr is probably the easier conversion for now,
but using blk_rq_map_kern would be the cleaner way going forward.

> +	/* insert request and run queue */
> +	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
> +
> +	wait_for_completion(&wait);

Why not blk_execute_rq?

> @@ -3770,6 +3803,9 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	mtip_init_cmd_header(rq);
>  
> +	if (rq->rq_flags & RQF_RESERVED)

And in fact I don't think we'd even need the helper I suggested before,
we can just check for REQ_OP_DRV_IN here.

But while we're at it - one oddity in mtip32xx is that it converts
discards to an internal command from ->queue_rq, so we end up using
two requests for it.  Just handling discards here would be a nice
improvement.  It would also easily allow the driver to support ranged
trims..

But I guess I'm simply to picky and we should just fix up the worst issues
first..
