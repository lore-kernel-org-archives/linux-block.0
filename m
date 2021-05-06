Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E13C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 06:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B601610E6
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 06:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhEFG4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhEFG4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 02:56:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C2C061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fHp2LIRmGaUY/+mP09aMgYa5KSHN/gBBn/J4uEVcWb8=; b=C16+GSyaIDsxnrQeqqB3Foix3U
        LjvQrCa4FV0KNGV8VQ3WL3d/dG0R/kT1f6TCtq4ov+F1/7AKW6gIZkmc9r40Np9IvWX+DQGikDrA+
        6v8iKgDu1ylwN/vfcrJlrcEccE2CYlh7NusygVHyyRk+Y5ZaWpdeHC2PJJ6VXNEvEtqo8LqFA8K9f
        u7fry5AIOLPFPEfAYyavoj1Sl89keB0yHDFFGUi10tM0xJ2C1a0bA9QwIjxwLe2oW8AFEMfTdeFVg
        Yl5+CqlWov/13bW6dvkCLahQl+Ia/Bqqhkl9btu6Keg38+Z4mzG4hQZS4J0xy3QgbANZzPlbRAcCc
        c4BcdX8Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leXuC-001Odf-6l; Thu, 06 May 2021 06:54:43 +0000
Date:   Thu, 6 May 2021 07:54:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 2/4] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
Message-ID: <20210506065440.GC328487@infradead.org>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505145855.174127-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 05, 2021 at 10:58:53PM +0800, Ming Lei wrote:
> Grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter(), and
> this way will prevent the request from being re-used when ->fn is
> running. The approach is same as what we do during handling timeout.
> 
> Fix request UAF related with completion race or queue releasing:

I guess UAF is supposed to mean use-after-free?  Please just spell that
out.

> +	rq = blk_mq_find_and_get_req(tags, bitnr);
>  	/*
>  	 * We can hit rq == NULL here, because the tagging functions
>  	 * test and set the bit before assigning ->rqs[].
>  	 */
> +	if (!rq)
> +		return true;

Nit: I'd find this much earier to follow if the blk_mq_find_and_get_req
and thus assignment to rq was after the block comment.

>  	struct blk_mq_tags *tags = iter_data->tags;
>  	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
>  	struct request *rq;
> +	bool ret = true;
> +	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
>  
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
> @@ -272,16 +288,19 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	 * We can hit rq == NULL here, because the tagging functions
>  	 * test and set the bit before assigning ->rqs[].
>  	 */
> +	if (iter_static_rqs)

I think this local variable just obsfucates what is going on here.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
