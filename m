Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 09/10] dm: don't set bounce limit
Date: Mon, 19 Jun 2017 09:26:27 +0200
Message-Id: <20170619072628.12894-10-hch@lst.de>
In-Reply-To: <20170619072628.12894-1-hch@lst.de>
References: <20170619072628.12894-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now all queues allocators come without abounce limit by default,
dm doesn't have to override this anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fbd06b9f9467..402946035308 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1534,7 +1534,6 @@ void dm_init_normal_md_queue(struct mapped_device *md)
 	 * Initialize aspects of queue that aren't relevant for blk-mq
 	 */
 	md->queue->backing_dev_info->congested_fn = dm_any_congested;
-	blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY);
 }
 
 static void cleanup_mapped_device(struct mapped_device *md)
-- 
2.11.0
