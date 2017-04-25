Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7775 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950293AbdDYUh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2017 16:37:57 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Tue, 25 Apr 2017 13:37:40 -0700
Message-ID: <20170425203745.19946-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170425203745.19946-1-bart.vanassche@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

One of the debugfs attributes allows to run a queue. Since running
a queue after a queue has entered the "dead" state is not allowed
and triggers a use-after-free, unregister the debugfs attributes
before a queue reaches the "dead" state.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
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
