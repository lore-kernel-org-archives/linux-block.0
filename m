Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC01C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 10:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253A86108F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHRKeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234893AbhHRKdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 06:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629282776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4ECR/7LCl11DZMmIx24paVmBtUy1mAPExnwlhk9tCY=;
        b=aVy6CQSTlahkO/GkXqqFwXs/NGGVBQYjYoYCzpYwLgYJlOC7FN4WHjgGr09CvBiX5xiUgS
        RKRjawpcut8vm/CuJdXDDWUC7GXTVX8UXNnESS+ATxRyz/R21MxbvrLFq8Slm8J+GoaJZU
        G2Ch6kRxbGguINRK3wzFC6IlKJA7uD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-n5v49ef6MlejYgF0sNhzKw-1; Wed, 18 Aug 2021 06:32:54 -0400
X-MC-Unique: n5v49ef6MlejYgF0sNhzKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F066687D543;
        Wed, 18 Aug 2021 10:32:52 +0000 (UTC)
Received: from T590 (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBC3A369A;
        Wed, 18 Aug 2021 10:32:43 +0000 (UTC)
Date:   Wed, 18 Aug 2021 18:32:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <YRzhxoB6zy0d7Ysk@T590>
References: <20210722095246.1240526-1-ming.lei@redhat.com>
 <20210722095246.1240526-4-ming.lei@redhat.com>
 <23acd521-dac3-068d-b82a-424c078e0ac0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23acd521-dac3-068d-b82a-424c078e0ac0@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 10:38:15AM +0100, John Garry wrote:
> On 22/07/2021 10:52, Ming Lei wrote:
> > blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
> > offline by draining all requests originated from this hctx and moving new
> > allocation to other active hctx. This way is for avoiding inflight IO in
> > case of managed irq because managed irq is shutdown when the last CPU in
> > the irq's affinity becomes offline.
> > 
> > However, lots of drivers(nvme fc, rdma, tcp, loop, ...) don't use managed
> > irq, so they needn't to deactivate hctx when the last CPU becomes offline.
> > Also, some of them are the only user of blk_mq_alloc_request_hctx() which
> > is used for connecting io queue. And their requirement is that the connect
> > request needs to be submitted successfully via one specified hctx even though
> > all CPUs in this hctx->cpumask have become offline.
> > 
> > Addressing the requirement for nvme fc/rdma/loop by allowing to
> > allocate request from one hctx when all CPUs in this hctx are offline,
> > since these drivers don't use managed irq.
> > 
> > Finally don't deactivate one hctx when it doesn't use managed irq.
> > 
> > Reviewed-by: Christoph Hellwig<hch@lst.de>
> > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> 
> Sorry for lateness. Just a few minor comments below, regardless:
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> > ---
> >   block/blk-mq.c | 27 +++++++++++++++++----------
> >   block/blk-mq.h |  8 ++++++++
> >   2 files changed, 25 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 2c4ac51e54eb..591ab07c64d8 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -427,6 +427,15 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
> >   }
> >   EXPORT_SYMBOL(blk_mq_alloc_request);
> > +static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> 
> I don't see why it needs to be inline. I think generally we leave it to the
> compiler to decide.

Usually if one function is called more than two times, it will not be
inlined. blk_mq_first_mapped_cpu() is called in fast path, so we need to
inline it.

> 
> > +{
> > +	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
> > +
> > +	if (cpu >= nr_cpu_ids)
> > +		cpu = cpumask_first(hctx->cpumask);
> > +	return cpu;
> > +}
> > +
> >   struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >   	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
> >   {
> > @@ -468,7 +477,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >   	data.hctx = q->queue_hw_ctx[hctx_idx];
> >   	if (!blk_mq_hw_queue_mapped(data.hctx))
> >   		goto out_queue_exit;
> > -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > +
> > +	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
> > +
> > +	cpu = blk_mq_first_mapped_cpu(data.hctx);
> >   	data.ctx = __blk_mq_get_ctx(q, cpu);
> >   	if (!q->elevator)
> > @@ -1501,15 +1513,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >   	hctx_unlock(hctx, srcu_idx);
> >   }
> > -static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> > -{
> > -	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
> > -
> > -	if (cpu >= nr_cpu_ids)
> > -		cpu = cpumask_first(hctx->cpumask);
> > -	return cpu;
> > -}
> > -
> >   /*
> >    * It'd be great if the workqueue API had a way to pass
> >    * in a mask and had some smarts for more clever placement.
> > @@ -2556,6 +2559,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> >   	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> >   			struct blk_mq_hw_ctx, cpuhp_online);
> > +	/* hctx needn't to be deactivated in case managed irq isn't used */
> > +	if (!blk_mq_hctx_use_managed_irq(hctx))
> > +		return 0;
> 
> In a previous version (v2) I think that we just didn't register the cpu
> hotplug handlers, so not sure why that changed.

Sorry, forget to mention the change, inside blk_mq_realloc_hw_ctxs()
we may grab one cached hctx without initializing it, so use managed irq
info change may not be visible in blk_mq_init_hctx().

Given blk_mq_hctx_notify_offline() isn't in fast path, I'd rather to
check in blk_mq_hctx_notify_offline(), which is more reliable than
running the check in blk_mq_init_hctx().

> 
> > +
> >   	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> >   	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> >   		return 0;
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index d08779f77a26..7333b659d8f5 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -119,6 +119,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> >   	return ctx->hctxs[type];
> >   }
> > +static inline bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	if (hctx->type == HCTX_TYPE_POLL)
> > +		return false;
> > +
> > +	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
> > +}
> 
> This function only seems to be used in blk-mq.c, so not sure why you put it
> in .h file.

oops, the helper must be used in early version, I will send a new
version soon.


Thanks,
Ming

