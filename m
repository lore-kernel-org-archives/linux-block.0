Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35811 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdHXR5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 13:57:41 -0400
Received: by mail-pg0-f50.google.com with SMTP id 63so1053238pgc.2
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 10:57:41 -0700 (PDT)
Date: Thu, 24 Aug 2017 10:57:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 2/2] block/loop: allow request merge for directio mode
Message-ID: <20170824175739.GC6964@vader.DHCP.thefacebook.com>
References: <cover.1503531709.git.shli@fb.com>
 <2fbfb61a927561c3c251fff8f6e75d7544df9eed.1503531709.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2fbfb61a927561c3c251fff8f6e75d7544df9eed.1503531709.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 23, 2017 at 04:49:24PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Currently loop disables merge. While it makes sense for buffer IO mode,
> directio mode can benefit from request merge. Without merge, loop could
> send small size IO to underlayer disk and harm performance.

A couple of nits on comments below, besides that

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  drivers/block/loop.c | 43 +++++++++++++++++++++++++++++++++++--------
>  drivers/block/loop.h |  1 +
>  2 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 428da07..1bfa3ff 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -213,10 +213,13 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>  	 */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  	lo->use_dio = use_dio;
> -	if (use_dio)
> +	if (use_dio) {
> +		queue_flag_clear_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
>  		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
> -	else
> +	} else {
> +		queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
>  		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> +	}

Could you please also update the comment in loop_add() where we set
QUEUE_FLAG_NOMERGES to say something like

	/*
	 * By default we do buffered I/O, so it doesn't make sense to
	 * enable merging because the I/O submitted to backing file is
	 * handled page by page. We enable merging when switching to
	 * direct I/O mode.
	 */

>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  }
>  
> @@ -464,6 +467,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
>  {
>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>  
> +	kfree(cmd->bvec);
> +	cmd->bvec = NULL;
>  	cmd->ret = ret;
>  	blk_mq_complete_request(cmd->rq);
>  }
> @@ -473,22 +478,44 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  {
>  	struct iov_iter iter;
>  	struct bio_vec *bvec;
> -	struct bio *bio = cmd->rq->bio;
> +	struct request *rq = cmd->rq;
> +	struct bio *bio = rq->bio;
>  	struct file *file = lo->lo_backing_file;
> +	unsigned int offset;
> +	int segments = 0;
>  	int ret;
>  
> -	/* nomerge for loop request queue */
> -	WARN_ON(cmd->rq->bio != cmd->rq->biotail);
> +	if (rq->bio != rq->biotail) {
> +		struct req_iterator iter;
> +		struct bio_vec tmp;
> +
> +		__rq_for_each_bio(bio, rq)
> +			segments += bio_segments(bio);
> +		bvec = kmalloc(sizeof(struct bio_vec) * segments, GFP_KERNEL);
> +		if (!bvec)
> +			return -EIO;
> +		cmd->bvec = bvec;
> +
> +		rq_for_each_segment(tmp, rq, iter) {
> +			*bvec = tmp;
> +			bvec++;
> +		}
> +		bvec = cmd->bvec;
> +		offset = 0;
> +	} else {
> +		offset = bio->bi_iter.bi_bvec_done;
> +		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> +		segments = bio_segments(bio);
> +	}
>  
> -	bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>  	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
> -		      bio_segments(bio), blk_rq_bytes(cmd->rq));
> +		      segments, blk_rq_bytes(rq));
>  	/*
>  	 * This bio may be started from the middle of the 'bvec'
>  	 * because of bio splitting, so offset from the bvec must
>  	 * be passed to iov iterator
>  	 */

This comment should be moved above to where you do

		offset = bio->bi_iter.bi_bvec_done;

> -	iter.iov_offset = bio->bi_iter.bi_bvec_done;
> +	iter.iov_offset = offset;
>  
>  	cmd->iocb.ki_pos = pos;
>  	cmd->iocb.ki_filp = file;
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index fecd3f9..bc9cf91 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -72,6 +72,7 @@ struct loop_cmd {
>  	bool use_aio;           /* use AIO interface to handle I/O */
>  	long ret;
>  	struct kiocb iocb;
> +	struct bio_vec *bvec;
>  };
>  
>  /* Support for loadable transfer modules */
> -- 
> 2.9.5
> 
