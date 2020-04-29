Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCAC83001
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 02:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DD620784
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 02:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs/5fecC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2CQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:16:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgD2CQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 22:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588126592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6ASSfj7kdH67HWu3L/nYZw/tdStNtr5OBtpC7mpx88=;
        b=Vs/5fecCposwNDTX9+cC+j/X3gKxI9kDjHf71JRP/TVjghQFOENk7SOkOMBV3JLobCZySO
        6Hfb018ljk6nwKCLBgAbGGDvy7rWvlKkSJB4c8piWHoOReaDoSX2ZSToYv1J1O8iRKKsQJ
        gsx1pUPKQCkNLDGy1QUug3V4rY9+iQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-HKjnAzb2OJ6mndOtIIi9EQ-1; Tue, 28 Apr 2020 22:16:28 -0400
X-MC-Unique: HKjnAzb2OJ6mndOtIIi9EQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BF871009610;
        Wed, 29 Apr 2020 02:16:26 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18097600D2;
        Wed, 29 Apr 2020 02:16:16 +0000 (UTC)
Date:   Wed, 29 Apr 2020 10:16:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200429021612.GD671522@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428155837.GA16910@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Peter,

On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> >  		atomic_inc(&data.hctx->nr_active);
> >  	}
> >  	data.hctx->tags->rqs[rq->tag] = rq;
> >  
> >  	/*
> > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > +	 * gets migrated to another CPU that is not mapped to this hctx.
> >  	 */
> > +	if (rq->mq_ctx->cpu != get_cpu())
> >  		smp_mb();
> > +	put_cpu();
> 
> This looks exceedingly weird; how do you think you can get to another
> CPU and not have an smp_mb() implied in the migration itself? Also, what

What we need is one smp_mb() between the following two OPs:

1) 
   rq->tag = rq->internal_tag;
   data.hctx->tags->rqs[rq->tag] = rq;

2) 
	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))

And the pair of the above barrier is in blk_mq_hctx_notify_offline().

So if this process is migrated before 1), the implied smp_mb() is useless.

> stops the migration from happening right after the put_cpu() ?

If the migration happens after put_cpu(), the above two OPs are still
ordered by the implied smp_mb(), so looks not a problem.

> 
> 
> >  	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
> >  		blk_mq_put_driver_tag(rq);
> 
> 
> > +static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> > +		struct blk_mq_hw_ctx *hctx)
> >  {
> > +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> > +		return false;
> > +	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
> > +		return false;
> > +	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> > +		return false;
> > +	return true;
> >  }
> 
> Does this want something like:
> 
> 	lockdep_assert_held(*set->tag_list_lock);
> 
> to make sure hctx->cpumask is stable? Those mask ops are not stable vs
> concurrenct set/clear at all.

hctx->cpumask is only updated in __blk_mq_update_nr_hw_queues(), in
which all request queues in the tagset have been frozen, and no any
in-flight IOs, so we needn't to pay attention to that case.


Thanks, 
Ming

