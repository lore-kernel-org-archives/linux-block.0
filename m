Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V5] blk-mq: dequeue request one by one from sw queue iff
 hctx is busy
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20180703145845.18140-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b208e0a1-0a41-654e-aad8-fb4a7df2967a@kernel.dk>
Date: Tue, 3 Jul 2018 09:04:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180703145845.18140-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 8:58 AM, Ming Lei wrote:
> It won't be efficient to dequeue request one by one from sw queue,
> but we have to do that when queue is busy for better merge performance.
> 
> This patch takes the Exponential Weighted Moving Average(EWMA) to figure
> out if queue is busy, then only dequeue request one by one from sw queue
> when queue is busy.

Applied, thanks.

-- 
Jens Axboe
