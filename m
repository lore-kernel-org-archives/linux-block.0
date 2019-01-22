Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FBAC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02932082C
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAVDfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:35:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfAVDfW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 22:35:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13F0F15F5E;
        Tue, 22 Jan 2019 03:35:22 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2975619C7C;
        Tue, 22 Jan 2019 03:35:11 +0000 (UTC)
Date:   Mon, 21 Jan 2019 22:35:11 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, NeilBrown <neilb@suse.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] dm: fix missing bio_split() pattern code in
 __split_and_process_bio()
Message-ID: <20190122033510.GA7621@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
 <20190119180506.1300-4-snitzer@redhat.com>
 <20190121032153.GA24610@ming.t460p>
 <20190121160204.GA32117@redhat.com>
 <20190122024640.GA4287@ming.t460p>
 <20190122031758.GA7574@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122031758.GA7574@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 22 Jan 2019 03:35:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 21 2019 at 10:17pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, Jan 21 2019 at  9:46pm -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Mon, Jan 21, 2019 at 11:02:04AM -0500, Mike Snitzer wrote:
> > > On Sun, Jan 20 2019 at 10:21P -0500,
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > > On Sat, Jan 19, 2019 at 01:05:05PM -0500, Mike Snitzer wrote:
> > > > > Use the same BIO_QUEUE_ENTERED pattern that was established by commit
> > > > > cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
> > > > > bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
> > > > > recursing via generic_make_request().
> > > > > 
> > > > > Also add trace_block_split() because it provides useful context about
> > > > > bio splits in blktrace.
> > > > > 
> > > > > Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for recursive bio submits")
> > > > > Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
> > > > > Cc: stable@vger.kernel.org # 4.16+
> > > > > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > > > > ---
> > > > >  drivers/md/dm.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > index fbadda68e23b..6e29c2d99b99 100644
> > > > > --- a/drivers/md/dm.c
> > > > > +++ b/drivers/md/dm.c
> > > > > @@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
> > > > >  						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
> > > > >  				part_stat_unlock();
> > > > >  
> > > > > +				bio_set_flag(bio, BIO_QUEUE_ENTERED);
> > > > >  				bio_chain(b, bio);
> > > > > +				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
> > > > >  				ret = generic_make_request(bio);
> > > > >  				break;
> > > > >  			}
> > > > 
> > > > In theory, BIO_QUEUE_ENTERED is only required when __split_and_process_bio() is
> > > > called from generic_make_request(). However, it may be called from dm_wq_work(),
> > > > this way might cause trouble on operation to q->q_usage_counter.
> > > 
> > > Good point, I've tweaked this patch to clear BIO_QUEUE_ENTERED in
> > > dm_make_request().
> > > 
> > > And to Neil's point: yes, these changes really do need to made
> > > common since it appears all bio_split() callers do go on to call
> > > generic_make_request().
> > > 
> > > Anyway, here is the updated patch that is now staged in linux-next:
> > > 
> > > From: Mike Snitzer <snitzer@redhat.com>
> > > Date: Fri, 18 Jan 2019 01:21:11 -0500
> > > Subject: [PATCH v2] dm: fix missing bio_split() pattern code in __split_and_process_bio()
> > > 
> > > Use the same BIO_QUEUE_ENTERED pattern that was established by commit
> > > cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
> > > bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
> > > recursing via generic_make_request().
> > > 
> > > Also add trace_block_split() because it provides useful context about
> > > bio splits in blktrace.
> > > 
> > > Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for recursive bio submits")
> > > Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
> > > Cc: stable@vger.kernel.org # 4.16+
> > > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > > ---
> > >  drivers/md/dm.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index fbadda68e23b..25884f833a32 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
> > >  						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
> > >  				part_stat_unlock();
> > >  
> > > +				bio_set_flag(bio, BIO_QUEUE_ENTERED);
> > >  				bio_chain(b, bio);
> > > +				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
> > >  				ret = generic_make_request(bio);
> > >  				break;
> > >  			}
> > > @@ -1734,6 +1736,13 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
> > >  
> > >  	map = dm_get_live_table(md, &srcu_idx);
> > >  
> > > +	/*
> > > +	 * Clear the bio-reentered-generic_make_request() flag,
> > > +	 * will be set again as needed if bio needs to be split.
> > > +	 */
> > > +	if (bio_flagged(bio, BIO_QUEUE_ENTERED))
> > > +		bio_clear_flag(bio, BIO_QUEUE_ENTERED);
> > > +
> > >  	/* if we're suspended, we have to queue this io for later */
> > >  	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
> > >  		dm_put_live_table(md, srcu_idx);
> > > -- 
> > > 2.15.0
> > > 
> > 
> > Hi Mike,
> > 
> > I'd suggest to fix this kind issue in the following way, then we
> > can avoid to touch this flag from drivers:
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 3c5f61ceeb67..e70103560ac2 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1024,6 +1024,8 @@ blk_qc_t generic_make_request(struct bio *bio)
> >  		else
> >  			bio_io_error(bio);
> >  		return ret;
> > +	} else {
> > +		bio_set_flag(bio, BIO_QUEUE_ENTERED);
> >  	}
> >  
> >  	if (!generic_make_request_checks(bio))
> > @@ -1074,6 +1076,8 @@ blk_qc_t generic_make_request(struct bio *bio)
> >  			if (blk_queue_enter(q, flags) < 0) {
> >  				enter_succeeded = false;
> >  				q = NULL;
> > +			} else {
> > +				bio_set_flag(bio, BIO_QUEUE_ENTERED);
> >  			}
> >  		}
> >  
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index b990853f6de7..8777e286bd3f 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -339,16 +339,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
> >  		/* there isn't chance to merge the splitted bio */
> >  		split->bi_opf |= REQ_NOMERGE;
> >  
> > -		/*
> > -		 * Since we're recursing into make_request here, ensure
> > -		 * that we mark this bio as already having entered the queue.
> > -		 * If not, and the queue is going away, we can get stuck
> > -		 * forever on waiting for the queue reference to drop. But
> > -		 * that will never happen, as we're already holding a
> > -		 * reference to it.
> > -		 */
> > -		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
> > -
> >  		bio_chain(split, *bio);
> >  		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
> >  		generic_make_request(*bio);
> > 
> 
> Not opposed to this.

But thinking further: when you have a stack of cascading
q->make_request_fn it could easily be that work done the next layer
down end up causing the bio to recurse to generic_make_request() but not
directly (e.g. dm_wq_work)... yet BIO_QUEUE_ENTERED will still be set
when it really isn't appropriate.

Getting too cute with setting bio flags but not clearing them on
different device boundaries could render the flags useless (or worse:
incorrect).

I'm not out for enaging in a focused audit/churn in this area that
becomes a slippery slope during the rest of 5.0-rcX.

That is why I was going for a local DM change for 5.0 and, in parallel,
work on the more generic fixes for 5.1.

So I'm back to preferring that...

But if you, Jens or others feel strongly about it I'm open to discuss it
further.

Think we need to set REQ_NOMERGE in the split too (like
blk_queue_split() is doing).  Again, a comprehensive cleanup and
consolidation of bio_split+generic_make_request pattern is needed.  MD
has a lot of it, DM has it, and then there is blk_queue_split().
Basically blk_queue_split()'s bio_split+bio_chain+generic_make_request
and all the flags that get set inbetween should be factored out for all
to use.

Mike
