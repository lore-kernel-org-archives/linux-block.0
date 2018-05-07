Return-Path: <hch@lst.de>
Date: Mon, 7 May 2018 11:53:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@redhat.com, hch@lst.de
Subject: Re: [PATCH 2/3] blk-wbt: account any writing command as a write
Message-ID: <20180507095326.GB25210@lst.de>
References: <1525360843-6504-1-git-send-email-axboe@kernel.dk> <1525360843-6504-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525360843-6504-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 03, 2018 at 09:20:42AM -0600, Jens Axboe wrote:
> We currently special case WRITE and FLUSH, but we should really
> just include any command with the write bit set. This ensures
> that we account DISCARD.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index f92fc84b5e2c..3e34b41bcefc 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -701,7 +701,7 @@ static int wbt_data_dir(const struct request *rq)
>  
>  	if (op == REQ_OP_READ)
>  		return READ;
> -	else if (op == REQ_OP_WRITE || op == REQ_OP_FLUSH)
> +	else if (op_is_write(op))
>  		return WRITE;
>  
>  	/* don't account */

But this whole function smells, the return value is an array
index, so instead of abusing read/write this should return 0 or 1
and be called _idx or similar.  But I guess that is a question for the
higher level interface.
