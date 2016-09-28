Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 0/2]: Add option for async ->queue_rq
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
CC: <jbacik@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <acf43ae6-76d5-8dca-548a-30f16d0e0928@sandisk.com>
Date: Tue, 27 Sep 2016 17:25:36 -0700
MIME-Version: 1.0
In-Reply-To: <1474555980-2787-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 09/22/16 07:52, Jens Axboe wrote:
> Two patches that add the ability for a driver to flag itself
> as wanting the ->queue_rq() invoked in a manner that allows
> it to block. We'll need that for the nbd conversion, to avoid
> having to add workqueue offload. We can use this in the current
> loop mq path as well.

Hello Jens,

How can this work since there is code that calls blk_mq_run_hw_queue() 
with a spin lock held? From mq_flush_data_end_io():

	spin_lock_irqsave(&fq->mq_flush_lock, flags);
	if (blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error))
		blk_mq_run_hw_queue(hctx, true);
	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);

Sorry that I hadn't noticed this before.

Bart.
