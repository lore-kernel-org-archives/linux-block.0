Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 28 Sep 2016 09:43:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
	jbacik@fb.com
Subject: Re: [PATCH 0/2]: Add option for async ->queue_rq
Message-ID: <20160928164318.GA31729@vader>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <acf43ae6-76d5-8dca-548a-30f16d0e0928@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acf43ae6-76d5-8dca-548a-30f16d0e0928@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 27, 2016 at 05:25:36PM -0700, Bart Van Assche wrote:
> On 09/22/16 07:52, Jens Axboe wrote:
> > Two patches that add the ability for a driver to flag itself
> > as wanting the ->queue_rq() invoked in a manner that allows
> > it to block. We'll need that for the nbd conversion, to avoid
> > having to add workqueue offload. We can use this in the current
> > loop mq path as well.
> 
> Hello Jens,
> 
> How can this work since there is code that calls blk_mq_run_hw_queue() with
> a spin lock held? From mq_flush_data_end_io():
> 
> 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
> 	if (blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error))
> 		blk_mq_run_hw_queue(hctx, true);
> 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> 
> Sorry that I hadn't noticed this before.
> 
> Bart.

Hey, Bart,

In this particular case, we're passing async=true to
blk_mq_run_hw_queue(), so we do

	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
			&hctx->run_work, 0);

So ->queue_rq() is being called from a worker thread, not by the calling
thread. Jens' patch 2 makes it so that a driver can request that the
behavior is always as if async were true.

-- 
Omar
