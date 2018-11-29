Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6950BC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B2D21019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B2D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeK2SFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:05:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbeK2SFt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 13:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 322B19B316;
        Thu, 29 Nov 2018 07:01:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA08965F4E;
        Thu, 29 Nov 2018 07:01:22 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:01:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
Message-ID: <20181129070116.GA27186@ming.t460p>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Nov 2018 07:01:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:35:37AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-core.c |  2 +-
>  block/blk-mq.c   | 16 ++++++++--------
>  block/blk-mq.h   |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d107d016b92b..3f6f5e6c2fe4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1334,7 +1334,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>  	 * bypass a potential scheduler on the bottom device for
>  	 * insert.
>  	 */
> -	return blk_mq_request_issue_directly(rq);
> +	return blk_mq_request_issue_directly(rq, true);
>  }
>  EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 18ff47a85ad3..9e1045152e45 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1743,12 +1743,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  
>  static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  					    struct request *rq,
> -					    blk_qc_t *cookie)
> +					    blk_qc_t *cookie, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_queue_data bd = {
>  		.rq = rq,
> -		.last = true,
> +		.last = last,
>  	};
>  	blk_qc_t new_cookie;
>  	blk_status_t ret;
> @@ -1783,7 +1783,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass_insert)
> +						bool bypass_insert, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> @@ -1812,7 +1812,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	return __blk_mq_issue_directly(hctx, rq, cookie);
> +	return __blk_mq_issue_directly(hctx, rq, cookie, last);
>  insert:
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
> @@ -1831,7 +1831,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	hctx_lock(hctx, &srcu_idx);
>  
> -	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
>  	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
>  		blk_mq_sched_insert_request(rq, false, true, false);
>  	else if (ret != BLK_STS_OK)
> @@ -1840,7 +1840,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	hctx_unlock(hctx, srcu_idx);
>  }
>  
> -blk_status_t blk_mq_request_issue_directly(struct request *rq)
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  {
>  	blk_status_t ret;
>  	int srcu_idx;
> @@ -1848,7 +1848,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
>  	hctx_lock(hctx, &srcu_idx);
> -	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
>  	hctx_unlock(hctx, srcu_idx);
>  
>  	return ret;
> @@ -1863,7 +1863,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				queuelist);
>  
>  		list_del_init(&rq->queuelist);
> -		ret = blk_mq_request_issue_directly(rq);
> +		ret = blk_mq_request_issue_directly(rq, list_empty(list));
>  		if (ret != BLK_STS_OK) {
>  			if (ret == BLK_STS_RESOURCE ||
>  					ret == BLK_STS_DEV_RESOURCE) {
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 9ae8e9f8f8b1..7291e5379358 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -69,7 +69,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  				struct list_head *list);
>  
>  /* Used by blk_insert_cloned_request() to issue request directly */
> -blk_status_t blk_mq_request_issue_directly(struct request *rq);
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				    struct list_head *list);
>  
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
