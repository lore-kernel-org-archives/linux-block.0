Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>
References: <20180519074406.6045-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ea0bf13-8891-0214-d735-2088827b2937@kernel.dk>
Date: Tue, 22 May 2018 14:20:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180519074406.6045-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/19/18 1:44 AM, Ming Lei wrote:
> When the allocation process is scheduled back and the mapped hw queue is
> changed, do one extra wake up on orignal queue for compensating wake up
> miss, so other allocations on the orignal queue won't be starved.
> 
> This patch fixes one request allocation hang issue, which can be
> triggered easily in case of very low nr_request.

Can you explain what the actual bug is? The commit message doesn't
really say, it just explains what the code change does. What wake up
miss?

-- 
Jens Axboe
