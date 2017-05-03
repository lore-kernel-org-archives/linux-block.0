Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35041 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755859AbdECTTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:15 -0400
Received: by mail-pf0-f180.google.com with SMTP id v14so17047484pfd.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:15 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 5/9] blk-mq: move debugfs declarations to a separate header file
Date: Wed,  3 May 2017 12:18:58 -0700
Message-Id: <44a0e77e2a6eb82e144d24ea1029485316b429bf.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Preparation for adding more declarations.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-debugfs.h | 29 +++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   |  1 +
 block/blk-mq.h         | 28 ----------------------------
 block/blk-sysfs.c      |  1 +
 6 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 block/blk-mq-debugfs.h

diff --git a/block/blk-core.c b/block/blk-core.c
index 24886b69690f..acdca6536562 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -40,6 +40,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 48b9f59acd91..6f98eb15e4f6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -21,6 +21,7 @@
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
 struct blk_mq_debugfs_attr {
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
new file mode 100644
index 000000000000..00b0f71d0ae9
--- /dev/null
+++ b/block/blk-mq-debugfs.h
@@ -0,0 +1,29 @@
+#ifndef INT_BLK_MQ_DEBUGFS_H
+#define INT_BLK_MQ_DEBUGFS_H
+
+#ifdef CONFIG_BLK_DEBUG_FS
+int blk_mq_debugfs_register(struct request_queue *q);
+void blk_mq_debugfs_unregister(struct request_queue *q);
+int blk_mq_debugfs_register_mq(struct request_queue *q);
+void blk_mq_debugfs_unregister_mq(struct request_queue *q);
+#else
+static inline int blk_mq_debugfs_register(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister(struct request_queue *q)
+{
+}
+
+static inline int blk_mq_debugfs_register_mq(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister_mq(struct request_queue *q)
+{
+}
+#endif
+
+#endif
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ec0afdf765e3..71a237a90d43 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -11,6 +11,7 @@
 
 #include <linux/blk-mq.h>
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2814a14e529c..cc67b48e3551 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -83,34 +83,6 @@ extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
-/*
- * debugfs helpers
- */
-#ifdef CONFIG_BLK_DEBUG_FS
-int blk_mq_debugfs_register(struct request_queue *q);
-void blk_mq_debugfs_unregister(struct request_queue *q);
-int blk_mq_debugfs_register_mq(struct request_queue *q);
-void blk_mq_debugfs_unregister_mq(struct request_queue *q);
-#else
-static inline int blk_mq_debugfs_register(struct request_queue *q)
-{
-	return 0;
-}
-
-static inline void blk_mq_debugfs_unregister(struct request_queue *q)
-{
-}
-
-static inline int blk_mq_debugfs_register_mq(struct request_queue *q)
-{
-	return 0;
-}
-
-static inline void blk_mq_debugfs_unregister_mq(struct request_queue *q)
-{
-}
-#endif
-
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
 void blk_mq_release(struct request_queue *q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3f37813ccbaf..9995355121d7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -13,6 +13,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-wbt.h"
 
 struct queue_sysfs_entry {
-- 
2.12.2
