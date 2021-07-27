Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483EC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2089761406
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhG0KG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 06:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236105AbhG0KG4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 06:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627380416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBIadlePi1nhhZbqCiG2KIXwtjptI0cXgbqATL0nsZI=;
        b=CgwveBxA85CRaYvF/jM15+ZZx1pyuUpe6gzLFFcZRgFSidicGGUQGQgItxY8jB1ghJkJAo
        U+ourGBunp4PsZKosra3kXjYH072bvjRSo/ZrtFDBf2tr4PNKpVgmmd9W/ibGVfsxnMzby
        Lnw5twUZboCEhY+fHOvKiiX8yYO40MQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-dHXDFyHZNze4RbAXe7PVww-1; Tue, 27 Jul 2021 06:06:55 -0400
X-MC-Unique: dHXDFyHZNze4RbAXe7PVww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B2F61853027;
        Tue, 27 Jul 2021 10:06:54 +0000 (UTC)
Received: from T590 (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B733C5DAA5;
        Tue, 27 Jul 2021 10:06:48 +0000 (UTC)
Date:   Tue, 27 Jul 2021 18:06:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error
 handling
Message-ID: <YP/atlyuacbHF/sp@T590>
References: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 05:32:53PM +0800, John Garry wrote:
> If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
> call blk_mq_sched_free_tags() -> blk_mq_free_rqs().
> 
> It is incorrect to do so, as any rqs would have already been freed in the
> blk_mq_alloc_rqs() call.
> 
> Fix by calling blk_mq_free_rq_map() only directly.
> 
> Fixes: 6917ff0b5bd41 ("blk-mq-sched: refactor scheduler initialization")
> Signed-off-by: John Garry <john.garry@huawei.com>

Not sure it is one fix, because blk_mq_free_rqs() does nothing when
->static_rqs[] isn't filled, so 'Fixes' tag isn't needed, IMO.

> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index c838d81ac058..0f006cabfd91 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -515,17 +515,6 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
>  	percpu_ref_put(&q->q_usage_counter);
>  }
>  
> -static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
> -				   struct blk_mq_hw_ctx *hctx,
> -				   unsigned int hctx_idx)
> -{
> -	if (hctx->sched_tags) {
> -		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
> -		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
> -		hctx->sched_tags = NULL;
> -	}
> -}
> -
>  static int blk_mq_sched_alloc_tags(struct request_queue *q,
>  				   struct blk_mq_hw_ctx *hctx,
>  				   unsigned int hctx_idx)
> @@ -539,8 +528,10 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
>  		return -ENOMEM;
>  
>  	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
> -	if (ret)
> -		blk_mq_sched_free_tags(set, hctx, hctx_idx);
> +	if (ret) {
> +		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
> +		hctx->sched_tags = NULL;
> +	}

The patch itself looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

