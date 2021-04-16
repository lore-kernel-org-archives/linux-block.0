Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FBC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 02:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4001061002
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 02:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhDPCP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235057AbhDPCP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 22:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618539305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtUYVy/xaclh6IHTZhhHN0cvRVFfOsj+jeNxCiXaxeg=;
        b=Gkwr5HVz/X8F/9NXx4YapnmOsgaaopiofoGsYZzvJfItnr2yFXdaGZ7gEURXciLpLw++6F
        6+3cGg+TyF9LYPs5zd82QKp5KJTvUB7ZINdBj8bYfcNSLtjcVNJRneCdM84uk8VKRFhtxC
        IaAqr/xdj1RVvDbKqZ0rKEAjccuLlfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-Z-eyIDWeMbKlSmag4j7wtA-1; Thu, 15 Apr 2021 22:15:01 -0400
X-MC-Unique: Z-eyIDWeMbKlSmag4j7wtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5FF881D72;
        Fri, 16 Apr 2021 02:15:00 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 234DA5D9DE;
        Fri, 16 Apr 2021 02:14:52 +0000 (UTC)
Date:   Fri, 16 Apr 2021 10:14:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Lin Feng <linf@wangsu.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] bfq/mq-deadline: remove redundant check for
 passthrough request
Message-ID: <YHjzGPO+SoHMEghy@T590>
References: <20210415034326.214227-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415034326.214227-1-linf@wangsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 15, 2021 at 11:43:26AM +0800, Lin Feng wrote:
> Since commit 01e99aeca39796003 'blk-mq: insert passthrough request into
> hctx->dispatch directly', passthrough request should not appear in
> IO-scheduler any more, so blk_rq_is_passthrough checking in addon IO
> schedulers is redundant.
> 
> (Notes: this patch passes generic IO load test with hdds under SAS
> controller and hdds under AHCI controller but obviously not covers all.
> Not sure if passthrough request can still escape into IO scheduler from
> blk_mq_sched_insert_requests, which is used by blk_mq_flush_plug_list and
> has lots of indirect callers.)
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>  block/bfq-iosched.c | 2 +-
>  block/mq-deadline.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 95586137194e..b827c9212b02 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5627,7 +5627,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	spin_lock_irq(&bfqd->lock);
>  	bfqq = bfq_init_rq(rq);
> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
> +	if (!bfqq || at_head) {
>  		if (at_head)
>  			list_add(&rq->queuelist, &bfqd->dispatch);
>  		else
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f3631a287466..04aded71ead2 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -500,11 +500,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> -	if (at_head || blk_rq_is_passthrough(rq)) {
> -		if (at_head)
> -			list_add(&rq->queuelist, &dd->dispatch);
> -		else
> -			list_add_tail(&rq->queuelist, &dd->dispatch);
> +	if (at_head) {
> +		list_add(&rq->queuelist, &dd->dispatch);
>  	} else {
>  		deadline_add_rq_rb(dd, rq);
>  
> -- 
> 2.30.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

