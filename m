Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36753 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdEBDtO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2017 23:49:14 -0400
Received: by mail-pf0-f175.google.com with SMTP id q66so38660155pfi.3
        for <linux-block@vger.kernel.org>; Mon, 01 May 2017 20:49:14 -0700 (PDT)
Date: Mon, 1 May 2017 20:49:12 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Message-ID: <20170502034912.GA4842@vader>
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
> 
> Bart.

The scheduler tags are there to abstract away the hardware, and
USE_HW_TAG should just be an optimization for when that abstraction is a
noop. That's not the case when there are shared tags, and I doubt that
the overhead of the scheduler tags is significant for scsi-mq. Let's
stick with the behavior Ming had here.
