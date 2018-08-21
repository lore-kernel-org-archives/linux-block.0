Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 0/2] fixes for the updating nr_hw_queues
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com,
 keith.busch@linux.intel.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <94238d71-9f39-1378-5f86-9093d0d2cf32@kernel.dk>
Date: Tue, 21 Aug 2018 09:02:33 -0600
MIME-Version: 1.0
In-Reply-To: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/21/18 1:15 AM, Jianchao Wang wrote:
> Hi Jens
> 
> Two fixes for updating nr_hw_queues.
> 
> The first patch fixes the following scenario:
> io scheduler (kyber) depends on the mapping between ctx and hctx.
> When update nr_hw_queues, io scheduler's init_hctx will be
> invoked before the mapping is adapted correctly, this would cause
> panic in kyber.
> 
> The second patch fixes the following scenario:
> part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
> inflight requests. It will access the queue_hw_ctx and nr_hw_queues
> w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
> /rw occur concurrently, panic comes up.

This looks good to me know, I'll queue it up for some testing.

-- 
Jens Axboe
