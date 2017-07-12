Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754700AbdGLCai (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 22:30:38 -0400
Date: Wed, 12 Jul 2017 10:30:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Message-ID: <20170712023028.GB13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
 <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 12:25:16PM -0600, Jens Axboe wrote:
> On 07/11/2017 12:21 PM, Ming Lei wrote:
> > When .queue_rq() returns BLK_STS_RESOURCE(BUSY), we can
> > consider that there is congestion in either low level
> > driver or hardware.
> > 
> > This patch uses EWMA to estimate this congestion threshold,
> > then this threshold can be used to detect/avoid congestion.
> 
> This whole patch set lacks some sort of reasoning why this
> makes sense. I'm assuming you want to reduce unnecessary
> restarts of the queue?

When low level drivers returns BLK_STS_RESOURCE, it means
either driver or hardware can't handle the incoming requests.
The issue is actually one problem of congestion control, IMO.

There are some ways taken in drivers to deal with the issue:

	1) both virtio-blk/xen-blkfront just stops queue in this
	case, then restart the queue when one request is completed.

	2) virtio-scsi chooses to not stop queue

For reaching good IO performance, we often do the following two
things:
	- try to make the queue pipeline as full by increasing queue depth
	- run several tasks to do IO at the same time

So for the soltion 1) above, it can't be efficient, because when one request
is completed to restart queue, there are lots of requests in the queue,
and dispatching these requests will cause to return lots of BLK_STS_RESOURCE
too. The dispatch isn't cheap at all, we need to acquire sw queue
lock/scheduler lock/hw queue lock /low level queue lock in the whole
path, so we should try to avoid dispatching to a busy queue.

For the solution 2), it simply doesn't stop queue, unnecessary
dispatching to a busy queue just wastes CPU, and has the same issue
with 1) too. As you can see in the commit log of patch 5, big
improvement is observed with this simple implementation:

	sequential read test(libaio, bs:4k, direct io, queue depth:64, 8 jobs)
	on virtio-scsi shows that:
	        - CPU utilization decreases ~20%
	        - IOPS increases by ~10%

EWMA is used to estimate one average queue depth, with which
the queue will often be busy. In this patchset, the average queue
depth when queue becomes busy is called congestion threshold.

I chooose EWMA because it is one usual/common way to figure out
weight average value, and it has been used in several fields of
kernel(wifi rate control, sequential I/O estimation in bcache,
network,...)  Or there is other better way to do that? I am happy
to take it, even in the future we may support more than one approaches
to address the issue.

Also another motivation is to unexport APIs of start/stop queue.

> I would much rather ensure that we only
> start when we absolutely have to to begin with, I'm pretty sure
> we have a number of cases where that is not so.

Could you share us these cases? I believe we can integrate different
approaches for congestion control to address different requirement.

> 
> What happens with fluid congestion boundaries, with shared tags?

The approach in this patch should work, but the threshold may not
be accurate in this way, one simple method is to use the average
tag weight in EWMA, like this:

	sbitmap_weight() / hctx->tags->active_queues

-- 
Ming
