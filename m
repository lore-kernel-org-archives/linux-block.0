Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C0C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 21:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CA620791
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 21:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4lF/kN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRDH596v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ2VBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:01:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2VBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 17:01:07 -0400
Date:   Thu, 29 Oct 2020 22:01:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604005265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLhFKWrP71TSoqyox5MkYbhaAh59bKLUqUOd82QKXAs=;
        b=D4lF/kN1PPw4zXahRgV8TWgh2/O+4kKwqCDBsk4FF9SQLj5kmpsluGR6PHXF/9kuL8CWwY
        cKxEjs3wm1u2hlPyuoKMrZ3moO5zwWH2pIpYuMb/ekpfPlem/Qx+dxXKszu+z5FmuQSGaR
        V7ux94Zily2gcYQj4tQI5Sc+PFwRfoCgha4NN/FX5Ab6vxudB2X28MWBnWnqGq2w7I0dXc
        PFzfuKRSGYKADBEX9+4lGT1kuBzoAIzIZ1rsp5b8sn1lqRviTAAgTthnluBTp+0o5taEYJ
        F4omNmlt+BWCnDlsAdaLo7hke+Q0RYmmnwEki9VgK5CB/9AyXWs59iFIMgFAxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604005265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLhFKWrP71TSoqyox5MkYbhaAh59bKLUqUOd82QKXAs=;
        b=TRDH596v5OSrQOQ89Fp2cgLGkwri4vV0bPcBU0OyTi4LeX5cGry7QzgtDji2ET8jVdRcpQ
        EooMF7OECrAaCYDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-29 13:03:26 [-0700], Sagi Grimberg wrote:
> 
> > > > Well, usb-storage obviously seems to do it, and the block layer
> > > > does not prohibit it.
> > > 
> > > Also loop, nvme-tcp and then I stopped looking.
> > > Any objections about adding local_bh_disable() around it?
> > 
> > To me it seems like the whole IPI plus potentially softirq dance is
> > a little pointless when completing from process context.
> 
> I agree.
> 
> > Sagi, any opinion on that from the nvme-tcp POV?
> 
> nvme-tcp should (almost) always complete from the context that matches
> the rq->mq_ctx->cpu as the thread that processes incoming
> completions (per hctx) should be affinitized to match it (unless cpus
> come and go).

in which context? But this is probably nr_hw_queues > 1?

> So for nvme-tcp I don't expect blk_mq_complete_need_ipi to return true
> in normal operation. That leaves the teardowns+aborts, which aren't very
> interesting here.

The process context invocation is nvme_tcp_complete_timed_out().

> I would note that nvme-tcp does not go to sleep after completing every
> I/O like how sebastian indicated usb does.
> 
> Having said that, today the network stack is calling nvme_tcp_data_ready
> in napi context (softirq) which in turn triggers the queue thread to
> handle network rx (and complete the I/O). It's been measured recently
> that running the rx context directly in softirq will save some
> latency (possible because nvme-tcp rx context is non-blocking).
> 
> So I'd think that patch #2 is unnecessary and just add overhead for
> nvme-tcp.. do note that the napi softirq cpu mapping depends on the RSS
> steering, which is unlikely to match rq->mq_ctx->cpu, hence if completed
> from napi context, nvme-tcp will probably always go to the IPI path.

but running it in softirq on the remote CPU would still allow of other
packets to come on the remote CPU (which would block BLOCK sofirq if
NET_RX is already running).

Sebastian
