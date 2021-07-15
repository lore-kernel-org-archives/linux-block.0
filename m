Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF22C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A712961362
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhGOHBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOHBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:01:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E343C06175F
        for <linux-block@vger.kernel.org>; Wed, 14 Jul 2021 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4lD9nmoh8/R7knOI4idv6dW3xpzfKl01b/s459wr9/0=; b=jXU6FyK7eU0bMkwMU+MT7/C/C4
        WBi06vaQ2f3CpT7oysYZL3/83OlIrBJAO9foh6mSXCB7h61qvC7Bd1NaOa6ju0TznMJnPY40cFoF6
        lkEquN+003AKQYyrEU9nwkcRU9bPUuIWKkvoQYk1JBTheW6AFja40h8RB85dd645gehOmwDLTTQsW
        xa2Fzrayb/HQZzCs7wBs1b0VvfhxnXBZ2fpt7G4BUXTBfVRlaf5v+/P5gQVLxYLJQWs3eRwYrVEuO
        lLh8UtVIVrTlq7NUG2T62PhQhZyck3gPraIdg4m52B9OrEXUnOkOM0dLuE9qENfYxTc1zqJWaFX6I
        ahG0kqyA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vK4-0034w4-Fa; Thu, 15 Jul 2021 06:58:24 +0000
Date:   Thu, 15 Jul 2021 07:58:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, tim@cyberelk.net,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] pd: fix order of cleaning up the queue and freeing the
 tagset
Message-ID: <YO/ciADnvkv/4ggb@infradead.org>
References: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you pick this one up?

On Tue, Jul 06, 2021 at 09:07:34AM +0800, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> We must release the queue before freeing the tagset.
> 
> Fixes: 262d431f9000 ("pd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
> ---
>  drivers/block/paride/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
> index 3b2b8e872beb..9b3298926356 100644
> --- a/drivers/block/paride/pd.c
> +++ b/drivers/block/paride/pd.c
> @@ -1014,8 +1014,8 @@ static void __exit pd_exit(void)
>  		if (p) {
>  			disk->gd = NULL;
>  			del_gendisk(p);
> -			blk_mq_free_tag_set(&disk->tag_set);
>  			blk_cleanup_disk(p);
> +			blk_mq_free_tag_set(&disk->tag_set);
>  			pi_release(disk->pi);
>  		}
>  	}
> -- 
> 2.25.1
> 
---end quoted text---
