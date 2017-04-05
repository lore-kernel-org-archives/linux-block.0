Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34342 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdDESnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:43:21 -0400
Received: by mail-pg0-f51.google.com with SMTP id 21so12517187pgg.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 11:43:20 -0700 (PDT)
Date: Wed, 5 Apr 2017 11:42:25 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Message-ID: <20170405184225.GB22645@vader.DHCP.thefacebook.com>
References: <cover.1491416593.git.osandov@fb.com>
 <89da4a6561df3e24af3ba1c8625470d3088d2fa1.1491416593.git.osandov@fb.com>
 <1491417192.2787.11.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1491417192.2787.11.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 05, 2017 at 06:33:14PM +0000, Bart Van Assche wrote:
> On Wed, 2017-04-05 at 11:28 -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > While dispatching requests, if we fail to get a driver tag, we mark the
> > hardware queue as waiting for a tag and put the requests on a
> > hctx->dispatch list to be run later when a driver tag is freed. However,
> > blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> > queues if using a single-queue scheduler with a multiqueue device. If
> > blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
> > are processing. This means we end up using the hardware queue of the
> > previous request, which may or may not be the same as that of the
> > current request. If it isn't, the wrong hardware queue will end up
> > waiting for a tag, and the requests will be on the wrong dispatch list,
> > leading to a hang.
> > 
> > The fix is twofold:
> > 
> > 1. Make sure we save which hardware queue we were trying to get a
> >    request for in blk_mq_get_driver_tag() regardless of whether it
> >    succeeds or not.
> > 2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
> >    blk_mq_hw_queue to make it clear that it must handle multiple
> >    hardware queues, since I've already messed this up on a couple of
> >    occasions.
> > 
> > This didn't appear in testing with nvme and mq-deadline because nvme has
> > more driver tags than the default number of scheduler tags. However,
> > with the blk_mq_update_nr_hw_queues() fix, it showed up with nbd.
> 
> Would the patch below be a valid alternative?
> 
> Thanks,
> 
> Bart.

Hi, Bart,

This actually has the same bug as the original code, see below.

> [PATCH] blk-mq: Simplify blk_mq_get_driver_tag()
> 
> The blk_mq_get_driver_tag() callers either assume that *hctx is not
> modified or that it points to a valid hctx pointer upon return if
> tag allocation succeeded. Avoid this confusion by returning the hctx
> pointer if and only if tag allocation succeeded and by only storing
> the return value into hctx in those blk_mq_get_driver_tag() callers
> for which the hctx pointer had not yet been computed before the
> blk_mq_get_driver_tag() call.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---
> �block/blk-mq-sched.c |��4 +++-
> �block/blk-mq.c�������| 24 ++++++++++--------------
> �block/blk-mq.h�������|��3 +--
> �3 files changed, 14 insertions(+), 17 deletions(-)
> 

[snip]

> �static void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
> @@ -985,7 +980,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
> �		struct blk_mq_queue_data bd;
> �
> �		rq = list_first_entry(list, struct request, queuelist);
> -		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
> +		if (!blk_mq_get_driver_tag(rq, false)) {

Here, we want to know what hardware queue we attempted the tag
allocation on, so this won't work.

Thanks for taking a look!
