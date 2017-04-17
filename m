Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v2 2/8] blk-mq: Let blk_mq_debugfs_register() look up the queue name
Date: Mon, 17 Apr 2017 09:56:45 -0700
Message-ID: <20170417165651.12693-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170417165651.12693-1-bart.vanassche@sandisk.com>
References: <20170417165651.12693-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

A later patch will move the call of blk_mq_debugfs_register() to
a function to which the queue name is not passed as an argument.
To avoid having to add a 'name' argument to multiple callers, let
blk_mq_debugfs_register() look up the queue name.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 5 +++--
 block/blk-mq-sysfs.c   | 2 +-
 block/blk-mq.h         | 5 ++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index df9b688b877c..2a5d6d83d57c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -782,12 +782,13 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-int blk_mq_debugfs_register(struct request_queue *q, const char *name)
+int blk_mq_debugfs_register(struct request_queue *q)
 {
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
-	q->debugfs_dir = debugfs_create_dir(name, blk_debugfs_root);
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
 	if (!q->debugfs_dir)
 		goto err;
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index dc547369c875..34a594470fc5 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -318,7 +318,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
-	blk_mq_debugfs_register(q, kobject_name(&dev->kobj));
+	blk_mq_debugfs_register(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 7d955c756810..9049c0f11505 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -87,13 +87,12 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
  * debugfs helpers
  */
 #ifdef CONFIG_BLK_DEBUG_FS
-int blk_mq_debugfs_register(struct request_queue *q, const char *name);
+int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
 int blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
 #else
-static inline int blk_mq_debugfs_register(struct request_queue *q,
-					  const char *name)
+static inline int blk_mq_debugfs_register(struct request_queue *q)
 {
 	return 0;
 }
-- 
2.12.2
