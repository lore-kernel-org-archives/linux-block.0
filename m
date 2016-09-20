Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33920 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755019AbcITR03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 13:26:29 -0400
Received: by mail-pa0-f54.google.com with SMTP id wk8so9062455pab.1
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2016 10:26:29 -0700 (PDT)
Date: Tue, 20 Sep 2016 10:26:26 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] blk-mq: Do not limit number of queues to
 'nr_cpu_ids' in allocations
Message-ID: <20160920172626.GA21461@vader.DHCP.thefacebook.com>
References: <cover.1474183901.git.agordeev@redhat.com>
 <9bb584d504bc2f8ef9d66822e68f082ee9a74ded.1474183901.git.agordeev@redhat.com>
 <20160919174849.GA21803@vader>
 <20160920114435.GC26808@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160920114435.GC26808@agordeev.lab.eng.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 20, 2016 at 01:44:36PM +0200, Alexander Gordeev wrote:
> On Mon, Sep 19, 2016 at 10:48:49AM -0700, Omar Sandoval wrote:
> > On Sun, Sep 18, 2016 at 09:37:14AM +0200, Alexander Gordeev wrote:
> > > Currently maximum number of used hardware queues is limited to
> > > number of CPUs in the system. However, using 'nr_cpu_ids' as
> > > the limit for (de-)allocations of data structures instead of
> > > existing data structures' counters (a) worsens readability and
> > > (b) leads to unused memory when number of hardware queues is
> > > less than number of CPUs.
> > > 
> > > CC: linux-block@vger.kernel.org
> > > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > > ---
> > >  block/blk-mq.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 276ec7b..2c77b68 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2054,8 +2054,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> > >  	if (!q->queue_ctx)
> > >  		goto err_exit;
> > >  
> > > -	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
> > > -						GFP_KERNEL, set->numa_node);
> > > +	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
> > > +			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
> > >  	if (!q->queue_hw_ctx)
> > >  		goto err_percpu;
> > >  
> > > @@ -2319,7 +2319,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> > >  	if (set->nr_hw_queues > nr_cpu_ids)
> > >  		set->nr_hw_queues = nr_cpu_ids;
> > >  
> > > -	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> > > +	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
> > >  				 GFP_KERNEL, set->numa_node);
> > >  	if (!set->tags)
> > >  		return -ENOMEM;
> > > @@ -2360,7 +2360,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> > >  {
> > >  	int i;
> > >  
> > > -	for (i = 0; i < nr_cpu_ids; i++) {
> > > +	for (i = 0; i < set->nr_hw_queues; i++) {
> > >  		if (set->tags[i])
> > >  			blk_mq_free_rq_map(set, set->tags[i], i);
> > >  	}
> > 
> > I don't think this is safe since we might increase the number of
> > hardware queues (blk_mq_update_nr_hw_queues()).
> 
> It is safe, because blk_mq_update_nr_hw_queues() limits number of
> hardware queues to nr_cpu_ids. But still using nr_cpu_ids is wrong,
> because (a) set->nr_hw_queues could be less than nr_cpu_ids and
> (b) it is set->nr_hw_queues counter that tracks size of the array.

But say we originally call blk_mq_init_allocated_queue() with
set->nr_hw_queues = 1 and later we call blk_mq_update_nr_hw_queues()
with nr_hw_queues = nr_cpu_ids (say, 4). Then we update (line numbers
from v4.8-rc7):

   2406         set->nr_hw_queues = nr_hw_queues;

So, when we call blk_mq_realloc_hw_ctxs(), we do:

   1998         for (i = 0; i < set->nr_hw_queues; i++) {
   1999                 int node;
   2000
   2001                 if (hctxs[i])
   2002                         continue;
   2003
   2004                 node = blk_mq_hw_queue_to_node(q->mq_map, i);
   2005                 hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
   2006                                         GFP_KERNEL, node);

Now set->nr_hw_queues = 4 but we only allocated 1 hardware queue, so
we'll scribble off the end of the array.

Similar problem in blk_mq_map_swqueue():

   1850         queue_for_each_hw_ctx(q, hctx, i) {
   1851                 struct blk_mq_ctxmap *map = &hctx->ctx_map;
   1852
   1853                 /*
   1854                  * If no software queues are mapped to this hardware queue,
   1855                  * disable it and free the request entries.
   1856                  */
   1857                 if (!hctx->nr_ctx) {
   1858                         if (set->tags[i]) {
   1859                                 blk_mq_free_rq_map(set, set->tags[i], i);
   1860                                 set->tags[i] = NULL;
   1861                         }
   1862                         hctx->tags = NULL;
   1863                         continue;
   1864                 }
   1865
   1866                 /* unmapped hw queue can be remapped after CPU topo changed */
   1867                 if (!set->tags[i])
   1868                         set->tags[i] = blk_mq_init_rq_map(set, i);

q->nr_hw_queues would now be 4, but we only allocated one element for
set->tags.

Allocating nr_cpu_ids upfront is the easiest way to handle adding
hardware queues up to nr_cpu_ids as needed. Both of these are just
arrays of pointers, so it's not like it's a huge waste of memory.

-- 
Omar
