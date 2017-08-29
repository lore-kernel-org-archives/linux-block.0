Return-Path: <prvs=407911b14=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/2] skd: Remove blk_queue_bounce_limit() call
Date: Tue, 29 Aug 2017 08:32:09 -0700
Message-Id: <20170829153211.6257-2-bart.vanassche@wdc.com>
In-Reply-To: <20170829153211.6257-1-bart.vanassche@wdc.com>
References: <20170829153211.6257-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since sTec s1120 devices support 64-bit DMA it is not necessary
to request data buffer bouncing. Hence remove the
blk_queue_bounce_limit() call.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 00a86252b3c5..f987ff601a4c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2844,7 +2844,6 @@ static int skd_cons_disk(struct skd_device *skdev)
 		rc = PTR_ERR(q);
 		goto err_out;
 	}
-	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 	q->queuedata = skdev;
 	q->nr_requests = skd_max_queue_depth / 2;
 
-- 
2.14.1
