Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36568 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdCNRtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 13:49:25 -0400
Received: by mail-pg0-f54.google.com with SMTP id g2so76735994pge.3
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 10:49:24 -0700 (PDT)
Date: Tue, 14 Mar 2017 10:48:37 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-sched: don't run the queue async from
 blk_mq_try_issue_directly()
Message-ID: <20170314174837.GB2352@vader.DHCP.thefacebook.com>
References: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 14, 2017 at 08:57:50AM -0600, Jens Axboe wrote:
> If we have scheduling enabled, we jump directly to insert-and-run.
> That's fine, but we run the queue async and we don't pass in information
> on whether we can block from this context or not. Fixup both these
> cases.

Reviewed-by: Omar Sandoval <osandov@fb.com>

Just one question: we call blk_mq_get_driver_tag() with wait=false in
blk_mq_try_issue_directly(). Should we change that to wait=can_block?
Maybe it's pointless to try a direct issue if we'd have to wait for a
tag anyways, though.

> Signed-off-by: Jens Axboe <axboe@fb.com>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 159187a28d66..4196d6bee92d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1434,7 +1434,8 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
>  }
>  
> -static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
> +static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
> +				      bool can_block)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_queue_data bd = {
> @@ -1475,7 +1476,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
>  	}
>  
>  insert:
> -	blk_mq_sched_insert_request(rq, false, true, true, false);
> +	blk_mq_sched_insert_request(rq, false, true, false, can_block);
>  }
>  
>  /*
> @@ -1569,11 +1570,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
>  			rcu_read_lock();
> -			blk_mq_try_issue_directly(old_rq, &cookie);
> +			blk_mq_try_issue_directly(old_rq, &cookie, false);
>  			rcu_read_unlock();
>  		} else {
>  			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
> -			blk_mq_try_issue_directly(old_rq, &cookie);
> +			blk_mq_try_issue_directly(old_rq, &cookie, true);
>  			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
>  		}
>  		goto done;
> 
> -- 
> Jens Axboe
> 
