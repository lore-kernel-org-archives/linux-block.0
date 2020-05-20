Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 01:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C978B2075F
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 01:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsemTWtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgETBSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 21:18:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgETBSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 21:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589937517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yYBRNQiyHNP5lLD1Its0j+AibWc7irAqGuGhp7bBL4=;
        b=TsemTWtSc3RCyzTGpMEsH7nzTU9iAvg3tXJON9hjjqtTokfjshJ6asJeiTuSrAPyzI8YGS
        Zst3EndkTLtCbaeCGe2WzB5HcL+7h84/xL8bjRV2DWyPRFRF8UR9MlQ2sUKiLvRSLAXhH1
        OQSNRHy8SBb4NMm5B9qmetNUAugSQq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-JGQmxt61OLSAhAeA6PWB1A-1; Tue, 19 May 2020 21:18:36 -0400
X-MC-Unique: JGQmxt61OLSAhAeA6PWB1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF2F464;
        Wed, 20 May 2020 01:18:34 +0000 (UTC)
Received: from T590 (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4E0060BE1;
        Wed, 20 May 2020 01:18:27 +0000 (UTC)
Date:   Wed, 20 May 2020 09:18:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200520011823.GA415158@T590>
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de>
 <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de>
 <20200518141107.GA50374@T590>
 <20200518165619.GA17465@lst.de>
 <20200519015420.GA70957@T590>
 <20200519153000.GB22286@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519153000.GB22286@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 05:30:00PM +0200, Christoph Hellwig wrote:
> On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
> > As Thomas clarified, workqueue hasn't such issue any more, and only other
> > per CPU kthreads can run until the CPU clears the online bit.
> > 
> > So the question is if IO can be submitted from such kernel context?
> 
> What other per-CPU kthreads even exist?

I don't know, so expose to wider audiences.

> 
> > > INACTIVE is set to the hctx, and it is set by the last CPU to be
> > > offlined that is mapped to the hctx.  once the bit is set the barrier
> > > ensured it is seen everywhere before we start waiting for the requests
> > > to finish.  What is missing?:
> > 
> > memory barrier should always be used as pair, and you should have mentioned
> > that the implied barrier in test_and_set_bit_lock pair from sbitmap_get()
> > is pair of smp_mb__after_atomic() in blk_mq_hctx_notify_offline().
> 
> Documentation/core-api/atomic_ops.rst makes it pretty clear that the
> special smp_mb__before_atomic and smp_mb__after_atomic barriers are only
> used around the set_bit/clear_bit/change_bit operations, and not on the
> test_bit side.  That is also how they are used in all the callsites I
> checked.

I didn't care if the barrier is smp_mb__after_atomic or smp_mb() because it
is added in slow path.

What I tried to express is that every SMP memory barrier use should be commented
clearly, especially about the pairing usage, see "SMP BARRIER PAIRING" section of
Documentation/memory-barriers.txt.

So please add comments around the new added smp_mb__after_atomic(),
something like:

/*
 * The pair of the following smp_mb__after_atomic() is smp_mb() implied in
 * test_and_set_bit_lock pair from sbitmap_get(), so that setting tag bit and
 * checking INACTIVE in blk_mq_get_tag() can be ordered, same with setting
 * INACTIVE and checking tag bit in blk_mq_hctx_notify_offline().
 */

> 
> > Then setting tag bit and checking INACTIVE in blk_mq_get_tag() can be ordered,
> > same with setting INACTIVE and checking tag bit in blk_mq_hctx_notify_offline().
> 
> Buy yes, even if not that would take care of it.

The OPs have been ordered in this way, that is exactly purpose of the added memory
barrier.

thanks,
Ming

