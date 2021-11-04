Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89956C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7425D61076
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhKDRf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhKDRf0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:35:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1868C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gLdUpph6a+S4z30wAXz1MAGLLDaYbpRN6A2MfTYVcKU=; b=pvPKQkhCfjebGbQu0s5jEn/cyB
        /1uW3Ln6Z77fTYgzk8Y4YepzZaETK3ibxTSM3mYkNy0fb0goqI4NP//B9RxcAsAWcC1KIveHVAWWd
        rJCux+aO1PMXYBD7yP/9QDpexHaBvbsZ6/YH4sh2Ui2rpaMkze6cLrUm8AQC/f4PorH6R4H4BZ/QH
        MglN0OT5iJjMROFGp/YfH5cuGLOzEe7UYYzobq51x2CsMe7qIYDnAjN8uDXyg6fJwLd8g/ccXblWp
        uh3wYy4Utfbs3Oa7+faes0aEzv8xLYrsR656HK0GEWjoZGswmldqmO+L7GOO+5uLnhWEXKACDXDWl
        XRevs92Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migbY-009g0j-GX; Thu, 04 Nov 2021 17:32:48 +0000
Date:   Thu, 4 Nov 2021 10:32:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQZQKDBAUhQnqsq@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk>
 <YYOjcuEExwJN1eiw@infradead.org>
 <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
 <4d92696b-41a3-b0f3-90de-5b41555f011d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d92696b-41a3-b0f3-90de-5b41555f011d@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 06:14:30AM -0600, Jens Axboe wrote:
> To player it safer, I would suggest we fold in something like the
> below. That keeps the submit_checks() under the queue enter.

Yes, this looks much better.  Nit below:

>  	struct block_device *bdev = bio->bi_bdev;
>  	struct request_queue *q = bdev_get_queue(bdev);
> @@ -868,14 +868,13 @@ static void __submit_bio(struct bio *bio)
>  {
>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
>  
> -	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
> -		return;
>  	if (!disk->fops->submit_bio) {
>  		blk_mq_submit_bio(bio);
>  	} else {
>  		if (unlikely(bio_queue_enter(bio) != 0))
>  			return;
> -		disk->fops->submit_bio(bio);
> +		if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
> +			disk->fops->submit_bio(bio);
>  		blk_queue_exit(disk->queue);
>  	}

A this point moving the whole ->submit_bio based branch into a
helper probably makes sense as well.

> +	if (unlikely(!blk_crypto_bio_prep(&bio)))
> +		return;
> +
>  	blk_queue_bounce(q, &bio);
>  	if (blk_may_split(q, bio))
>  		__blk_queue_split(q, &bio, &nr_segs);
> @@ -2551,6 +2554,8 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  		if (unlikely(!blk_mq_queue_enter(q, bio)))
>  			return;
> +		if (unlikely(!submit_bio_checks(bio)))
> +			goto put_exit;

This now skips the checks for the cached request case, doesn't it?
