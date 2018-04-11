Return-Path: <ming.lei@redhat.com>
Date: Wed, 11 Apr 2018 10:02:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Hang with blk-mq map series (block/008)
Message-ID: <20180411020252.GA4494@ming.t460p>
References: <d4cafa94-919c-e83d-eb91-d10dc06fc515@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d4cafa94-919c-e83d-eb91-d10dc06fc515@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 09:51:41AM -0600, Jens Axboe wrote:
> Hi Ming,
> 
> Ran the above blktests on the current tree, and we end up getting
> a hang that we never recover from. There's on request perpetually
> stuck:
> 
> root@dell:/sys/kernel/debug/block/nvme0n1/hctx2# cat busy 
> 000000005e2b09fe {.op=READ, .cmd_flags=, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=313, .internal_tag=-1}
> 
> and no amount of manual running or kicking the queue will bring it
> back to life. If I run it on 'master', it works fine.
> 
> Did you run blktests on your series?

Not yet.

Will take a look at it, but this seems related with driver, since
the request has been submitted to hardware already.

Thanks,
Ming
