Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v6 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Wed, 26 Apr 2017 13:47:52 -0700
Message-ID: <20170426204757.18910-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170426204757.18910-1-bart.vanassche@sandisk.com>
References: <20170426204757.18910-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

We currently call blk_mq_free_queue() from blk_cleanup_queue()
before we unregister the debugfs attributes for that queue in
blk_release_queue(). This leaves a window open during which
accessing most of the mq debugfs attributes would cause a
use-after-free. Additionally, the "state" attribute allows
running the queue, which we should not do after the queue has
entered the "dead" state. Fix both cases by unregistering the
debugfs attributes before freeing queue resources starts.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a49b0830aaaf..6bd4d1754d29 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -563,9 +563,13 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * prevent that q->request_fn() gets invoked after draining finished.
 	 */
 	blk_freeze_queue(q);
-	spin_lock_irq(lock);
-	if (!q->mq_ops)
+	if (!q->mq_ops) {
+		spin_lock_irq(lock);
 		__blk_drain_queue(q, true);
+	} else {
+		blk_mq_debugfs_unregister_mq(q);
+		spin_lock_irq(lock);
+	}
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
-- 
2.12.2
