Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] block: fix a typo in comment of BLK_MQ_POLL_STATS_BKTS
Date: Thu, 15 Feb 2018 23:53:17 +0900
Message-Id: <1518706397-16116-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Update comment typo _consisitent_ to _consistent_ from following commit.
commit 0206319fdfee ("blk-mq: Fix poll_stat for new size-based bucketing.")

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f3df80..ed63f3b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -49,7 +49,7 @@ struct blk_stat_callback;
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
 
-/* Must be consisitent with blk_mq_poll_stats_bkt() */
+/* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
 
 /*
-- 
2.7.4
