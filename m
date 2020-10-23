Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5CC4363A
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29C9208B6
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 13:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdzB5UuF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drGgKFg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750125AbgJWNwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750124AbgJWNwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 09:52:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB2C0613CE;
        Fri, 23 Oct 2020 06:52:22 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:52:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603461141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mSwLBiQN8wgOA1EFVT7t2Fh/mBpsT8gU/jlnEuQWt8=;
        b=fdzB5UuFFowfwPRMWd5yX43uPmKAxvOXRixse6gFs8C6jHd8FGLFrKm5x4reeeUWp7O56t
        sqe/0MlfnTUDc6r6f/unMp7HWgBU7db+F239GI2xl4UZDYEda8FrIX+xkOuRZKO8cAv1gK
        IafvRjj0x3j1cnlBX7nxyNOe+kwvsG6XiIAQ+0YwFeQpBo25RFgZdn35biaArgq7gYr9hX
        YrzPo3h5/HKaGKe/bnTXrOXyZgmw2NvN3Uy8E1itkvjiQ+vXa9y24ZETR0PmZVfWw+CmrU
        j61B/IwQodzy3wxYrHIIB1j6n6s2zpPeNSgl3PGocufv34QHB0mwq46flA68dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603461141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mSwLBiQN8wgOA1EFVT7t2Fh/mBpsT8gU/jlnEuQWt8=;
        b=drGgKFg3WTRVPkBaGDa+ttUhbedrrsoR19jaWdrA52t4mnhMJyKF433463bINPKtAr0UsM
        14d3ln1cB9U/6vBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023112130.GA23790@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-23 12:21:30 [+0100], Christoph Hellwig wrote:
> > -	if (!IS_ENABLED(CONFIG_SMP) ||
> > +	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
> >  	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
> 
> This needs a big fat comment explaining your rationale.  And probably
> a separate if statement to make it obvious as well.

Okay.
How much difference does it make between completing in-softirq vs
in-IPI? I'm asking because acquiring a spinlock_t in an IPI shouldn't be
done (as per Documentation/locking/locktypes.rst). We don't have
anything in lockdep that will complain here on !RT and we the above we
avoid the case on RT.

Sebastian
