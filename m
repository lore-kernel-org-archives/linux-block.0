Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55080 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756598AbeFOVzX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 17:55:23 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH 4/5] block: Inline blk_queue_nr_zones()
Date: Fri, 15 Jun 2018 14:55:20 -0700
Message-Id: <20180615215521.27435-5-bart.vanassche@wdc.com>
In-Reply-To: <20180615215521.27435-1-bart.vanassche@wdc.com>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the implementation of blk_queue_nr_zones() is trivial and since
it only has a single caller, inline this function.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 2 +-
 include/linux/blkdev.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 67aa2d4e2e89..b92ef4c3038e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -214,7 +214,7 @@ static int queue_zone_wlock_show(void *data, struct seq_file *m)
 	if (!q->seq_zones_wlock)
 		return 0;
 
-	for (i = 0; i < blk_queue_nr_zones(q); i++)
+	for (i = 0; i < q->nr_zones; i++)
 		if (test_bit(i, q->seq_zones_wlock))
 			seq_printf(m, "%u\n", i);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05cd0c8e5735..96640bcd5e78 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -800,11 +800,6 @@ static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
 
-static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
-{
-	return q->nr_zones;
-}
-
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
-- 
2.17.0
