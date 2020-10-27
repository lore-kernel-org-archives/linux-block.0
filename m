Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD8C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4914421556
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npuz5bBu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LcxebdN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823659AbgJ0R7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:59:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823648AbgJ0R7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 13:59:24 -0400
Date:   Tue, 27 Oct 2020 18:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603821563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YW3/NPOF7xoOmIn/XQxXTt+kGRGSQ42qcp9fBVrIJk=;
        b=npuz5bBuIFtgaJkz2yZDJqvqxLRL2LxwJj1bT1HOHH9zo+BtG80cW47qVn/vciZrJ5p7Qq
        1RegbSGjpMqqrID6s5D7zPyPsOyf62iW2VLvZuun0QqxkOM5MtKLZ3+ICo/G5TEj7RhcHF
        tLVSo7VYjbFq6Y2ZTnzTzLJRSkLANVe9mGA/it/7pevqf2shFJgqWOspI37lEifmB19rKv
        4Bs3el3Vpjv8H/2Lek6zdP+Il16Fbj6QjnKVqVe+85HiahOH5i6SGJtypiia/ZgG5WFFY+
        ZpZCzLUnfNEyvffDKZeEtsGNg3/bB7hRc5wjPUoQGwEvc6EWIgkOVbUANNIbrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603821563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YW3/NPOF7xoOmIn/XQxXTt+kGRGSQ42qcp9fBVrIJk=;
        b=LcxebdN0zE4/+u9RlIK5b3xel6TFXwAj09aw3buCO7iKRwRoG1f55H2rxIBaXqNyaPtgDB
        P1/Jy31B2lRgt/Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027175920.otcm2ox7vxce5k3c@linutronix.de>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
 <20201027160742.GA19073@infradead.org>
 <87eelj1tx0.fsf@nanos.tec.linutronix.de>
 <20201027172309.GA15004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027172309.GA15004@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-27 17:23:09 [+0000], Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 06:05:15PM +0100, Thomas Gleixner wrote:
> > > Is there a way to raise a softirq and preferably place it on a given
> > > CPU without our IPI dance?  That should be a win-win situation for
> > > everyone.
> > 
> > Not really. Softirq pending bits are strictly per cpu and we don't have
> > locking or atomics to set them remotely. Even if we had that, then you'd
> > still need a mechanism to make sure that the remote CPU actually
> > processes them. So you'd still need an IPI of some sorts.
> 
> Ok.  I was hoping we could hide this in core code somehow, especially
> a peterz didn't like the use of smp_call_function_single_async in the
> blk-mq completion code very much.
> 
> Sebastian, would this solve your preempt-rt and lockdep issues?

second. I'm cooking something.

Sebastian
