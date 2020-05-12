Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80821C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F28F2071A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9EsaCxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgELCI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 22:08:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727886AbgELCI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 22:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589249307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEemfPJYhCYFTcRDEi1mUZDpXEdPohuvEbKF5We+oK0=;
        b=A9EsaCxyZZdokX//rn6HlaEOJyOAtXhz48+qmBbp6UWTrGoh/scllYdl5ziMegaimD8lSW
        aUI6Id/VjUSWPZpPI8mnde6HxdHr2N0YdvvBp7/eH3GGnJgp+2wkP46AxQt5cEy2VwRa2Z
        XxFoZgXQx61z3PtNUZzbDE4jN0wgcQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-dFymtbLCMKmOwNIR4HcsdA-1; Mon, 11 May 2020 22:08:23 -0400
X-MC-Unique: dFymtbLCMKmOwNIR4HcsdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 560281009440;
        Tue, 12 May 2020 02:08:22 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0407E196AE;
        Tue, 12 May 2020 02:08:14 +0000 (UTC)
Date:   Tue, 12 May 2020 10:08:10 +0800
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
Message-ID: <20200512020810.GC1531898@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
 <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
 <20200511021133.GC1418834@T590>
 <73702cd9-6dcc-a757-be3b-c250e050692c@acm.org>
 <20200511040841.GE1418834@T590>
 <c4d78e75-91e1-1521-1ba0-d30bf3716f83@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d78e75-91e1-1521-1ba0-d30bf3716f83@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 01:52:14PM -0700, Bart Van Assche wrote:
> On 2020-05-10 21:08, Ming Lei wrote:
> > OK, just forgot the whole story, but the issue can be fixed quite easily
> > by adding a new request allocation flag in slow path, see the following
> > patch:
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index ec50d7e6be21..d743be1b45a2 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -418,6 +418,11 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
> >  		if (success)
> >  			return 0;
> >  
> > +		if (flags & BLK_MQ_REQ_FORCE) {
> > +			percpu_ref_get(ref);
> > +			return 0;
> > +		}
> > +
> >  		if (flags & BLK_MQ_REQ_NOWAIT)
> >  			return -EBUSY;
> >  
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index c2ea0a6e5b56..2816886d0bea 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -448,6 +448,13 @@ enum {
> >  	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
> >  	/* set RQF_PREEMPT */
> >  	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
> > +
> > +	/*
> > +	 * force to allocate request and caller has to make sure queue
> > +	 * won't be forzen completely during allocation, and this flag
> > +	 * is only applied after queue freeze is started
> > +	 */
> > +	BLK_MQ_REQ_FORCE	= (__force blk_mq_req_flags_t)(1 << 4),
> >  };
> >  
> >  struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
> 
> I'm not sure that introducing such a flag is a good idea. After
> blk_mq_freeze_queue() has made it clear that a request queue must be
> frozen and before the request queue is really frozen, an RCU grace
> period must expire. Otherwise it cannot be guaranteed that the intention
> to freeze a request queue (by calling percpu_ref_kill()) has been
> observed by all potential blk_queue_enter() callers (blk_queue_enter()
> calls percpu_ref_tryget_live()). Not introducing any new race conditions
> would either require to introduce an smp_mb() call in blk_queue_enter()
> or to let another RCU grace period expire after the last allocation of a
> request with BLK_MQ_REQ_FORCE and before the request queue is really frozen.

Actually neither smp_mb() or extra grace period is needed, and it can
be explained in the following way simply:

percpu_ref_get() -> percpu_ref_get_many() is introduced by BLK_MQ_REQ_FORCE.

When percpu_ref_get() is called:

- if it is still in percpu mode, it will be covered by the rcu grace period
in percpu_ref_kill_and_confirm().

- otherwise, the refcount is grabbed in atomic mode, no extra smp_mb()
or rcu period required because we guarantee that the atomic number is >
1 when calling percpu_ref_get(). And blk_mq_freeze_queue_wait() will
observe correct value of this atomic refcount.

percpu_ref_get() is documented as :

 * This function is safe to call as long as @ref is between init and exit.


Thanks,
Ming

