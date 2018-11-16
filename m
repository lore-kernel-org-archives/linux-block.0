Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5BC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94F2208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="QVeVAN+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94F2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPTCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:02:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40783 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPTCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:02:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so10313838pgp.7
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WeLiOeL+kd35pygCfZ7jlk2hRuFtnfyOVC4AjHqbllY=;
        b=QVeVAN+UfKCYd13hwo/F/DOgeOnLC6e8OZT+IAgbZYmCY6OnCQbtIxgTQJMdT1ovM9
         xJeO/GjE/89Rc1UjLzvJUFvzMxiALFHeFzasqg398ujPvNbKc7ri+ta6uSR+UbkJ7aBA
         nRpKeX1+KqcAHM/c/26Xr+O6dCtR8nJSLnGrxrWmHGWnfjm7M5N9/b4dKCkRNYHyT2cY
         cSSyWJix8HadXeW1ZLHbuJe9KSPYm22IKiGXPW0bx9D1j1h6VAqSYZ4lGZGSUlzjZxMv
         pf6B20gczYvgnSG7+NUqlWQ+bEKFchpa8rJh9vV/bgwzoR+7MDbB/tE0rTwrnYLUuafW
         6CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WeLiOeL+kd35pygCfZ7jlk2hRuFtnfyOVC4AjHqbllY=;
        b=KkSIkDb/zwRFc1wKoIY5g7uqD6q2jfOdMTbclv1yktL3RGBnD0qiciYxbxFjSS0nJZ
         ICiRa5sY+lSd11nmjXX956M0iBEo9wNnxOKfmNG+ZpqCYn2WTf46dblEmyqYlVDjy7v7
         cYJ7dUTpbncN9P3/PUrn1xeviMGdjKIvcPvIFVfFFUPnW2vLoQDiuMMbRHAIwPK4htnr
         lDF360An7o+Fc0MCvr7XWMbl2g9QN2x3LdT6D2v3ER8u/2/eVt53jxjKr5Rh+Xqw3Y5m
         i7/o81Z3844xJM4whXvSW0Smq7qTPJzh5agfQqNfQ3w0VtdCN/knIciObzoK2H/mvgv7
         S06w==
X-Gm-Message-State: AGRZ1gJxkDpNAqtgA1CmOpN0HXTkAuzspHJImUJ9QmHlvoKjrjaC+cND
        SNlyIfxj6ZB3WULv6d/cukI4Fg==
X-Google-Smtp-Source: AJdET5dVtmQiy4lf13ayR2QIsQfiWMWiq8D+Jj6Ho/GtMaMsrFvN377mEs4EO/w11xISyBz9mGq1Uw==
X-Received: by 2002:a63:3546:: with SMTP id c67mr9241168pga.284.1542358280528;
        Fri, 16 Nov 2018 00:51:20 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u5-v6sm40166992pgk.46.2018.11.16.00.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:51:20 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:51:19 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 6/6] mmc: stop abusing the request queue_lock pointer
Message-ID: <20181116085119.GU23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:06AM +0100, Christoph Hellwig wrote:
> Replace the lock in mmc_blk_data that is only used through a pointer
> in struct mmc_queue and to protect fields in that structure with
> an actual lock in struct mmc_queue.

Looks sane to me, but I'll let the mmc people ack.

> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/core/block.c | 24 +++++++++++-------------
>  drivers/mmc/core/queue.c | 31 +++++++++++++++----------------
>  drivers/mmc/core/queue.h |  4 ++--
>  3 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 70ec465beb69..2c329a3e3fdb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -100,7 +100,6 @@ static DEFINE_IDA(mmc_rpmb_ida);
>   * There is one mmc_blk_data per slot.
>   */
>  struct mmc_blk_data {
> -	spinlock_t	lock;
>  	struct device	*parent;
>  	struct gendisk	*disk;
>  	struct mmc_queue queue;
> @@ -1483,7 +1482,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>  		blk_mq_end_request(req, BLK_STS_OK);
>  	}
>  
> -	spin_lock_irqsave(mq->lock, flags);
> +	spin_lock_irqsave(&mq->lock, flags);
>  
>  	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
>  
> @@ -1491,7 +1490,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>  
>  	mmc_cqe_check_busy(mq);
>  
> -	spin_unlock_irqrestore(mq->lock, flags);
> +	spin_unlock_irqrestore(&mq->lock, flags);
>  
>  	if (!mq->cqe_busy)
>  		blk_mq_run_hw_queues(q, true);
> @@ -1991,13 +1990,13 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>  	unsigned long flags;
>  	bool put_card;
>  
> -	spin_lock_irqsave(mq->lock, flags);
> +	spin_lock_irqsave(&mq->lock, flags);
>  
>  	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
>  
>  	put_card = (mmc_tot_in_flight(mq) == 0);
>  
> -	spin_unlock_irqrestore(mq->lock, flags);
> +	spin_unlock_irqrestore(&mq->lock, flags);
>  
>  	if (put_card)
>  		mmc_put_card(mq->card, &mq->ctx);
> @@ -2093,11 +2092,11 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>  		 * request does not need to wait (although it does need to
>  		 * complete complete_req first).
>  		 */
> -		spin_lock_irqsave(mq->lock, flags);
> +		spin_lock_irqsave(&mq->lock, flags);
>  		mq->complete_req = req;
>  		mq->rw_wait = false;
>  		waiting = mq->waiting;
> -		spin_unlock_irqrestore(mq->lock, flags);
> +		spin_unlock_irqrestore(&mq->lock, flags);
>  
>  		/*
>  		 * If 'waiting' then the waiting task will complete this
> @@ -2116,10 +2115,10 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>  	/* Take the recovery path for errors or urgent background operations */
>  	if (mmc_blk_rq_error(&mqrq->brq) ||
>  	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
> -		spin_lock_irqsave(mq->lock, flags);
> +		spin_lock_irqsave(&mq->lock, flags);
>  		mq->recovery_needed = true;
>  		mq->recovery_req = req;
> -		spin_unlock_irqrestore(mq->lock, flags);
> +		spin_unlock_irqrestore(&mq->lock, flags);
>  		wake_up(&mq->wait);
>  		schedule_work(&mq->recovery_work);
>  		return;
> @@ -2142,7 +2141,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
>  	 * Wait while there is another request in progress, but not if recovery
>  	 * is needed. Also indicate whether there is a request waiting to start.
>  	 */
> -	spin_lock_irqsave(mq->lock, flags);
> +	spin_lock_irqsave(&mq->lock, flags);
>  	if (mq->recovery_needed) {
>  		*err = -EBUSY;
>  		done = true;
> @@ -2150,7 +2149,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
>  		done = !mq->rw_wait;
>  	}
>  	mq->waiting = !done;
> -	spin_unlock_irqrestore(mq->lock, flags);
> +	spin_unlock_irqrestore(&mq->lock, flags);
>  
>  	return done;
>  }
> @@ -2327,12 +2326,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  		goto err_kfree;
>  	}
>  
> -	spin_lock_init(&md->lock);
>  	INIT_LIST_HEAD(&md->part);
>  	INIT_LIST_HEAD(&md->rpmbs);
>  	md->usage = 1;
>  
> -	ret = mmc_init_queue(&md->queue, card, &md->lock);
> +	ret = mmc_init_queue(&md->queue, card);
>  	if (ret)
>  		goto err_putdisk;
>  
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 4485cf12218c..35cc138b096d 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -89,9 +89,9 @@ void mmc_cqe_recovery_notifier(struct mmc_request *mrq)
>  	struct mmc_queue *mq = q->queuedata;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(mq->lock, flags);
> +	spin_lock_irqsave(&mq->lock, flags);
>  	__mmc_cqe_recovery_notifier(mq);
> -	spin_unlock_irqrestore(mq->lock, flags);
> +	spin_unlock_irqrestore(&mq->lock, flags);
>  }
>  
>  static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
> @@ -128,14 +128,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
>  	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(mq->lock, flags);
> +	spin_lock_irqsave(&mq->lock, flags);
>  
>  	if (mq->recovery_needed || !mq->use_cqe)
>  		ret = BLK_EH_RESET_TIMER;
>  	else
>  		ret = mmc_cqe_timed_out(req);
>  
> -	spin_unlock_irqrestore(mq->lock, flags);
> +	spin_unlock_irqrestore(&mq->lock, flags);
>  
>  	return ret;
>  }
> @@ -157,9 +157,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>  
>  	mq->in_recovery = false;
>  
> -	spin_lock_irq(mq->lock);
> +	spin_lock_irq(&mq->lock);
>  	mq->recovery_needed = false;
> -	spin_unlock_irq(mq->lock);
> +	spin_unlock_irq(&mq->lock);
>  
>  	mmc_put_card(mq->card, &mq->ctx);
>  
> @@ -258,10 +258,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	issue_type = mmc_issue_type(mq, req);
>  
> -	spin_lock_irq(mq->lock);
> +	spin_lock_irq(&mq->lock);
>  
>  	if (mq->recovery_needed || mq->busy) {
> -		spin_unlock_irq(mq->lock);
> +		spin_unlock_irq(&mq->lock);
>  		return BLK_STS_RESOURCE;
>  	}
>  
> @@ -269,7 +269,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	case MMC_ISSUE_DCMD:
>  		if (mmc_cqe_dcmd_busy(mq)) {
>  			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
> -			spin_unlock_irq(mq->lock);
> +			spin_unlock_irq(&mq->lock);
>  			return BLK_STS_RESOURCE;
>  		}
>  		break;
> @@ -294,7 +294,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	get_card = (mmc_tot_in_flight(mq) == 1);
>  	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
>  
> -	spin_unlock_irq(mq->lock);
> +	spin_unlock_irq(&mq->lock);
>  
>  	if (!(req->rq_flags & RQF_DONTPREP)) {
>  		req_to_mmc_queue_req(req)->retries = 0;
> @@ -328,12 +328,12 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (issued != MMC_REQ_STARTED) {
>  		bool put_card = false;
>  
> -		spin_lock_irq(mq->lock);
> +		spin_lock_irq(&mq->lock);
>  		mq->in_flight[issue_type] -= 1;
>  		if (mmc_tot_in_flight(mq) == 0)
>  			put_card = true;
>  		mq->busy = false;
> -		spin_unlock_irq(mq->lock);
> +		spin_unlock_irq(&mq->lock);
>  		if (put_card)
>  			mmc_put_card(card, &mq->ctx);
>  	} else {
> @@ -385,19 +385,18 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>   * mmc_init_queue - initialise a queue structure.
>   * @mq: mmc queue
>   * @card: mmc card to attach this queue
> - * @lock: queue lock
>   *
>   * Initialise a MMC card request queue.
>   */
> -int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> -		   spinlock_t *lock)
> +int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
>  	int ret;
>  
>  	mq->card = card;
> -	mq->lock = lock;
>  	mq->use_cqe = host->cqe_enabled;
> +	
> +	spin_lock_init(&mq->lock);
>  
>  	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
>  	mq->tag_set.ops = &mmc_mq_ops;
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 5421f1542e71..fd11491ced9f 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -73,11 +73,11 @@ struct mmc_queue_req {
>  
>  struct mmc_queue {
>  	struct mmc_card		*card;
> -	spinlock_t		*lock;
>  	struct mmc_ctx		ctx;
>  	struct blk_mq_tag_set	tag_set;
>  	struct mmc_blk_data	*blkdata;
>  	struct request_queue	*queue;
> +	spinlock_t		lock;
>  	int			in_flight[MMC_ISSUE_MAX];
>  	unsigned int		cqe_busy;
>  #define MMC_CQE_DCMD_BUSY	BIT(0)
> @@ -96,7 +96,7 @@ struct mmc_queue {
>  	struct work_struct	complete_work;
>  };
>  
> -extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
> +extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *);
>  extern void mmc_cleanup_queue(struct mmc_queue *);
>  extern void mmc_queue_suspend(struct mmc_queue *);
>  extern void mmc_queue_resume(struct mmc_queue *);
> -- 
> 2.19.1
> 
