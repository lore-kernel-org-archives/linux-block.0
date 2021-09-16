Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE4BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD9C60F4A
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhIPCSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 22:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231674AbhIPCSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 22:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631758639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/iLmkx3P2+W+8y8LQZyQBtm9zHR79tI+Ag4NekFlLU=;
        b=KQpSr+L2o52bGsHldQExSIl7mp1kN7kz4v1Hd5pYLWR5D7RnEe3uINIaIDeIG8fq4lASSr
        KxJV9FjLd2eyW6Md+j92yc6s5F8MUcGxGjuzLUcILd0g7uNUAvT1W2vHk57bx6argBXgFB
        ZvFBs2f/PIwLw+h8qtiayecwoFz5k8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-mTQKEqP-P0eYO9NWWd_9RQ-1; Wed, 15 Sep 2021 22:17:16 -0400
X-MC-Unique: mTQKEqP-P0eYO9NWWd_9RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6288B1084688;
        Thu, 16 Sep 2021 02:17:15 +0000 (UTC)
Received: from T590 (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE0B18EC5;
        Thu, 16 Sep 2021 02:17:06 +0000 (UTC)
Date:   Thu, 16 Sep 2021 10:17:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <YUKpLmOPM1BNN5lF@T590>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-4-ming.lei@redhat.com>
 <20210915161459.ks3pbqceuj5x3ugu@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915161459.ks3pbqceuj5x3ugu@carbon.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 06:14:59PM +0200, Daniel Wagner wrote:
> On Wed, Aug 18, 2021 at 10:44:28PM +0800, Ming Lei wrote:
> >  struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >  	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
> >  {
> > @@ -468,7 +485,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >  	data.hctx = q->queue_hw_ctx[hctx_idx];
> >  	if (!blk_mq_hw_queue_mapped(data.hctx))
> >  		goto out_queue_exit;
> > -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > +
> > +	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
> > +
> > +	cpu = blk_mq_first_mapped_cpu(data.hctx);
> >  	data.ctx = __blk_mq_get_ctx(q, cpu);
> 
> I was pondering how we could address the issue that the qla2xxx driver
> is using managed IRQs which makes nvme-fc depending as class on managed
> IRQ.
> 
> blk_mq_alloc_request_hctx() is the only place where we really need to
> distinguish between managed and !managed IRQs. As far I undertand the
> situation, if all CPUs for a hctx are going offline, the driver wont use
> this context. So there is only the case we end up in this code path is
> when the driver tries to reconnect the queues, e.g. after
> devloss. Couldn't we in this case not just return an error and go into
> error recovery? Something like this:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a2db50886a26..52fc8592c72e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -486,9 +486,13 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>         if (!blk_mq_hw_queue_mapped(data.hctx))
>                 goto out_queue_exit;
>  
> -       WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
> -
> -       cpu = blk_mq_first_mapped_cpu(data.hctx);
> +       if (blk_mq_hctx_use_managed_irq(data.hctx)) {

Firstly, even with patches of 'qla2xxx - add nvme map_queues support',
the knowledge if managed irq is used in nvmef LLD is still missed, so
blk_mq_hctx_use_managed_irq() may always return false, but that
shouldn't be hard to solve.

The problem is that we still should make connect io queue completed
when all CPUs of this hctx is offline in case of managed irq.

One solution might be to use io polling for connecting io queue, but nvme fc
doesn't support polling, all the other nvme hosts do support it.



Thanks,
Ming

