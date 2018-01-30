Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752630AbeA3ELR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 23:11:17 -0500
Date: Tue, 30 Jan 2018 12:10:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jiri Palecek <jpalecek@web.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [2/2] block: fix blk_rq_append_bio
Message-ID: <20180130041048.GH17176@ming.t460p>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87tvv4p1f2.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tvv4p1f2.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 30, 2018 at 02:42:41AM +0100, Jiri Palecek wrote:
> Hello,
> 
> I see a problem with this patch:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > From: Jens Axboe <axboe@kernel.dk>
> >
> > Commit caa4b02476e3(blk-map: call blk_queue_bounce from blk_rq_append_bio)
> > moves blk_queue_bounce() into blk_rq_append_bio(), but don't consider
> > that the bounced bio becomes invisiable to caller since the parameter type is
> > 'struct bio *', which should have been 'struct bio **'.
> >
> > This patch fixes this issue by passing 'struct bio **' to
> > blk_rq_append_bio(), then the bounced bio can be returned to caller.
> >
> > Also failure handling is considered too.
> >
> > Fixes: caa4b02476e3 ("blk-map: call blk_queue_bounce from blk_rq_append_bio")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Reported-by: Michele Ballabio <barra_cuda@katamail.com>
> > (handling failure of blk_rq_append_bio(), only call bio_get() after
> > blk_rq_append_bio() returns OK)
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-map.c                    | 38 ++++++++++++++++++++++----------------
> >  drivers/scsi/osd/osd_initiator.c   |  4 +++-
> >  drivers/target/target_core_pscsi.c |  4 ++--
> >  include/linux/blkdev.h             |  2 +-
> >  4 files changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index b21f8e86f120..d3a94719f03f 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -12,22 +12,29 @@
> >  #include "blk.h"
> >  
> >  /*
> > - * Append a bio to a passthrough request.  Only works can be merged into
> > - * the request based on the driver constraints.
> > + * Append a bio to a passthrough request.  Only works if the bio can be merged
> > + * into the request based on the driver constraints.
> >   */
> > -int blk_rq_append_bio(struct request *rq, struct bio *bio)
> > +int blk_rq_append_bio(struct request *rq, struct bio **bio)
> >  {
> > -	blk_queue_bounce(rq->q, &bio);
> > +	struct bio *orig_bio = *bio;
> > +
> > +	blk_queue_bounce(rq->q, bio);
> >  
> >  	if (!rq->bio) {
> > -		blk_rq_bio_prep(rq->q, rq, bio);
> > +		blk_rq_bio_prep(rq->q, rq, *bio);
> >  	} else {
> > -		if (!ll_back_merge_fn(rq->q, rq, bio))
> > +		if (!ll_back_merge_fn(rq->q, rq, *bio)) {
> > +			if (orig_bio != *bio) {
> > +				bio_put(*bio);
> > +				*bio = orig_bio;
> 
> 1) Suppose the bio *does* bounce, which allocates some pages from the
> DMA pool, and subsequently this test fails. bio_put won't deallocate
> those pages. Prior to caa4b02476e3, it would be done by bio_endio, which
> is IMHO the correct way to do it.

You are right, that is my fault, and will review your patch later.

> 
> 2) What if the bio bounces and goes into the splitting path of
> __blk_queue_bounce. That would submit the request, which would be a
> problem should this test or some other later fail, cancelling the whole
> request.

When bio comes here, bio_is_passthrough() is true, it won't go into that
path, so needn't to worry.

Thanks,
Ming
