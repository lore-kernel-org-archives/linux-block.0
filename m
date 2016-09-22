Return-Path: <BATV+790fc1df0de68f83423e+4778+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 22 Sep 2016 08:12:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, jbacik@fb.com,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
Message-ID: <20160922151222.GA515@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
 <20160922145922.GB1800@infradead.org>
 <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 22, 2016 at 09:03:56AM -0600, Jens Axboe wrote:
> Having to grab a mutex, for instance. We invoke ->queue_rq() with
> preemption disabled, so I'd hope that would not be the case... What
> drivers block in ->queue_rq?

I though I had converted a lot of them to GFP_NOIO instead of GFP_ATOMIC
allocations, but I can't find any evidence of that.  Maybe it was just
my imagination, or an unsubmitted patch series.  Sorry for the
confusion.

> Loop was another case that was on my radar to get rid of the queue_work
> it currently has to do. Josef is currently testing the nbd driver using
> this approach, so we should get some numbers there too. If we have to,
> we can always bump up the concurrency to mimic more of the behavior of
> having multiple workers running on the hardware queue. I'd prefer to
> still do that in blk-mq, instead of having drivers reinventing their own
> work offload functionality.

There should be a lot of numbers in the list archives from the time
that Ming did the loop conversion, as I've been trying to steer him
that way, and he actually implemented and benchmarked it.

We can't just increase the concurrency as a single work_struct item
can't be queued multiple times even on a high concurreny workqueue.
