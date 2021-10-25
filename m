Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 06:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B2A60FD7
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 06:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJYGrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 02:47:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJYGrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 02:47:16 -0400
Date:   Mon, 25 Oct 2021 08:44:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635144294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DngAR4EmL3rcW4b1mmY8P9txHYNTuDeEZVegQ4tOA4U=;
        b=JcRsCcrV+pprDvp1VmTSPHn6slG2tHxowZY3uU2RLDxCFzFINTXpNHrqNFtzFL0DcpKLs6
        Hg23hR9LuUBTymaWAtEWuNLmjFo0I/pu2qGpF4Dfh+y3CQCJv1tifb6Yy3IjlMXThUCU9u
        yj2LQzdcUxFH1qbs4Vp1mZuGxqN7RDjdEXhWzXcdgBzDReN2peTrW6tjjBLmAJAOliQRLi
        fgBQqgocQCGb2wwwfmcY/BI8W3EruDAZcvpu0831bvJjs/QEHMVW1Wzeg783sw5TLxPEoB
        ZN0IqtUSnfCs7eNRucxR1xy2mlCaedSsli4pnMZa0j1am9HVTKfBny+3YtSsxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635144294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DngAR4EmL3rcW4b1mmY8P9txHYNTuDeEZVegQ4tOA4U=;
        b=Ca6sVmpQlakzqK/XKdihIRuCOjnJKYJOdKq2BK6ucGKb0q+3UTtl0V0oQMes1h3+EJ9Rm9
        ljPsWgtyNHkB0gBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] mmc: core: Use blk_mq_complete_request_direct().
Message-ID: <20211025064452.kpiqth72yrsfhqod@linutronix.de>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
 <20211018135559.244400-3-bigeasy@linutronix.de>
 <CAPDyKFrnmevHeCZ3Fb3XCOx6cHvEv6b3ktYdU-WAnuuq8L4kXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrnmevHeCZ3Fb3XCOx6cHvEv6b3ktYdU-WAnuuq8L4kXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-10-19 13:32:42 [+0200], Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 431af5e8be2f8..7d6b43fe52e8a 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2178,7 +2183,8 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
> >         mq->rw_wait = false;
> >         wake_up(&mq->wait);
> >
> > -       mmc_blk_mq_post_req(mq, req);
> > +       /* context unknown */
> > +       mmc_blk_mq_post_req(mq, req, false);
> 
> So it seems we would benefit from knowing the context here, right?

Yes.

> At this point, what you suggest seems like a reasonable way forward
> (assuming atomic context), but in a next step we could potentially add
> a non-atomic helper function for mmc host drivers to call, when that
> is suitable. Would that make sense you think?

Sure. I didn't mange to figure where this can be called from so I
assumed atomic so it behaves the way it did. If you can provide
additional information here then the additional scheduling of ksoftirqd
could be avoided. Also, if there are drivers which complete their
requests in a threaded-irq handler, then the softirq could be also
avoided (there should be no irq-disabling then).

I *think* there were other completion paths, I just touched the one I
managed to reproduce.

> 
> Kind regards
> Uffe

Sebastian
