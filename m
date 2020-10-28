Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27077C388F7
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CDA2470E
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkIIwAYw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4iuuf+8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgJ1Vy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:54:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgJ1Vy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:27 -0400
Date:   Wed, 28 Oct 2020 15:47:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603896463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjxQZUT2XHIUN+A5Fq2QlowNbrTxdzuKdrciR3H6eT4=;
        b=JkIIwAYwW8CRXGEsk/H+Ea/gaV6UximvDbFI1DEeB0b+yAYJKp9Es0yHfrVtylY5Dz4v1x
        m3NDKjm/bdeFMj+7znQdGoSIzGHx1OPX/yYFu0h68berJJi9ZoeHT4isJo1yEhizXxKdMi
        a4pSSkC7e8AMNbKgmAeWFWavGjlpDjSZE/MPYMpz397Ak/59pe1HoI8V1DGjX6WsYbeir6
        vt3eWm1r3H4hrO1CXI4Zito/OYJ+0hkbR4d7Osgp58l7W+qvjvcKY4GtVs7VxBw35Par/8
        feIYosw8eTeB85FXa6omP1rxG1ZRVO5EKy654FiELlu82IwQ95cB2VUiUeVYUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603896463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjxQZUT2XHIUN+A5Fq2QlowNbrTxdzuKdrciR3H6eT4=;
        b=4iuuf+8cmL2s16nDaTS4C0Gm5gWOJ8Loc9uy5WFZxOEzMGzh3jsM02ZwrQpX/leh5TjhCr
        iKbyVNXinlcGZpCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201028144741.zvldomzk2pwj4zq6@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201028144453.GA18610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028144453.GA18610@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-28 14:44:53 [+0000], Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 03:12:51PM +0100, Sebastian Andrzej Siewior wrote:
> >  static int blk_softirq_cpu_dead(unsigned int cpu)
> >  {
> > -	/*
> > -	 * If a CPU goes away, splice its entries to the current CPU
> > -	 * and trigger a run of the softirq
> > -	 */
> > -	local_irq_disable();
> > -	list_splice_init(&per_cpu(blk_cpu_done, cpu),
> > -			 this_cpu_ptr(&blk_cpu_done));
> > -	raise_softirq_irqoff(BLOCK_SOFTIRQ);
> > -	local_irq_enable();
> > -
> > +	blk_complete_reqs(&per_cpu(blk_cpu_done, cpu));
> >  	return 0;
> 
> How can this be preempted?  Can't we keep using this_cpu_ptr here?

cpu of the dead CPU != this CPU.

Sebastian
