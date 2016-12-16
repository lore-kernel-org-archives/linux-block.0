Return-Path: <riteshh@codeaurora.org>
From: Ritesh Harjani <riteshh@codeaurora.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH] block: Remove unused member (busy) from struct blk_queue_tag
Date: Fri, 16 Dec 2016 10:11:56 +0530
Message-Id: <1481863316-6736-1-git-send-email-riteshh@codeaurora.org>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 286b2a2..8369564 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,7 +288,6 @@ enum blk_queue_state {
 struct blk_queue_tag {
 	struct request **tag_index;	/* map of busy tags */
 	unsigned long *tag_map;		/* bit map of free/busy tags */
-	int busy;			/* current depth */
 	int max_depth;			/* what we will send to device */
 	int real_max_depth;		/* what the array can hold */
 	atomic_t refcnt;		/* map can be shared */
-- 
1.8.2.1
