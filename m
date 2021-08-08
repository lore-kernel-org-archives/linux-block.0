Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895F0C4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0A46101C
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 08:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhHHIpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 04:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhHHIpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Aug 2021 04:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628412303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFwi0Z6oGORAHQ+dxi0xTcqJOzaM4j07+7O6RC89Pmo=;
        b=DXeqOvs1EygOhSvlYa2P9z87us8Htsm+WEsqO0ioepftsyxryAOhiQTIPLJHGCqkyizvNc
        fLlPLqRDupvXs0f5F8ocqItJ8zA+eRS3suAUp4SEwvb1HvC9wKHPZ0ANaDPAnLGA82Ia4j
        UkPMNBSr11rMJP9Q4hvYHEwZ5WZok1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-KnHj6BWkMziveqpLqC8vLA-1; Sun, 08 Aug 2021 04:44:59 -0400
X-MC-Unique: KnHj6BWkMziveqpLqC8vLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7EA8180FCCF;
        Sun,  8 Aug 2021 08:44:58 +0000 (UTC)
Received: from T590 (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBDCE5D9D3;
        Sun,  8 Aug 2021 08:44:51 +0000 (UTC)
Date:   Sun, 8 Aug 2021 16:44:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] block: don't decrement flush request refcount if it's
 state is idle in flush_end_io()
Message-ID: <YQ+Zfkl7Nsl2aSdw@T590>
References: <20210808070330.763177-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808070330.763177-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 08, 2021 at 03:03:30PM +0800, Yu Kuai wrote:
> flush_end_io() currently decrement request refcount unconditionally.
> However, it's possible that the request is already idle and it's
> refcount is zero since that flush_end_io() can be called concurrently.
> 
> For example, nbd_clear_que() can be called concurrently with normal
> io completion or io timeout.
> 
> Thus check idle before decrement to avoid refcount_t underflow
> warning.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-flush.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 1002f6c58181..9b65dc43702c 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -222,7 +222,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	/* release the tag's ownership to the req cloned from */
>  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>  
> -	if (!refcount_dec_and_test(&flush_rq->ref)) {
> +	if (blk_mq_rq_state(flush_rq) == MQ_RQ_IDLE ||
> +	    !refcount_dec_and_test(&flush_rq->ref)) {

It is driver's bug to finish one already ended request, so please
fix the driver instead.

Thanks,
Ming

