Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5DFC38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9EF21655
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF/5iNwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEICVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 22:21:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgEICVL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 22:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588990869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HU7MS1unXmMqOnqWmhfdtfqrZPzdRtN+BY2jI/XIMMQ=;
        b=XF/5iNwnf0iZlzZyEsZrgwhe7coeW8wiG0BMJBkNlBUaTqDMWtIvyyjnaAkJh3AF5taFoE
        Z/ReDoxValneVdvexYyb2+tt5jzjf87vZMvq+8SM6KRWUzQoxPS/7LuS+XJxOukSPYdg7c
        thVILFoUeco5keibZXS5uSt+UL5oeko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-NRlidhC6NLa_XNPMXyVVcA-1; Fri, 08 May 2020 22:21:05 -0400
X-MC-Unique: NRlidhC6NLa_XNPMXyVVcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70276464;
        Sat,  9 May 2020 02:21:04 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A56A708F3;
        Sat,  9 May 2020 02:20:56 +0000 (UTC)
Date:   Sat, 9 May 2020 10:20:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200509022051.GC1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 04:39:46PM -0700, Bart Van Assche wrote:
> On 2020-05-04 19:09, Ming Lei wrote:
> > -static bool blk_mq_get_driver_tag(struct request *rq)
> > +static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
> >  {
> >  	if (rq->tag != -1)
> >  		return true;
> > -	return __blk_mq_get_driver_tag(rq);
> > +
> > +	if (!__blk_mq_get_driver_tag(rq))
> > +		return false;
> > +	/*
> > +	 * In case that direct issue IO process is migrated to other CPU
> > +	 * which may not belong to this hctx, add one memory barrier so we
> > +	 * can order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> > +	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> > +	 * and driver tag assignment are run on the same CPU because
> > +	 * BLK_MQ_S_INACTIVE is only set after the last CPU of this hctx is
> > +	 * becoming offline.
> > +	 *
> > +	 * Process migration might happen after the check on current processor
> > +	 * id, smp_mb() is implied by processor migration, so no need to worry
> > +	 * about it.
> > +	 */
> > +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> > +		smp_mb();
> > +	else
> > +		barrier();
> > +
> > +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
> > +		blk_mq_put_driver_tag(rq);
> > +		return false;
> > +	}
> > +	return true;
> >  }
> 
> How much does this patch slow down the hot path?

Basically zero cost is added to hot path, exactly:

> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))

In case of direct issue, chance of the io process migration is very
small, since basically direct issue follows request allocation and the
time is quite small, so smp_mb() won't be run most of times.

> +		smp_mb();
> +	else
> +		barrier();

So barrier() is added most of times, however the effect can be ignored
since it is just a compiler barrier.

> +
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {

hctx->state is always checked in hot path, so basically zero cost.

> +		blk_mq_put_driver_tag(rq);
> +		return false;
> +	}

> 
> Can CPU migration be fixed without affecting the hot path, e.g. by using
> the request queue freezing mechanism?

Why do we want to fix CPU migration of direct issue IO process? It may not be
necessary or quite difficultly:

1) preempt disable is removed previously in cleanup patch since request
is allocated

2) we have drivers which may set BLOCKING, so .queue_rq() may sleep

Not sure why you mention queue freezing.


Thanks,
Ming

