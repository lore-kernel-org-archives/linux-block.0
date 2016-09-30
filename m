Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933652AbcI3NXv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:51 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 7/8] blk-mq: Pair blk_mq_hctx_kobj_init() with blk_mq_hctx_kobj_put()
Date: Fri, 30 Sep 2016 15:23:29 +0200
Message-Id: <ae5b727341240a974b6b2cbd91b98eb85f9aef53.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq-sysfs.c | 5 +++++
 block/blk-mq.c       | 2 +-
 block/blk-mq.h       | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 01fb455..11846d0 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -429,6 +429,11 @@ void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
 }
 
+void blk_mq_hctx_kobj_put(struct blk_mq_hw_ctx *hctx)
+{
+	kobject_put(&hctx->kobj);
+}
+
 static void blk_mq_sysfs_init(struct request_queue *q)
 {
 	struct blk_mq_ctx *ctx;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b07901..78ee5af 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1928,7 +1928,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			continue;
 
 		hctxs[i] = NULL;
-		kobject_put(&hctx->kobj);
+		blk_mq_hctx_kobj_put(hctx);
 
 		if (hctx->tags) {
 			blk_mq_free_rq_map(set, hctx->tags, j);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e5d2524..3d53818 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -53,6 +53,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
+extern void blk_mq_hctx_kobj_put(struct blk_mq_hw_ctx *hctx);
 
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
-- 
1.8.3.1

