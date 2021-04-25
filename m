Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F4C433ED
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 00:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A329161463
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 00:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhDYAN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Apr 2021 20:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhDYAN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Apr 2021 20:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619309600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAw5XIWpSS2FR6G9yTl4DgBoMoroPru/03T/GFo2v6s=;
        b=gg67N7yV30Mt3H/l55sysv/0NNIxIcT3WW+RLQZLJZjbb5RfOqvnq/I3QOxTDewdfgwQlB
        fYZWa14jZ9rzUOVgdUUX8T1heRTs/myTMw3Pm6UJmDZgmWYwvCXaKOrxKUGeAsXvz4Hv0l
        z4wGz68KXM6ilGzdeIAVD7FHO7RXA98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-a7HAs3jkPN6a4vI4jq0bZw-1; Sat, 24 Apr 2021 20:13:16 -0400
X-MC-Unique: a7HAs3jkPN6a4vI4jq0bZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8700C107ACCA;
        Sun, 25 Apr 2021 00:13:15 +0000 (UTC)
Received: from T590 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9877719C46;
        Sun, 25 Apr 2021 00:13:07 +0000 (UTC)
Date:   Sun, 25 Apr 2021 08:13:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: Fix two racy hctx->tags->rqs[] assignments
Message-ID: <YIS0FuSl/PVAtEZb@T590>
References: <20210423200109.18430-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423200109.18430-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 01:01:09PM -0700, Bart Van Assche wrote:
> hctx->tags->rqs[] must be cleared before releasing a request tag because
> otherwise clearing that pointer races with the following assignment in
> blk_mq_get_driver_tag():
> 
> 	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 2 +-
>  block/blk-mq.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 06d204796c43..1ffaab7c9b11 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -501,8 +501,8 @@ static void __blk_mq_free_request(struct request *rq)
>  	blk_pm_mark_last_busy(rq);
>  	rq->mq_hctx = NULL;
>  	if (rq->tag != BLK_MQ_NO_TAG) {
> -		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>  		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> +		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>  	}
>  	if (sched_tag != BLK_MQ_NO_TAG)
>  		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 9ccb1818303b..f73cd659eb81 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -225,8 +225,8 @@ static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
>  static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>  					   struct request *rq)
>  {
> -	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>  	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> +	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>  	rq->tag = BLK_MQ_NO_TAG;
>  
>  	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> 

I'd suggest to document the memory order which is key to the usage's
correctness, especially both memory barriers are implied in allocating
& releasing bit tag.


Thanks,
Ming

