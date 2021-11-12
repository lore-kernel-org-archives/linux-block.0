Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C0EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C21960FE3
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhKLGiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhKLGiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 01:38:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94672C0613F5;
        Thu, 11 Nov 2021 22:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3q/aJHZrY5ynd2RQlPJDWKqDAoup6icD+Fi8/kYJiqE=; b=hWSGINFhVoDrwPu2zQ42u+nH+U
        E+GXg2fn+VsfVkICAxn3FhZYn24A/e5AgOHyQD1BcU1Z9NdEsI64KjCUXrl4z4V8LMLyQfDVsiok4
        6Qrfsfc7zppxuO/CZ9KFf8vNGnM5teFOhGON+4OBTCPBztMgspfN8eys/UkCo+8XFApJAexqXeEdY
        MsDjmP9/bKz5d0mDxhCUbRVfFU7xdpx5PqXFXdaQPq0qfAxSB8MPweOVN/iZoYFRn6CYHiO7k2U7G
        jwfgx/BCvRXGKzXgACCJ5yKrzhrkngSY34Z/rZnsgf/jctpuCxNboyVb2X7bvoHEYW1iOKLNLC6yk
        vI6swbRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlQ9Y-009WzA-1a; Fri, 12 Nov 2021 06:35:12 +0000
Date:   Thu, 11 Nov 2021 22:35:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] blk-mq:Use BUG_ON instead of if condition followed by
 BUG.
Message-ID: <YY4LILztrgdH5tiU@infradead.org>
References: <20211111103722.1650-1-zhang.mingyu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111103722.1650-1-zhang.mingyu@zte.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 10:37:22AM +0000, cgel.zte@gmail.com wrote:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7c5c8a26c8fc..05bffbc6b8ff 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -818,8 +818,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
>  
>  void blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
> -	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
> -		BUG();
> +	BUG_ON(blk_update_request(rq, error, blk_rq_bytes(rq)));

Err, no.  This now moves the actually important condition into the
BUG_ON macro and makes the function a complete mess.
