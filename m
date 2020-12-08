Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CEBC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9355023A5B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 08:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgLHIXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:23:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgLHIXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 03:23:02 -0500
Date:   Tue, 8 Dec 2020 09:22:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607415741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZzlOGmHIpSyxCjmcdUfQC5JDV/yOZvyaYtXwzpP6Wc=;
        b=bylqx93LFybQfC6kP4Upgam6m1rhOPEkzbZjdGn+J4TTgqXR3nZYQinDpeKmraKw0EvvGU
        xyqlTHq2+au+IYwxCHUK+8HkzpoduVIy298E77ZUsGV72pORXxesaScRiYTfCSlwR2oWgS
        30+Uygm4NmG0keR9GM8FCDSIMptX7cnTQEY3WP5QY8g9zdJEK7IKins8KO7y4Unclr1Pjl
        5evVAMIB+SkGMx2i6GmRWdxJaPpRpIOpaTPykuESmttJn//jRklj2MtYh8aF7YmvSiIlPB
        PhR0lKTwimfUuuWVYUuvxPyqLbD6LBSAK21BXtNgg6BrwUEbfI2Bi0OjnaoTcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607415741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZzlOGmHIpSyxCjmcdUfQC5JDV/yOZvyaYtXwzpP6Wc=;
        b=sAtNTEhFWXBEcRrbxy9nON3pLsJMplTbH0ah2qaSwm085mDn78N5bNX4EGYYfxzSXnqI8d
        0bCGpdIE7LmJeYAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-07 16:52:57 [-0700], Jens Axboe wrote:
> On 12/4/20 12:13 PM, Sebastian Andrzej Siewior wrote:
> > Controllers with multiple queues have their IRQ-handelers pinned to a
> > CPU. The core shouldn't need to complete the request on a remote CPU.
> > 
> > Remove this case and always raise the softirq to complete the request.
> 
> I don't like this one at all, it'll add a softirq jump for the fast path
> for eg nvme devices. Did you run any performance testing with this? I
> can give it a spin, will do so anyway, but was curious if anything but
> "this still works" testing was done.

I understood that the nvme devices have a queue per CPU and don't need
to complete on a remote-CPU in general.
Also, they don't jump to softirq but invoke softirq on the return from
IRQ. So if softirq is already busy because of network then softirq of
the block layer is delayed. Otherwise there should be no significant
delay if the CPU is idle (so the IRQ is handled and softirq right after
it).

Sagi mentioned nvme-tcp as a user of this remote completion and Daniel
has been kind to run some nvme-tcp tests.

> -- 
> Jens Axboe
> 

Sebastian
