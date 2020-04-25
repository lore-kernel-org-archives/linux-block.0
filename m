Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8972CC55185
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 09:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B2420704
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKa7CK+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDYJfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:35:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYJfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 05:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587807298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnX0/8su+mvIjq7pIaWX++imcXEuwmfhSWsS2IEw6cU=;
        b=HKa7CK+BtZS5u5znJ+fLVW5gy1mK/LnhiW2lCzQzrEGQRgC7P8a5MYgbwlX6jx/yve3AX0
        RLb6aaJgmMQablb9ZiSg7nDMIJTl+4GNomYIxyyAVrZFEMJyBeJWLD4rpgoBzXZs4NbLUF
        MT3P5hwdoHuQUOErWscvRomXX2/ir0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-tQSTiobsOvqHNlZ5LOOHnw-1; Sat, 25 Apr 2020 05:34:54 -0400
X-MC-Unique: tQSTiobsOvqHNlZ5LOOHnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E8A81800D4A;
        Sat, 25 Apr 2020 09:34:52 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4004B5D9CA;
        Sat, 25 Apr 2020 09:34:42 +0000 (UTC)
Date:   Sat, 25 Apr 2020 17:34:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425093437.GA495669@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425083224.GA5634@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 10:32:24AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 25, 2020 at 11:17:23AM +0800, Ming Lei wrote:
> > I am not sure if it helps by adding two helper, given only two
> > parameters are needed, and the new parameter is just a constant.
> > 
> > > the point of barrier(), smp_mb__before_atomic and
> > > smp_mb__after_atomic), as none seems to be addressed and I also didn't
> > > see a reply.
> > 
> > I believe it has been documented:
> > 
> > +   /*
> > +    * Add one memory barrier in case that direct issue IO process is
> > +    * migrated to other CPU which may not belong to this hctx, so we can
> > +    * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> > +    * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> > +    * and driver tag assignment are run on the same CPU in case that
> > +    * BLK_MQ_S_INACTIVE is set.
> > +    */
> > 
> > OK, I can add more:
> > 
> > In case of not direct issue, __blk_mq_delay_run_hw_queue() guarantees
> > that dispatch is done on CPUs of this hctx.
> > 
> > In case of direct issue, the direct issue IO process may be migrated to
> > other CPU which doesn't belong to hctx->cpumask even though the chance
> > is quite small, but still possible.
> > 
> > This patch sets hctx as inactive in the last CPU of hctx, so barrier()
> > is enough for not direct issue. Otherwise, one smp_mb() is added for
> > ordering tag assignment(include setting rq) and checking S_INACTIVE in
> > blk_mq_get_driver_tag().
> 
> How do you prevent a cpu migration between the call to raw_smp_processor_id
> and barrier? 

Fine, we may have to use get_cpu()/put_cpu() for direct issue to cover
the check. For non-direct issue, either preempt is disabled or the work is
run on specified CPU.

> 
> Also as far as I can tell Documentation/core-api/atomic_ops.rst ask
> you to use smp_mb__before_atomic and smp_mb__after_atomic for any
> ordering with non-updating bitops.  Quote:
> 
> --------------------------------- snip ---------------------------------
> If explicit memory barriers are required around {set,clear}_bit() (which do
> not return a value, and thus does not need to provide memory barrier
> semantics), two interfaces are provided::
> 
>         void smp_mb__before_atomic(void);
> 	void smp_mb__after_atomic(void);
> --------------------------------- snip ---------------------------------
> 
> I really want someone who knows the memory model to look over this scheme,
> as it looks dangerous.

smp_mb() is enough, the version of _[before|after]_atomic might be
a little lightweight in some ARCH I guess. Given smp_mb() or its variant
is only needed in very unlikely case of slow path, it is fine to just
use smp_mb(), IMO.


Thanks,
Ming

