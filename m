Return-Path: <BATV+b9f22be6cf688ae68bc2+5192+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 10 Nov 2017 09:34:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: only run the hardware queue if IO is pending
Message-ID: <20171110173425.GB15114@infradead.org>
References: <b1c29434-929d-a8aa-7181-b0b90607ede1@kernel.dk>
 <20171110172957.GA29446@infradead.org>
 <59eb93ed-72ca-3e6d-036a-023281a0d07f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59eb93ed-72ca-3e6d-036a-023281a0d07f@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 10:31:29AM -0700, Jens Axboe wrote:
> On 11/10/2017 10:29 AM, Christoph Hellwig wrote:
> > On Fri, Nov 10, 2017 at 09:12:18AM -0700, Jens Axboe wrote:
> >> Currently we are inconsistent in when we decide to run the queue. Using
> >> blk_mq_run_hw_queues() we check if the hctx has pending IO before
> >> running it, but we don't do that from the individual queue run function,
> >> blk_mq_run_hw_queue(). This results in a lot of extra and pointless
> >> queue runs, potentially, on flush requests and (much worse) on tag
> >> starvation situations. This is observable just looking at the top
> >> output, with lots of kworkers active. For the !async runs, it just adds
> >> to the CPU overhead of blk-mq.
> >>
> >> Move the has-pending check into the run function instead of having
> >> callers do it.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Do we even still need the blk_mq_hctx_has_pending helper at all?
> 
> We do, otherwise we end up running the queue for cases where we don't
> need to. The caller doesn't always know if it's necessary. And even
> if the caller can figure it out, it'd add complicated logic for some
> of those cases (like flush). It's easier/cleaner and more efficient
> to keep it.

I didn't mean the logic - just wondering if we need the separate
helper given it has a single caller left.

But it's really just a cosmetic point.
