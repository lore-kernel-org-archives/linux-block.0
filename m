Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B2C433E4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516FA20714
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3Ve9qig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgG1BJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:09:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgG1BJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 21:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595898583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=baOPMXnAAHz4Dgy9VjwzwyyrCvFs3hyQP6/RGRj2qaE=;
        b=O3Ve9qigkiqBKS5hfSvutXUbrhiNgV8fFAO9i6fls8HmQretWUX4Gbwtpl+MNvyvHPsbfI
        Eqx2/i0A772Djv89df6nMGGOP6akeCcaNnZRwd9Hdo+lnWMtC+tVQ9DZlZUFrDtzF4w+3E
        fxk2pRq/awBJODu49lqR9wxqdRFUkFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-EODb3-lnNu2XjM7cLv6kGA-1; Mon, 27 Jul 2020 21:09:41 -0400
X-MC-Unique: EODb3-lnNu2XjM7cLv6kGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF983800468;
        Tue, 28 Jul 2020 01:09:39 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 898F810013D0;
        Tue, 28 Jul 2020 01:09:32 +0000 (UTC)
Date:   Tue, 28 Jul 2020 09:09:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200728010928.GA1303645@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 02:00:15PM -0700, Sagi Grimberg wrote:
> 
> > > > > > > +void blk_mq_quiesce_queue_async(struct request_queue *q)
> > > > > > > +{
> > > > > > > +	struct blk_mq_hw_ctx *hctx;
> > > > > > > +	unsigned int i;
> > > > > > > +
> > > > > > > +	blk_mq_quiesce_queue_nowait(q);
> > > > > > > +
> > > > > > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > > > > > +		init_completion(&hctx->rcu_sync.completion);
> > > > > > > +		init_rcu_head(&hctx->rcu_sync.head);
> > > > > > > +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > > > > > +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> > > > > > > +				wakeme_after_rcu);
> > > > > > > +		else
> > > > > > > +			call_rcu(&hctx->rcu_sync.head,
> > > > > > > +				wakeme_after_rcu);
> > > > > > > +	}
> > > > > > 
> > > > > > Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> > > > > > synchronize_rcu() is OK for all hctx during waiting.
> > > > > 
> > > > > That's true, but I want a single interface for both. v2 had exactly
> > > > > that, but I decided that this approach is better.
> > > > 
> > > > Not sure one new interface is needed, and one simple way is to:
> > > > 
> > > > 1) call blk_mq_quiesce_queue_nowait() for each request queue
> > > > 
> > > > 2) wait in driver specific way
> > > > 
> > > > Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
> > > > then you may add per-tagset APIs for the waiting.
> > > 
> > > Because it puts assumptions on how quiesce works, which is something
> > > I'd like to avoid because I think its cleaner, what do others think?
> > > Jens? Christoph?
> > 
> > I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
> > call that.
> 
> I agree with this approach as well.
> 
> Jens, this mean that we use the call_rcu mechanism also for non-blocking
> hctxs, because the caller  will call it for multiple request queues (see
> patch 2) and we don't want to call synchronize_rcu for every request
> queue serially, we want it to happen in parallel.
> 
> Which leaves us with the patchset as it is, just to convert the
> rcu_synchronize structure to be dynamically allocated on the heap
> rather than keeping it statically allocated in the hctx.
> 
> This is how it looks:
> --
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..d913924117d2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue
> *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> 
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +       struct blk_mq_hw_ctx *hctx;
> +       unsigned int i;
> +       int rcu = false;
> +
> +       blk_mq_quiesce_queue_nowait(q);
> +
> +       queue_for_each_hw_ctx(q, hctx, i) {
> +               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync),
> GFP_KERNEL);
> +               if (!hctx->rcu_sync) {
> +                       /* fallback to serial rcu sync */
> +                       if (hctx->flags & BLK_MQ_F_BLOCKING)
> +                               synchronize_srcu(hctx->srcu);
> +                       else
> +                               rcu = true;
> +               } else {
> +                       init_completion(&hctx->rcu_sync->completion);
> +                       init_rcu_head(&hctx->rcu_sync->head);
> +                       if (hctx->flags & BLK_MQ_F_BLOCKING)
> +                               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
> +                                       wakeme_after_rcu);
> +                       else
> +                               call_rcu(&hctx->rcu_sync->head,
> +                                       wakeme_after_rcu);
> +               }
> +       }
> +       if (rcu)
> +               synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> +
> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> +{
> +       struct blk_mq_hw_ctx *hctx;
> +       unsigned int i;
> +
> +       queue_for_each_hw_ctx(q, hctx, i) {
> +               if (!hctx->rcu_sync)
> +                       continue;
> +               wait_for_completion(&hctx->rcu_sync->completion);
> +               destroy_rcu_head(&hctx->rcu_sync->head);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> +
>  /**
>   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>   * @q: request queue.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 23230c1d031e..7213ce56bb31 100644
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
>          */
>         struct list_head        hctx_list;
> 
> +       struct rcu_synchronize  *rcu_sync;

The above pointer needn't to be added to blk_mq_hw_ctx, and it can be
allocated on heap and passed to the waiting helper.


Thanks,
Ming

