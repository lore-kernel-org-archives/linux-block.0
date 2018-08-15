Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd.c: Fix wrong return code when alloc_disk() fails.
To: Jiecheng Wu <jasonwood2031@gmail.com>, linux-block@vger.kernel.org
References: <20180815032251.32136-1-jasonwood2031@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ba791a1-674a-89a5-74f3-9b9cd7eb6fb6@kernel.dk>
Date: Wed, 15 Aug 2018 08:22:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180815032251.32136-1-jasonwood2031@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/14/18 9:22 PM, Jiecheng Wu wrote:
> Function pkt_setup_dev() defined in drivers/block/pktcdvd.c calls
> alloc_disk(). However, it forgets to set the error return code when
> alloc_disk() fails. Instead, when alloc_disk() fails, it simply jumps
> to label 'out_mem' leaving the variable ret unchanged.

We do init it to -ENOMEM, the problem is that
mempool_init_kmalloc_pool() overwrites it, and any unset jump to error
out after that won't work so well.

So your fix isn't complete, since it won't catch blk_alloc_queue()
failure. The below should do it.


diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index e285413d4a75..6f1d25c1eb64 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2740,6 +2740,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	pd->write_congestion_on  = write_congestion_on;
 	pd->write_congestion_off = write_congestion_off;
 
+	ret = -ENOMEM;
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out_mem;

-- 
Jens Axboe
