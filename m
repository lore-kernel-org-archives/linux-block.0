Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13858C10F0E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145B20882
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfDDPdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:33:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34594 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDPdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 11:33:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so1919649qka.1
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 08:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Fb1G/ShoVBNlfqSpBMRpAhZLAEQbS9W3xybK1qOwoc=;
        b=qLRymr3lTzG3RKNycHnyK8ob+uustBqHO60UFcSuG0jje62UlYrQmdENirFjyi2u0z
         Yc07D4C3RUVwByZ/S3+vfUlZ+EzwVfjEwFTSMp2wDwazXp3q8oLLlWsEyvsKXVSOHaUF
         Q65OsH2Gvl6wZxzMnMBMrVEMki35UqkGSk+u9nd788R3pu7vhBMFoeV5Zdfm29lkHR2e
         6gWFri87APXtt2es9mq0LfFpJQAeJE5I87pkfkuFgi4iqmBT4urYMXQjKGaFMJnWhTax
         O7twuCp6o47Qq00/CJFIF2EX9/X4hOJzIv4WbHQE/Tk6Bt57n+3Jp+dEF8Lgq2wj0uxC
         VAQQ==
X-Gm-Message-State: APjAAAXrwZItczgKCDk8VQBOIWopICERhLrcHFrUXWfBYP3NDbkt2e42
        UMyq6xBoXhZss7hushkluqKtqg==
X-Google-Smtp-Source: APXvYqyDm+nP5/oDkwxXZl5VO8UQQ2nQ1UriVoRACGj/rvlOZAHyWbXQ8b0sNY1pmrJLG5vaKEs7Xg==
X-Received: by 2002:a37:9c91:: with SMTP id f139mr5659928qke.48.1554392023221;
        Thu, 04 Apr 2019 08:33:43 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id 204sm10773304qki.58.2019.04.04.08.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:33:42 -0700 (PDT)
Message-ID: <a8083ea7e02cb0ff7c65d8a24f5f484b90a57549.camel@redhat.com>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 11:33:41 -0400
In-Reply-To: <1554391728.118779.241.camel@acm.org>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <20190404070849.GD5004@ming.t460p> <1554389983.118779.237.camel@acm.org>
         <2b049ffa57ccac27b876c674bc1fa06faca5d3b6.camel@redhat.com>
         <1554391728.118779.241.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 08:28 -0700, Bart Van Assche wrote:
> On Thu, 2019-04-04 at 11:09 -0400, Laurence Oberman wrote:
> > When I bisected and got to that commit I was unable to revert it to
> > test without it.
> > I showed that in an earlier update, had merge issues.
> > 
> > loberman@lobewsrhel linux_torvalds]$ git revert 7f556a44e61d
> > error: could not revert 7f556a4... blk-mq: refactor the code of
> > issue
> > request directly
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add <paths>' or 'git rm <paths>'
> > hint: and commit the result with 'git commit'
> 
> Hi Laurence,
> 
> On my setup the following commits revert cleanly if I revert them in
> the
> following order:
>  * d6a51a97c0b2 ("blk-mq: replace and kill
> blk_mq_request_issue_directly") # v5.0.
>  * 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in
> blk_mq_sched_insert_requests") # v5.0.
>  * 7f556a44e61d ("blk-mq: refactor the code of issue request
> directly") # v5.0.
> 
> The result of these three reverts is the patch below. Test feedback
> for
> this patch would be appreciated.
> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] block: Revert recent blk_mq_request_issue_directly()
> changes
> 
> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests
> that
> have been queued. If that happens when blk_mq_try_issue_directly() is
> called
> by the dm-mpath driver then the dm-mpath will try to resubmit a
> request that
> is already queued and a kernel crash follows. Since it is nontrivial
> to fix
> blk_mq_request_issue_directly(), revert the most recent
> blk_mq_request_issue_directly() changes.
> 
> This patch reverts the following commits:
> * d6a51a97c0b2 ("blk-mq: replace and kill
> blk_mq_request_issue_directly") # v5.0.
> * 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in
> blk_mq_sched_insert_requests") # v5.0.
> * 7f556a44e61d ("blk-mq: refactor the code of issue request
> directly") # v5.0.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request
> directly") # v5.0.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-core.c     |   4 +-
>  block/blk-mq-sched.c |   8 +--
>  block/blk-mq.c       | 122 ++++++++++++++++++++++-------------------
> --
>  block/blk-mq.h       |   6 +--
>  4 files changed, 71 insertions(+), 69 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2921af6f8d33..5bca56016575 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1232,8 +1232,6 @@ static int blk_cloned_rq_check_limits(struct
> request_queue *q,
>   */
>  blk_status_t blk_insert_cloned_request(struct request_queue *q,
> struct request *rq)
>  {
> -	blk_qc_t unused;
> -
>  	if (blk_cloned_rq_check_limits(q, rq))
>  		return BLK_STS_IOERR;
>  
> @@ -1249,7 +1247,7 @@ blk_status_t blk_insert_cloned_request(struct
> request_queue *q, struct request *
>  	 * bypass a potential scheduler on the bottom device for
>  	 * insert.
>  	 */
> -	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused,
> true, true);
> +	return blk_mq_request_issue_directly(rq, true);
>  }
>  EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
>  
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 40905539afed..aa6bc5c02643 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -423,10 +423,12 @@ void blk_mq_sched_insert_requests(struct
> blk_mq_hw_ctx *hctx,
>  		 * busy in case of 'none' scheduler, and this way may
> save
>  		 * us one extra enqueue & dequeue to sw queue.
>  		 */
> -		if (!hctx->dispatch_busy && !e && !run_queue_async)
> +		if (!hctx->dispatch_busy && !e && !run_queue_async) {
>  			blk_mq_try_issue_list_directly(hctx, list);
> -		else
> -			blk_mq_insert_requests(hctx, ctx, list);
> +			if (list_empty(list))
> +				return;
> +		}
> +		blk_mq_insert_requests(hctx, ctx, list);
>  	}
>  
>  	blk_mq_run_hw_queue(hctx, run_queue_async);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 652d0c6d5945..403984a557bb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1808,74 +1808,76 @@ static blk_status_t
> __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx
> *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass, bool last)
> +						bool bypass_insert,
> bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> -	blk_status_t ret = BLK_STS_RESOURCE;
> -	int srcu_idx;
> -	bool force = false;
>  
> -	hctx_lock(hctx, &srcu_idx);
>  	/*
> -	 * hctx_lock is needed before checking quiesced flag.
> +	 * RCU or SRCU read lock is needed before checking quiesced
> flag.
>  	 *
> -	 * When queue is stopped or quiesced, ignore 'bypass', insert
> -	 * and return BLK_STS_OK to caller, and avoid driver to try to
> -	 * dispatch again.
> +	 * When queue is stopped or quiesced, ignore 'bypass_insert'
> from
> +	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to
> caller,
> +	 * and avoid driver to try to dispatch again.
>  	 */
> -	if (unlikely(blk_mq_hctx_stopped(hctx) ||
> blk_queue_quiesced(q))) {
> +	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
>  		run_queue = false;
> -		bypass = false;
> -		goto out_unlock;
> +		bypass_insert = false;
> +		goto insert;
>  	}
>  
> -	if (unlikely(q->elevator && !bypass))
> -		goto out_unlock;
> +	if (q->elevator && !bypass_insert)
> +		goto insert;
>  
>  	if (!blk_mq_get_dispatch_budget(hctx))
> -		goto out_unlock;
> +		goto insert;
>  
>  	if (!blk_mq_get_driver_tag(rq)) {
>  		blk_mq_put_dispatch_budget(hctx);
> -		goto out_unlock;
> +		goto insert;
>  	}
>  
> -	/*
> -	 * Always add a request that has been through
> -	 *.queue_rq() to the hardware dispatch list.
> -	 */
> -	force = true;
> -	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
> -out_unlock:
> +	return __blk_mq_issue_directly(hctx, rq, cookie, last);
> +insert:
> +	if (bypass_insert)
> +		return BLK_STS_RESOURCE;
> +
> +	blk_mq_request_bypass_insert(rq, run_queue);
> +	return BLK_STS_OK;
> +}
> +
> +static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq, blk_qc_t *cookie)
> +{
> +	blk_status_t ret;
> +	int srcu_idx;
> +
> +	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> +
> +	hctx_lock(hctx, &srcu_idx);
> +
> +	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false,
> true);
> +	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> +		blk_mq_request_bypass_insert(rq, true);
> +	else if (ret != BLK_STS_OK)
> +		blk_mq_end_request(rq, ret);
> +
> +	hctx_unlock(hctx, srcu_idx);
> +}
> +
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool
> last)
> +{
> +	blk_status_t ret;
> +	int srcu_idx;
> +	blk_qc_t unused_cookie;
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +
> +	hctx_lock(hctx, &srcu_idx);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie,
> true, last);
>  	hctx_unlock(hctx, srcu_idx);
> -	switch (ret) {
> -	case BLK_STS_OK:
> -		break;
> -	case BLK_STS_DEV_RESOURCE:
> -	case BLK_STS_RESOURCE:
> -		if (force) {
> -			blk_mq_request_bypass_insert(rq, run_queue);
> -			/*
> -			 * We have to return BLK_STS_OK for the DM
> -			 * to avoid livelock. Otherwise, we return
> -			 * the real result to indicate whether the
> -			 * request is direct-issued successfully.
> -			 */
> -			ret = bypass ? BLK_STS_OK : ret;
> -		} else if (!bypass) {
> -			blk_mq_sched_insert_request(rq, false,
> -						    run_queue, false);
> -		}
> -		break;
> -	default:
> -		if (!bypass)
> -			blk_mq_end_request(rq, ret);
> -		break;
> -	}
>  
>  	return ret;
>  }
> @@ -1883,20 +1885,22 @@ blk_status_t blk_mq_try_issue_directly(struct
> blk_mq_hw_ctx *hctx,
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		struct list_head *list)
>  {
> -	blk_qc_t unused;
> -	blk_status_t ret = BLK_STS_OK;
> -
>  	while (!list_empty(list)) {
> +		blk_status_t ret;
>  		struct request *rq = list_first_entry(list, struct
> request,
>  				queuelist);
>  
>  		list_del_init(&rq->queuelist);
> -		if (ret == BLK_STS_OK)
> -			ret = blk_mq_try_issue_directly(hctx, rq,
> &unused,
> -							false,
> +		ret = blk_mq_request_issue_directly(rq,
> list_empty(list));
> +		if (ret != BLK_STS_OK) {
> +			if (ret == BLK_STS_RESOURCE ||
> +					ret == BLK_STS_DEV_RESOURCE) {
> +				blk_mq_request_bypass_insert(rq,
>  							list_empty(list
> ));
> -		else
> -			blk_mq_sched_insert_request(rq, false, true,
> false);
> +				break;
> +			}
> +			blk_mq_end_request(rq, ret);
> +		}
>  	}
>  
>  	/*
> @@ -1904,7 +1908,7 @@ void blk_mq_try_issue_list_directly(struct
> blk_mq_hw_ctx *hctx,
>  	 * the driver there was more coming, but that turned out to
>  	 * be a lie.
>  	 */
> -	if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
> +	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
>  		hctx->queue->mq_ops->commit_rqs(hctx);
>  }
>  
> @@ -2017,13 +2021,13 @@ static blk_qc_t blk_mq_make_request(struct
> request_queue *q, struct bio *bio)
>  		if (same_queue_rq) {
>  			data.hctx = same_queue_rq->mq_hctx;
>  			blk_mq_try_issue_directly(data.hctx,
> same_queue_rq,
> -					&cookie, false, true);
> +					&cookie);
>  		}
>  	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
>  			!data.hctx->dispatch_busy)) {
>  		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
> -		blk_mq_try_issue_directly(data.hctx, rq, &cookie,
> false, true);
> +		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>  	} else {
>  		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d704fc7766f4..423ea88ab6fb 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -70,10 +70,8 @@ void blk_mq_request_bypass_insert(struct request
> *rq, bool run_queue);
>  void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct
> blk_mq_ctx *ctx,
>  				struct list_head *list);
>  
> -blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> -						struct request *rq,
> -						blk_qc_t *cookie,
> -						bool bypass, bool
> last);
> +/* Used by blk_insert_cloned_request() to issue request directly */
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool
> last);
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				    struct list_head *list);
>  
> 

Doing that now
back with test results

