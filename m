Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD04C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DB1208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="sKWgR4Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DB1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeK1Ktb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:49:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44298 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeK1Ktb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:49:31 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so18482391iod.11
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMKmIrQ2/8pN0sO1DnqzjbLUxDxgWJM6rS1IDHfNAwU=;
        b=sKWgR4Qwhbx8RJ3PdOwxFnn1vJgnDbPL0YHAYbQwthrNY6L20xSLOdRwjZyMk6PA5b
         S3M5DK0wMAPt+iuDsXrPjkOEhOFZR3SeKugpix3TKsYj5hZEZPCPFr06ekCpYfiUrlhn
         AqhgWpujNAsFZxtA2P7qMRk23c3XhHRFcuanjHjGCDnZNGg/gUW6ljdaS5p+5sloHbwU
         Ny1h2NBj5FP6WNNJkRJIriHUe7uDzxHEURvYimJjmkfCcBTFMIs88i7uI/lvdZi/jH2N
         DDXAr/rAU8xws/bB4bOIcPLck4R2IqIFnOujuj52xY3d6Ol93bUAClbC5syp8rdx2j6I
         Q2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMKmIrQ2/8pN0sO1DnqzjbLUxDxgWJM6rS1IDHfNAwU=;
        b=X6rVCC/RLMQMkmumxcrOA0njw83ozhdeIZnw161W7OSTY7Gqc/OOm/5aLjJ60ESlWN
         UU4Zg/wXfd8lQS5t+hwIxEt1PkTrAb0EHqKn0Pjb/FJKtQWI4Hw9T+hYtK/zYVqwPCdp
         UwKof8I2eqTHmHzUCE/rA+KiJkMmg1NJ4kQxzqC+Zrc8uLXEPWq4vw+rnspTKMsFg0PB
         aYGgP6pvg86UvLO7XF9zd5AccjEWod6HAdeZohwgvx81SkiZnjFGwrENp3NqwrnEUiOD
         ZGQA2lc03UfjcP2UtMe0VkkRShlLWRn8XXEYbLCsVdbpPa7i4OO4+p/GXt9NAhbkejxi
         2ghA==
X-Gm-Message-State: AA+aEWbS7cb44821l4hczG0rneqUbFhl0mUMye0ZhLix+SNLth/1BXGX
        9zS4u9KX0O46SnHH8zVH8LcEpw==
X-Google-Smtp-Source: AFSGD/XbM50voHPlkFril/aeOLWxBfE83BeVRnJYjouv2nsV21OS0OCXJ/CcPCoB4i48TT5+IZp8tQ==
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr27352469ion.111.1543362596382;
        Tue, 27 Nov 2018 15:49:56 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id c10-v6sm339781itc.2.2018.11.27.15.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:49:55 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:49:54 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
Message-ID: <20181127234954.GF846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-8-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:55AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.

One comment below, otherwise

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-core.c |  2 +-
>  block/blk-mq.c   | 32 ++++++++++++++++++++++++--------
>  block/blk-mq.h   |  2 +-
>  3 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c9758d185357..808a65d23f1a 100644
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
> index 6a249bf6ed00..0a12cec0b426 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  	if (!list_empty(list)) {
>  		bool needs_restart;
>  
> +		/*
> +		 * If we didn't flush the entire list, we could have told
> +		 * the driver there was more coming, but that turned out to
> +		 * be a lie.
> +		 */
> +		if (q->mq_ops->commit_rqs)
> +			q->mq_ops->commit_rqs(hctx);
> +

This hunk seems like it should go with the patch adding commit_rqs.

>  		spin_lock(&hctx->lock);
>  		list_splice_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
> @@ -1736,12 +1744,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
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
> @@ -1776,7 +1784,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass_insert)
> +						bool bypass_insert, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> @@ -1805,7 +1813,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	return __blk_mq_issue_directly(hctx, rq, cookie);
> +	return __blk_mq_issue_directly(hctx, rq, cookie, last);
>  insert:
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
> @@ -1824,7 +1832,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	hctx_lock(hctx, &srcu_idx);
>  
> -	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
>  	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
>  		blk_mq_sched_insert_request(rq, false, true, false);
>  	else if (ret != BLK_STS_OK)
> @@ -1833,7 +1841,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	hctx_unlock(hctx, srcu_idx);
>  }
>  
> -blk_status_t blk_mq_request_issue_directly(struct request *rq)
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  {
>  	blk_status_t ret;
>  	int srcu_idx;
> @@ -1841,7 +1849,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
>  	hctx_lock(hctx, &srcu_idx);
> -	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
>  	hctx_unlock(hctx, srcu_idx);
>  
>  	return ret;
> @@ -1856,7 +1864,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				queuelist);
>  
>  		list_del_init(&rq->queuelist);
> -		ret = blk_mq_request_issue_directly(rq);
> +		ret = blk_mq_request_issue_directly(rq, list_empty(list));
>  		if (ret != BLK_STS_OK) {
>  			if (ret == BLK_STS_RESOURCE ||
>  					ret == BLK_STS_DEV_RESOURCE) {
> @@ -1866,6 +1874,14 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  			blk_mq_end_request(rq, ret);
>  		}
>  	}
> +
> +	/*
> +	 * If we didn't flush the entire list, we could have told
> +	 * the driver there was more coming, but that turned out to
> +	 * be a lie.
> +	 */
> +	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
> +		hctx->queue->mq_ops->commit_rqs(hctx);
>  }
>  
>  static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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
