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
Subject: Re: [PATCH 12/16] mmc: queue: stop flushing the pipeline with NULL
Date: Tue, 28 Feb 2017 19:03:06 +0100
Message-id: <1560739.rabct3bM5X@amdc3058>
In-reply-to: <20170209153403.9730-13-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-13-linus.walleij@linaro.org>
 <CGME20170228180309epcas5p317af83f41d3b0426868dcfd660bd0aec@epcas5p3.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:33:59 PM Linus Walleij wrote:
> Remove all the pipeline flush: i.e. repeatedly sending NULL
> down to the core layer to flush out asynchronous requests,
> and also sending NULL after "special" commands to achieve the
> same flush.
> 
> Instead: let the "special" commands wait for any ongoing
> asynchronous transfers using the completion, and apart from
> that expect the core.c and block.c layers to deal with the
> ongoing requests autonomously without any "push" from the
> queue.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 80 +++++++++++++++++-------------------------------
>  drivers/mmc/core/core.c  | 37 ++++++++++------------
>  drivers/mmc/core/queue.c | 18 ++++++++---
>  include/linux/mmc/core.h |  5 ++-
>  4 files changed, 60 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0bd9070f5f2e..4952a105780e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1753,42 +1753,27 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
>  
>  static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
>  {
> -	enum mmc_blk_status status;
> -	struct mmc_async_req *new_areq;
> -	struct mmc_async_req *old_areq;
>  	struct mmc_card *card = mq->card;
>  
> -	if (!new_req && !mq->mqrq_prev->req)
> +	if (!new_req) {
> +		pr_err("%s: NULL request!\n", __func__);
>  		return;
> +	}
>  
> -	if (new_req) {
> -		/*
> -		 * When 4KB native sector is enabled, only 8 blocks
> -		 * multiple read or write is allowed
> -		 */
> -		if (mmc_large_sector(card) &&
> -		    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
> -			pr_err("%s: Transfer size is not 4KB sector size aligned\n",
> -			       new_req->rq_disk->disk_name);
> -			mmc_blk_rw_cmd_abort(card, new_req);
> -			return;
> -		}
> -
> -		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> -		new_areq = &mq->mqrq_cur->areq;
> -	} else
> -		new_areq = NULL;
> -
> -	old_areq = mmc_start_areq(card->host, new_areq, &status);
> -	if (!old_areq) {
> -		/*
> -		 * We have just put the first request into the pipeline
> -		 * and there is nothing more to do until it is
> -		 * complete.
> -		 */
> +	/*
> +	 * When 4KB native sector is enabled, only 8 blocks
> +	 * multiple read or write is allowed
> +	 */
> +	if (mmc_large_sector(card) &&
> +	    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
> +		pr_err("%s: Transfer size is not 4KB sector size aligned\n",
> +		       new_req->rq_disk->disk_name);
> +		mmc_blk_rw_cmd_abort(card, new_req);
>  		return;
>  	}
> -	/* FIXME: yes, we just disregard the old_areq */
> +
> +	mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> +	mmc_start_areq(card->host, &mq->mqrq_cur->areq);
>  }
>  
>  void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> @@ -1796,48 +1781,39 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  	int ret;
>  	struct mmc_blk_data *md = mq->blkdata;
>  	struct mmc_card *card = md->queue.card;
> -	bool req_is_special = mmc_req_is_special(req);
> -
> -	if (req && !mq->mqrq_prev->req)
> -		/* claim host only for the first request */
> -		mmc_get_card(card);
>  
>  	ret = mmc_blk_part_switch(card, md);
>  	if (ret) {
>  		if (req) {
>  			blk_end_request_all(req, -EIO);
>  		}
> -		goto out;
> +		return;
>  	}
>  
>  	if (req && req_op(req) == REQ_OP_DISCARD) {
>  		/* complete ongoing async transfer before issuing discard */
> -		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> +		if (card->host->areq) {
> +			wait_for_completion(&card->host->areq->complete);
> +			card->host->areq = NULL;
> +		}
>  		mmc_blk_issue_discard_rq(mq, req);
>  	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
>  		/* complete ongoing async transfer before issuing secure erase*/
> -		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> +		if (card->host->areq) {
> +			wait_for_completion(&card->host->areq->complete);
> +			card->host->areq = NULL;
> +		}
>  		mmc_blk_issue_secdiscard_rq(mq, req);
>  	} else if (req && req_op(req) == REQ_OP_FLUSH) {
>  		/* complete ongoing async transfer before issuing flush */
> -		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> +		if (card->host->areq) {
> +			wait_for_completion(&card->host->areq->complete);
> +			card->host->areq = NULL;
> +		}
>  		mmc_blk_issue_flush(mq, req);
>  	} else {
>  		mmc_blk_issue_rw_rq(mq, req);
>  	}
> -
> -out:
> -	if (!req || req_is_special)
> -		/*
> -		 * Release host when there are no more requests
> -		 * and after special request(discard, flush) is done.
> -		 * In case sepecial request, there is no reentry to
> -		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
> -		 */
> -		mmc_put_card(card);
>  }
>  
>  static inline int mmc_blk_readonly(struct mmc_card *card)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 34337ef6705e..03c290e5e2c9 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -667,42 +667,37 @@ EXPORT_SYMBOL(mmc_restart_areq);
>   *	return the completed request. If there is no ongoing request, NULL
>   *	is returned without waiting. NULL is not an error condition.
>   */
> -struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
> -				     struct mmc_async_req *areq,
> -				     enum mmc_blk_status *ret_stat)
> +int mmc_start_areq(struct mmc_host *host,
> +		   struct mmc_async_req *areq)
>  {
> -	enum mmc_blk_status status;
> -	int start_err = 0;
> +	int ret;
>  	struct mmc_async_req *previous = host->areq;
>  
>  	/* Prepare a new request */
> -	if (areq)
> -		mmc_pre_req(host, areq->mrq);
> +	if (!areq) {
> +		pr_err("%s: NULL asynchronous request!\n", __func__);
> +		return -EIO;
> +	}
> +
> +	mmc_pre_req(host, areq->mrq);
>  
>  	/* Finalize previous request, if there is one */
>  	if (previous)
>  		wait_for_completion(&previous->complete);
>  
> -	status = MMC_BLK_SUCCESS;
> -	if (ret_stat)
> -		*ret_stat = status;
> -
>  	/* Fine so far, start the new request! */
> -	if (status == MMC_BLK_SUCCESS && areq) {
> -		init_completion(&areq->complete);
> -		start_err = __mmc_start_data_req(host, areq->mrq);
> -	}
> +	init_completion(&areq->complete);
> +	ret = __mmc_start_data_req(host, areq->mrq);
>  
>  	/* Cancel a prepared request if it was not started. */
> -	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
> +	if (ret) {
>  		mmc_post_req(host, areq->mrq, -EINVAL);
> -
> -	if (status != MMC_BLK_SUCCESS)
>  		host->areq = NULL;
> -	else
> -		host->areq = areq;
> +		pr_err("%s: failed to start request\n", __func__);
> +	}
> +	host->areq = areq;
>  
> -	return previous;
> +	return ret;
>  }
>  EXPORT_SYMBOL(mmc_start_areq);
>  
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index ae6837317fe0..c9f28de7b0f4 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -53,6 +53,7 @@ static int mmc_queue_thread(void *d)
>  {
>  	struct mmc_queue *mq = d;
>  	struct request_queue *q = mq->queue;
> +	bool claimed_host = false;
>  
>  	current->flags |= PF_MEMALLOC;
>  
> @@ -67,9 +68,11 @@ static int mmc_queue_thread(void *d)
>  		mq->mqrq_cur->req = req;
>  		spin_unlock_irq(q->queue_lock);
>  
> -		if (req || mq->mqrq_prev->req) {
> +		if (req) {
>  			bool req_is_special = mmc_req_is_special(req);
>  
> +			if (!claimed_host)
> +				mmc_get_card(mq->card);

missing
				claimed_host = true;

?

>  			set_current_state(TASK_RUNNING);
>  			mmc_blk_issue_rq(mq, req);
>  			cond_resched();
> @@ -78,11 +81,14 @@ static int mmc_queue_thread(void *d)
>  			 * and vice versa.
>  			 * In case of special requests, current request
>  			 * has been finished. Do not assign it to previous
> -			 * request.
> +			 * request. Always unclaim the host after special
> +			 * commands.
>  			 */
> -			if (req_is_special)
> +			if (req_is_special) {
>  				mq->mqrq_cur->req = NULL;
> -
> +				mmc_put_card(mq->card);
> +				claimed_host = false;
> +			}
>  			mq->mqrq_prev->brq.mrq.data = NULL;
>  			mq->mqrq_prev->req = NULL;
>  			swap(mq->mqrq_prev, mq->mqrq_cur);
> @@ -97,6 +103,10 @@ static int mmc_queue_thread(void *d)
>  			down(&mq->thread_sem);
>  		}
>  	} while (1);
> +
> +	if (claimed_host)

claimed_host is never set to true

> +		mmc_put_card(mq->card);
> +
>  	up(&mq->thread_sem);
>  
>  	return 0;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 55b45dcddee6..af651e723ba2 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -160,9 +160,8 @@ struct mmc_async_req;
>  
>  void mmc_finalize_areq(struct kthread_work *work);
>  int mmc_restart_areq(struct mmc_host *host, struct mmc_async_req *areq);
> -struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
> -				struct mmc_async_req *areq,
> -				enum mmc_blk_status *ret_stat);
> +int mmc_start_areq(struct mmc_host *host,
> +		   struct mmc_async_req *areq);
>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>  		int retries);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
