Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Fri, 21 Apr 2017 16:40:21 -0700
Message-ID: <20170421234026.18970-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170421234026.18970-1-bart.vanassche@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

One of the debugfs attributes allows to run a queue. Since running
a queue after a queue has entered the "dead" state is not allowed
and even can cause a kernel crash, unregister the debugfs attributes
before a queue reaches the "dead" state.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a49b0830aaaf..33c91a4bee97 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_queue *q)
 	spin_lock_irq(lock);
 	if (!q->mq_ops)
 		__blk_drain_queue(q, true);
+	spin_unlock_irq(lock);
+
+	blk_mq_debugfs_unregister_mq(q);
+
+	spin_lock_irq(lock);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
-- 
2.12.2
