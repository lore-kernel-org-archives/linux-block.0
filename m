Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S376386AbdD2Jzj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2017 05:55:39 -0400
Date: Sat, 29 Apr 2017 17:55:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/4] blk-mq: introduce blk_mq_get_queue_depth()
Message-ID: <20170429095529.GB12421@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-3-ming.lei@redhat.com>
 <01993bcb-da07-a8f5-1f00-09b808f9efc9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01993bcb-da07-a8f5-1f00-09b808f9efc9@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 12:23:38PM -0600, Jens Axboe wrote:
> On 04/28/2017 09:15 AM, Ming Lei wrote:
> > The hardware queue depth can be resized via blk_mq_update_nr_requests(),
> > so introduce this helper for retrieving queue's depth easily.
> > 
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
> > +
> > +	return tags->bitmap_tags.sb.depth;
> > +}
> 
> What about the per-hw queue tag space? q->nr_requests is device side,
> this might not be.

This helper returns hw queue's actual queue depth, so only hw tag
space is involved.

We don't have per-hw queue tag space yet, and the tag space
should belong to tag set actually, but the hw queue number can be
one. And now all hw queues have same queue depth, either it is
set->queue_depth, or the new value updated in blk_mq_update_nr_requests().
And tags's depth is always the latest value.

The similar comment can be found in kyber_sched_tags_shift() too.

BTW, this patch missed reserved tags, will fix it in V1.

Thanks,
Ming
