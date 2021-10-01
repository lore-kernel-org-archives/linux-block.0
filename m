Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C50C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 04:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C8A61A40
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 04:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhJAEPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 00:15:34 -0400
Received: from verein.lst.de ([213.95.11.211]:33564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235967AbhJAEPd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 00:15:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DF1C67373; Fri,  1 Oct 2021 06:13:48 +0200 (CEST)
Date:   Fri, 1 Oct 2021 06:13:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 4/5] block: drain file system I/O on del_gendisk
Message-ID: <20211001041348.GA17306@lst.de>
References: <20210929071241.934472-1-hch@lst.de> <20210929071241.934472-5-hch@lst.de> <YVQg/a6GnELfPV1S@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVQg/a6GnELfPV1S@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 04:17:01PM +0800, Ming Lei wrote:

[full quote deleted]

> Draining request won't fix the problem completely:
> 
> 1) blk-mq dispatch code may still be in-progress after q_usage_counter
> becomes zero, see the story in 662156641bc4 ("block: don't drain in-progress dispatch in
> blk_cleanup_queue()")

That commit does not have a good explanation on what it actually fixed.

> 2) elevator code / blkcg code may still be called after blk_cleanup_queue(), such
> as kyber, trace_kyber_latency()(q->disk is referred) is called in kyber's timer
> handler, and the timer is deleted via del_timer_sync() via kyber_exit_sched()
> from blk_release_queue().

Yes.  There's two things we can do here:

 - stop using the dev_t in tracing a request_queue
 - exit the I/O schedules in del_gendisk, because they are only used
   for file system I/O that requires the gendisk anyway

we'll probably want both eventually.

> 
> > +
> > +	rq_qos_exit(q);
> > +	blk_sync_queue(q);
> > +	blk_flush_integrity();
> > +	/*
> > +	 * Allow using passthrough request again after the queue is torn down.
> > +	 */
> > +	blk_mq_unfreeze_queue(q);
> 
> Again, one FS bio is still possible to enter queue now: submit_bio_checks()
> is done before set_capacity(0), and submitted after blk_mq_unfreeze_queue()
> returns.

Not with the new patch 1 in this series.

Jens - can you take a look at the series that fixes the crashes people
are sending while I'm looking at the rest of the corner cases?
