Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdEBIqr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 04:46:47 -0400
Date: Tue, 2 May 2017 16:46:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Message-ID: <20170502084637.GA963@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-4-ming.lei@redhat.com>
 <1493402979.2767.10.camel@sandisk.com>
 <20170429103554.GC12421@ming.t460p>
 <1493651174.2665.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493651174.2665.1.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 01, 2017 at 03:06:16PM +0000, Bart Van Assche wrote:
> On Sat, 2017-04-29 at 18:35 +0800, Ming Lei wrote:
> > On Fri, Apr 28, 2017 at 06:09:40PM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> > > > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> > > > +{
> > > > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > > > +		return false;
> > > > +
> > > > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > > 
> > > The only user of shared tag sets I know of is scsi-mq. I think it's really
> > > unfortunate that this patch systematically disables BLK_MQ_F_SCHED_USE_HW_TAG
> > > for scsi-mq.
> > 
> > In previous patch, I actually allow driver to pass this flag, but this
> > feature is dropped in this post, just for making it simple & clean.
> > If you think we need it for shared tag set, I can add it in v1.
> > 
> > For shared tag sets, I suggest to not enable it at default, because
> > scheduler is per request queue now, and generaly more requests available,
> > better it performs.  When tags are shared among several request
> > queues, one of them may use tags up for its own scheduling, then
> > starve others. But it should be possible and not difficult to allocate
> > requests fairly for scheduling in this case if we switch to per-hctx
> > scheduling.
> 
> Hello Ming,
> 
> Have you noticed that there is already a mechanism in the block layer to
> avoid starvation if a tag set is shared? The hctx_may_queue() function
> guarantees that each user that shares a tag set gets at least some tags.
> The .active_queues counter keeps track of the number of hardware queues
> that share a tag set.

OK, from hctx_may_queue(), each hw queue can be allocated at most
tags of (queue depth / nr_hw_queues), and we can allow to use
hw tag for scheduler too if the following condition is ture for
shared tags:

	q->nr_requests <= (blk_mq_get_queue_depth(q) / nr_hw_queues)

It should often be true for some scsi devices(such as virtio-scsi)
in some configurations.


thanks,
Ming
