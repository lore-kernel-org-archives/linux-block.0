Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11C020675
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Puod3wEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgENApV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 20:45:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51867 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732279AbgENApV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589417119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BuwsKaIZwwTwHeVKPeTziDwAyqQc2tBppj5bMmvLnFw=;
        b=Puod3wEjw+Kr7//4NWIwSDiyRdr9VzjoWSQHgJUjuGiFMi/PzlXg/SXLev70fOhc0MEDwo
        nwkDr4fqyjiSRcRwAG2r13ZmXOR+6S5K4biQMXrXiJLEZHkniUTz1QbvDM/pRAYD+a4l2t
        nQNW+QPjWz325tebcXIAvZDDhPD0oUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-SsxfTMaPPc2UrzhQkYf1fA-1; Wed, 13 May 2020 20:45:16 -0400
X-MC-Unique: SsxfTMaPPc2UrzhQkYf1fA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFFAB80183C;
        Thu, 14 May 2020 00:45:14 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 093C25C1BE;
        Thu, 14 May 2020 00:45:07 +0000 (UTC)
Date:   Thu, 14 May 2020 08:45:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200514004503.GD2073570@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-12-ming.lei@redhat.com>
 <20200513122147.GF6297@lst.de>
 <837d3c51-5a14-8c91-7e4a-9ef9b83359b9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837d3c51-5a14-8c91-7e4a-9ef9b83359b9@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 08:03:13AM -0700, Bart Van Assche wrote:
> On 2020-05-13 05:21, Christoph Hellwig wrote:
> > Use of the BLK_MQ_REQ_FORCE is pretty bogus here..
> > 
> >> +	if (rq->rq_flags & RQF_PREEMPT)
> >> +		flags |= BLK_MQ_REQ_PREEMPT;
> >> +	if (reserved)
> >> +		flags |= BLK_MQ_REQ_RESERVED;
> >> +	/*
> >> +	 * Queue freezing might be in-progress, and wait freeze can't be
> >> +	 * done now because we have request not completed yet, so mark this
> >> +	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
> >> +	 * freeze hung forever.
> >> +	 */
> >> +	flags |= BLK_MQ_REQ_FORCE;
> >> +
> >> +	/* avoid allocation failure by clearing NOWAIT */
> >> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> >> +	if (!nrq)
> >> +		return;
> > 
> > blk_get_request returns an ERR_PTR.
> > 
> > But I'd rather avoid the magic new BLK_MQ_REQ_FORCE hack when we can
> > just open code it and document what is going on:
> > 
> > static struct blk_mq_tags *blk_mq_rq_tags(struct request *rq)
> > {
> > 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > 
> > 	if (rq->q->elevator)
> > 		return hctx->sched_tags;
> > 	return hctx->tags;
> > }
> > 
> > static void blk_mq_resubmit_rq(struct request *rq)
> > {
> > 	struct blk_mq_alloc_data alloc_data = {
> > 		.cmd_flags	= rq->cmd_flags & ~REQ_NOWAIT;
> > 	};
> > 	struct request *nrq;
> > 
> > 	if (rq->rq_flags & RQF_PREEMPT)
> > 		alloc_data.flags |= BLK_MQ_REQ_PREEMPT;
> > 	if (blk_mq_tag_is_reserved(blk_mq_rq_tags(rq), rq->internal_tag))
> > 		alloc_data.flags |= BLK_MQ_REQ_RESERVED;
> > 
> > 	/*
> > 	 * We must still be able to finish a resubmission due to a hotplug
> > 	 * even even if a queue freeze is in progress.
> > 	 */
> > 	percpu_ref_get(&q->q_usage_counter);
> > 	nrq = blk_mq_get_request(rq->q, NULL, &alloc_data);
> > 	blk_queue_exit(q);
> > 
> > 	if (!nrq)
> > 		return; // XXX: warn?
> > 	if (nrq->q->mq_ops->initialize_rq_fn)
> > 		rq->mq_ops->initialize_rq_fn(nrq);
> > 
> > 	blk_rq_copy_request(nrq, rq);
> > 	...
> 
> I don't like this because the above code allows allocation of requests
> and tags while a request queue is frozen. I'm concerned that this will
> break code that assumes that no tags are allocated while a request queue
> is frozen. If a request queue has a single hardware queue with 64 tags,

The above code path will never be called for single hw queue.

> if the above code allocates tag 40 and if blk_mq_tag_update_depth()
> reduces the queue depth to 32, will nrq become a dangling pointer?

allocation for nrq is just like other normal allocation, and if
it doesn't work with blk_mq_tag_update_depth(), it must be a more
generic issue instead of relating with this specific use case.

The only difference is that 'nrq' will be allocated from a new active
hctx, so the two requests can co-exist and we needn't to worry deadlock.


thanks,
Ming

