Return-Path: <ming.lei@redhat.com>
Date: Sat, 9 Sep 2017 18:39:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] Make SCSI device suspend work reliably
Message-ID: <20170909103859.GA29285@ming.t460p>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Bart,

On Fri, Sep 08, 2017 at 04:52:21PM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> Recently it was reported on the block layer mailing list that suspend
> does not work reliably neither for the legacy block layer nor for blk-mq.

What is the issue? Why is it not reliably? Please describe it clearly.

> The purpose of this patch series is to make device suspend work reliably
> without affecting the hot path significantly and without introducing any
> race conditions between request queue cleanup and blk_get_request().

If you mean the approach in my patchset, please say it clearly.
I replied you already, but I am happy to reply you again.

Looks you do not understand the root cause behind I/O hang
during suspend/resume reported by Oleksandr.

Let me explain it again:

- the issue is not suspend/resume only, it is about SCSI quiesce vs.
RQF_PREEMPT.

- when SCSI device is put into quiesce, only RQF_PREEMPT request is
allowed to dispatch to lld, and other requests can't be dispatched
successfully.

- so if requests pool are used up during SCSI quiesce, no request can
be allocated for RQF_PREEMPT and these requests can't be freed too,
so I/O hang is caused because the pool is often very limited, and
easy to be consumed up

Except for the suspend I/O hang reported by Oleksandr, we also have
other I/O hang related with SCSI quiesce, both belongs to the
same kind of issue.

I don't see the issue above addressed by this patchset, so maybe
you are trying to fix another PM specific issue(not reported by
Oleksandr), I am just confused.

So again, please describe the issue to be addressed clearly first!

-- 
Ming
