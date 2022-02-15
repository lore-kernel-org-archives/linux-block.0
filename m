Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA16C433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 12:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiBOMLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:11:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiBOMLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 07:11:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6313D7D
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 04:11:28 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:11:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeGpcrAuJBoAVzlyFAKZA5tJeUeywy3ITQx3dcrCZBE=;
        b=h0VM7Mo1l1ZyBHjgsDRk804z7q/EPleFlraV2FATKRETMiP6HJdXDesBxIzJgq/it5f+UW
        JdVzP7D+UV2wjsTsl65j8gzdNy9HF0XimKSa+ParA5/bCJjn0niPzMHy4m2PrhDKJOcnEf
        llAARm75BUu9r2g0DijRSqUTDne02XmWPzifsDuGs65UF1lZ4tjKLD+MLoOGawHHS5gxWM
        y9BAdsIT8xtB4M2kwwbviPlRXa3wv2YuFbG1vFzcAQUqMJNzFJdsoIc5FCXtzcJjuye2vu
        GmIf89/UL8EhDNeZJPyzF7YVZGvkfqveZn9I1CMebMasHjSZXympNe9VIoitqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeGpcrAuJBoAVzlyFAKZA5tJeUeywy3ITQx3dcrCZBE=;
        b=uqbwzVompzJa3vxzzQ7anYhTUawRS4HWtELbOMmCEsDh4xcOnahN9e/r8EQKsTqgVgm6F1
        helxH8LeoqtwIDBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] blk-mq: Remove get_cpu() in
 __blk_mq_delay_run_hw_queue().
Message-ID: <YguYbC0540CecccG@linutronix.de>
References: <YgtuX9dDpXe8Xbs+@linutronix.de>
 <YgtxIZdDXie01OJJ@T590>
 <YgtzBdwYxA7ryJh3@linutronix.de>
 <YguVS3cfbJ6w4Thi@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YguVS3cfbJ6w4Thi@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-02-15 19:58:03 [+0800], Ming Lei wrote:
> On Tue, Feb 15, 2022 at 10:31:49AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2022-02-15 17:23:45 [+0800], Ming Lei wrote:
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 1adfe4824ef5e..90217f1b09add 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -2040,14 +2040,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
> > > >  		return;
> > > >  
> > > >  	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > > > -		int cpu = get_cpu();
> > > 
> > > Did you observe the warning triggered?  might_sleep_if(true) in
> > > __blk_mq_run_dispatch_ops() is only supposed to be run in case of
> > > (hctx->flags & BLK_MQ_F_BLOCKING).
> > 
> > I haven't seen it triggering but if that call chain is possible then it
> > will triggert due to get_cpu().
> 
> As I mentioned, the call chain isn't possible.

Why not? Is BLK_MQ_F_BLOCKING and blk_queue_has_srcu() exclusive?

> Thanks,
> Ming

Sebastian
