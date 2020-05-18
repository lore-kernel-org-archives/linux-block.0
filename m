Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D72C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C69207ED
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMbyG+Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgERJcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 05:32:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32809 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgERJcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 05:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589794337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4Gtna4JJYoT2k1EZMPSnpiVpHxGCb2w7MmU1rurbdc=;
        b=LMbyG+Hsh829Jex2iv94vbpV1m2xa+pVltNQjrwoCbuAHWWiitjzaVxYponcvuJtrPDNBS
        D7vTVtvGiboMLRSWv9mwNs/FpGtukYqn67O5kMXll83LW6td4fg/+zjTgI9pflVCmlW6f2
        GkD6g3dvuAZR1Z+zfEMpz0Vea10NQo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-yjgoU-u0P3q3Gj1ouPXgtQ-1; Mon, 18 May 2020 05:32:13 -0400
X-MC-Unique: yjgoU-u0P3q3Gj1ouPXgtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 004CE80058A;
        Mon, 18 May 2020 09:32:12 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F53D5C1B2;
        Mon, 18 May 2020 09:31:59 +0000 (UTC)
Date:   Mon, 18 May 2020 17:31:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518093155.GB35380@T590>
References: <20200518063937.757218-1-hch@lst.de>
 <20200518063937.757218-6-hch@lst.de>
 <871rnhzlrd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rnhzlrd.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 10:32:22AM +0200, Thomas Gleixner wrote:
> Christoph Hellwig <hch@lst.de> writes:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index fcfce666457e2..540b5845cd1d3 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -386,6 +386,20 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
> >  	return rq;
> >  }
> >  
> > +static void __blk_mq_alloc_request_cb(void *__data)
> > +{
> > +	struct blk_mq_alloc_data *data = __data;
> > +
> > +	data->rq = __blk_mq_alloc_request(data);
> > +}
> > +
> > +static struct request *__blk_mq_alloc_request_on_cpumask(const cpumask_t *mask,
> > +		struct blk_mq_alloc_data *data)
> > +{
> > +	smp_call_function_any(mask, __blk_mq_alloc_request_cb, data, 1);
> > +	return data->rq;
> > +}
> 
> Is this absolutely necessary to be a smp function call? That's going to

I think it is.

Request is bound to the allocation CPU and the hw queue(hctx) which is
mapped from the allocation CPU.

If request is allocated from one cpu which is going to offline, we can't
handle that easily.

> be problematic vs. RT. Same applies to the explicit preempt_disable() in
> patch 7.

I think it is true and the reason is same too, but the period is quite short,
and it is just taken for iterating several bitmaps for finding one free bit.



thanks,
Ming

