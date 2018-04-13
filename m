Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: fix aio/dio end of request clearing
From: Jens Axboe <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
References: <64287b95-4e2d-9220-acd5-6528954e8b60@kernel.dk>
Message-ID: <3e65381a-d450-40c3-b2fd-38870a386e7c@kernel.dk>
Date: Fri, 13 Apr 2018 12:31:33 -0600
MIME-Version: 1.0
In-Reply-To: <64287b95-4e2d-9220-acd5-6528954e8b60@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/12/18 12:52 PM, Jens Axboe wrote:
> If we read more than the user asked for, we zero fill the last
> part. But the current code assumes that the request has just
> one bio, and since that's not guaranteed to be true, we can
> run into a situation where we attempt to advance a bio by
> a bigger amount than its size.
> 
> Handle the zero filling appropriately, regardless of what bio
> ends up needing to be cleared.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c9d04497a415..d3aa96a2f369 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -455,9 +455,22 @@ static void lo_complete_rq(struct request *rq)
>  	if (unlikely(req_op(cmd->rq) == REQ_OP_READ && cmd->use_aio &&
>  		     cmd->ret >= 0 && cmd->ret < blk_rq_bytes(cmd->rq))) {
>  		struct bio *bio = cmd->rq->bio;
> +		long left = cmd->ret;
>  
> -		bio_advance(bio, cmd->ret);
> -		zero_fill_bio(bio);
> +		while (left >= bio->bi_iter.bi_size) {
> +			left -= bio->bi_iter.bi_size;
> +			bio = bio->bi_next;
> +			if (WARN_ON_ONCE(!bio))
> +				break;
> +		}
> +		while (bio) {
> +			if (left) {
> +				bio_advance(bio, left);
> +				left = 0;
> +			}
> +			zero_fill_bio(bio);
> +			bio = bio->bi_next;
> +		}
>  	}

Ignore this one, new version coming.

-- 
Jens Axboe
