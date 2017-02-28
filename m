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
Subject: Re: [PATCH 13/16] mmc: queue: issue struct mmc_queue_req items
Date: Tue, 28 Feb 2017 19:10:06 +0100
Message-id: <6338776.YcFVTrvOsv@amdc3058>
In-reply-to: <20170209153403.9730-14-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-14-linus.walleij@linaro.org>
 <CGME20170228181009epcas1p4ca0e714214097d07d7172182ba8e032b@epcas1p4.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:34:00 PM Linus Walleij wrote:
> Instead of passing two pointers around and messing and reassigning
> to the left and right, issue mmc_queue_req and dereference
> the queue from the request where needed. The struct mmc_queue_req
> is the thing that has a lifecycle after all: this is what we are
> keepin in out queue. Augment all users to be passed the struct
> mmc_queue_req as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 88 ++++++++++++++++++++++++------------------------
>  drivers/mmc/core/block.h |  5 ++-
>  drivers/mmc/core/queue.c |  6 ++--
>  3 files changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4952a105780e..628a22b9bf41 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1151,9 +1151,9 @@ int mmc_access_rpmb(struct mmc_queue *mq)
>  	return false;
>  }
>  
> -static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_issue_discard_rq(struct mmc_queue_req *mq_rq)
>  {
> -	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_blk_data *md = mq_rq->mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
>  	unsigned int from, nr, arg;
>  	int err = 0, type = MMC_BLK_DISCARD;
> @@ -1163,8 +1163,8 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  		goto fail;
>  	}
>  
> -	from = blk_rq_pos(req);
> -	nr = blk_rq_sectors(req);
> +	from = blk_rq_pos(mq_rq->req);
> +	nr = blk_rq_sectors(mq_rq->req);
>  
>  	if (mmc_can_discard(card))
>  		arg = MMC_DISCARD_ARG;
> @@ -1188,13 +1188,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  	if (!err)
>  		mmc_blk_reset_success(md, type);
>  fail:
> -	blk_end_request(req, err, blk_rq_bytes(req));
> +	blk_end_request(mq_rq->req, err, blk_rq_bytes(mq_rq->req));
>  }
>  
> -static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> -				       struct request *req)
> +static void mmc_blk_issue_secdiscard_rq(struct mmc_queue_req *mq_rq)
>  {
> -	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_blk_data *md = mq_rq->mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
>  	unsigned int from, nr, arg;
>  	int err = 0, type = MMC_BLK_SECDISCARD;
> @@ -1204,8 +1203,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>  		goto out;
>  	}
>  
> -	from = blk_rq_pos(req);
> -	nr = blk_rq_sectors(req);
> +	from = blk_rq_pos(mq_rq->req);
> +	nr = blk_rq_sectors(mq_rq->req);
>  
>  	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
>  		arg = MMC_SECURE_TRIM1_ARG;
> @@ -1253,12 +1252,12 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>  	if (!err)
>  		mmc_blk_reset_success(md, type);
>  out:
> -	blk_end_request(req, err, blk_rq_bytes(req));
> +	blk_end_request(mq_rq->req, err, blk_rq_bytes(mq_rq->req));
>  }
>  
> -static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_issue_flush(struct mmc_queue_req *mq_rq)
>  {
> -	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_blk_data *md = mq_rq->mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
>  	int ret = 0;
>  
> @@ -1266,7 +1265,7 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
>  	if (ret)
>  		ret = -EIO;
>  
> -	blk_end_request_all(req, ret);
> +	blk_end_request_all(mq_rq->req, ret);
>  }
>  
>  /*
> @@ -1614,11 +1613,13 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
>   * @mq: the queue with the card and host to restart
>   * @req: a new request that want to be started after the current one
>   */
> -static void mmc_blk_rw_try_restart(struct mmc_queue *mq)
> +static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
>  {
> +	struct mmc_queue *mq = mq_rq->mq;
> +
>  	/* Proceed and try to restart the current async request */
> -	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
> -	mmc_restart_areq(mq->card->host, &mq->mqrq_cur->areq);
> +	mmc_blk_rw_rq_prep(mq_rq, mq->card, 0, mq);
> +	mmc_restart_areq(mq->card->host, &mq_rq->areq);
>  }
>  
>  void mmc_blk_rw_done(struct mmc_async_req *areq,
> @@ -1676,11 +1677,11 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
>  		if (mmc_blk_reset(md, host, type)) {
>  			mmc_blk_rw_cmd_abort(card, old_req);
> -			mmc_blk_rw_try_restart(mq);
> +			mmc_blk_rw_try_restart(mq_rq);
>  			return;
>  		}
>  		if (!req_pending) {
> -			mmc_blk_rw_try_restart(mq);
> +			mmc_blk_rw_try_restart(mq_rq);
>  			return;
>  		}
>  		break;
> @@ -1693,7 +1694,7 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  		if (!mmc_blk_reset(md, host, type))
>  			break;
>  		mmc_blk_rw_cmd_abort(card, old_req);
> -		mmc_blk_rw_try_restart(mq);
> +		mmc_blk_rw_try_restart(mq_rq);
>  		return;
>  	case MMC_BLK_DATA_ERR: {
>  		int err;
> @@ -1702,7 +1703,7 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  			break;
>  		if (err == -ENODEV) {
>  			mmc_blk_rw_cmd_abort(card, old_req);
> -			mmc_blk_rw_try_restart(mq);
> +			mmc_blk_rw_try_restart(mq_rq);
>  			return;
>  		}
>  		/* Fall through */
> @@ -1723,19 +1724,19 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  		req_pending = blk_end_request(old_req, -EIO,
>  					      brq->data.blksz);
>  		if (!req_pending) {
> -			mmc_blk_rw_try_restart(mq);
> +			mmc_blk_rw_try_restart(mq_rq);
>  			return;
>  		}
>  		break;
>  	case MMC_BLK_NOMEDIUM:
>  		mmc_blk_rw_cmd_abort(card, old_req);
> -		mmc_blk_rw_try_restart(mq);
> +		mmc_blk_rw_try_restart(mq_rq);
>  		return;
>  	default:
>  		pr_err("%s: Unhandled return value (%d)",
>  		       old_req->rq_disk->disk_name, status);
>  		mmc_blk_rw_cmd_abort(card, old_req);
> -		mmc_blk_rw_try_restart(mq);
> +		mmc_blk_rw_try_restart(mq_rq);
>  		return;
>  	}
>  
> @@ -1747,15 +1748,16 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  		mmc_blk_rw_rq_prep(mq_rq, card,
>  				   disable_multi, mq);
>  		mq_rq->brq.retune_retry_done = retune_retry_done;
> -		mmc_restart_areq(host, &mq->mqrq_cur->areq);
> +		mmc_restart_areq(host, &mq_rq->areq);
>  	}
>  }
>  
> -static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
> +static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
>  {
> +	struct mmc_queue *mq = mq_rq->mq;
>  	struct mmc_card *card = mq->card;
>  
> -	if (!new_req) {
> +	if (!mq_rq->req) {
>  		pr_err("%s: NULL request!\n", __func__);
>  		return;
>  	}
> @@ -1765,54 +1767,52 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
>  	 * multiple read or write is allowed
>  	 */
>  	if (mmc_large_sector(card) &&
> -	    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
> +	    !IS_ALIGNED(blk_rq_sectors(mq_rq->req), 8)) {
>  		pr_err("%s: Transfer size is not 4KB sector size aligned\n",
> -		       new_req->rq_disk->disk_name);
> -		mmc_blk_rw_cmd_abort(card, new_req);
> +		       mq_rq->req->rq_disk->disk_name);
> +		mmc_blk_rw_cmd_abort(card, mq_rq->req);
>  		return;
>  	}
>  
> -	mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> -	mmc_start_areq(card->host, &mq->mqrq_cur->areq);
> +	mmc_blk_rw_rq_prep(mq_rq, card, 0, mq);
> +	mmc_start_areq(card->host, &mq_rq->areq);
>  }
>  
> -void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> +void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
>  {
>  	int ret;
> -	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_blk_data *md = mq_rq->mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
>  
>  	ret = mmc_blk_part_switch(card, md);
>  	if (ret) {
> -		if (req) {

dropping of req checking should belong to some earlier patch

> -			blk_end_request_all(req, -EIO);
> -		}
> +		blk_end_request_all(mq_rq->req, -EIO);
>  		return;
>  	}
>  
> -	if (req && req_op(req) == REQ_OP_DISCARD) {
> +	if (req_op(mq_rq->req) == REQ_OP_DISCARD) {

ditto

>  		/* complete ongoing async transfer before issuing discard */
>  		if (card->host->areq) {
>  			wait_for_completion(&card->host->areq->complete);
>  			card->host->areq = NULL;
>  		}
> -		mmc_blk_issue_discard_rq(mq, req);
> -	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {

ditto

> +		mmc_blk_issue_discard_rq(mq_rq);
> +	} else if (req_op(mq_rq->req) == REQ_OP_SECURE_ERASE) {
>  		/* complete ongoing async transfer before issuing secure erase*/
>  		if (card->host->areq) {
>  			wait_for_completion(&card->host->areq->complete);
>  			card->host->areq = NULL;
>  		}
> -		mmc_blk_issue_secdiscard_rq(mq, req);
> -	} else if (req && req_op(req) == REQ_OP_FLUSH) {
> +		mmc_blk_issue_secdiscard_rq(mq_rq);
> +	} else if (req_op(mq_rq->req) == REQ_OP_FLUSH) {

ditto

>  		/* complete ongoing async transfer before issuing flush */
>  		if (card->host->areq) {
>  			wait_for_completion(&card->host->areq->complete);
>  			card->host->areq = NULL;
>  		}
> -		mmc_blk_issue_flush(mq, req);
> +		mmc_blk_issue_flush(mq_rq);
>  	} else {
> -		mmc_blk_issue_rw_rq(mq, req);
> +		mmc_blk_issue_rw_rq(mq_rq);
>  	}
>  }
>  
> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
> index b4b489911599..0326fa5d8217 100644
> --- a/drivers/mmc/core/block.h
> +++ b/drivers/mmc/core/block.h
> @@ -3,10 +3,9 @@
>  
>  struct mmc_async_req;
>  enum mmc_blk_status;
> -struct mmc_queue;
> -struct request;
> +struct mmc_queue_req;
>  
>  void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status);
> -void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
> +void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq);
>  
>  #endif
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index c9f28de7b0f4..c4e1ced55796 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -54,6 +54,7 @@ static int mmc_queue_thread(void *d)
>  	struct mmc_queue *mq = d;
>  	struct request_queue *q = mq->queue;
>  	bool claimed_host = false;
> +	struct mmc_queue_req *mq_rq;
>  
>  	current->flags |= PF_MEMALLOC;
>  
> @@ -65,7 +66,8 @@ static int mmc_queue_thread(void *d)
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		req = blk_fetch_request(q);
>  		mq->asleep = false;
> -		mq->mqrq_cur->req = req;
> +		mq_rq = mq->mqrq_cur;
> +		mq_rq->req = req;
>  		spin_unlock_irq(q->queue_lock);
>  
>  		if (req) {
> @@ -74,7 +76,7 @@ static int mmc_queue_thread(void *d)
>  			if (!claimed_host)
>  				mmc_get_card(mq->card);
>  			set_current_state(TASK_RUNNING);
> -			mmc_blk_issue_rq(mq, req);
> +			mmc_blk_issue_rq(mq_rq);
>  			cond_resched();
>  			/*
>  			 * Current request becomes previous request

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
