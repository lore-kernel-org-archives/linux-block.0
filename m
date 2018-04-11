Return-Path: <00moses.alexander00@gmail.com>
Return-Path: <00moses.alexander00@gmail.com>
Date: Wed, 11 Apr 2018 12:12:56 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411101242.GA2322@gmail.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409220938.GI3126663@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 03:09:38PM -0700, Tejun Heo wrote:
> (cc'ing Joseph as he worked on the area recently, hi!)
> 
> Hello,
> 
> On Sat, Apr 07, 2018 at 12:21:48PM +0200, Alexandru Moise wrote:
> > The q->id is used as an index within the blkg_tree radix tree.
> > 
> > If the entry is not released before reclaiming the blk_queue_ida's id
> > blkcg_init_queue() within a different driver from which this id
> > was originally for can fail due to the entry at that index within
> > the radix tree already existing.
> > 
> > Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
> > ---
> > v2: Added no-op for !CONFIG_BLK_CGROUP
> > 
> >  block/blk-cgroup.c         | 2 +-
> >  block/blk-sysfs.c          | 4 ++++
> >  include/linux/blk-cgroup.h | 3 +++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 1c16694ae145..224e937dbb59 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -369,7 +369,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
> >   *
> >   * Destroy all blkgs associated with @q.
> >   */
> > -static void blkg_destroy_all(struct request_queue *q)
> > +void blkg_destroy_all(struct request_queue *q)
> >  {
> >  	struct blkcg_gq *blkg, *n;
> >  
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index d00d1b0ec109..a72866458f22 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -816,6 +816,10 @@ static void __blk_release_queue(struct work_struct *work)
> >  	if (q->bio_split)
> >  		bioset_free(q->bio_split);
> >  
> > +	spin_lock_irq(q->queue_lock);
> > +	blkg_destroy_all(q);
> > +	spin_unlock_irq(q->queue_lock);
> > +
> >  	ida_simple_remove(&blk_queue_ida, q->id);
> >  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
> 
> But we already do this through calling blkcg_exit_queue() from
> __blk_release_queue().  What's missing?

Hi,

It might be the jetlag but I can't see how you end up calling
blkcg_exit_queue() from __blk_release_queue().

As I see it the only way to reach blkcg_exit_queue() is from
blk_cleanup_queue(), which I don't see anywhere in __blk_release_queue().

I suspect that I'm just fixing a corner case though and
the general case is what you describe or similar.

../Alex
> 
> Thanks.
> 
> -- 
> tejun
