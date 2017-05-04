Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753474AbdEDCKX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 22:10:23 -0400
Date: Thu, 4 May 2017 10:10:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/4] blk-mq: introduce blk_mq_get_queue_depth()
Message-ID: <20170504021004.GA16084@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-3-ming.lei@redhat.com>
 <20170503165530.GB10775@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503165530.GB10775@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 03, 2017 at 09:55:30AM -0700, Omar Sandoval wrote:
> On Fri, Apr 28, 2017 at 11:15:37PM +0800, Ming Lei wrote:
> > The hardware queue depth can be resized via blk_mq_update_nr_requests(),
> > so introduce this helper for retrieving queue's depth easily.
> 
> One nit below. If the per-hardware queue tag space situation changes, we
> can revisit this and the similar thing in Kyber.

OK, will add comment about this situation in V3. 

> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 12 ++++++++++++
> >  block/blk-mq.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index e530bc54f0d9..04761fb76ab4 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2637,6 +2637,18 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> >  }
> >  EXPORT_SYMBOL(blk_mq_free_tag_set);
> >  
> > +/*
> > + * Queue depth can be changed via blk_mq_update_nr_requests(),
> > + * so use this helper to retrieve queue's depth.
> > + */
> > +int blk_mq_get_queue_depth(struct request_queue *q)
> > +{
> > +	/* All queues have same queue depth */
> > +	struct blk_mq_tags	*tags = q->tag_set->tags[0];
> 
> Not sure what's going on with the spacing here. Tab instead of a space?

Either one should be fine, and I am sure this patch is warning/error
free when checking with ./scripts/checkpatch.pl, :-)

Thanks,
Ming
