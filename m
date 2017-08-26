Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdHZIxg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Aug 2017 04:53:36 -0400
Date: Sat, 26 Aug 2017 16:53:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 09/20] blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
Message-ID: <20170826085319.GC28380@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-10-ming.lei@redhat.com>
 <1503438955.2508.30.camel@wdc.com>
 <20170824065215.GJ12966@ming.t460p>
 <1503699788.2680.52.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503699788.2680.52.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 25, 2017 at 10:23:09PM +0000, Bart Van Assche wrote:
> On Thu, 2017-08-24 at 14:52 +0800, Ming Lei wrote:
> > On Tue, Aug 22, 2017 at 09:55:57PM +0000, Bart Van Assche wrote:
> > > On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > > > +	/*
> > > > +	 * if there is q->queue_depth, all hw queues share
> > > > +	 * this queue depth limit
> > > > +	 */
> > > > +	if (q->queue_depth) {
> > > > +		queue_for_each_hw_ctx(q, hctx, i)
> > > > +			hctx->flags |= BLK_MQ_F_SHARED_DEPTH;
> > > > +	}
> > > > +
> > > > +	if (!q->elevator)
> > > > +		goto exit;
> > > 
> > > Hello Ming,
> > > 
> > > It seems very fragile to me to set BLK_MQ_F_SHARED_DEPTH if and only if
> > > q->queue_depth != 0. Wouldn't it be better to let the block driver tell the
> > > block layer whether or not there is a queue depth limit across hardware
> > > queues, e.g. through a tag set flag?
> > 
> > One reason for not doing in that way is because q->queue_depth can be
> > changed via sysfs interface.
> 
> Only the SCSI core allows the queue depth to be changed through sysfs. The
> other block drivers I am familiar with set the queue depth when the block
> layer queue is created and do not allow the queue depth to be changed later
> on.

Actually SCSI core is the only user of q->queue_depth, and it supports
to change it via sysfs.

> 
> > Another reason is that better to not exposing this flag to drivers since
> > it isn't necessary, that said it is an internal flag actually.
> 
> As far as I know only the SCSI core can create request queues that have a
> queue depth that is lower than the number of tags in the tag set. So for all
> block drivers except the SCSI core it is OK to dispatch all requests at once
> to which a hardware tag has been assigned. My proposal is either to let
> drivers like the SCSI core set BLK_MQ_F_SHARED_DEPTH or to modify
> blk_mq_sched_dispatch_requests() such that it flushes all requests if the
> request queue depth is not lower than the hardware tag set size instead of if
> q->queue_depth == 0.

As I mentioned, SCSI core is the only user of q->queue_depth, so no
affect on other drivers.


-- 
Ming
