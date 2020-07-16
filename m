Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DECC433E0
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DBE206F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bCPjPsYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPOen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:34:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B50C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zGJzjGaIXggDvLFVYP8RonukC8k5gLioaGYOWhyJhiM=; b=bCPjPsYLvOrTWm0OOBtSooeTUS
        VMRXuRzHo2M0O52E7c/78zujehnR5k+/1rjoEf/O80C3r1Pnk/ZTCWEt4C8WdAlX/2o+Huzc7u9Qh
        V0Dxy0mosWsOAm0LP2oFwdUPUb22008dWmuyGLVmi9g8KeRUWKoAjqORFL7eXAc/cltIANUDf0Y17
        3Z19xhx5X9pVtOQZH3CXfYSD/U9tF3xR3uzBqQWFOsPrElAWIm0RDRiieKfc2hdTz6QM9R8FXNKym
        ojxSWIHsfhAxlQVVhZ0VWbYsJ67XznYUOmf+XJBgqZEi4YXsqCyJW2OAsCWPQ35AZeAchGboYLyf4
        TRZLDtrg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw4y9-0000H1-6Q; Thu, 16 Jul 2020 14:34:41 +0000
Date:   Thu, 16 Jul 2020 15:34:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: align max append sectors to physical block size
Message-ID: <20200716143441.GA937@infradead.org>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:
> Max append sectors needs to be aligned to physical block size, otherwise
> we can end up in a situation where it's off by 1-3 sectors which would
> cause short writes with asynchronous zone append submissions from an FS.

Huh? The physical block size is purely a hint.

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  block/blk-settings.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 9a2c23cd9700..d75c4cc34a7a 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -231,6 +231,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
>  void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  		unsigned int max_zone_append_sectors)
>  {
> +	unsigned int phys = queue_physical_block_size(q);
>  	unsigned int max_sectors;
>  
>  	if (WARN_ON(!blk_queue_is_zoned(q)))
> @@ -246,6 +247,13 @@ void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  	 */
>  	WARN_ON(!max_sectors);
>  
> +	/*
> +	 * Max append sectors needs to be aligned to physical block size,
> +	 * otherwise we can end up in a situation where it's off by 1-3 sectors
> +	 * which would cause short writes with asynchronous zone append
> +	 * submissions from an FS.
> +	 */
> +	max_sectors = ALIGN_DOWN(max_sectors << 9, phys) >> 9;
>  	q->limits.max_zone_append_sectors = max_sectors;
>  }
>  EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
> -- 
> 2.26.2
> 
---end quoted text---
