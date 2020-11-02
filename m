Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF098C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 09:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88507222B9
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YycuQOgL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykIGbTM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgKBJzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:55:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBJzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 04:55:37 -0500
Date:   Mon, 2 Nov 2020 10:55:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604310935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=My5bl5kX+DtJfjGcAm8wru8FkX6173R2moUSDiddh+E=;
        b=YycuQOgLpxEAheAVchd9mghKl8yr8SvnNKA/vC7tB/MF77JnI5oMVAFGVCzwblfDsxCYH3
        AGVd/7YiPry7GU6wqkyfy93LHT1PZUsK+W6KGmVYY3mHq0kBX6SRrBz07CRH0K8o62EVNN
        84SOfXmilSCRat5B5iHhHlT/5zCdQoqnbBFRPS3SQb72+byehqmvBNFVxLfNNUfEXXeUfe
        Ujel8HuJfmspOSYOXi85T9PVsduVEMDiK2tVVp9CMC3zkwbXhecIMwumcBkDnQgissNoEP
        GZ+ouIXDEDWnz5AnCmi5gVN9QNePElYXM+474xQ1vcsFLPjkqsKZMv7+E780Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604310935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=My5bl5kX+DtJfjGcAm8wru8FkX6173R2moUSDiddh+E=;
        b=ykIGbTM+BV3wEyT1wccLb8RgIyiRkFJ1K9NxQ/RX7r43SoU2B3q4hci7pKC2PFyOcJ7ASu
        Fl4vmociHDwi0QAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201102095533.fxc2xpauzsoju7cm@linutronix.de>
References: <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-31 09:00:49 [-0600], Jens Axboe wrote:
> There really aren't any rules for this, and it's perfectly legit to
> complete from process context. Maybe you're a kthread driven driver and
> that's how you handle completions. The block completion path has always
> been hard IRQ safe, but possible to call from anywhere.

I'm not trying to put restrictions and forbidding completions from a
kthread. I'm trying to avoid the pointless softirq dance for no added
value. We could:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f53de48e5038..c4693b3750878 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -644,9 +644,11 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
+		preempt_disable();
 		cpu_list = this_cpu_ptr(&blk_cpu_done);
 		if (llist_add(&rq->ipi_list, cpu_list))
 			raise_softirq(BLOCK_SOFTIRQ);
+		preempt_enable();
 	}
 
 	return true;

to not break that assumption you just mentioned and provide 
|static inline void blk_mq_complete_request_local(struct request *rq)
|{
|                 rq->q->mq_ops->complete(rq);
|}

so that completion issued from from process context (like those from
usb-storage) don't end up waking `ksoftird' (running at SCHED_OTHER)
completing the requests but rather performing it right away. The softirq
dance makes no sense here.

As mentioned earlier, the alternative _could_ be to
	s/preempt_/local_bh_/

in the above patch. This would ensure that any invocation outside of
IRQ/Softirq context would invoke the softirq _directly_ at
local_bh_enable() time rather than waking the daemon for that purpose.
It would also avoid another completion function for the direct case
which could be abused if used from outside the thread context.
The last one is currently my favorite.

Sebastian
