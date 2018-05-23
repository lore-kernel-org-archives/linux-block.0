Return-Path: <ming.lei@redhat.com>
Date: Wed, 23 May 2018 08:22:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
Message-ID: <20180523002254.GB31196@ming.t460p>
References: <20180519074406.6045-1-ming.lei@redhat.com>
 <9ea0bf13-8891-0214-d735-2088827b2937@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ea0bf13-8891-0214-d735-2088827b2937@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 02:20:37PM -0600, Jens Axboe wrote:
> On 5/19/18 1:44 AM, Ming Lei wrote:
> > When the allocation process is scheduled back and the mapped hw queue is
> > changed, do one extra wake up on orignal queue for compensating wake up
> > miss, so other allocations on the orignal queue won't be starved.
> > 
> > This patch fixes one request allocation hang issue, which can be
> > triggered easily in case of very low nr_request.
> 
> Can you explain what the actual bug is? The commit message doesn't
> really say, it just explains what the code change does. What wake up
> miss?

For example:

1) one request queue has 2 queues, and queue depth is low, so wake_batch
is set 1 or very small.

2) There are 2 allocations which are blocked on hw queue 0, now the last
request mapped to hw queue 0 is completed, then sbq_wake_up() wakes only
one of 2 blockers.

3) the waken up allocation process is migrated to another CPU, and its
hw queue becomes mapped to hw queue 1, and this allocation is switched
to hw queue 1

4) so there isn't any chance for another blocked allocation to move one,
since all request in hw queue 0 has been completed. That is why I call
it wake up miss.

BTW, this issue can be reproduced reliably by the block/020 I posted
yesterday:

https://marc.info/?l=linux-block&m=152698758418536&w=2

Thanks,
Ming
