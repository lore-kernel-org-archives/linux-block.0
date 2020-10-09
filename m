Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41BC433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D1A2225B
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNbByV2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgJIJq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 05:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733218AbgJIJq5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Oct 2020 05:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602236816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4XUeXXmXlqIj+XqwTZZwDnHthCD+pdCzaZWs+qGYP4=;
        b=DNbByV2x8FPdM1ORiRHFF3HJ6vhN2WFNWSeAGyf6niy/GnYnpFDz4fLy+tzLaXZcHNncXX
        7Zu358wBcethdBxuI9GccZbnvYhsAMRuuM9mdDWK7zH815fu4U/eeKDGb1gFsIPOS/8gCz
        eyxOt/aJpoIKHhHp0S75GcvCMS6U7Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-S4eEBrtrOdWvJ9wbhG3QQA-1; Fri, 09 Oct 2020 05:46:52 -0400
X-MC-Unique: S4eEBrtrOdWvJ9wbhG3QQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC6271007465;
        Fri,  9 Oct 2020 09:46:50 +0000 (UTC)
Received: from T590 (ovpn-13-88.pek2.redhat.com [10.72.13.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6006B6266E;
        Fri,  9 Oct 2020 09:46:43 +0000 (UTC)
Date:   Fri, 9 Oct 2020 17:46:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yang Yang <yang.yang@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, onlyfever@icloud.com
Subject: Re: [PATCH] blk-mq: move cancel of hctx->run_work to the front of
 blk_exit_queue
Message-ID: <20201009094640.GA53552@T590>
References: <20201009080015.3217-1-yang.yang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009080015.3217-1-yang.yang@vivo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 09, 2020 at 01:00:14AM -0700, Yang Yang wrote:
> blk_exit_queue will free elevator_data, while blk_mq_run_work_fn
> will access it. Move cancel of hctx->run_work to the front of
> blk_exit_queue to avoid use-after-free.
> 
> Fixes: 1b97871b501f ("blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  block/blk-mq-sysfs.c | 2 --
>  block/blk-sysfs.c    | 9 ++++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 062229395a50..7b52e7657b2d 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -36,8 +36,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
>  	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
>  						  kobj);
>  
> -	cancel_delayed_work_sync(&hctx->run_work);
> -
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
>  		cleanup_srcu_struct(hctx->srcu);
>  	blk_free_flush_queue(hctx->fq);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7dda709f3ccb..8c6bafc801dd 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -934,9 +934,16 @@ static void blk_release_queue(struct kobject *kobj)
>  
>  	blk_free_queue_stats(q->stats);
>  
> -	if (queue_is_mq(q))
> +	if (queue_is_mq(q)) {
> +		struct blk_mq_hw_ctx *hctx;
> +		int i;
> +
>  		cancel_delayed_work_sync(&q->requeue_work);
>  
> +		queue_for_each_hw_ctx(q, hctx, i)
> +			cancel_delayed_work_sync(&hctx->run_work);
> +	}
> +

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

