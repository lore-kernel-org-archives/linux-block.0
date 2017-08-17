Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 39/55] skd: Convert explicit skd_request_fn() calls
Date: Thu, 17 Aug 2017 13:13:22 -0700
Message-Id: <20170817201338.16537-40-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This will make it easier to convert this driver to the blk-mq
approach. This patch also reduces interrupt latency by moving
skd_request_fn() calls out of the skd_isr() interrupt.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 8040500ba09c..3db89707b227 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2806,7 +2806,7 @@ static void skd_completion_worker(struct work_struct *work)
 	 * process everything in compq
 	 */
 	skd_isr_completion_posted(skdev, 0, &flush_enqueued);
-	skd_request_fn(skdev->queue);
+	blk_run_queue_async(skdev->queue);
 
 	spin_unlock_irqrestore(&skdev->lock, flags);
 }
@@ -2882,12 +2882,12 @@ skd_isr(int irq, void *ptr)
 	}
 
 	if (unlikely(flush_enqueued))
-		skd_request_fn(skdev->queue);
+		blk_run_queue_async(skdev->queue);
 
 	if (deferred)
 		schedule_work(&skdev->completion_worker);
 	else if (!flush_enqueued)
-		skd_request_fn(skdev->queue);
+		blk_run_queue_async(skdev->queue);
 
 	spin_unlock(&skdev->lock);
 
@@ -3588,12 +3588,12 @@ static irqreturn_t skd_comp_q(int irq, void *skd_host_data)
 	deferred = skd_isr_completion_posted(skdev, skd_isr_comp_limit,
 						&flush_enqueued);
 	if (flush_enqueued)
-		skd_request_fn(skdev->queue);
+		blk_run_queue_async(skdev->queue);
 
 	if (deferred)
 		schedule_work(&skdev->completion_worker);
 	else if (!flush_enqueued)
-		skd_request_fn(skdev->queue);
+		blk_run_queue_async(skdev->queue);
 
 	spin_unlock_irqrestore(&skdev->lock, flags);
 
-- 
2.14.0
