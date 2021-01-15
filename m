Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F1C433DB
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AA32336F
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 07:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbhAOHhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 02:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbhAOHhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 02:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610696145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Mr5U83Zqan/W3G9fx5RhiOT2aeY1vNP5n7NEJb7wDM=;
        b=DDPcSF6EiX6fHzs2oPOXtmbZplUKPw/kq84OKrgbd+kLS9e4gsZS5UbFqVbcPxl8/E3msu
        HLBEwwRVK2VteZ+HLFmwcdSTZOd12tch0F2X318lW5rEjTG8a+Z6w/UJ3V9gkSNEiiV+ML
        rw8G1WXJbwR1NeHT6JOIzT5p5VM1Ngg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-M2ULXdYePRi0bJnYQDWvlQ-1; Fri, 15 Jan 2021 02:35:41 -0500
X-MC-Unique: M2ULXdYePRi0bJnYQDWvlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE86190D34A;
        Fri, 15 Jan 2021 07:35:40 +0000 (UTC)
Received: from T590 (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 479E15D9EF;
        Fri, 15 Jan 2021 07:35:33 +0000 (UTC)
Date:   Fri, 15 Jan 2021 15:35:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] block: quiesce queue before freeing queue
Message-ID: <20210115073529.GA396337@T590>
References: <20210115064352.532534-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115064352.532534-1-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 15, 2021 at 01:43:52AM -0500, Yufen Yu wrote:
> There is a race beteewn blk_mq_run_hw_queue() and cleanup queue,
> which can cause use-after-free as following:
> 
> cpu1                              cpu2
> queue_state_write()
>                                   blk_release_queue
>                                     blk_exit_queue
>   blk_mq_run_hw_queue
>     blk_mq_hctx_has_pending
>       e = q->elevator
>                                     q->elevator = NULL
>                                     free(q->elevator)
>       e && e->type->ops.has_work //use-after-free
> 
> Fix this bug by adding quiesce before freeing queue. Then, anyone
> who tries to run hw queue will be safe.

It is blk_mq_run_hw_queue() caller's responsibility to make sure that
the request queue won't disappear, so please fix the caller if there is
such issue.

> 
> This is basically revert of 662156641bc4 ("block: don't drain
> in-progress dispatch in blk_cleanup_queue()")
> 
> Fixes: 662156641bc4 ("block: don't drain in-progress dispatch in blk_cleanup_queue()")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7663a9b94b80..f8a038d19c89 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -392,6 +392,18 @@ void blk_cleanup_queue(struct request_queue *q)
>  
>  	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>  
> +	/*
> +	 * make sure all in-progress dispatch are completed because
> +	 * blk_freeze_queue() can only complete all requests, and
> +	 * dispatch may still be in-progress since we dispatch requests
> +	 * from more than one contexts.
> +	 *
> +	 * We rely on driver to deal with the race in case that queue
> +	 * initialization isn't done.
> +	 */
> +	if (queue_is_mq(q) && blk_queue_init_done(q))
> +		blk_mq_quiesce_queue(q);

No, please don't do that. We had several slow boot reports before caused by
by synchronize_rcu() in blk_cleanup_queue(), since blk_cleanup_queue()
is called for in-existed queues, which number can be quite big.

Thanks,
Ming

