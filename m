Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbdDGDX1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 23:23:27 -0400
Date: Fri, 7 Apr 2017 11:23:15 +0800
From: Ming Lei <minlei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Message-ID: <20170407032309.GA10976@ming.t460p>
References: <cover.1491418411.git.osandov@fb.com>
 <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
 <20170406043108.GA29955@ming.t460p>
 <20170406075751.GA15461@vader>
 <20170406082330.GA3863@ming.t460p>
 <000e804d-fa00-d248-a3ce-dcbebc34cda9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000e804d-fa00-d248-a3ce-dcbebc34cda9@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Thanks for your comment!

On Thu, Apr 06, 2017 at 01:29:26PM -0600, Jens Axboe wrote:
> On 04/06/2017 02:23 AM, Ming Lei wrote:
> > On Thu, Apr 06, 2017 at 12:57:51AM -0700, Omar Sandoval wrote:
> >> On Thu, Apr 06, 2017 at 12:31:18PM +0800, Ming Lei wrote:
> >>> On Wed, Apr 05, 2017 at 12:01:29PM -0700, Omar Sandoval wrote:
> >>>> From: Omar Sandoval <osandov@fb.com>
> >>>>
> >>>> While dispatching requests, if we fail to get a driver tag, we mark the
> >>>> hardware queue as waiting for a tag and put the requests on a
> >>>> hctx->dispatch list to be run later when a driver tag is freed. However,
> >>>> blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> >>>> queues if using a single-queue scheduler with a multiqueue device. If
> >>>
> >>> It can't perform well by using a SQ scheduler on a MQ device, so just be
> >>> curious why someone wants to do that in this way,:-)
> >>
> >> I don't know why anyone would want to, but it has to work :) The only
> >> reason we noticed this is because when the NBD device is created, it
> >> only has a single queue, so we automatically assign mq-deadline to it.
> >> Later, we update the number of queues, but it's still using mq-deadline.
> >>
> >>> I guess you mean that ops.mq.dispatch_request() may dispatch requests
> >>> from other hardware queues in blk_mq_sched_dispatch_requests() instead
> >>> of current hctx.
> >>
> >> Yup, that's right. It's weird, and I talked to Jens about just forcing
> >> the MQ device into an SQ mode when using an SQ scheduler, but this way
> >> works fine more or less.
> > 
> > Or just switch the elevator to the MQ default one when the device becomes
> > MQ? Or let mq-deadline's .dispatch_request() just return reqs in current
> > hctx?
> 
> No, that would be a really bad idea imho. First of all, I don't want
> kernel driven scheduler changes. Secondly, the framework should work
> with a non-direct mapping between hardware dispatch queues and
> scheduling queues.
> 
> While we could force a single queue usage to make that a 1:1 mapping
> always, that loses big benefits on eg nbd, which uses multiple hardware
> queues to up the bandwidth. Similarly on nvme, for example, we still
> scale better with N submission queues and 1 scheduling queue compared to
> having just 1 submission queue.

Looks that isn't what I meant. And my 2nd point is to make mq-deadline's
dispatch_request(hctx) just returns requests mapped to the hw queue of
'hctx', then we can avoid to mess up blk-mq.c and blk-mq-sched.c.

> 
> >>> If that is true, it looks like a issue in usage of I/O scheduler, since
> >>> the mq-deadline scheduler just queues requests in one per-request_queue
> >>> linked list, for MQ device, the scheduler queue should have been per-hctx.
> >>
> >> That's an option, but that's a different scheduling policy. Again, I
> >> agree that it's strange, but it's reasonable behavior.
> > 
> > IMO, the current mq-deadline isn't good/ready for MQ device, and it
> > doesn't make sense to use it for MQ.
> 
> I don't think that's true at all. I do agree that it's somewhat quirky
> since it does introduce scheduling dependencies between the hardware
> queues, and we have to work at making that well understood and explicit,
> as not to introduce bugs due to that. But in reality, all multiqueue
> hardware we are deadling with are mapped to a single resource. As such,
> it makes a lot of sense to schedule it as such. Hence I don't think that
> a single queue deadline approach is necessarily a bad idea for even fast
> storage.

When we map all mq into one single deadline queue, it can't scale well, for
example, I just run a simple write test(libaio, dio, bs:4k, 4jobs) over one
commodity NVMe in a dual-socket(four cores) system:
	
	IO scheduler|	CPU utilization
	-------------------------------
	none		|   60%
	-------------------------------
	mq-deadline |	100%
	-------------------------------

And IO throughput is basically same in two cases.

Thanks,
Ming
