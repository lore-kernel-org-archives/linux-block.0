Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcITLil (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 07:38:41 -0400
Date: Tue, 20 Sep 2016 13:44:36 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] blk-mq: Do not limit number of queues to
 'nr_cpu_ids' in allocations
Message-ID: <20160920114435.GC26808@agordeev.lab.eng.brq.redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
 <9bb584d504bc2f8ef9d66822e68f082ee9a74ded.1474183901.git.agordeev@redhat.com>
 <20160919174849.GA21803@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919174849.GA21803@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 10:48:49AM -0700, Omar Sandoval wrote:
> On Sun, Sep 18, 2016 at 09:37:14AM +0200, Alexander Gordeev wrote:
> > Currently maximum number of used hardware queues is limited to
> > number of CPUs in the system. However, using 'nr_cpu_ids' as
> > the limit for (de-)allocations of data structures instead of
> > existing data structures' counters (a) worsens readability and
> > (b) leads to unused memory when number of hardware queues is
> > less than number of CPUs.
> > 
> > CC: linux-block@vger.kernel.org
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > ---
> >  block/blk-mq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 276ec7b..2c77b68 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2054,8 +2054,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> >  	if (!q->queue_ctx)
> >  		goto err_exit;
> >  
> > -	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
> > -						GFP_KERNEL, set->numa_node);
> > +	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
> > +			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
> >  	if (!q->queue_hw_ctx)
> >  		goto err_percpu;
> >  
> > @@ -2319,7 +2319,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> >  	if (set->nr_hw_queues > nr_cpu_ids)
> >  		set->nr_hw_queues = nr_cpu_ids;
> >  
> > -	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> > +	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
> >  				 GFP_KERNEL, set->numa_node);
> >  	if (!set->tags)
> >  		return -ENOMEM;
> > @@ -2360,7 +2360,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < nr_cpu_ids; i++) {
> > +	for (i = 0; i < set->nr_hw_queues; i++) {
> >  		if (set->tags[i])
> >  			blk_mq_free_rq_map(set, set->tags[i], i);
> >  	}
> 
> I don't think this is safe since we might increase the number of
> hardware queues (blk_mq_update_nr_hw_queues()).

It is safe, because blk_mq_update_nr_hw_queues() limits number of
hardware queues to nr_cpu_ids. But still using nr_cpu_ids is wrong,
because (a) set->nr_hw_queues could be less than nr_cpu_ids and
(b) it is set->nr_hw_queues counter that tracks size of the array.

> -- 
> Omar
