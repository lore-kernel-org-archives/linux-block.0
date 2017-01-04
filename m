Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Merlin <marc@merlins.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/6] blk-mq: Remove unused variable
Date: Wed,  4 Jan 2017 17:41:11 -0500
Message-Id: <1483569671-1462-7-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0c9a2a3..fae9651 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -916,7 +916,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
 {
 	LIST_HEAD(rq_list);
-	LIST_HEAD(driver_list);
 
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
-- 
2.5.5
