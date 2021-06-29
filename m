Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E2C11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDA261DB3
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhF2OUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234381AbhF2OUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624976253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEd0iL8sflC3igF9PSfknmHOeadUEAx77IF24oaHt9U=;
        b=NSnjFvmekmQCEwEFq31jNA+gqOt8sSce8TMOnm7/1OmAeoJEIBWMv70v/rCvNQTz9+aVkE
        SYwOOHc/OO7ItM9R/DE8gnhaA2OVvFrfrpo+DcAW1thqXRL4Uf1NRm8WHlC0ktdWmqCHBz
        X5D6NU+ewVzuPgQUGEFNXtrKT+oc/mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-s1GaoaQJMSGwUs5g9cf2xQ-1; Tue, 29 Jun 2021 10:17:29 -0400
X-MC-Unique: s1GaoaQJMSGwUs5g9cf2xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E35C804141;
        Tue, 29 Jun 2021 14:17:28 +0000 (UTC)
Received: from T590 (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84CD610016F8;
        Tue, 29 Jun 2021 14:17:19 +0000 (UTC)
Date:   Tue, 29 Jun 2021 22:17:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <YNsrayg+pbVO+J7I@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <1a14a397-6244-928e-5aaa-85c2ccbe0e40@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a14a397-6244-928e-5aaa-85c2ccbe0e40@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 29, 2021 at 02:39:14PM +0200, Hannes Reinecke wrote:
> On 6/29/21 9:49 AM, Ming Lei wrote:
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
> 
> How can you submit a connect request for a hctx on which all CPUs are
> offline? That hctx will be unusable as it'll never be able to receive
> interrupts ...

I believe BLK_MQ_F_NOT_USE_MANAGED_IRQ is self-explanatory. And the
interrupt(non-managed) of this hctx will be migrated to online CPUs,
see migrate_one_irq().

For managed irq, we have to prevent new allocation if all CPUs of this
hctx is offline because genirq will shutdown the interrupt.

> 
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
> 
> I don't get it.
> Doesn't this allow us to allocate a request on a dead cpu, ie the very thing
> we try to prevent?

It is fine to allocate & dispatch one request to the hctx when all CPU on
its cpumask are offline if this hctx's interrupt isn't managed.


Thanks,
Ming

