Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6DC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629AB23A31
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgLHMxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:53:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHMxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 07:53:07 -0500
Date:   Tue, 8 Dec 2020 13:52:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607431945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsRiReqclmhQ9h9ljHQ781kt6xBAJFOeyfel2aM4UVM=;
        b=Wra0GQkX0YLGrd6dWu/bW+dvSKijelD6eUlHgUbSQAab5hx9IP1u59OqUkFmMTvx8DBQh4
        Lul/fmn19O+Qw6sBv9KLBEx6BH0i2hFA9TQjH21YuNIRlVkDrUCIJpT/RsWj9ffIHr0Rec
        vvMqgm6zPn8BrY70Ls2p+cyTmNpywtyi/ST1O0VIBNSwpip/qfaA/4egJ5aooHXedY9JRf
        hLmPVS4BZyTiH+eEYWekpH5VEw2cWzRK0neR27kdOhy4L8KgOQtjQ6qdBpJ8u1xdzTtG3E
        J8bjug+pu0Yf4ongZr80RELiD4iIq3W3oepGdoyf8nHG8nG1MZvVi/gAXwO/FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607431945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsRiReqclmhQ9h9ljHQ781kt6xBAJFOeyfel2aM4UVM=;
        b=qyF3TjCVBUKpVyNoAxszsyWFIStWIsY8Mh0Em7GAfnqdPDKlQwaLg4QdPIYAvLSbuVoN2j
        3/3i8Kg2bh9l0gBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208125224.m2xt66ladp63fa3t@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <20201208113653.awqz4zggmy37vbog@beryllium.lan>
 <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
 <20201208124148.4dxdu6dp5m3mudff@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208124148.4dxdu6dp5m3mudff@beryllium.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-08 13:41:48 [+0100], Daniel Wagner wrote:
> On Tue, Dec 08, 2020 at 12:49:36PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-12-08 12:36:53 [+0100], Daniel Wagner wrote:
> > > Obvious in this configuration there are no remote completions (verified
> > > it).
> > 
> > do you complete on a remote CPU if you limit the queues to one (this is
> > untested of course)?
> 
> nvme0n1/ completed   11913011 remote    6718563 56.40%
> 
> yes, but how is this relevant? I thought Jens complain was about the
> additional indirection via the softirq context
> 
> -		rq->q->mq_ops->complete(rq);
> +	blk_mq_trigger_softirq(rq);
> 
> and not the remote completion path. I can benchmark it out but I don't
> know if it's really helping in the discussion.

The only additional softirq path is for cross-CPU completion. If I
understood you correctly then your NVME device always completes locally
because the queue interrupt fires on the correct CPU.
If you take away the queues then you should have cross-CPU completion
since you have only one queue and this will now complete on the remote
CPU in softirq context (and not in IRQ as it used to).
If this single queue NVME device, which may complete on another CPU, is
not an issue / interesting because it is already limited then ignore
this.

Sebastian
