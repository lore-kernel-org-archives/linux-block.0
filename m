Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F66C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B8920720
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEHkIpBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgF3FGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgF3FGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E5C061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JqJ88ziwnmBKQSfNW6BuUEvK/eBwQbM8EYwZ235Ry8k=; b=DEHkIpBnwyriSYCLagoTapRz1X
        lKxFmcjw9cqSVfFM1S4006CMB7SYuCchWOqBXjYTGkIDFtlqhv6K5SRvwxP/hiYlc/Q2tQxoPPNJy
        5lfKOzEap0f46bbbH2D0M71A5w1Sr+Fe9ObwVAPkNMrYhtPYsNLOITsI+VssYVZ3vTMqQadcP/0cd
        ZpYFjAww9bBa5IBhmW4E51U7+DPsrfluc3BVhX3Qo5HPiO1UEMo6oIOLroRPgafCn+o6y4KwS43uB
        ZNG+DVGTrsVVCZRV47pWcJuDX6BeHsm/g/zLr/UnhUaoaqDfrpq9h4fuj67XJeMT7C+sH8LCadbSl
        YZFSI0PA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq8Sz-0005LU-90; Tue, 30 Jun 2020 05:05:57 +0000
Date:   Tue, 30 Jun 2020 06:05:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200630050557.GE17653@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630022356.2149607-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> index 21108a550fbf..3b0c5cfe922a 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -236,12 +236,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  		error = fq->rq_status;
>  
>  	hctx = flush_rq->mq_hctx;
> +	if (!q->elevator)
>  		flush_rq->tag = -1;
> +	else
>  		flush_rq->internal_tag = -1;

These should switch to BLK_MQ_NO_TAG which you're at it.

> -	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
> -		blk_mq_tag_busy(data->hctx);

BLK_MQ_REQ_INTERNAL is gone now, so this won't apply.

>  static bool blk_mq_get_driver_tag(struct request *rq)
>  {
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	bool shared = blk_mq_tag_busy(rq->mq_hctx);
> +
> +	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
> +		return false;
> +
> +	if (shared) {
> +		rq->rq_flags |= RQF_MQ_INFLIGHT;
> +		atomic_inc(&hctx->nr_active);
> +	}
> +	hctx->tags->rqs[rq->tag] = rq;
> +	return true;
>  }

The function seems a bit misnamed now, although I don't have a good
suggestion for a better name.
