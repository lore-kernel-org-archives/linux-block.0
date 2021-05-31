Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4741C47082
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B1D6135C
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhEaMGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 08:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhEaMGP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 08:06:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622462675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RH9+Kd8V7sTyxG42KUVjkdL2tsMCgNmqqsFlFhYEQXI=;
        b=cw/PULhQy9CVpYVQQI07Uq+uX5DImUpTOf6hXz6I1aDnuQKtIG97n+SUB6ZYE1ljVvb4G/
        qfIy0O6bYJJbTLqlo4aMoCQcMy1OlPWBBbHHQBWSrqGqdwXADVoevGpfcv2vLZvw/6gySH
        Z8Nasyf9PHaxTY08oogJYVDG/z3rwVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622462675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RH9+Kd8V7sTyxG42KUVjkdL2tsMCgNmqqsFlFhYEQXI=;
        b=KJsD0sm563RsNCkbboEcFbyEnT2SBLpEypZC+mJUK8ouOYy135iP1JLQP07P1YqW9VPBeW
        dOr0Mvk475t05UCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E3ECAE72;
        Mon, 31 May 2021 12:04:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DED0E1F2CB0; Mon, 31 May 2021 14:04:34 +0200 (CEST)
Date:   Mon, 31 May 2021 14:04:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
Message-ID: <20210531120434.GB5349@quack2.suse.cz>
References: <20210528032055.2242080-1-ming.lei@redhat.com>
 <20210528122631.GA28653@quack2.suse.cz>
 <YLQ9vdTarVAA+y+Z@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLQ9vdTarVAA+y+Z@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 31-05-21 09:37:01, Ming Lei wrote:
> On Fri, May 28, 2021 at 02:26:31PM +0200, Jan Kara wrote:
> > On Fri 28-05-21 11:20:55, Ming Lei wrote:
> > > Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > starts to support io batching submission by using hctx->dispatch_busy.
> > > 
> > > However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> > > in that commit, so fix the issue by updating hctx->dispatch_busy in case
> > > of real scheduler.
> > > 
> > > Reported-by: Jan Kara <jack@suse.cz>
> > > Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  block/blk-mq.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > 
> > Looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > BTW: Do you plan to submit also your improvement to
> > __blk_mq_do_dispatch_sched() to update dispatch_busy during the fetching
> > requests from the scheduler to avoid draining all requests from the IO
> > scheduler?
> 
> I understand that kind of change isn't needed. When more requests are
> dequeued, hctx->dispatch_busy will be updated, then __blk_mq_do_dispatch_sched()
> won't dequeue at batch any more if either .queue_rq() returns
> STS_RESOURCE or running out of driver tag/budget.
> 
> Or do you still see related issues after this patch is applied?

I was suspicious that __blk_mq_do_dispatch_sched() would be still pulling
requests too aggressively from the IO scheduler (which effectively defeats
impact of cgroup IO weights on observed throughput). Now I did a few more
experiments with the workload doing multiple iterations for each kernel and
comparing ratios of achieved throughput when cgroup weights were in 2:1
ratio.

With this patch alone, I've got no significant distinction between IO from
two cgroups in 4 out of 5 test iterations. With your patch to update
max_dispatch in __blk_mq_do_dispatch_sched() applied on top the results
were not significantly different (my previous test result was likely a
lucky chance). With my original patch to allocate driver tags early in
__blk_mq_do_dispatch_sched() I get reliable distinction between cgroups -
the worst ratio from all the iterations is 1.4, average ratio is ~1.75.
This last result is btw very similar to ratios I can see when using
virtio-scsi instead of virtio-blk for the backing storage which is kind of
natural because virtio-scsi ends up using the dispatch-budget logic of SCSI
subsystem. I'm not saying my patch is the right way to do things but it
clearly shows that __blk_mq_do_dispatch_sched() is still too aggressive
pulling requests out of the IO scheduler.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
