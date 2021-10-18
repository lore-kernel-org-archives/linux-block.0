Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56C9610A3
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhJRCow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243161AbhJRCor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634524955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bNTSAOTt6Yv2MDoPtOGaSGRRLT99tBO5zNZhTktx4j0=;
        b=dhP4ldaKrALLRk12WuDHua+1vf/Dp+2fr6Ap6kmgnaKkXS9wcSimahqhOJg8gh8By2fZ3s
        lfVDh8diMatzrJy3Gt+ubFI50q/jzPo7LCD+BbeivNitqQK2JMy5dtHldtSfAA0XKr3UsB
        fTq882p22GYsrsRS/OK3zSPTSW0G4KI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-1XAABNt7Nb68vG7-zascXw-1; Sun, 17 Oct 2021 22:42:31 -0400
X-MC-Unique: 1XAABNt7Nb68vG7-zascXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C5411006AA3;
        Mon, 18 Oct 2021 02:42:30 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B538C5D6D5;
        Mon, 18 Oct 2021 02:42:25 +0000 (UTC)
Date:   Mon, 18 Oct 2021 10:42:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't dereference request after flush insertion
Message-ID: <YWzfDJ9sYBbLn741@T590>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
> We could have a race here, where the request gets freed before we call
> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
> of the request.
> 
> Grab the hardware context before inserting the flush.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2197cfbf081f..22b30a89bf3a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
>  	}
>  
>  	if (unlikely(is_flush_fua)) {
> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  		/* Bypass scheduler for flush requests */
>  		blk_insert_flush(rq);
> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
> +		blk_mq_run_hw_queue(hctx, true);
>  	} else if (plug && (q->nr_hw_queues == 1 ||
>  		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
>  		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {

From report in [1], no device close & queue release is involved, and
request freeing could be much easier to trigger than queue release,
so looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Fixes: f328476e373a ("blk-mq: cleanup blk_mq_submit_bio")



[1] https://lore.kernel.org/linux-block/23531d29-9d96-6744-bab9-797e65379037@kernel.dk/T/#t


thanks,
Ming

