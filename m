Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F187C11F67
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659B061D81
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 00:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhF3Aff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 20:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235456AbhF3Afe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 20:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625013186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goskKeW0yzEcAx5B3vtHPNaTJXA0fzeCUV8XRqEWcNk=;
        b=UkNFqU99Y+cIjRruEtV8TaCMIwH+HXm4jZHe55pMm10fNfsbySN0QUq+eJaU8vQQ0Yztt+
        npuIYcUihPS5chE+9BVkf1QsytyrbcE6d/v4LePHOKrReauXRI43Vl+PrjgBnnpDXc5XRZ
        zz/NxPu1iVQzGJiySfCjVAdea3yJn4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-chgzleZaNZuPxADKaXVFnQ-1; Tue, 29 Jun 2021 20:33:02 -0400
X-MC-Unique: chgzleZaNZuPxADKaXVFnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F56804140;
        Wed, 30 Jun 2021 00:33:00 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5831F5D6A1;
        Wed, 30 Jun 2021 00:32:51 +0000 (UTC)
Date:   Wed, 30 Jun 2021 08:32:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <YNu7rs7j5/KtQjAi@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 29, 2021 at 04:49:56PM +0100, John Garry wrote:
> On 29/06/2021 08:49, Ming Lei wrote:
> > hctx is deactivated when all CPU in hctx->cpumask become offline by
> > draining all requests originated from this hctx and moving new
> > allocation to active hctx. This way is for avoiding inflight IO when
> > the managed irq is shutdown.
> > 
> > Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
> > they needn't to deactivate hctx. Also, they are the only user of
> > blk_mq_alloc_request_hctx() which is used for connecting io queue.
> > And their requirement is that the connect request can be submitted
> > via one specified hctx on which all CPU in its hctx->cpumask may have
> > become offline.
> > 
> > Address the requirement for nvme fc/rdma/loop, so the reported kernel
> > panic on the following line in blk_mq_alloc_request_hctx() can be fixed.
> > 
> > 	data.ctx = __blk_mq_get_ctx(q, cpu)
> > 
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Daniel Wagner <dwagner@suse.de>
> > Cc: Wen Xiong <wenxiong@us.ibm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq.c         | 6 +++++-
> >   include/linux/blk-mq.h | 1 +
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index df5dc3b756f5..74632f50d969 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >   	data.hctx = q->queue_hw_ctx[hctx_idx];
> >   	if (!blk_mq_hw_queue_mapped(data.hctx))
> >   		goto out_queue_exit;
> > -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > +	cpu = cpumask_first(data.hctx->cpumask);
> >   	data.ctx = __blk_mq_get_ctx(q, cpu);
> >   	if (!q->elevator)
> > @@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> >   	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> >   		return 0;
> > +	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
> > +	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
> > +		return 0;
> Is there anything to be gained in registering the CPU hotplug handler for
> the hctx in this case at all?

Indeed, we may replace BLK_MQ_F_STACKING with BLK_MQ_F_NOT_USE_MANAGED_IRQ
(BLK_MQ_F_NO_MANAGED_IRQ) too, and the latter is one general solution.

> 
> > +
> >   	/*
> >   	 * Prevent new request from being allocated on the current hctx.
> >   	 *
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 21140132a30d..600c5dd1a069 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -403,6 +403,7 @@ enum {
> >   	 */
> >   	BLK_MQ_F_STACKING	= 1 << 2,
> >   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
> > +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
> 
> Many block drivers don't use managed interrupts - to be proper, why not set
> this everywhere (which doesn't use managed interrupts)? I know why, but it's
> odd.

It is just one small optimization in slow path for other drivers, not sure these
drivers are interested in such change. It only serves as fix for callers of
blk_mq_alloc_request_hctx().

Anyway, we can document the situation.

> 
> As an alternative, if the default queue mapping was used (in
> blk_mq_map_queues()), then that's the same thing as
> BLK_MQ_F_NOT_USE_MANAGED_IRQ in reality, right? If so, could we
> alternatively check for that somehow?

This way can't work, for example of NVMe PCI, managed irq is used for
the default/write queues, but poll queues uses blk_mq_map_queues().

Also it can't cover all cases, such as MVMe RDMA.

Using managed irq or not is thing of driver's choice, and not sure if it
is good for block layer to provide such abstract. I'd suggest to fix the
issue still by passing one flag, given we needn't it everywhere so far.

 
Thanks,
Ming

