Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB03EC38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F40A20838
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EkMPlFN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGGLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 02:11:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16AC061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LzvgL++8U/pwm5Kc7XVFO+CU9JRthH2oiAl0V9vKYko=; b=EkMPlFN32F5yLa5nVtdCDQa7GS
        z8QLZo8DbeH8O7lU9ad/XKLwXM6QEwdWs6njcMC07+fCZcJKc2LW8UUDVxq0q4Wp8X/dvI4DnRkWE
        Sn36hlG5cRXcw/O+dcTq28vyWi8L/EEnvbCt3OiCgM31BsFT6/RCIn1x9ldEFYsQKlDeyGWdARFLY
        nUbos/6PWPFLgeemqwe+mp89C7SnghP9cgidjbLp7kZ0RMnB5XuLa1bUmG1JvSZnV9ryQbeiRrCX3
        OXkuQxPg0aNELn6GJGDQlDWOaMjO/ZV8GwPHvShlcFJUesIl2MTLzzTo2imCqUMakJg6qhxno5inU
        G6Usn2CA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZkz-00026A-7R; Thu, 07 May 2020 06:11:41 +0000
Date:   Wed, 6 May 2020 23:11:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 4/5] block: rename __blk_mq_alloc_rq_map
Message-ID: <20200507061141.GC23530@infradead.org>
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <7eaff8fdfc394ecb686abb186564d9e1aebcf9ae.1588660550.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eaff8fdfc394ecb686abb186564d9e1aebcf9ae.1588660550.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 02:45:58PM +0800, Weiping Zhang wrote:
> rename __blk_mq_alloc_rq_map to __blk_mq_alloc_map_and_request,
> actually it alloc both map and request, make function name
> align with function.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c6ba94cba17d..02af33f56daa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2473,7 +2473,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>  	}
>  }
>  
> -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> +static bool __blk_mq_alloc_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)

Please fix the > 80 char line here.
