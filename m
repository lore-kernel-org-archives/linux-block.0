Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDBC35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6971320CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEuloc8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBYPvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:51:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgBYPvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 10:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G0aMGDe5/xPKL5jVz6JRkDW5PbuX+POPyMFXa6BTYfs=; b=UEuloc8Lj72qRMlfuKK49ejTba
        OlCi+7Pl6oDjmQH5656CBUuSdkJs2YoGB0QDesaOQE6uwiKH1sdruk5+Jzun5PNHfiU61gTEfeotA
        fW9cndD1FSMIPvn19mHujUdDHc8jrK7erY7G71643j7ZxoAe4UEQnrdGSfDt4W7M9ntYeM7Lw3jFD
        +gkvsgMhZROoLOtS5eUOfsdoIPWg5h8G5EQxIiGwF5l9Z0XqXfgVnWQxOK/EAqwg0o710EHgJPL41
        emljopS82eoEiy80kbavxzWF3eBQDZJLMhVmI7GfinHNZztgupi/oNn7+k7O+Oik2WYtxmf+Fm3+K
        Eu1PSk+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6cUA-0005C6-Tx; Tue, 25 Feb 2020 15:51:02 +0000
Date:   Tue, 25 Feb 2020 07:51:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH V2] blk-mq: insert passthrough request into
 hctx->dispatch directly
Message-ID: <20200225155102.GA18299@infradead.org>
References: <20200225010432.29225-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225010432.29225-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It would be really helpful if the commit log contained the explanation
from your reply on the previous submission..

On Tue, Feb 25, 2020 at 09:04:32AM +0800, Ming Lei wrote:
> For some reason, device may be in one situation which can't handle
> FS request, so STS_RESOURCE is always returned and the FS request
> will be added to hctx->dispatch. However passthrough request may
> be required at that time for fixing the problem. If passthrough
> request is added to scheduler queue, there isn't any chance for
> blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
> Then the FS IO request may never be completed, and IO hang is caused.
> 
> So passthrough request has to be added to hctx->dispatch directly
> for fixing the IO hang.
> 
> Fix this issue by inserting passthrough request into hctx->dispatch
> directly together withing adding FS request to the tail of
> hctx->dispatch in blk_mq_dispatch_rq_list(). Actually we add FS request
> to tail of hctx->dispatch at default, see blk_mq_request_bypass_insert().
> 
> Then it becomes consistent with original legacy IO request
> path, in which passthrough request is always added to q->queue_head.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- adding FS request to the tail of hctx->dispatch in blk_mq_dispatch_rq_list()
> 	- pass our(RH) customer's test
> 
>  block/blk-flush.c    |  2 +-
>  block/blk-mq-sched.c | 22 +++++++++++++++-------
>  block/blk-mq.c       | 18 +++++++++++-------
>  block/blk-mq.h       |  3 ++-
>  4 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 3f977c517960..5cc775bdb06a 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -412,7 +412,7 @@ void blk_insert_flush(struct request *rq)
>  	 */
>  	if ((policy & REQ_FSEQ_DATA) &&
>  	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> -		blk_mq_request_bypass_insert(rq, false);
> +		blk_mq_request_bypass_insert(rq, false, false);
>  		return;
>  	}
>  
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd47b3d..856356b1619e 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -361,13 +361,19 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
>  				       bool has_sched,
>  				       struct request *rq)
>  {
> -	/* dispatch flush rq directly */
> -	if (rq->rq_flags & RQF_FLUSH_SEQ) {
> -		spin_lock(&hctx->lock);
> -		list_add(&rq->queuelist, &hctx->dispatch);
> -		spin_unlock(&hctx->lock);
> +	/*
> +	 * dispatch flush and passthrough rq directly
> +	 *
> +	 * passthrough request has to be added to hctx->dispatch directly.
> +	 * For some reason, device may be in one situation which can't
> +	 * handle FS request, so STS_RESOURCE is always returned and the
> +	 * FS request will be added to hctx->dispatch. However passthrough
> +	 * request may be required at that time for fixing the problem. If
> +	 * passthrough request is added to scheduler queue, there isn't any
> +	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
> +	 */
> +	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
>  		return true;
> -	}
>  
>  	if (has_sched)
>  		rq->rq_flags |= RQF_SORTED;
> @@ -391,8 +397,10 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>  
>  	WARN_ON(e && (rq->tag != -1));
>  
> -	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
> +	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> +		blk_mq_request_bypass_insert(rq, at_head, false);
>  		goto run;
> +	}
>  
>  	if (e && e->type->ops.insert_requests) {
>  		LIST_HEAD(list);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a12b1763508d..5e1e4151cb51 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -735,7 +735,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  		 * merge.
>  		 */
>  		if (rq->rq_flags & RQF_DONTPREP)
> -			blk_mq_request_bypass_insert(rq, false);
> +			blk_mq_request_bypass_insert(rq, false, false);
>  		else
>  			blk_mq_sched_insert_request(rq, true, false, false);
>  	}
> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  			q->mq_ops->commit_rqs(hctx);
>  
>  		spin_lock(&hctx->lock);
> -		list_splice_init(list, &hctx->dispatch);
> +		list_splice_tail_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
>  
>  		/*
> @@ -1677,12 +1677,16 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   * Should only be used carefully, when the caller knows we want to
>   * bypass a potential IO scheduler on the target device.
>   */
> -void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
> +void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
> +				  bool run_queue)
>  {
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
>  	spin_lock(&hctx->lock);
> -	list_add_tail(&rq->queuelist, &hctx->dispatch);
> +	if (at_head)
> +		list_add(&rq->queuelist, &hctx->dispatch);
> +	else
> +		list_add_tail(&rq->queuelist, &hctx->dispatch);
>  	spin_unlock(&hctx->lock);
>  
>  	if (run_queue)
> @@ -1849,7 +1853,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
>  
> -	blk_mq_request_bypass_insert(rq, run_queue);
> +	blk_mq_request_bypass_insert(rq, false, run_queue);
>  	return BLK_STS_OK;
>  }
>  
> @@ -1876,7 +1880,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
>  	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> -		blk_mq_request_bypass_insert(rq, true);
> +		blk_mq_request_bypass_insert(rq, false, true);
>  	else if (ret != BLK_STS_OK)
>  		blk_mq_end_request(rq, ret);
>  
> @@ -1910,7 +1914,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		if (ret != BLK_STS_OK) {
>  			if (ret == BLK_STS_RESOURCE ||
>  					ret == BLK_STS_DEV_RESOURCE) {
> -				blk_mq_request_bypass_insert(rq,
> +				blk_mq_request_bypass_insert(rq, false,
>  							list_empty(list));
>  				break;
>  			}
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index eaaca8fc1c28..c0fa34378eb2 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -66,7 +66,8 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   */
>  void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  				bool at_head);
> -void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
> +void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
> +				  bool run_queue);
>  void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  				struct list_head *list);
>  
> -- 
> 2.20.1
> 
---end quoted text---
