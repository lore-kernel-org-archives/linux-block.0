Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50741 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbcKRHqT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 02:46:19 -0500
Date: Thu, 17 Nov 2016 23:46:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
Message-ID: <20161118074615.GA9077@infradead.org>
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 17, 2016 at 02:17:11PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
> 
> This adds a new block layer operation to zero out a range of
> LBAs. This allows to implement zeroing for devices that don't use
> either discard with a predictable zero pattern or WRITE SAME of zeroes.
> The prominent example of that is NVMe with the Write Zeroes command,
> but in the future this should also help with improving the way
> zeroing discards work.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>

I think you'll need to resend the whole series so that nvme can set
the maximum discard sectors value.

> @@ -575,9 +575,10 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
>  	const int op = bio_op(bio);
>  
>  	/*
> -	 * If not a WRITE (or a discard), do nothing
> +	 * If not a WRITE (or a discard or write zeroes), do nothing
>  	 */
> -	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD))
> +	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD ||
> +				op == REQ_OP_WRITE_ZEROES))
>  		return false;

Jens: should we really throttle for discard or write zeroes here?
Those aren't really writeback driven..

> +static inline unsigned int bdev_write_zeroes(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return q->limits.max_write_zeroes_sectors;
> +
> +	return 0;

If this returns a sector value I'd name it bdev_write_zeroes_sectors.

Otherwise this looks great.
