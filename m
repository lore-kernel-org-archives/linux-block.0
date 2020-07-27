Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BAFC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 02:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035E02070A
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 02:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7Jep594"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgG0CIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 22:08:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgG0CIW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 22:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595815700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHxRyECYtQanh0ezBnPcM1ZXwerag91PJylDaVDzjY4=;
        b=I7Jep594kWuA+gcrg0yauKOFw0aAVISprWhuSxSXZizlytxMDLilgpV2aO5MtUo1xzKi22
        x3yTaBZ9/4l3JtwukK1aTGd0HUp3Vz8IaOmVVUdd9Raj0LFDuFbFZKbLTgycxlzAxxFAcd
        DOkDqyh83+3gBC2HWUGmeIkTht/zCxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-YJqsOQdjOPqpH92RAWKq1A-1; Sun, 26 Jul 2020 22:08:18 -0400
X-MC-Unique: YJqsOQdjOPqpH92RAWKq1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500DA1005510;
        Mon, 27 Jul 2020 02:08:16 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A643A1992D;
        Mon, 27 Jul 2020 02:08:08 +0000 (UTC)
Date:   Mon, 27 Jul 2020 10:08:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727020803.GC1129253@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 26, 2020 at 09:27:56AM -0700, Sagi Grimberg wrote:
> 
> > > +void blk_mq_quiesce_queue_async(struct request_queue *q)
> > > +{
> > > +	struct blk_mq_hw_ctx *hctx;
> > > +	unsigned int i;
> > > +
> > > +	blk_mq_quiesce_queue_nowait(q);
> > > +
> > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > +		init_completion(&hctx->rcu_sync.completion);
> > > +		init_rcu_head(&hctx->rcu_sync.head);
> > > +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> > > +				wakeme_after_rcu);
> > > +		else
> > > +			call_rcu(&hctx->rcu_sync.head,
> > > +				wakeme_after_rcu);
> > > +	}
> > 
> > Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> > synchronize_rcu() is OK for all hctx during waiting.
> 
> That's true, but I want a single interface for both. v2 had exactly
> that, but I decided that this approach is better.

Not sure one new interface is needed, and one simple way is to:

1) call blk_mq_quiesce_queue_nowait() for each request queue

2) wait in driver specific way

Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
then you may add per-tagset APIs for the waiting.

> 
> Also, having the driver call a single synchronize_rcu isn't great

Too many drivers are using synchronize_rcu():

	$ git grep -n synchronize_rcu ./drivers/ | wc
	    186     524   11384

> layering (as quiesce can possibly use a different mechanism in the future).

What is the different mechanism?

> So drivers assumptions like:
> 
>         /*
>          * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
>          * calling synchronize_rcu() once is enough.
>          */
>         WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
> 
>         if (!ret)
>                 synchronize_rcu();
> 
> Are not great...

Both rcu read lock/unlock and synchronize_rcu is global interface, then
it is reasonable to avoid unnecessary synchronize_rcu().

> 
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> > > +
> > > +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> > > +{
> > > +	struct blk_mq_hw_ctx *hctx;
> > > +	unsigned int i;
> > > +
> > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > +		wait_for_completion(&hctx->rcu_sync.completion);
> > > +		destroy_rcu_head(&hctx->rcu_sync.head);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> > > +
> > >   /**
> > >    * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
> > >    * @q: request queue.
> > > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > > index 23230c1d031e..5536e434311a 100644
> > > --- a/include/linux/blk-mq.h
> > > +++ b/include/linux/blk-mq.h
> > > @@ -5,6 +5,7 @@
> > >   #include <linux/blkdev.h>
> > >   #include <linux/sbitmap.h>
> > >   #include <linux/srcu.h>
> > > +#include <linux/rcupdate_wait.h>
> > >   struct blk_mq_tags;
> > >   struct blk_flush_queue;
> > > @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
> > >   	 */
> > >   	struct list_head	hctx_list;
> > > +	struct rcu_synchronize	rcu_sync;
> > The above struct takes at least 5 words, and I'd suggest to avoid it,
> > and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
> > Meantime !BLK_MQ_F_BLOCKING doesn't need it.
> 
> It is at the end and contains exactly what is needed to synchronize. Not

The sync is simply single global synchronize_rcu(), and why bother to add
extra >=40bytes for each hctx.

> sure what you mean by reuse hctx->srcu?

You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
to each hctx for just simulating one single synchronize_rcu().


Thanks,
Ming

