Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C18FC433E0
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC86206E3
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Op8NBZlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgGZJbw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:31:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgGZJbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595755910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFFrWY8Oz3HwxPvXJO5/UEvTxCU9HEM5CYerxz56T1c=;
        b=Op8NBZlFw5/yLib3BUd4PVe7PE15i3pNnKFmh2bQwl4+W6z/jH/oZvFfmLnndy8v96vPNl
        FJkNGZqPGzEddxfahWsApVav5h6tErAiE1Blev8cgqYZgRm6f1GdIfeevzumrMZDvaxLP7
        X61LSUUldu6nuM4u/Z11OYuRwXyIlMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-rj0vGx7EP4yvMW3S375rfg-1; Sun, 26 Jul 2020 05:31:45 -0400
X-MC-Unique: rj0vGx7EP4yvMW3S375rfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04C01902EA2;
        Sun, 26 Jul 2020 09:31:43 +0000 (UTC)
Received: from T590 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E47485DA30;
        Sun, 26 Jul 2020 09:31:36 +0000 (UTC)
Date:   Sun, 26 Jul 2020 17:31:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200726093132.GD1110104@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726002301.145627-2-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On Sat, Jul 25, 2020 at 05:23:00PM -0700, Sagi Grimberg wrote:
> Drivers that may have to quiesce a large amount of request queues at once
> (e.g. controller or adapter reset). These drivers would benefit from an
> async quiesce interface such that the can trigger quiesce asynchronously
> and wait for all in parallel.
> 
> This leaves the synchronization responsibility to the driver, but adds
> a convenient interface to quiesce async and wait in a single pass.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 32 ++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 ++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..60d137265bd9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,38 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		init_completion(&hctx->rcu_sync.completion);
> +		init_rcu_head(&hctx->rcu_sync.head);
> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> +				wakeme_after_rcu);
> +		else
> +			call_rcu(&hctx->rcu_sync.head,
> +				wakeme_after_rcu);
> +	}

Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
synchronize_rcu() is OK for all hctx during waiting.

> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> +
> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		wait_for_completion(&hctx->rcu_sync.completion);
> +		destroy_rcu_head(&hctx->rcu_sync.head);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> +
>  /**
>   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>   * @q: request queue.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 23230c1d031e..5536e434311a 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -5,6 +5,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/sbitmap.h>
>  #include <linux/srcu.h>
> +#include <linux/rcupdate_wait.h>
>  
>  struct blk_mq_tags;
>  struct blk_flush_queue;
> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>  	 */
>  	struct list_head	hctx_list;
>  
> +	struct rcu_synchronize	rcu_sync;
 
The above struct takes at least 5 words, and I'd suggest to avoid it,
and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
Meantime !BLK_MQ_F_BLOCKING doesn't need it.


Thanks,
Ming

