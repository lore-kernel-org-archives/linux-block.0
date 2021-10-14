Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC87C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7518460F93
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhJNHfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJNHfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 03:35:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6AC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WVvyuMzRL6LpKSYzxmK77pXbyK5lAmjO9EMwyHaKHzU=; b=SyD2M9Gk7K6lc7eVBuNvf9B/sJ
        +uJjZIlx3SbsBTADaFKe2EKzrszRMEqpeDZtroVx4dbohvK8hNT7jbdKsE+1i09UG3xO2zignaEyO
        hTvgtrh/G7xZMqMAbsX7bgPyofD1Gy1aXvl+tdLJrEZizcSsiYO6S/8uqvzyuGukBtT7BuU6gjuUW
        4F6A8Zu7+y930i8YqTj6591DQ2TQOV1fPipEkwiqWvrCb4r1P6PrddLVUAbJriHTWwyi//4QoYu44
        gWU40gAbRpfR4grrdUbd2SD+riJ6mHoEUqn6vn44x6tR7blyAEa6lRE/QMPKbzhvotyrI6s8hDoLj
        Dxbqa65g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mavE8-0088s3-Ab; Thu, 14 Oct 2021 07:32:47 +0000
Date:   Thu, 14 Oct 2021 08:32:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 5/9] block: add support for blk_mq_end_request_batch()
Message-ID: <YWfdEPSIVmTzht/1@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +void blk_mq_end_request_batch(struct io_batch *iob)
> +{
> +	int tags[TAG_COMP_BATCH], nr_tags = 0, acct_tags = 0;
> +	struct blk_mq_hw_ctx *last_hctx = NULL;
> +	struct request *rq;
> +	u64 now = 0;
> +
> +	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
> +		if (!now && blk_mq_need_time_stamp(rq))
> +			now = ktime_get_ns();
> +		blk_update_request(rq, rq->status, blk_rq_bytes(rq));
> +		__blk_mq_end_request_acct(rq, rq->status, now);
> +
> +		if (rq->q->elevator) {
> +			blk_mq_free_request(rq);
> +			continue;
> +		}

So why do we even bother adding requests with an elevator to the batch
list?  

> +	/*
> +	 * csd is used for remote completions, fifo_time at scheduler time.
> +	 * They are mutually exclusive. result is used at completion time
> +	 * like csd, but for batched IO. Batched IO does not use IPI
> +	 * completions.
> +	 */
>  	union {
>  		struct __call_single_data csd;
>  		u64 fifo_time;
> +		blk_status_t status;
>  	};

The ->status field isn't needed any more now that error completions
aren't batched.
