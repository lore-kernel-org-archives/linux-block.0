Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258CDC31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC092208C2
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560342629;
	bh=ZgUkPIjK5vv5C9bnNgJJj8zoHrtcD1cASc3wnBOslKg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j7+WxtwhirwyyneUa7KBAWuXGcBX1SnVlvJqwKl7IvLlDWd7lE/GZpqbEQgWvTa8M
	 pn34L+baAqHkXzYjs/J7KUOC7mC+AV69AjaiIxfHK0zadI+OCt6r12AHwOWFt+VyAg
	 h7qBFgc0QXIWGFALTBBP3Fh9EOKHQvq5ahgDZJuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407613AbfFLMa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406351AbfFLMa2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 08:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F64F20874;
        Wed, 12 Jun 2019 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342626;
        bh=ZgUkPIjK5vv5C9bnNgJJj8zoHrtcD1cASc3wnBOslKg=;
        h=From:To:Cc:Subject:Date:From;
        b=FFrXJ+8bqcT0XzbRP8ML+s7IPpNGhHexELMoq1K0iJ7GPvng1KuoTR7ddjvFMTNvp
         G5zjdXPlfd1zn5AlyVnnnYIjbY1Hzzh9RRf3xwtifSB0A9XEBz/nW7BsKbJJMPhA04
         5iMEzyH3fOZbOall4yIuFxlzZj2+i0+5RzFwQ13w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     axboe@kernel.dk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:30:19 +0200
Message-Id: <20190612123019.25112-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

When all of these checks are cleaned up, lots of the functions used in
the blk-mq-debugfs code can now return void, as no need to check the
return value of them either.

Overall, this ends up cleaning up the code and making it smaller, always
a nice win.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-debugfs.c | 145 ++++++++++-------------------------------
 block/blk-mq-debugfs.h |  36 +++++-----
 2 files changed, 49 insertions(+), 132 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6aea0ebc3a73..2489ddbb21db 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -821,38 +821,28 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static bool debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	if (IS_ERR_OR_NULL(parent))
-		return false;
+		return;
 
 	d_inode(parent)->i_private = data;
 
-	for (; attr->name; attr++) {
-		if (!debugfs_create_file(attr->name, attr->mode, parent,
-					 (void *)attr, &blk_mq_debugfs_fops))
-			return false;
-	}
-	return true;
+	for (; attr->name; attr++)
+		debugfs_create_file(attr->name, attr->mode, parent,
+				    (void *)attr, &blk_mq_debugfs_fops);
 }
 
-int blk_mq_debugfs_register(struct request_queue *q)
+void blk_mq_debugfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
-	if (!q->debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(q->debugfs_dir, q,
-				  blk_mq_debugfs_queue_attrs))
-		goto err;
+	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
 	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
@@ -864,11 +854,10 @@ int blk_mq_debugfs_register(struct request_queue *q)
 
 	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->debugfs_dir && blk_mq_debugfs_register_hctx(q, hctx))
-			goto err;
-		if (q->elevator && !hctx->sched_debugfs_dir &&
-		    blk_mq_debugfs_register_sched_hctx(q, hctx))
-			goto err;
+		if (!hctx->debugfs_dir)
+			blk_mq_debugfs_register_hctx(q, hctx);
+		if (q->elevator && !hctx->sched_debugfs_dir)
+			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
 	if (q->rq_qos) {
@@ -879,12 +868,6 @@ int blk_mq_debugfs_register(struct request_queue *q)
 			rqos = rqos->next;
 		}
 	}
-
-	return 0;
-
-err:
-	blk_mq_debugfs_unregister(q);
-	return -ENOMEM;
 }
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
@@ -894,52 +877,32 @@ void blk_mq_debugfs_unregister(struct request_queue *q)
 	q->debugfs_dir = NULL;
 }
 
-static int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
-				       struct blk_mq_ctx *ctx)
+static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+					struct blk_mq_ctx *ctx)
 {
 	struct dentry *ctx_dir;
 	char name[20];
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
-	if (!ctx_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs))
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
 }
 
-int blk_mq_debugfs_register_hctx(struct request_queue *q,
-				 struct blk_mq_hw_ctx *hctx)
+void blk_mq_debugfs_register_hctx(struct request_queue *q,
+				  struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_ctx *ctx;
 	char name[20];
 	int i;
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
-	if (!hctx->debugfs_dir)
-		return -ENOMEM;
-
-	if (!debugfs_create_files(hctx->debugfs_dir, hctx,
-				  blk_mq_debugfs_hctx_attrs))
-		goto err;
-
-	hctx_for_each_ctx(hctx, ctx, i) {
-		if (blk_mq_debugfs_register_ctx(hctx, ctx))
-			goto err;
-	}
 
-	return 0;
+	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
 
-err:
-	blk_mq_debugfs_unregister_hctx(hctx);
-	return -ENOMEM;
+	hctx_for_each_ctx(hctx, ctx, i)
+		blk_mq_debugfs_register_ctx(hctx, ctx);
 }
 
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
@@ -949,17 +912,13 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 	hctx->debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (blk_mq_debugfs_register_hctx(q, hctx))
-			return -ENOMEM;
-	}
-
-	return 0;
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_debugfs_register_hctx(q, hctx);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
@@ -971,29 +930,16 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 		blk_mq_debugfs_unregister_hctx(hctx);
 }
 
-int blk_mq_debugfs_register_sched(struct request_queue *q)
+void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 	struct elevator_type *e = q->elevator->type;
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
 	if (!e->queue_debugfs_attrs)
-		return 0;
+		return;
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
-	if (!q->sched_debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(q->sched_debugfs_dir, q,
-				  e->queue_debugfs_attrs))
-		goto err;
-
-	return 0;
-
-err:
-	blk_mq_debugfs_unregister_sched(q);
-	return -ENOMEM;
+	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -1008,36 +954,22 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	rqos->debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
-		return 0;
+		return;
 
-	if (!q->rqos_debugfs_dir) {
+	if (!q->rqos_debugfs_dir)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
-		if (!q->rqos_debugfs_dir)
-			return -ENOMEM;
-	}
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name,
 					       rqos->q->rqos_debugfs_dir);
-	if (!rqos->debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(rqos->debugfs_dir, rqos,
-				  rqos->ops->debugfs_attrs))
-		goto err;
-	return 0;
- err:
-	blk_mq_debugfs_unregister_rqos(rqos);
-	return -ENOMEM;
+	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
@@ -1046,27 +978,18 @@ void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
 	q->rqos_debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
-				       struct blk_mq_hw_ctx *hctx)
+void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+					struct blk_mq_hw_ctx *hctx)
 {
 	struct elevator_type *e = q->elevator->type;
 
-	if (!hctx->debugfs_dir)
-		return -ENOENT;
-
 	if (!e->hctx_debugfs_attrs)
-		return 0;
+		return;
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	if (!hctx->sched_debugfs_dir)
-		return -ENOMEM;
-
-	if (!debugfs_create_files(hctx->sched_debugfs_dir, hctx,
-				  e->hctx_debugfs_attrs))
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+			     e->hctx_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 8c9012a578c1..a68aa6041a10 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -18,74 +18,68 @@ struct blk_mq_debugfs_attr {
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
-int blk_mq_debugfs_register(struct request_queue *q);
+void blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
-int blk_mq_debugfs_register_hctx(struct request_queue *q,
-				 struct blk_mq_hw_ctx *hctx);
+void blk_mq_debugfs_register_hctx(struct request_queue *q,
+				  struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
-int blk_mq_debugfs_register_hctxs(struct request_queue *q);
+void blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
 
-int blk_mq_debugfs_register_sched(struct request_queue *q);
+void blk_mq_debugfs_register_sched(struct request_queue *q);
 void blk_mq_debugfs_unregister_sched(struct request_queue *q);
-int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
 #else
-static inline int blk_mq_debugfs_register(struct request_queue *q)
+static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_hctx(struct request_queue *q,
-					       struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_debugfs_register_hctx(struct request_queue *q,
+						struct blk_mq_hw_ctx *hctx)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
 }
 
-static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+static inline void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_sched(struct request_queue *q)
+static inline void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
-						     struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+						      struct blk_mq_hw_ctx *hctx)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
 }
 
-static inline int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-- 
2.22.0

