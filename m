Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:38520 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752137AbeDMDMv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 23:12:51 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 1/4] bcache: finish incremental GC
Date: Fri, 13 Apr 2018 11:12:52 +0800
Message-Id: <1523589172-17828-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,

Hello Coly,

> On 2018/4/12 2:38 PM, tang.junhui@zte.com.cn wrote:
> > From: Tang Junhui <tang.junhui@zte.com.cn>
> > 
> > In GC thread, we record the latest GC key in gc_done, which is expected
> > to be used for incremental GC, but in currently code, we didn't realize
> > it. When GC runs, front side IO would be blocked until the GC over, it
> > would be a long time if there is a lot of btree nodes.
> > 
> > This patch realizes incremental GC, the main ideal is that, when there
> > are front side I/Os, after GC some nodes (100), we stop GC, release locker
> > of the btree node, and go to process the front side I/Os for some times
> > (100 ms), then go back to GC again.
> > 
> > By this patch, when we doing GC, I/Os are not blocked all the time, and
> > there is no obvious I/Os zero jump problem any more.
> > 
> > Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hi Junhui,
> 
> I reply my comments in line,
Thanks for your comments in advance.
> 
> > ---
> >  drivers/md/bcache/bcache.h  |  5 +++++
> >  drivers/md/bcache/btree.c   | 15 ++++++++++++++-
> >  drivers/md/bcache/request.c |  3 +++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> > index 843877e..ab4c9ca 100644
> > --- a/drivers/md/bcache/bcache.h
> > +++ b/drivers/md/bcache/bcache.h
> > @@ -445,6 +445,7 @@ struct cache {
> >  
> >  struct gc_stat {
> >      size_t            nodes;
> > +    size_t            nodes_pre;
> >      size_t            key_bytes;
> >  
> >      size_t            nkeys;
> > @@ -568,6 +569,10 @@ struct cache_set {
> >       */
> >      atomic_t        rescale;
> >      /*
> > +     * used for GC, identify if any front side I/Os is inflight
> > +     */
> > +    atomic_t        io_inflight;
> 
> Could you please to rename the above variable to something like
> search_inflight ? Just to be more explicit, considering we have many
> types of io requests.
OK, It looks better.
> 
> > +    /*
> >       * When we invalidate buckets, we use both the priority and the amount
> >       * of good data to determine which buckets to reuse first - to weight
> >       * those together consistently we keep track of the smallest nonzero
> > diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> > index 81e8dc3..b36d276 100644
> > --- a/drivers/md/bcache/btree.c
> > +++ b/drivers/md/bcache/btree.c
> > @@ -90,6 +90,9 @@
> >  
> >  #define MAX_NEED_GC        64
> >  #define MAX_SAVE_PRIO        72
> > +#define MIN_GC_NODES        100
> > +#define GC_SLEEP_TIME        100
> 
> How about naming the above macro as GC_SLEEP_MS ? So people may
> understand the sleep time is 100ms without checking more context.
OK, It looks better.
> > +
> >  
> >  #define PTR_DIRTY_BIT        (((uint64_t) 1 << 36))
> >  
> > @@ -1581,6 +1584,13 @@ static int btree_gc_recurse(struct btree *b, struct btree_op *op,
> >          memmove(r + 1, r, sizeof(r[0]) * (GC_MERGE_NODES - 1));
> >          r->b = NULL;
> >  
> > +        if (atomic_read(&b->c->io_inflight) &&
> > +            gc->nodes >= gc->nodes_pre + MIN_GC_NODES) {
> 
> On 32bit machines, gc->nodes is a 32bit count, if it is overflowed the
> above check will be false for a very long time, and in some condition it
> might be always false after gc->nodes overflowed.
> 
> How about adding the following check before the if() statement ?

>         /* in case gc->nodes is overflowed */
>         if (gc->nodes_pre < gc->nodes)
>             gc->noeds_pre = gc->nodes;
>
I think 32bit is big enough, which can express a value of billions,
but the number of nodes is usually around tens of thousands.
Also gc->nodes and gc->nodes_pre were set to zero when GC begin each time.

How do you think about? 

> > +            gc->nodes_pre =  gc->nodes;
> > +            ret = -EAGAIN;
> > +            break;
> > +        }
> > +
> >          if (need_resched()) {
> >              ret = -EAGAIN;
> >              break;
> > @@ -1748,7 +1758,10 @@ static void bch_btree_gc(struct cache_set *c)
> >          closure_sync(&writes);
> >          cond_resched();
> >  
> > -        if (ret && ret != -EAGAIN)
> > +        if (ret == -EAGAIN)
> > +            schedule_timeout_interruptible(msecs_to_jiffies
> > +                               (GC_SLEEP_TIME));
> > +        else if (ret)
> >              pr_warn("gc failed!");
> >      } while (ret);
> >  
> > diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> > index 643c3021..26750a9 100644
> > --- a/drivers/md/bcache/request.c
> > +++ b/drivers/md/bcache/request.c
> > @@ -637,7 +637,9 @@ static void do_bio_hook(struct search *s, struct bio *orig_bio)
> >  static void search_free(struct closure *cl)
> >  {
> >      struct search *s = container_of(cl, struct search, cl);
> > +
> >      bio_complete(s);
> > +    atomic_dec(&s->d->c->io_inflight);
> >  
> >      if (s->iop.bio)
> >          bio_put(s->iop.bio);
> > @@ -655,6 +657,7 @@ static inline struct search *search_alloc(struct bio *bio,
> >  
> >      closure_init(&s->cl, NULL);
> >      do_bio_hook(s, bio);
> > +    atomic_inc(&d->c->io_inflight);
> >  
> 
> Similar variable naming.
> 
> >      s->orig_bio        = bio;
> >      s->cache_miss        = NULL;
> > 
> 

Thanks for your comments.
Tang Junhui
