Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967713AbdD2K7T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2017 06:59:19 -0400
Date: Sat, 29 Apr 2017 18:59:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Message-ID: <20170429105910.GD12421@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-4-ming.lei@redhat.com>
 <c8984e2a-ecdc-fdf7-afba-484b823270c9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8984e2a-ecdc-fdf7-afba-484b823270c9@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 12:22:45PM -0600, Jens Axboe wrote:
> On 04/28/2017 09:15 AM, Ming Lei wrote:  
> > +/*
> > + * If this queue has enough hardware tags and doesn't share tags with
> > + * other queues, just use hw tag directly for scheduling.
> > + */
> > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> > +{
> > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > +		return false;
> > +
> > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > +		return false;
> 
> I think we should leave a bigger gap. Ideally, for scheduling, we should
> have a hw queue depth that's around half of what the scheduler has to
> work with. That will always leave us something to schedule with, if the
> hw can't deplete the whole pool.

When .sched_tags and .tags are different, it makes sense to make
nr_requests to be two times of queue_depth.

When we switch to schedule with hw tags directly, the euquation
can't be true at all. The simple policy in this patch can't be worsen
than standalone .sched_tags because lifetime of one sched tag is
actually same with request(from its allocation<io submission> to
freeing<io completion>). When we have bigger queue depth, even we can
schedule more.


Thanks,
Ming
