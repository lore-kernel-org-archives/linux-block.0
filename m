Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D498C8300B
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 11:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7ED20870
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588244676;
	bh=CedaVmhMJydNlN3+5OOqHxPQXAjgO7wa5lpISSfhzNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LlOhsh1dwtnf+uwLe3rFP6Zws6B+gxE4jYUv3dNp28VY9NoNhIR8x/9gJkpbxzxc4
	 ADjYWDAK+nmTEwTRiO2CWK7gZ9n4du7AcDnxb6cQVqQG5cpIVfbUzpO/imuhu8H6Xq
	 N7ePsfox336B1vgnpTLRTwdIfBNc5tqNv0/NYHmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD3LEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgD3LEf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 07:04:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5DA20774;
        Thu, 30 Apr 2020 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588244674;
        bh=CedaVmhMJydNlN3+5OOqHxPQXAjgO7wa5lpISSfhzNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rgIXW36JneHRbDm+1eNCEIFkD+V2E/2FC0wzmIIznr58uBsRzswu/TjCunzgW8z9
         A7H6N79/4UM+W27QvDQ8af7KVwzKcaPq0WZTOEPq5sT9Th2WjbYAP/HO3qT6NTquIz
         gbJGk3u8D0j3s5haMvpC+MqPKv+w4ncWwwVFTRUE=
Date:   Thu, 30 Apr 2020 12:04:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200430110429.GI19932@willie-the-truck>
References: <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430003945.GA719313@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 08:39:45AM +0800, Ming Lei wrote:
> On Wed, Apr 29, 2020 at 06:34:01PM +0100, Will Deacon wrote:
> > On Wed, Apr 29, 2020 at 09:43:27PM +0800, Ming Lei wrote:
> > > Please see the following two code paths:
> > > 
> > > [1] code path1:
> > > blk_mq_hctx_notify_offline():
> > > 	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> > > 
> > > 	smp_mb() or smp_mb_after_atomic()
> > > 
> > > 	blk_mq_hctx_drain_inflight_rqs():
> > > 		blk_mq_tags_inflight_rqs()
> > > 			rq = hctx->tags->rqs[index]
> > > 			and
> > > 			READ rq->tag
> > > 
> > > [2] code path2:
> > > 	blk_mq_get_driver_tag():
> > > 
> > > 		process might be migrated to other CPU here and chance is small,
> > > 		then the follow code will be run on CPU different with code path1
> > > 
> > > 		rq->tag = rq->internal_tag;
> > > 		hctx->tags->rqs[rq->tag] = rq;
> > 
> > I /think/ this can be distilled to the SB litmus test:
> > 
> > 	// blk_mq_hctx_notify_offline()		blk_mq_get_driver_tag();
> > 	Wstate = INACTIVE			Wtag
> > 	smp_mb()				smp_mb()
> > 	Rtag					Rstate
> > 
> > and you want to make sure that either blk_mq_get_driver_tag() sees the
> > state as INACTIVE and does the cleanup, or it doesn't and
> > blk_mq_hctx_notify_offline() sees the newly written tag and waits for the
> > request to complete (I don't get how that happens, but hey).
> > 
> > Is that right?
> 
> Yeah, exactly.
> 
> > 
> > > 		barrier() in case that code path2 is run on same CPU with code path1
> > > 		OR
> > > 		smp_mb() in case that code path2 is run on different CPU with code path1 because
> > > 		of process migration
> > > 		
> > > 		test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state)
> > 
> > Couldn't you just check this at the start of blk_mq_get_driver_tag() as
> > well, and then make the smp_mb() unconditional?
> 
> As I mentioned, the chance for the current process(calling
> blk_mq_get_driver_tag()) migration is very small, we do want to
> avoid the extra smp_mb() in the fast path.

Hmm, but your suggestion of checking 'rq->mq_ctx->cpu' only works if that
is the same CPU on which blk_mq_hctx_notify_offline() executes. What
provides that guarantee?

If there's any chance of this thing being concurrent, then you need the
barrier there just in case. So I'd say you either need to prevent the race,
or live with the barrier. Do you have numbers to show how expensive it is?

Will
