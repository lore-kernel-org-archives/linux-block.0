Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 26 Feb 2018 15:41:01 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Omar Sandoval <osandov@fb.com>, oleksandr@natalenko.name,
	holger@applied-asynchrony.com
Subject: Re: [PATCH 0/2] blk-mq: kyber: fix domain token leak during requeue
Message-ID: <20180226234101.GB15264@vader.DHCP.thefacebook.com>
References: <20180223153657.17376-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223153657.17376-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 23, 2018 at 11:36:55PM +0800, Ming Lei wrote:
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
> 
>  block/blk-mq.c        | 4 +++-
>  block/kyber-iosched.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.9.5
> 

I didn't get to add my reviewed-by before Jens queued this up, but
thanks for fixing this, Ming.
