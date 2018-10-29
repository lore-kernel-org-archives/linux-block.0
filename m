Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/29] blk-wbt: kill check for legacy queue type
Date: Mon, 29 Oct 2018 10:34:31 -0600
Message-Id: <20181029163444.9940-17-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Everything is blk-mq at this point, so it doesn't make any sense
to have this option available as it does nothing.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/Kconfig   | 6 ------
 block/blk-wbt.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index f7045aa47edb..8044452a4fd3 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -155,12 +155,6 @@ config BLK_CGROUP_IOLATENCY
 
 	Note, this is an experimental interface and could be changed someday.
 
-config BLK_WBT_SQ
-	bool "Single queue writeback throttling"
-	depends on BLK_WBT
-	---help---
-	Enable writeback throttling by default on legacy single queue devices
-
 config BLK_WBT_MQ
 	bool "Multiqueue writeback throttling"
 	default y
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8ac93fcbaa2e..0fc222d4194b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -709,8 +709,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
 		return;
 
-	if ((q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ)) ||
-	    (q->request_fn && IS_ENABLED(CONFIG_BLK_WBT_SQ)))
+	if (q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ))
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
-- 
2.17.1
