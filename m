Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] blk-mq: Fix the comment above blk_mq_quiesce_queue()
Date: Thu, 27 Apr 2017 08:54:33 -0700
Message-ID: <20170427155437.23228-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170427155437.23228-1-bart.vanassche@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The first version of blk_mq_quiesce_queue() that was posted on
the linux-block mailing list waited for ongoing .queue_rq()
calls but did not stop the request queue. The current version
however stops the request queue. Hence reflect this behavior in
the comment above that function.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b3420f76b5a..113c09d8026c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -157,8 +157,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  * @q: request queue.
  *
  * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Additionally, it is not prevented that
- * new queue_rq() calls occur unless the queue has been stopped first.
+ * callback function is invoked.
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-- 
2.12.2
