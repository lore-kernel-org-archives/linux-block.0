Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E4C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858D4208C7
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 15:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oecZkBnH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOEYaONJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgKFPXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 10:23:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36024 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFPXd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 10:23:33 -0500
Date:   Fri, 6 Nov 2020 16:23:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604676211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtLuAYXrlaU0hbaqYajfTStS7KDqOPQPneTx+0rzWpE=;
        b=oecZkBnHsmqmlAcxFE/V/ZxyMTKkH0OoslfUnscBSsp/oSawPcrcxjMPsGlS+xKKQRY1Un
        c3kpY9oYrVLsJBLZed65wjzG2X6e63kA2/hpxaXZTs2/l4HieIs9zEl0bMmn2fgvgi+M8u
        1pzbzHlR1b2SMbUc1H3E54Bef/FzAWvjNwYWeIWVMpACCj6hbSs28ahhAfhdNja9bwHQbV
        jkHDMPWJiCyIMcUkcdd2+E5JJGTBde0QGOUndFOckyPJh8SF/7FGnc6VXHkZDvileQcRXx
        x+li+gPQC17FEF1TLUIZphGcVQiv8VUiSDLbdzAbwVM8Z7tbxQEZdsfqeT0OAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604676211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtLuAYXrlaU0hbaqYajfTStS7KDqOPQPneTx+0rzWpE=;
        b=uOEYaONJz22IL6804wmaEva2hvTRTSJt3LvyCppRrt5KlNPFOznNZkB9Q1k+GE2wKnw9nV
        Br0TyB7B8uZ+y3BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201106152329.4vms2hk7dlzyojfw@linutronix.de>
References: <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
 <20201102095533.fxc2xpauzsoju7cm@linutronix.de>
 <20201102181238.GA17806@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102181238.GA17806@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-11-02 18:12:38 [+0000], Christoph Hellwig wrote:
> > to not break that assumption you just mentioned and provide 
> > |static inline void blk_mq_complete_request_local(struct request *rq)
> > |{
> > |                 rq->q->mq_ops->complete(rq);
> > |}
> > 
> > so that completion issued from from process context (like those from
> > usb-storage) don't end up waking `ksoftird' (running at SCHED_OTHER)
> > completing the requests but rather performing it right away. The softirq
> > dance makes no sense here.
> 
> Agreed.  But I don't think your above blk_mq_complete_request_local
> is all that useful either as ->complete is defined by the caller,
> so we could just do a direct call.
In usb-storage case it is hidden somewhere in the SCSI stack but this
can probably be changed later on.

>                                     Basically we should just
> return false from blk_mq_complete_request_remote after updating
> the state when called from process context.  But given that IIRC
> we are not supposed to check what state we are called from
> we'll need a helper just for updating the state instead and
> ensure the driver uses the right helper.  Now of course we might
> have process context callers that still want to bounce to the
> submitting CPU, but in that case we should go directly to a
> workqueue or similar.

So instead blk_mq_complete_request_local() you want a helper to set the
state in which the completion function is invoked. Sounds more like an
argument :)

> Either way doing this properly will probabl involve an audit of all
> drivers, but I think that is worth it.

I'm lost. Should I repost the three patches with a preempt_disable()
section (as suggested) to not break preemptible callers? And then move
from there to provide callers from preemtible context an alternative?

Sebastian
