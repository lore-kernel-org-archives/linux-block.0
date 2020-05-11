Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B95C38A2A
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D58C206D7
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5NdBDaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgEKCLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 22:11:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729102AbgEKCLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 22:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589163109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7S8jgKgFppIdleXVmCwDJvLU57zYF6f2ubuP/BVl4Z0=;
        b=b5NdBDaayCkXuZGXoyDjA28S55P7oJvvn5KdrWwwc5iVXx+nxtt83X3y2zLwTqGM1RwgSX
        Id1aDRaL/yu/cpYaAFgKVTPEd1s+6sZJH6gZL3dzR+r+9VqkXWcgnvWpNTh2YsLDKF2xdL
        o9t2GWgRYEvEDGWRgnw3kbpAvn9uJ6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-1UIPOBwNMBeVbK2NscfUMA-1; Sun, 10 May 2020 22:11:47 -0400
X-MC-Unique: 1UIPOBwNMBeVbK2NscfUMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2FE81899521;
        Mon, 11 May 2020 02:11:45 +0000 (UTC)
Received: from T590 (ovpn-13-75.pek2.redhat.com [10.72.13.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B325F7D5;
        Mon, 11 May 2020 02:11:38 +0000 (UTC)
Date:   Mon, 11 May 2020 10:11:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V10 11/11] block: deactivate hctx when the hctx is
 actually inactive
Message-ID: <20200511021133.GC1418834@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
 <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 09, 2020 at 07:07:55AM -0700, Bart Van Assche wrote:
> On 2020-05-04 19:09, Ming Lei wrote:
> > @@ -1373,28 +1375,16 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >  	int srcu_idx;
> >  
> [ ... ]
> >  	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> > -		cpu_online(hctx->next_cpu)) {
> > -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> > -			raw_smp_processor_id(),
> > -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> > -		dump_stack();
> > +	    cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) >=
> > +	    nr_cpu_ids) {
> > +		blk_mq_hctx_deactivate(hctx);
> > +		return;
> >  	}
> 
> The blk_mq_hctx_deactivate() function calls blk_mq_resubmit_rq()
> indirectly. From blk_mq_resubmit_rq():
> 
> +  /* avoid allocation failure by clearing NOWAIT */
> +  nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> 
> blk_get_request() calls blk_mq_alloc_request(). blk_mq_alloc_request()
> calls blk_queue_enter(). blk_queue_enter() waits until a queue is
> unfrozen if freezing of a queue has started. As one can see freezing a
> queue triggers a queue run:
> 
> void blk_freeze_queue_start(struct request_queue *q)
> {
> 	mutex_lock(&q->mq_freeze_lock);
> 	if (++q->mq_freeze_depth == 1) {
> 		percpu_ref_kill(&q->q_usage_counter);
> 		mutex_unlock(&q->mq_freeze_lock);
> 		if (queue_is_mq(q))
> 			blk_mq_run_hw_queues(q, false);
> 	} else {
> 		mutex_unlock(&q->mq_freeze_lock);
> 	}
> }
> 
> Does this mean that if queue freezing happens after hot unplugging
> started that a deadlock will occur because the blk_mq_run_hw_queues()
> call in blk_freeze_queue_start() will wait forever?

Yes, looks there is such issue.

However, the wait forever isn't new with this patch, because all queued
(in scheduler queue or sw queue)request may not be completed after this
hctx becomes inactive.

One simple solution is to pass BLK_MQ_REQ_PREEMPT to blk_get_request()
called in blk_mq_resubmit_rq() because at that time freezing wait won't
return and it is safe to allocate a new request for completing old
requests originated from inactive hctx.

I will do this way in V11.

Thanks,
Ming

