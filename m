Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4619C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F86A60F24
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 15:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhIXP7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhIXP7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 11:59:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40817C061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Phf/bCOtpiqB87R/WUiVfJGQKzRdnfe3dvprV27ohCo=; b=BwIwKKeEqkmyb9uYjBCSdSIiDq
        kgE+ZBSJnfoQQMCcxqpcrdUHsjxM4GOTegqS5jx4dMuosYmXE/v9qkFUQHnIfUvZgBlS4K4yLJfb7
        15xXXfG+auK/Vb4xUR4s8gC8StL+pNTCmG7EpNW2cM3cui1vTemvJMEf/1UU2s9sCCqwiydqYSlhW
        gGT5x9OJFtjD02Hba/BvFqDR7RNoR1TwqJV+gKBQvlH7rzSnxn6ZzXmW6usWLOzYSUxz0zJXEKrbm
        KeMF2pXeO2Uu7LLWGz4JQN0uJuMWSuXW39OuDZD1S0PbitT2dqZfVN5CoqnZ/E55q2APs5G2ihCfF
        oTnnnj5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTnZA-007Muq-VW; Fri, 24 Sep 2021 15:57:01 +0000
Date:   Fri, 24 Sep 2021 16:56:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, tj@kernel.org
Subject: Re: [PATCH] block: don't call rq_qos_ops->done_bio if the bio isn't
 tracked
Message-ID: <YU31QB/l8HEeUalz@infradead.org>
References: <20210924110704.1541818-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924110704.1541818-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 24, 2021 at 07:07:04PM +0800, Ming Lei wrote:
> rq_qos framework is only applied on request based driver, so:
> 
> 1) rq_qos_done_bio() needn't to be called for bio based driver
> 
> 2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
> such as bios ended from error handling code.
> 
> Especially in bio_endio():
> 
> 1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
> may be gone since request queue refcount may not be held in above two
> cases
> 
> 2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
> __rq_qos_done_bio()
> 
> Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
> the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
> and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> @@ -1466,7 +1466,7 @@ void bio_endio(struct bio *bio)
>  	if (!bio_integrity_endio(bio))
>  		return;
>  
> -	if (bio->bi_bdev)
> +	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACKED))
>  		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);

We should probbly also drop the request_queue argument to
rq_qos_done_bio in a separate cleanup.
