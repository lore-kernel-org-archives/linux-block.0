Return-Path: <prvs=540be3476=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH, resend] blk-mq: Fix spelling in a source code comment
Date: Tue,  9 Jan 2018 10:09:15 -0800
Message-Id: <20180109180915.14545-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Change "nedeing" into "needing" and "caes" into "cases".

Fixes: commit f906a6a0f426 ("blk-mq: improve tag waiting setup for non-shared tags")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34d14ab3e68e..fbb3dcf8342e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1104,8 +1104,8 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 
 /*
  * Mark us waiting for a tag. For shared tags, this involves hooking us into
- * the tag wakeups. For non-shared tags, we can simply mark us nedeing a
- * restart. For both caes, take care to check the condition again after
+ * the tag wakeups. For non-shared tags, we can simply mark us needing a
+ * restart. For both cases, take care to check the condition again after
  * marking us as waiting.
  */
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
-- 
2.15.1
