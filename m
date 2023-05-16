Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D1EC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjEPOsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjEPOr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 10:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AE768A
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 07:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C7561B6C
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 14:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D9BC433D2;
        Tue, 16 May 2023 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684248468;
        bh=bfiegA8pQbZTKz4sfUNqZUwteop4ZWQJGoredlfVI1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdFkl3v1k5Gg4Dc6bBCckdYA/aAmy7bns597ysOxZ7tfQGpykOrCWZwMyweoqNupp
         Eh6ZUbWT1sVKdxb95BKNNChLVlSM0bcWAOwhA6MBAUzq9mMEF1D+77RwnmYQyq5ogE
         4g/Zv/vpZgosDzbnrGFueTCNaX62lJgsbarGMrl3DjdNCpg6Wv54DGhm86u0d6EM+/
         Zjl7qJbLtQzHlFNHuFrlAuhdM52SmkDmFEcFqmFOM78yfBD5y9TFrLPiy6s9aR1t1L
         Ua5X+Ji+cLO6W/SEAa9hYlIAlAX9PrPnyCP7afZMvZi0VLs+SeVMh1NrUg/fpL2wbb
         BeEt1Iezdp/OA==
Date:   Tue, 16 May 2023 08:47:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGOXkhzPplCfK6kc@kbusch-mbp>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 09:20:55AM +0800, Ming Lei wrote:
> On Mon, May 15, 2023 at 02:22:18PM -0600, Keith Busch wrote:
> > On Mon, May 15, 2023 at 08:52:38AM -0700, Bart Van Assche wrote:
> > > On 5/15/23 07:46, Ming Lei wrote:
> > > > @@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
> > > >   static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > > >   {
> > > > -	if (rq->rq_flags & RQF_ELV) {
> > > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > > >   		struct elevator_queue *e = rq->q->elevator;
> > > >   		if (e->type->ops.completed_request)
> > > > @@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > > >   static inline void blk_mq_sched_requeue_request(struct request *rq)
> > > >   {
> > > > -	if (rq->rq_flags & RQF_ELV) {
> > > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > > >   		struct request_queue *q = rq->q;
> > > >   		struct elevator_queue *e = q->elevator;
> > > 
> > > Has it been considered not to set RQF_ELV for passthrough requests instead
> > > of making the above changes?
> > 
> > That sounds like a good idea. It changes more behavior than what Ming is
> > targeting here, but after looking through each use for RQF_ELV, I think
> > not having that set really is the right thing to do in all cases for
> > passthrough requests.
> 
> I did consider that approach. But:
> 
> - RQF_ELV actually means that the request & its tag is allocated from sched tags.
> 
> - if RQF_ELV is cleared for passthrough request, request may be
>   allocated from sched tags(normal IO) and driver tags(passthrough) at the same time.
>   This way may cause other problem, such as, breaking blk_mq_hctx_has_requests().
>   Meantime it becomes not likely to optimize tags resource utilization in future,
>   at least for single LUN/NS, no need to keep sched tags & driver tags
>   in memory at the same time.

Isn't that similar to multiple namespaces where some use elevator and
others use 'none'? They're all contenting for the same shared driver
tags with racing 'has_requests()'.

And the passthrough case is special with users of that interface taking
on a greater responsibility and generally want the kernel out of the
way. I don't think anyone would purposefully run a tag intense workload
through that engine at the same time as using a generic one with the
scheduler. It definitely should still work, but it doesn't need to be
fair, right?
