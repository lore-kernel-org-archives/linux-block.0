Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A9C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0221104
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB0221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeLNLjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:39:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNLjn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 06:39:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 359D530001E3;
        Fri, 14 Dec 2018 11:39:42 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B4935D6B3;
        Fri, 14 Dec 2018 11:39:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] blk-mq-debugfs: support rq_qos
Date:   Fri, 14 Dec 2018 19:39:25 +0800
Message-Id: <20181214113926.7451-2-ming.lei@redhat.com>
In-Reply-To: <20181214113926.7451-1-ming.lei@redhat.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 14 Dec 2018 11:39:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq-debugfs has been proved as very helpful for debug some
tough issues, such as IO hang.

We have seen blk-wbt related IO hang several times, even inside
Red Hat BZ, there is such report not sovled yet, so this patch
adds support debugfs on rq_qos.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h | 17 ++++++++++++++++
 block/blk-rq-qos.c     |  2 ++
 block/blk-rq-qos.h     | 26 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 5 files changed, 100 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a32bb79d6c95..bbcbc2ca0176 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -23,6 +23,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
+#include "blk-rq-qos.h"
 
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
@@ -856,6 +857,15 @@ int blk_mq_debugfs_register(struct request_queue *q)
 			goto err;
 	}
 
+	if (q->rq_qos) {
+		struct rq_qos *rqos = q->rq_qos;
+
+		while (rqos) {
+			blk_mq_debugfs_register_rqos(rqos);
+			rqos = rqos->next;
+		}
+	}
+
 	return 0;
 
 err:
@@ -978,6 +988,50 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
+void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
+{
+	debugfs_remove_recursive(rqos->debugfs_dir);
+	rqos->debugfs_dir = NULL;
+}
+
+int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+	char *dir_name = rq_qos_id_to_name(rqos->id);
+
+	if (!q->debugfs_dir)
+		return -ENOENT;
+
+	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
+		return 0;
+
+	if (!q->rqos_debugfs_dir) {
+		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
+							 q->debugfs_dir);
+		if (!q->rqos_debugfs_dir)
+			return -ENOMEM;
+	}
+
+	rqos->debugfs_dir = debugfs_create_dir(dir_name,
+					       rqos->q->rqos_debugfs_dir);
+	if (!rqos->debugfs_dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_files(rqos->debugfs_dir, rqos,
+				  rqos->ops->debugfs_attrs))
+		goto err;
+	return 0;
+ err:
+	blk_mq_debugfs_unregister_rqos(rqos);
+	return -ENOMEM;
+}
+
+void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->rqos_debugfs_dir);
+	q->rqos_debugfs_dir = NULL;
+}
+
 int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index a9160be12be0..8c9012a578c1 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -31,6 +31,10 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q);
 int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
+
+int blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
+void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
 #else
 static inline int blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -78,6 +82,19 @@ static inline int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
 }
+
+static inline int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
+{
+}
+
+static inline void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
+{
+}
 #endif
 
 #ifdef CONFIG_BLK_DEBUG_FS_ZONED
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e932ef9d2718..d169d7188fa6 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -264,6 +264,8 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
+	blk_mq_debugfs_unregister_queue_rqos(q);
+
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 8678875de420..fd8a0c5debd3 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -7,6 +7,10 @@
 #include <linux/atomic.h>
 #include <linux/wait.h>
 
+#include "blk-mq-debugfs.h"
+
+struct blk_mq_debugfs_attr;
+
 enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_CGROUP,
@@ -22,6 +26,9 @@ struct rq_qos {
 	struct request_queue *q;
 	enum rq_qos_id id;
 	struct rq_qos *next;
+#ifdef CONFIG_BLK_DEBUG_FS
+	struct dentry		*debugfs_dir;
+#endif
 };
 
 struct rq_qos_ops {
@@ -33,6 +40,9 @@ struct rq_qos_ops {
 	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*exit)(struct rq_qos *);
+#ifdef CONFIG_BLK_DEBUG_FS
+	const struct blk_mq_debugfs_attr *debugfs_attrs;
+#endif
 };
 
 struct rq_depth {
@@ -66,6 +76,17 @@ static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 	return rq_qos_id(q, RQ_QOS_CGROUP);
 }
 
+static inline char *rq_qos_id_to_name(enum rq_qos_id id)
+{
+	switch (id) {
+	case RQ_QOS_WBT:
+		return "wbt";
+	case RQ_QOS_CGROUP:
+		return "cgroup";
+	}
+	return "unknown";
+}
+
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
@@ -76,6 +97,9 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
+
+	if (rqos->ops->debugfs_attrs)
+		blk_mq_debugfs_register_rqos(rqos);
 }
 
 static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
@@ -91,6 +115,8 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 		}
 		prev = cur;
 	}
+
+	blk_mq_debugfs_unregister_rqos(rqos);
 }
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 81f1b105946b..45552e6eae1e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -560,6 +560,7 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
+	struct dentry		*rqos_debugfs_dir;
 #endif
 
 	bool			mq_sysfs_init_done;
-- 
2.9.5

