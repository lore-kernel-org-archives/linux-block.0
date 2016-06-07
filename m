Return-Path: <linux-block-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:51525 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbcFGEux (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2016 00:50:53 -0400
Date: Tue, 7 Jun 2016 05:50:49 +0100
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, snitzer@redhat.com, martin.petersen@oracle.com,
	hch@infradead.org, Kernel-team@fb.com,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160607045049.GA10921@sucs.org>
References: <20160606223357.GA52883@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160606223357.GA52883@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 06, 2016 at 03:33:58PM -0700, Shaohua Li wrote:
> blkdev_issue_zeroout try discard/writesame first, if they fail, zeroout
> fallback to regular write. The problem is discard/writesame doesn't
> return error for -EOPNOTSUPP, then zeroout can't do fallback and leave
> disk data not changed. zeroout should have guaranteed zero-fill
> behavior.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=118581
> 
> V2: move the return value policy to blkdev_issue_discard and
> delete the policy for blkdev_issue_write_same (Martin)
> 
> Cc: Sitsofe Wheeler <sitsofe@yahoo.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  block/blk-lib.c | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 23d7f30..a3a26c8 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -84,6 +84,28 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(__blkdev_issue_discard);
>  
> +static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags,
> +		int *io_err)
> +{
> +	int type = REQ_WRITE | REQ_DISCARD;
> +	struct bio *bio = NULL;
> +	struct blk_plug plug;
> +	int ret;
> +
> +	if (flags & BLKDEV_DISCARD_SECURE)
> +		type |= REQ_SECURE;
> +
> +	blk_start_plug(&plug);
> +	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, type,
> +			&bio);
> +	if (!ret && bio)
> +		*io_err = submit_bio_wait(type, bio);
> +	blk_finish_plug(&plug);
> +
> +	return ret;
> +}
> +
>  /**
>   * blkdev_issue_discard - queue a discard
>   * @bdev:	blockdev to issue discard for
> @@ -98,23 +120,12 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
>  int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
>  {
> -	int type = REQ_WRITE | REQ_DISCARD;
> -	struct bio *bio = NULL;
> -	struct blk_plug plug;
> -	int ret;
> +	int ret, io_err;
>  
> -	if (flags & BLKDEV_DISCARD_SECURE)
> -		type |= REQ_SECURE;
> -
> -	blk_start_plug(&plug);
> -	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, type,
> -			&bio);
> -	if (!ret && bio) {
> -		ret = submit_bio_wait(type, bio);
> -		if (ret == -EOPNOTSUPP)
> -			ret = 0;
> -	}
> -	blk_finish_plug(&plug);
> +	ret = do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
> +		flags, &io_err);
> +	if (!ret && io_err != -EOPNOTSUPP)
> +		ret = io_err;

Because io_err is always consulted if ret is not true shouldn't it be
explicitly initialized to 0 before the call to do_blkdev_issue_discard
(as do_blkdev_issue_discard will only set io_err if bio returned true)?

Perhaps there's an argument that do_blkdev_issue_discard should always
set io_err on all its paths rather than just on errors in case the
caller hasn't initialized it - is there an existing kernel pattern for
this)?

>  
>  	return ret;
>  }
> @@ -167,7 +178,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
>  
>  	if (bio)
>  		ret = submit_bio_wait(REQ_WRITE | REQ_WRITE_SAME, bio);
> -	return ret != -EOPNOTSUPP ? ret : 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(blkdev_issue_write_same);
>  
> @@ -236,9 +247,11 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  			 sector_t nr_sects, gfp_t gfp_mask, bool discard)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> +	int io_err = 0;
>  
>  	if (discard && blk_queue_discard(q) && q->limits.discard_zeroes_data &&
> -	    blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0) == 0)
> +	    (do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0,
> +				     &io_err) == 0 && io_err == 0))
>  		return 0;
>  
>  	if (bdev_write_same(bdev) &&
> -- 
> 2.8.0.rc2

-- 
Sitsofe | http://sucs.org/~sits/
