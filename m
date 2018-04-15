Return-Path: <ming.lei@redhat.com>
Date: Sun, 15 Apr 2018 10:16:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: handle short DIO reads
Message-ID: <20180415021643.GB11030@ming.t460p>
References: <1523658636-2212-1-git-send-email-axboe@kernel.dk>
 <1523658636-2212-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523658636-2212-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 13, 2018 at 04:30:36PM -0600, Jens Axboe wrote:
> We ran into an issue with loop and btrfs, where btrfs would complain about
> checksum errors. It turns out that is because we don't handle short reads
> at all, we just zero fill the remainder. Worse than that, we don't handle
> the filling properly, which results in loop trying to advance a single
> bio by much more than its size, since it doesn't take chaining into
> account.
> 
> Handle short reads appropriately, by simply retrying at the new correct
> offset. End the remainder of the request with EIO, if we get a 0 read.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/loop.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 8b2fde2109fc..5d4e31655d96 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -451,16 +451,36 @@ static int lo_req_flush(struct loop_device *lo, struct request *rq)
>  static void lo_complete_rq(struct request *rq)
>  {
>  	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> +	blk_status_t ret = BLK_STS_OK;
>  
> -	if (unlikely(req_op(rq) == REQ_OP_READ && cmd->use_aio &&
> -		     cmd->ret >= 0 && cmd->ret < blk_rq_bytes(rq))) {
> -		struct bio *bio = rq->bio;
> -
> -		bio_advance(bio, cmd->ret);
> -		zero_fill_bio(bio);
> +	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
> +	    req_op(rq) != REQ_OP_READ) {
> +		if (cmd->ret < 0)
> +			ret = BLK_STS_IOERR;
> +		goto end_io;
>  	}
>  
> -	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
> +	/*
> +	 * Short READ - if we got some data, advance our request and
> +	 * retry it. If we got no data, end the rest with EIO.
> +	 */
> +	if (cmd->ret) {
> +		blk_update_request(rq, BLK_STS_OK, cmd->ret);
> +		cmd->ret = 0;
> +		blk_mq_requeue_request(rq, true);
> +	} else {
> +		if (cmd->use_aio) {
> +			struct bio *bio = rq->bio;
> +
> +			while (bio) {
> +				zero_fill_bio(bio);
> +				bio = bio->bi_next;
> +			}
> +		}
> +		ret = BLK_STS_IOERR;
> +end_io:
> +		blk_mq_end_request(rq, ret);
> +	}
>  }
>  
>  static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
> -- 
> 2.7.4
> 

Looks fine, short read will be guaranteed to complete when zero read
is triggered.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
