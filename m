Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13203C388F9
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F3722281
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gq4YASmX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IogHknio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409753AbgJ0KLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:11:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409784AbgJ0KLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 06:11:06 -0400
Date:   Tue, 27 Oct 2020 11:11:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603793463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdykm7OMWcpMdag7rOMg9t7m9ra1YP3LbuvlAxrtSes=;
        b=gq4YASmX2t2eHtUyZy81sSUkqzdCVNn6IkXtOaGIjuvmThTQue4piW+l9SZ4NhPj96BF1D
        cv6zOQb6RkV8H+85ELUaKpNKwr8dFTieaavtsdWOg0JaYALkl1m8v40CBPUeY9/9ln5R3+
        G+dYeol81svT+gzMaut6mVAuEKmBuHsebZGMPdL8uD+R4kKtCnhmtmXYVF4+lYS/UpA8wx
        vtHN8iHuugkDKOYddvk195jsGdzUL5Wx8fSwGyR6LrvZnci5QSL73MwKofuEHhAqtwCz0o
        zWO7gYBv/FFmiHYvnUpuznbay6Y5PY2ZknL2jwU5FQV7/u6db1z88MhlO97PjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603793463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdykm7OMWcpMdag7rOMg9t7m9ra1YP3LbuvlAxrtSes=;
        b=IogHknioUksMBCF0Dy1KojXALdJ4/l0u3K887eanQPV5dPixfNju4ywNGTrezyANryA+ij
        nU7krRzJjddyqeBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027092606.GA20805@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-27 09:26:06 [+0000], Christoph Hellwig wrote:
> On Fri, Oct 23, 2020 at 03:52:19PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-10-23 12:21:30 [+0100], Christoph Hellwig wrote:
> > > > -	if (!IS_ENABLED(CONFIG_SMP) ||
> > > > +	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
> > > >  	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
> > > 
> > > This needs a big fat comment explaining your rationale.  And probably
> > > a separate if statement to make it obvious as well.
> > 
> > Okay.
> > How much difference does it make between completing in-softirq vs
> > in-IPI?
> 
> For normal non-RT builds?  This introduces another context switch, which
> for the latencies we are aiming for is noticable.

There should be no context switch. The pending softirq should be
executed on irq_exit() from that IPI, that is
  irq_exit()
  -> __irq_exit_rcu()
    -> invoke_softirq()
      -> __do_softirq() || do_softirq_own_stack() 

unlike with the command line switch `threadirqs' enabled,
invoke_softirq() woukd wakeup the `ksoftirqd' thread which would involve
a context switch.

> > I'm asking because acquiring a spinlock_t in an IPI shouldn't be
> > done (as per Documentation/locking/locktypes.rst). We don't have
> > anything in lockdep that will complain here on !RT and we the above we
> > avoid the case on RT.
> 
> At least for NVMe we aren't taking locks, but with the number of drivers

Right. I found this David Runge's log:

|BUG: scheduling while atomic: swapper/19/0/0x00010002
|CPU: 19 PID: 0 Comm: swapper/19 Not tainted 5.9.1-rt18-1-rt #1
|Hardware name: System manufacturer System Product Name/Pro WS X570-ACE, BIOS 1302 01/20/2020
|Call Trace:
| <IRQ>
| dump_stack+0x6b/0x88
| __schedule_bug.cold+0x89/0x97
| __schedule+0x6a4/0xa10
| preempt_schedule_lock+0x23/0x40
| rt_spin_lock_slowlock_locked+0x117/0x2c0
| rt_spin_lock_slowlock+0x58/0x80
| rt_spin_lock+0x2a/0x40
| test_clear_page_writeback+0xcd/0x310
| end_page_writeback+0x43/0x70
| end_bio_extent_buffer_writepage+0xb2/0x100 [btrfs]
| btrfs_end_bio+0x83/0x140 [btrfs]
| clone_endio+0x84/0x1f0 [dm_mod]
| blk_update_request+0x254/0x470
| blk_mq_end_request+0x1c/0x130
| flush_smp_call_function_queue+0xd5/0x1a0
| __sysvec_call_function_single+0x36/0x150
| asm_call_irq_on_stack+0x12/0x20
| </IRQ>

so the NVME driver isn't taking any locks but lock_page_memcg() (and
xa_lock_irqsave()) in test_clear_page_writeback() is.

Sebastian
