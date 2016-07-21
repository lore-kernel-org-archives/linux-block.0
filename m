Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44689 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcGUF67 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 01:58:59 -0400
Date: Wed, 20 Jul 2016 22:58:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH 5/6] block: Introduce BLKPREP_DONE
Message-ID: <20160721055857.GC14568@infradead.org>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-6-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468934439-93579-6-git-send-email-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +++ b/block/blk-core.c
> @@ -2462,9 +2462,13 @@ struct request *blk_peek_request(struct request_queue *q)
>  
>  			rq = NULL;
>  			break;
> -		} else if (ret == BLKPREP_KILL || ret == BLKPREP_INVALID) {
> +		} else if (ret == BLKPREP_KILL || ret == BLKPREP_INVALID ||
> +			   ret == BLKPREP_DONE) {
>  			int err = (ret == BLKPREP_INVALID) ? -EREMOTEIO : -EIO;
>  
> +			if (ret == BLKPREP_DONE)
> +				err = 0;
> +

Please just use a proper switch statement for the return values.

static void blk_prep_end_request(struct request *req, int error)
{
	rq->cmd_flags |= REQ_QUIET;
	blk_start_request(rq);
	__blk_end_request_all(rq, error);
}

struct request *blk_peek_request(struct request_queue *q)
{

	...


	switch (ret) {
	...
	case BLKPREP_KILL:
		blk_prep_end_request(rq, -EIO);
		break;
	case BLKPREP_INVALID:
		blk_prep_end_request(rq, -EREMOTEIO);
		break;
	case BLKPREP_DONE:
		blk_prep_end_request(rq, 0);
		break;
	...
}
