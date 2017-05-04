Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932544AbdEDCwL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 22:52:11 -0400
Date: Thu, 4 May 2017 10:51:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Message-ID: <20170504025150.GA16218@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-2-ming.lei@redhat.com>
 <20170503164631.GA10775@vader>
 <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
 <20170503214029.GA27440@vader>
 <CACVXFVMLuGioTLCJt3AF6NBkpb=7T48mEm0b1q-ATJs2PFYjYg@mail.gmail.com>
 <b7f4f8cf-30d1-8995-4256-c96184522992@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7f4f8cf-30d1-8995-4256-c96184522992@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 03, 2017 at 08:13:03PM -0600, Jens Axboe wrote:
> On 05/03/2017 08:01 PM, Ming Lei wrote:
> > On Thu, May 4, 2017 at 5:40 AM, Omar Sandoval <osandov@osandov.com> wrote:
> >> On Thu, May 04, 2017 at 04:13:51AM +0800, Ming Lei wrote:
> >>> On Thu, May 4, 2017 at 12:46 AM, Omar Sandoval <osandov@osandov.com> wrote:
> >>>> On Fri, Apr 28, 2017 at 11:15:36PM +0800, Ming Lei wrote:
> >>>>> When blk-mq I/O scheduler is used, we need two tags for
> >>>>> submitting one request. One is called scheduler tag for
> >>>>> allocating request and scheduling I/O, another one is called
> >>>>> driver tag, which is used for dispatching IO to hardware/driver.
> >>>>> This way introduces one extra per-queue allocation for both tags
> >>>>> and request pool, and may not be as efficient as case of none
> >>>>> scheduler.
> >>>>>
> >>>>> Also currently we put a default per-hctx limit on schedulable
> >>>>> requests, and this limit may be a bottleneck for some devices,
> >>>>> especialy when these devices have a quite big tag space.
> >>>>>
> >>>>> This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
> >>>>> allow to use hardware/driver tags directly for IO scheduling if
> >>>>> devices's hardware tag space is big enough. Then we can avoid
> >>>>> the extra resource allocation and make IO submission more
> >>>>> efficient.
> >>>>>
> >>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>> ---
> >>>>>  block/blk-mq-sched.c   | 10 +++++++++-
> >>>>>  block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
> >>>>>  include/linux/blk-mq.h |  1 +
> >>>>>  3 files changed, 39 insertions(+), 7 deletions(-)
> >>>>
> >>>> One more note on this: if we're using the hardware tags directly, then
> >>>> we are no longer limited to q->nr_requests requests in-flight. Instead,
> >>>> we're limited to the hw queue depth. We probably want to maintain the
> >>>> original behavior,
> >>>
> >>> That need further investigation, and generally scheduler should be happy with
> >>> more requests which can be scheduled.
> >>>
> >>> We can make it as one follow-up.
> >>
> >> If we say nr_requests is 256, then we should honor that. So either
> >> update nr_requests to reflect the actual depth we're using or resize the
> >> hardware tags.
> > 
> > Firstly nr_requests is set as 256 from blk-mq inside instead of user
> > space, it won't be a big deal to violate that.
> 
> The legacy scheduling layer used 2*128 by default, that's why I used the
> "magic" 256 internally. FWIW, I agree with Omar here. If it's set to
> 256, we must honor that. Users will tweak this value down to trade peak
> performance for latency, it's important that it does what it advertises.

In case of scheduling with hw tags, we share tags between scheduler and
dispatching, if we resize(only decrease actually) the tags, dispatching
space(hw tags) is decreased too. That means the actual usable device tag
space need to be decreased much.

> 
> > Secondly, when there is enough tags available, it might hurt
> > performance if we don't use them all.
> 
> That's mostly bogus. Crazy large tag depths have only one use case -
> synthetic peak performance benchmarks from manufacturers. We don't want
> to allow really deep queues. Nothing good comes from that, just a lot of
> pain and latency issues.

Given device provides so high queue depth, it might be reasonable to just
allow to use them up. For example of NVMe, once mq scheduler is enabled,
the actual size of device tag space is just 256 at default, even though
the hardware provides very big tag space(>= 10K).

The problem is that lifetime of sched tag is same with request's
lifetime(from submission to completion), and it covers lifetime of
device tag.  In theory sched tag should have been freed just after
the rq is dispatched to driver. Unfortunately we can't do that because
request is allocated from sched tag set.

> 
> The most important part is actually that the scheduler has a higher
> depth than the device, as mentioned in an email from a few days ago. We

I agree this point, but:

Unfortunately in case of NVMe or other high depth devices, the default
scheduler queue depth(256) is much less than device depth, do we need to
adjust the default value for this devices? In theory, the default 256
scheduler depth may hurt performance on this devices since the device
tag space is much under-utilized.


Thanks,
Ming
