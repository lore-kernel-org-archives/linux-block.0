Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E0C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiBIOD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiBIOD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 09:03:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C03C061355
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 06:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uiS7CFqe3cvHIX9eTDHWO1RpUO2FpzDLb8w1wAl01+k=; b=IzP9gbpO9AbkfNGbP96o3f9aZW
        pOEVVA+kQApdFvzOdC70xXdHhAKCY4gmBqCVH7jEuFhiOATAIqOd+e9OsNz74dezOi2yleEySsIAX
        szKAKCLIO8kzXUZ+AVtoISPDoL5HL3oGdfhziOk75MliLu6x7tXueVoLLRF5Ro+qmi865qHru1jJz
        t+8/Uqsxk1HNj6lRE4TooKJH2xMtuXvy/N6VOwpOV6olf8DrpEJmRiaZ1TrrceXOxDh9HMF3naEgi
        bc+3jHkvF+H71JNphNO134+GSbaLsENcys30rQlVvEjb81+VJtLfWwKyjoAIIol4jlu7A4joSI6Jx
        0o8XSFfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHnZW-000IEO-Fu; Wed, 09 Feb 2022 14:03:50 +0000
Date:   Wed, 9 Feb 2022 06:03:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 4/7] block: don't check bio in
 blk_throtl_dispatch_work_fn
Message-ID: <YgPJxjA8zsfQpNuE@infradead.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/**
> + * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This is a version of submit_bio() that shall only be used for I/O that is
> + * resubmitted to lower level drivers by stacking block drivers.  All file
> + * systems and other upper level users of the block layer should use
> + * submit_bio() instead.
> + */
> +void submit_bio_noacct(struct bio *bio)
> +{
> +	if (unlikely(!submit_bio_checks(bio)))
> +		return;
> +	__submit_bio_noacct_nocheck(bio);

Given that this is the only caller of submit_bio_checks I'd merge
the two.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> +}
>  EXPORT_SYMBOL(submit_bio_noacct);
>  
> +void submit_bio_noacct_nocheck(struct bio *bio)
> +{
> +	__submit_bio_noacct_nocheck(bio);
> +}
> +
>  /**
>   * submit_bio - submit a bio to the block device layer for I/O
>   * @bio: The &struct bio which describes the I/O
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..6cca1715c31e 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1219,7 +1219,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
>  	if (!bio_list_empty(&bio_list_on_stack)) {
>  		blk_start_plug(&plug);
>  		while ((bio = bio_list_pop(&bio_list_on_stack)))
> -			submit_bio_noacct(bio);
> +			submit_bio_noacct_nocheck(bio);
>  		blk_finish_plug(&plug);
>  	}
>  }
> diff --git a/block/blk.h b/block/blk.h
> index b2516cb4f98e..ebaa59ca46ca 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -46,6 +46,7 @@ void blk_freeze_queue(struct request_queue *q);
>  void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
>  void blk_queue_start_drain(struct request_queue *q);
>  int __bio_queue_enter(struct request_queue *q, struct bio *bio);
> +void submit_bio_noacct_nocheck(struct bio *bio);
>  
>  static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
>  {
> -- 
> 2.31.1
> 
---end quoted text---
