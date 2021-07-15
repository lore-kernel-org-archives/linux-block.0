Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F699C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4930A6115B
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhGOHA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOHAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:00:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0EC06175F
        for <linux-block@vger.kernel.org>; Wed, 14 Jul 2021 23:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r2B8rzvM85EDJe553QQKer4o53/ntJG7vQdEqG7ZqEM=; b=Uf+ZVCN7UQuEBeb89xCO5Ofk4m
        EUW2IEDAypOGWKFpRGalnhM7+vHZotOrtwXkHq/YFz+5qDbKTgmW/hwcpqVZw4czO82L4D26hHvIq
        sVgbo59+Hxd4RVNZOWbxVNzlSXWp7ektl+H8/kHjxxHyPVLFYOVmlR9/UUM+k6Y3wsaZh6PgyFGy3
        C1nEGOyWVaBt5js9j33oXoBebUuwFms+/CmS0xLo8q/PkpDZzDIn3g8FyWnB7ncz2QtOYNAuoSI0r
        sNFqKxTj5RCrEPgZh9WkpvqMAceBcAgbI+9OeA5sb5OUFARwfJG2+0KvI9actmzi8nlivX6clD5cE
        yULzkFKQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vHQ-0034j9-C3; Thu, 15 Jul 2021 06:56:21 +0000
Date:   Thu, 15 Jul 2021 07:55:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, josef@toxicpanda.com,
        chaitanya.kulkarni@wdc.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH V2] nbd: fix order of cleaning up the queue and freeing
 the tagset
Message-ID: <YO/b5Gmc6k3Xfzqk@infradead.org>
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
 <20210706040016.1360412-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706040016.1360412-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you pick this up?

On Tue, Jul 06, 2021 at 12:00:16PM +0800, Guoqing Jiang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> We must release the queue before freeing the tagset.
> 
> Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Reported-and-tested-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
> ---
> V2 changes: Correct the fixes tag and mail address.
> 
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b7d663736d35..c38317979f74 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -239,8 +239,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)
>  
>  	if (disk) {
>  		del_gendisk(disk);
> -		blk_mq_free_tag_set(&nbd->tag_set);
>  		blk_cleanup_disk(disk);
> +		blk_mq_free_tag_set(&nbd->tag_set);
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
---end quoted text---
