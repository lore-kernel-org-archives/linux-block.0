Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81EC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4562086B
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o5ezbQOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4562086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK3NQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:16:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36900 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 08:16:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1993397plr.4
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 18:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=odmvZyi0KptFzu1QUlvsbpJDbVDM8QUjnZ4hh/BdI+Q=;
        b=o5ezbQOWSdoIStRukPJd3/0ITKV2cM8msU1f0l6pBiyagZhAh1IVYRGluo7X3PUQNf
         NkmkwXV1+vkJZ5c3XV/XMNBrVSEOcFqMquh0muJedQEEhb/5tW67ULuF26lONAV0xFT6
         qiKhr3WfGDMyR0QTjAHtu/U1MLbBmqlrrxd2WeXnTZWhfqCq4Jo7xcwVq0ghxYS+roAO
         KoV0WGfYXvxEM0O0suwwtTP08kvvmIt/LZgC3B68ZXdWc55aYzo9sRtvOoBSw0r2gGg1
         Qr12jPp1wUwU2h2IuUC7bi9kqmKEz8pOVFH3TcjWP4Yyw68hVX+m8xYS4vTvLphd3Mo6
         suJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=odmvZyi0KptFzu1QUlvsbpJDbVDM8QUjnZ4hh/BdI+Q=;
        b=crhhkOKWRdvZKIEgo8o1Yc84Qe2D0io3hx/NxHJsVFNUWWod3rGaNOF3tbFtZiUORk
         a8EoK+H9WomRThfgmTJu2b5ftSQAOKaQEte1xUlNef2tpxSC6km8DEHbTu2LVROBMPfY
         59ACGhVWqMSSo4Akc5uNM+la5E6ELNlzVmzuYTvREqeQn1sBwnxc/OhZJYgamGVmT/WJ
         GThigCbLExkSEAZkHDm1iXwZEn4HJ1GmZJ3hqcRFfL4AZ7ruJrJEd6Pr5UGG/lTwJKsd
         bdJCNbwqq5yHWlpmSp9yAOM5lHVPFjJxHURgggEVVgAiP/B2QfzqipdWGvJDDQNVIgkD
         gVeg==
X-Gm-Message-State: AA+aEWb22mhbAxYSIwCyNDVIKqaTjn06FH+hKcnVl2bE/CSWrptDM2Ks
        alY2csd9Q2V33NDFcmE2P1b6LKRKGSA=
X-Google-Smtp-Source: AFSGD/VZp6QlNIWxe5JPYISFNcdYheNdOpICDdoWHON/dlCaAAIF/HSIfBluxJqXf0SY26tuwlUlWA==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr3847189plt.304.1543543756482;
        Thu, 29 Nov 2018 18:09:16 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d16sm3711612pgj.21.2018.11.29.18.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:09:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] sbitmap: optimize wakeup check
Date:   Thu, 29 Nov 2018 19:09:08 -0700
Message-Id: <20181130020908.7325-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130020908.7325-1-axboe@kernel.dk>
References: <20181130020908.7325-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even if we have no waiters on any of the sbitmap_queue wait states, we
still have to loop every entry to check. We do this for every IO, so
the cost adds up.

Shift a bit of the cost to the slow path, when we actually have waiters.
Wrap prepare_to_wait_exclusive() and finish_wait(), so we can maintain
an internal count of how many are currently active. Then we can simply
check this count in sbq_wake_ptr() and not have to loop if we don't
have any sleepers.

Convert the two users of sbitmap with waiting, blk-mq-tag and iSCSI.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c                       | 13 ++++++-------
 drivers/target/iscsi/iscsi_target_util.c |  9 ++++++---
 include/linux/sbitmap.h                  | 19 +++++++++++++++++++
 lib/sbitmap.c                            | 21 +++++++++++++++++++++
 4 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 87bc5df72d48..4704046ce493 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -154,12 +154,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
-		prepare_to_wait_exclusive(&ws->wait, &wait,
-						TASK_UNINTERRUPTIBLE);
+		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
-		if (tag != -1)
+		if (tag != -1) {
+			sbitmap_finish_wait(bt, ws, &wait);
 			break;
+		}
 
 		if (data->ctx)
 			blk_mq_put_ctx(data->ctx);
@@ -167,6 +168,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		bt_prev = bt;
 		io_schedule();
 
+		sbitmap_finish_wait(bt, ws, &wait);
+
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
 						data->ctx->cpu);
@@ -176,8 +179,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		else
 			bt = &tags->bitmap_tags;
 
-		finish_wait(&ws->wait, &wait);
-
 		/*
 		 * If destination hw queue is changed, fake wake up on
 		 * previous queue for compensating the wake up miss, so
@@ -192,8 +193,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (drop_ctx && data->ctx)
 		blk_mq_put_ctx(data->ctx);
 
-	finish_wait(&ws->wait, &wait);
-
 found_tag:
 	return tag + tag_offset;
 }
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 36b742932c72..37db1f80a219 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -152,22 +152,25 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
 	int tag = -1;
 	DEFINE_WAIT(wait);
 	struct sbq_wait_state *ws;
+	struct sbitmap_queue *sbq;
 
 	if (state == TASK_RUNNING)
 		return tag;
 
-	ws = &se_sess->sess_tag_pool.ws[0];
+	sbq = &se_sess->sess_tag_pool;
+	ws = &sbq->ws[0];
 	for (;;) {
-		prepare_to_wait_exclusive(&ws->wait, &wait, state);
+		sbitmap_prepare_to_wait(sbq, ws, &wait, state);
 		if (signal_pending_state(state, current))
 			break;
 		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
 		if (tag >= 0)
 			break;
 		schedule();
+		sbitmap_finish_wait(sbq, ws, &wait);
 	}
+	sbitmap_finish_wait(sbq, ws, &wait);
 
-	finish_wait(&ws->wait, &wait);
 	return tag;
 }
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index cec685b89998..a65d5b67a611 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -130,6 +130,11 @@ struct sbitmap_queue {
 	 */
 	struct sbq_wait_state *ws;
 
+	/*
+	 * @ws_active: count of currently active ws waitqueues
+	 */
+	atomic_t ws_active;
+
 	/**
 	 * @round_robin: Allocate bits in strict round-robin order.
 	 */
@@ -549,4 +554,18 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
  */
 void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
 
+/*
+ * Wrapper around prepare_to_wait_exclusive(), which maintains some extra
+ * internal state.
+ */
+void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
+				struct sbq_wait_state *ws,
+				struct wait_queue_entry *wait, int state);
+
+/*
+ * Must be paired with sbitmap_prepare_to_wait().
+ */
+void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
+				struct wait_queue_entry *wait);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2316f53f3e1d..ba51f538011a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -381,6 +381,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
+	atomic_set(&sbq->ws_active, 0);
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -496,6 +497,9 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
 
+	if (!atomic_read(&sbq->ws_active))
+		return NULL;
+
 	wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
@@ -636,3 +640,20 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	seq_printf(m, "min_shallow_depth=%u\n", sbq->min_shallow_depth);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_show);
+
+void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
+			     struct sbq_wait_state *ws,
+			     struct wait_queue_entry *wait, int state)
+{
+	atomic_inc(&sbq->ws_active);
+	prepare_to_wait_exclusive(&ws->wait, wait, state);
+}
+EXPORT_SYMBOL_GPL(sbitmap_prepare_to_wait);
+
+void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
+			 struct wait_queue_entry *wait)
+{
+	finish_wait(&ws->wait, wait);
+	atomic_dec(&sbq->ws_active);
+}
+EXPORT_SYMBOL_GPL(sbitmap_finish_wait);
-- 
2.17.1

