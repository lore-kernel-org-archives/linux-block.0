Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A766C55179
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E4C21D24
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ji7B4Rl3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhI3vz0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816413AbgJ0RG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:06:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815760AbgJ0RFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 13:05:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603818316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeTo+nqMytKpidhwafrElTV5yZ+u300kHK1bdYzrdw8=;
        b=Ji7B4Rl3j/bc5QszNJTBOXLS9DKhUIp6eGC7m9JGmL8+p5X62B1SEvaHz7e+wgCUYQacNQ
        YFvA6g7fMDF/u62uz3zYY6HpVs3BC7jjdMMlNMxzRWF/gijDwYRHLbVtJgHobvVhFbX3S2
        ZXohGjJqkBaaNGSs9yenVrglBiiYyQkWUUBVudZdseS/6dKgtgjKCKSQsENO/Vh0C+YEi2
        nDiAFLX+TzFguzKH2rhNNtVA3OpSREOFqRAMv8hdqHvFOi6oLd4ajsuCHlDbDounIaBuMd
        xB49J9fSQ4Yrm6CBoAVAWxm1HnQ/rEXJudYHAn5vGjaDZs2K+HDcmgLWdoUI7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603818316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeTo+nqMytKpidhwafrElTV5yZ+u300kHK1bdYzrdw8=;
        b=PhI3vz0uvNTzw98BkAOjrW1UAkn5pjXfEy8Q6hYwgepBkyoKHxqO7V12yyaL7t3UQjEe16
        GiF2Tcxqc2CtypAg==
To:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
In-Reply-To: <20201027160742.GA19073@infradead.org>
References: <20201021175059.GA4989@hmbx> <20201023110400.bx3uzsb7xy5jtsea@linutronix.de> <20201023112130.GA23790@infradead.org> <20201023135219.mzzl76eqqy6tqwhe@linutronix.de> <20201027092606.GA20805@infradead.org> <20201027101102.cvczdb3mkvtoguo5@linutronix.de> <20201027160742.GA19073@infradead.org>
Date:   Tue, 27 Oct 2020 18:05:15 +0100
Message-ID: <87eelj1tx0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 27 2020 at 16:07, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 11:11:02AM +0100, Sebastian Andrzej Siewior wrote:
>> Right. I found this David Runge's log:
>
> True, ->bi_end_io instances can do a lot of things as long as they
> are hardirq safe.
>
> And in the end the IPI case isn't the super fast path anyway, as it
> means we don't use a queue per CPU.
>
> Is there a way to raise a softirq and preferably place it on a given
> CPU without our IPI dance?  That should be a win-win situation for
> everyone.

Not really. Softirq pending bits are strictly per cpu and we don't have
locking or atomics to set them remotely. Even if we had that, then you'd
still need a mechanism to make sure that the remote CPU actually
processes them. So you'd still need an IPI of some sorts.

Thanks,

        tglx




