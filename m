Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D16C55178
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B56C21D24
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EA2fxLcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818758AbgJ0RXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:23:14 -0400
Received: from casper.infradead.org ([90.155.50.34]:49976 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1818748AbgJ0RXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 13:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/yaM1/ccAl9TS5PHr6ruyAQYLv2OniGCu6yOsMlXOvA=; b=EA2fxLcwb4ys6uRdv+LOHpQkXs
        AAL2U3TtqQZqYr+59RhpghBMmS1p9M9grt1TD6KLPSCG8H5DXgonOET+Apb5I7w+qUXtirEYSnd5M
        bFtL4XbgDfWRarrjWlStg9G5Wiwn/rlO9CYdKyFAP/j3Tf1WQRsHz+jREsSXzbQGB9R77h9nh3j89
        cRsy3bsegufF4ahl5c5OpDnFMxlQG2JrPzhf/wCKBGmrdQwSYq6SWH2QiiQ1u3Jv1Nq96WngiXKaP
        TjGB2iqa5BD8yf+WsIabEOXm9fBCnsApiCCo5RJ2dGn6ceG2C7xePlJLeAZGOCrZTKJ9GXeQ6XWuB
        rC/Z28qQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXSgf-0004Pg-JN; Tue, 27 Oct 2020 17:23:09 +0000
Date:   Tue, 27 Oct 2020 17:23:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027172309.GA15004@infradead.org>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
 <20201027160742.GA19073@infradead.org>
 <87eelj1tx0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eelj1tx0.fsf@nanos.tec.linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 27, 2020 at 06:05:15PM +0100, Thomas Gleixner wrote:
> > Is there a way to raise a softirq and preferably place it on a given
> > CPU without our IPI dance?  That should be a win-win situation for
> > everyone.
> 
> Not really. Softirq pending bits are strictly per cpu and we don't have
> locking or atomics to set them remotely. Even if we had that, then you'd
> still need a mechanism to make sure that the remote CPU actually
> processes them. So you'd still need an IPI of some sorts.

Ok.  I was hoping we could hide this in core code somehow, especially
a peterz didn't like the use of smp_call_function_single_async in the
blk-mq completion code very much.

Sebastian, would this solve your preempt-rt and lockdep issues?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index cdced4aca2e812..5c125fb11b5691 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -626,19 +626,7 @@ static void __blk_mq_complete_request_remote(void *data)
 {
 	struct request *rq = data;
 
-	/*
-	 * For most of single queue controllers, there is only one irq vector
-	 * for handling I/O completion, and the only irq's affinity is set
-	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
-	 * is handled on one specific CPU.
-	 *
-	 * So complete I/O requests in softirq context in case of single queue
-	 * devices to avoid degrading I/O performance due to irqsoff latency.
-	 */
-	if (rq->q->nr_hw_queues == 1)
-		blk_mq_trigger_softirq(rq);
-	else
-		rq->q->mq_ops->complete(rq);
+	blk_mq_trigger_softirq(rq);
 }
 
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
