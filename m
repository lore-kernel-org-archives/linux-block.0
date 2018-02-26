Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 26 Feb 2018 12:52:45 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 1/4] block: fix the count of PGPGOUT for WRITE_SAME
Message-ID: <20180226205245.GA9157@vader.DHCP.thefacebook.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
 <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 26, 2018 at 08:04:35PM +0800, Jiufei Xue wrote:
> The vm counters is counted in sectors, so we should do the conversation
> in submit_bio.
> 
> Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and
> partitions index")

The Fixes line shouldn't be wrapped. Besides that,

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  block/blk-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2d1a7bb..6d82c4f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2434,7 +2434,7 @@ blk_qc_t submit_bio(struct bio *bio)
>  		unsigned int count;
>  
>  		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
> -			count = queue_logical_block_size(bio->bi_disk->queue);
> +			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
>  		else
>  			count = bio_sectors(bio);
>  
> -- 
> 1.9.4
> 
