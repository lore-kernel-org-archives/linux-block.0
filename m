Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B09C43219
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 07:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJJHlp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiJJHkh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B5EA8
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1tUMMaMbsNcj03Xl6K+6IxqxLn7xCzLOdkslRNp7V+U=; b=hksasiMZTSuPYrSvrYvRf7XxoX
        UiR4U4945dTW2A2my4pbGbyf6h3cS64ICY5Jmua2sGETXQ+Qiwm2BIZuSd4jt2QWgGEf5KLQp6fL0
        hXKnbZ8htgWmjCB+8RaHXV6LMShp1NMvMcDUVqwcud36R7w7oys6aa73WMQD40KH1I7E4b5Whk7ym
        XllXhOUVynKhOP65Uo7F6AvnXqSbzTvnSAjlYfzve8lmTra15rLPL5fR3i5JqgmIWhjJdQdfar6pP
        ApDxND5MuCqYOo16K3Q5mTQPrER3qmTAfFczRfru8XGZtQLPmlonvAeEgBfmDVvSaoeiwVMkRR/Ik
        zZuNaD1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnFX-00HO28-KB; Mon, 10 Oct 2022 07:30:55 +0000
Date:   Mon, 10 Oct 2022 00:30:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq: aggregate ktime_get per request batch
Message-ID: <Y0PKL2Lm5yAY/ODl@infradead.org>
References: <20221004153004.2058994-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004153004.2058994-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	rq->timeout = 0;
>  
> -	if (blk_mq_need_time_stamp(rq))
> -		rq->start_time_ns = ktime_get_ns();
> -	else
> -		rq->start_time_ns = 0;
> +	rq->start_time_ns = now;
>  	rq->part = NULL;
>  #ifdef CONFIG_BLK_RQ_ALLOC_TIME
> -	rq->alloc_time_ns = alloc_time_ns;
> +	rq->alloc_time_ns = now;
>  #endif

Given that rq->start_time_ns and rq->alloc_time_ns are not always
the same (except for the odd flush case), do we even need both fields?

>  static inline struct request *
>  __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
> -		u64 alloc_time_ns)
> +		u64 now)

Nit: this fits into the previous line now.

>  	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
> -					alloc_time_ns);
> +					now);

Same here.

>  static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
> -					    struct request *rq, bool last)
> +					    struct request *rq, bool last, u64 now)

Overly long line.  FYI, this becomes a lot more readable anyway with
the two tab indent:

static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
		struct request *rq, bool last, u64 now)

> @@ -2521,6 +2528,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	 * Any other error (busy), just add it to our list as we
>  	 * previously would have done.
>  	 */
> +	rq->io_start_time_ns = now;

Looking though this more I hate all these extra assignments, and
it will change the accounting a bit from what we had.  Why can't we
pass the time to blk_mq_start_request and just keep it where it was?

> +	u64 now = 0;
> +
> +	if (blk_queue_stat(rq->q))
> +		now = ktime_get_ns();

This code pattern is duplicated a lot.  Can't we have a nice
helper and shortcut it to:

	u64 now = blk_ktime_get_ns_for_stats(rq->q);

and use the opportunity to document the logic in the helpe.

> -static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
> +static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last, u64 now)

Overly long line here.  But I really wonder why we even needthis helper.

