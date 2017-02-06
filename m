Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36094 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbdBFUPy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 15:15:54 -0500
Received: by mail-pg0-f53.google.com with SMTP id v184so31200048pgv.3
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2017 12:15:54 -0800 (PST)
Date: Mon, 6 Feb 2017 12:15:21 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] blk-mq-sched: separate mark hctx and queue restart
 operations
Message-ID: <20170206201521.GC20714@vader>
References: <0ec9b1167d22966cdf77a1d5140499493ea888a2.1486408944.git.osandov@fb.com>
 <182de41f-33d3-bbf8-c591-9e577b0f1762@fb.com>
 <20170206195330.GB20714@vader>
 <f26e16b9-2e54-3e06-adca-190c952804a7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f26e16b9-2e54-3e06-adca-190c952804a7@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 06, 2017 at 01:07:41PM -0700, Jens Axboe wrote:
> On 02/06/2017 12:53 PM, Omar Sandoval wrote:
> > On Mon, Feb 06, 2017 at 12:39:57PM -0700, Jens Axboe wrote:
> >> On 02/06/2017 12:24 PM, Omar Sandoval wrote:
> >>> From: Omar Sandoval <osandov@fb.com>
> >>>
> >>> In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
> >>> after we dispatch requests left over on our hardware queue dispatch
> >>> list. This is so we'll go back and dispatch requests from the scheduler.
> >>> In this case, it's only necessary to restart the hardware queue that we
> >>> are running; there's no reason to run other hardware queues just because
> >>> we are using shared tags.
> >>>
> >>> So, split out blk_mq_sched_mark_restart() into two operations, one for
> >>> just the hardware queue and one for the whole request queue. The core
> >>> code uses both, and I/O schedulers may also want to use them.
> >>>
> >>> Signed-off-by: Omar Sandoval <osandov@fb.com>
> >>> ---
> >>> Patch based on block/for-next.
> >>>
> >>>  block/blk-mq-sched.c |  2 +-
> >>>  block/blk-mq-sched.h | 25 ++++++++++++++++++-------
> >>>  block/blk-mq.c       |  5 ++++-
> >>>  3 files changed, 23 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> >>> index ee455e7cf9d8..7538565359ea 100644
> >>> --- a/block/blk-mq-sched.c
> >>> +++ b/block/blk-mq-sched.c
> >>> @@ -201,7 +201,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >>>  	 * needing a restart in that case.
> >>>  	 */
> >>>  	if (!list_empty(&rq_list)) {
> >>> -		blk_mq_sched_mark_restart(hctx);
> >>> +		blk_mq_sched_mark_restart_hctx(hctx);
> >>>  		blk_mq_dispatch_rq_list(hctx, &rq_list);
> >>
> >> What if we dispatched nothing on this hardware queue, and it currently
> >> doesn't have any IO pending?
> > 
> > Hm, so there are two ways that could happen. If it's because
> > ->queue_rq() returned BLK_MQ_RQ_QUEUE_BUSY, then the driver is supposed
> > to kick I/O off again, right?
> > 
> > If it's because we failed to get a driver tag, then we'll call
> > blk_mq_sched_mark_restart_queue() in the shared case. I just realized
> > that there's a bug there, though. Since we already set the hctx restart
> > bit, we won't set the queue restart bit. The below should work, and
> > makes more sense in general.
> > 
> > Or were you thinking of something else?
> 
> No, I think that covers it, I had not read far enough either to see that
> you handle the shared tag case for tag starvation in the caller.

Yup, I considered making that its own helper but I figured we could do
that when we need the same logic elsewhere.
