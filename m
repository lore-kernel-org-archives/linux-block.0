Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v4 04/10] blk-mq: Check blk_mq_debugfs_register() return value
Date: Fri, 21 Apr 2017 16:40:20 -0700
Message-ID: <20170421234026.18970-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170421234026.18970-1-bart.vanassche@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Make __blk_mq_register_dev() check the blk_mq_debugfs_register()
return value. In the error path, only unregister hctxs for which
registration succeeded.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-sysfs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index c2cac20d981d..5f66a7798878 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -318,21 +318,32 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
-	blk_mq_debugfs_register(q);
+	ret = blk_mq_debugfs_register(q);
+	if (ret)
+		goto remove;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
-			break;
+			goto unreg;
 	}
 
-	if (ret)
-		__blk_mq_unregister_dev(dev, q);
-	else
-		q->mq_sysfs_init_done = true;
+	q->mq_sysfs_init_done = true;
 
 out:
 	return ret;
+
+unreg:
+	while (--i >= 0)
+		blk_mq_unregister_hctx(hctx);
+
+	blk_mq_debugfs_unregister_mq(q);
+
+remove:
+	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(&q->mq_kobj);
+	kobject_put(&dev->kobj);
+	goto out;
 }
 
 int blk_mq_register_dev(struct device *dev, struct request_queue *q)
-- 
2.12.2
