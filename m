Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/16] mmc: queue: issue requests in massive parallel
Date: Wed, 01 Mar 2017 13:02:45 +0100
Message-id: <2511235.tiV1t004Z7@amdc3058>
In-reply-to: <20170209153403.9730-16-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-16-linus.walleij@linaro.org>
 <CGME20170301120247epcas1p1ad2be24dc9bbd1218dab8f565fb82b27@epcas1p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:34:02 PM Linus Walleij wrote:
> This makes a crucial change to the issueing mechanism for the
> MMC requests:
> 
> Before commit "mmc: core: move the asynchronous post-processing"
> some parallelism on the read/write requests was achieved by
> speculatively postprocessing a request and re-preprocess and
> re-issue the request if something went wrong, which we discover
> later when checking for an error.
> 
> This is kind of ugly. Instead we need a mechanism like here:
> 
> We issue requests, and when they come back from the hardware,
> we know if they finished successfully or not. If the request
> was successful, we complete the asynchronous request and let a
> new request immediately start on the hardware. If, and only if,
> it returned an error from the hardware we go down the error
> path.
> 
> This is achieved by splitting the work path from the hardware
> in two: a successful path ending up calling down to
> mmc_blk_rw_done_success() and an errorpath calling down to
> mmc_blk_rw_done_error().
> 
> This has a profound effect: we reintroduce the parallelism on
> the successful path as mmc_post_req() can now be called in
> while the next request is in transit (just like prior to
> commit "mmc: core: move the asynchronous post-processing")
> but ALSO we can call mmc_queue_bounce_post() and
> blk_end_request() in parallel.
> 
> The latter has the profound effect of issuing a new request
> again so that we actually need to have at least three requests
> in transit at the same time: we haven't yet dropped the
> reference to our struct mmc_queue_req so we need at least
> three. I put the pool to 4 requests for now.
> 
> I expect the imrovement to be noticeable on systems that use
> bounce buffers since they can now process requests in parallel
> with post-processing their bounce buffers, but I don't have a
> test target for that.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 61 +++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/core/block.h |  4 +++-
>  drivers/mmc/core/core.c  | 27 ++++++++++++++++++---
>  drivers/mmc/core/queue.c |  2 +-
>  4 files changed, 75 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index acca15cc1807..f1008ce5376b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1622,8 +1622,51 @@ static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
>  	mmc_restart_areq(mq->card->host, &mq_rq->areq);
>  }
>  
> -void mmc_blk_rw_done(struct mmc_async_req *areq,
> -		     enum mmc_blk_status status)
> +/**
> + * Final handling of an asynchronous request if there was no error.
> + * This is the common path that we take when everything is nice
> + * and smooth. The status from the command is always MMC_BLK_SUCCESS.
> + */
> +void mmc_blk_rw_done_success(struct mmc_async_req *areq)
> +{
> +	struct mmc_queue_req *mq_rq;
> +	struct mmc_blk_request *brq;
> +	struct mmc_blk_data *md;
> +	struct request *old_req;
> +	bool req_pending;
> +	int type;
> +
> +	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
> +	md = mq_rq->mq->blkdata;
> +	brq = &mq_rq->brq;
> +	old_req = mq_rq->req;
> +	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
> +
> +	mmc_queue_bounce_post(mq_rq);
> +	mmc_blk_reset_success(md, type);
> +	req_pending = blk_end_request(old_req, 0,
> +				      brq->data.bytes_xfered);
> +	/*
> +	 * If the blk_end_request function returns non-zero even
> +	 * though all data has been transferred and no errors
> +	 * were returned by the host controller, it's a bug.
> +	 */
> +	if (req_pending) {
> +		pr_err("%s BUG rq_tot %d d_xfer %d\n",
> +		       __func__, blk_rq_bytes(old_req),
> +		       brq->data.bytes_xfered);

What has happened to mmc_blk_rw_cmd_abort() call?

> +		return;
> +	}
> +}
> +
> +/**
> + * Error, recapture, retry etc for asynchronous requests.
> + * This is the error path that we take when there is bad status
> + * coming back from the hardware and we need to do a bit of
> + * cleverness.
> + */
> +void mmc_blk_rw_done_error(struct mmc_async_req *areq,
> +			   enum mmc_blk_status status)
>  {
>  	struct mmc_queue *mq;
>  	struct mmc_queue_req *mq_rq;
> @@ -1652,6 +1695,8 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  
>  	switch (status) {
>  	case MMC_BLK_SUCCESS:
> +		pr_err("%s: MMC_BLK_SUCCESS on error path\n", __func__);
> +		/* This should not happen: anyway fall through */
>  	case MMC_BLK_PARTIAL:
>  		/*
>  		 * A block was successfully transferred.
> @@ -1660,18 +1705,6 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  
>  		req_pending = blk_end_request(old_req, 0,
>  					      brq->data.bytes_xfered);
> -		/*
> -		 * If the blk_end_request function returns non-zero even
> -		 * though all data has been transferred and no errors
> -		 * were returned by the host controller, it's a bug.
> -		 */
> -		if (status == MMC_BLK_SUCCESS && req_pending) {
> -			pr_err("%s BUG rq_tot %d d_xfer %d\n",
> -			       __func__, blk_rq_bytes(old_req),
> -			       brq->data.bytes_xfered);
> -			mmc_blk_rw_cmd_abort(card, old_req);
> -			return;
> -		}
>  		break;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
