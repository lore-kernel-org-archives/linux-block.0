Return-Path: <axboe@kernel.dk>
Date: Sat, 24 Feb 2018 15:56:20 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Omar Sandoval <osandov@fb.com>, oleksandr@natalenko.name,
	holger@applied-asynchrony.com
Subject: Re: [PATCH 0/2] blk-mq: kyber: fix domain token leak during requeue
Message-ID: <20180224225617.GA6452@kernel.dk>
References: <20180223153657.17376-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223153657.17376-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 23 2018, Ming Lei wrote:
> Hi,
> 
> This two patch fixes domain token leak on kyber scheduler, and actually
> fixes one IO hang issue.
> 
> Thanks,
> 
> Ming Lei (2):
>   blk-mq: don't call io sched's .requeue_request when requeueing rq to
>     ->dispatch
>   block: kyber: fix domain token leak during requeue

Applied, thanks.

-- 
Jens Axboe
