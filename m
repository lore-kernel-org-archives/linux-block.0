Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiBOJcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:32:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiBOJcB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:32:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404FA9A5C
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 01:31:52 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644917510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Yz7tVLvYZJfVj4mQOhhKq8bLGyxiv0AjT4YTIkMqpQ=;
        b=4n9XEIEEv8eoqORodiukuhpd21t7IWIjyxLhXHkJ3jqlLNHoReDnor7f5EHn7azwQ0jUAu
        CogLRwZ06CdMcqV7IUwerkBKjYz+RCiqjcdiskHccTqaA29xnvo8EJsd0l15VvocNJJ+AP
        7Ftxp8ZewUEWnEhaB4gAFFqMA/5EQLMj+3GPrjmK4CbMkfegR6GBYAuNPaV+zHoAauJ7kH
        FRQcBygSgiuagpHiJnIXZD4nE+3IyJF+Ue7vtDNDvzBakDk5G1nDR51MRxaTvKPZm8myBH
        ajSXJZbAy7yHXE/NtfzvbbPbCfAvEsXStHa58esEkL0B+xURTtzFlXQfawL9Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644917510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Yz7tVLvYZJfVj4mQOhhKq8bLGyxiv0AjT4YTIkMqpQ=;
        b=WuTXUbnHic8ZGKcVVKwIHv+g0/FwLEe7HtdNfjrS4fN1ygUmSSWowQP+31AwR1ZAOq+OsT
        LNlA3jDCmx+5fLCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] blk-mq: Remove get_cpu() in
 __blk_mq_delay_run_hw_queue().
Message-ID: <YgtzBdwYxA7ryJh3@linutronix.de>
References: <YgtuX9dDpXe8Xbs+@linutronix.de>
 <YgtxIZdDXie01OJJ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgtxIZdDXie01OJJ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-02-15 17:23:45 [+0800], Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 1adfe4824ef5e..90217f1b09add 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2040,14 +2040,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
> >  		return;
> >  
> >  	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > -		int cpu = get_cpu();
> 
> Did you observe the warning triggered?  might_sleep_if(true) in
> __blk_mq_run_dispatch_ops() is only supposed to be run in case of
> (hctx->flags & BLK_MQ_F_BLOCKING).

I haven't seen it triggering but if that call chain is possible then it
will triggert due to get_cpu().

> Thanks, 
> Ming

Sebastian
