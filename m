Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88EC65BAE
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A7E2146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="giy0s/Nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A7E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLADLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:11:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36926 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLADLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:11:13 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so4924144ioc.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VD7x+jCHzchNwON0o+zX+xRpZWyqbTARaQb1ekxUQbs=;
        b=giy0s/NjRJhEA0tNsB/3nmF8H/9pVVFPRmwPIk0krSIxqSSXMqdxh1sl5m2Hral1/a
         dq84jSKianSjtuByKS3L0drIuytzzZd4KKekI0xqBVR2gehNPHLXECZTfXnvIIVRa0/N
         SGiAMivHnen5oHes6LVkJLvd2zu860pdD3/u/mOkwvFcTw8LrU2lRUoxjFPZcCVrUfgh
         4Qgs9VNb2Tv2DOLH9yLA7LhGrBSWrYjSP/al+1ghLRciPPmuTtwyz9UoVmf0TAmg9DLx
         0Cd/ks5H0eQSF9x4YREK/n/sZTf0QV8gXx/Kx7nr3TaKeRqwqMy0mMnGawwr+TWdvV1J
         2cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VD7x+jCHzchNwON0o+zX+xRpZWyqbTARaQb1ekxUQbs=;
        b=GVP6ArF2JLSgh+OfACzCsEoJ2GLv0nweDs9StPnj0FMkaa3XxVf38maOc/wo8nqNU4
         GUK7E+s+AiMJZk05RWRKqGgormQbyGbwR1NUMYxET+KttlG8do5+KqiHN2ofiOpXMaYV
         TyDzJTJ0vgUOHvtbUtyxKwn7ZVTpzccl4IYg4fAbhr/JKbAsKzKUUS6TXYSjJTrqXqxF
         J1MLifvit9m+XnSfg1FNXzIifZ40k5eMmnIN1MYESky3oa/KIy6QAJIWRK+Vh7Lo2X/Z
         N7tWEszjELJT7kCScfSLcmQm0/Uhd9uR5+gugzFe/E/viYUsVNLg6wuZUSYStuXJ41pA
         vO+Q==
X-Gm-Message-State: AA+aEWbzjoFho6ONXnX322/t62GTZQAuaJCVe0I3pqgH/lPkr107HC6v
        2Tb8X1tI5MGCXycjFWWJyJfDsBA+rKk=
X-Google-Smtp-Source: AFSGD/VrXf9KUaDmuZbs5sqqddcnqTxLU538UMYaznNjgieFqM8qes/9oIftf8zqx+Fls+o5qjhfhQ==
X-Received: by 2002:a5e:dd01:: with SMTP id t1mr5152163iop.102.1543593684639;
        Fri, 30 Nov 2018 08:01:24 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m11sm2906784itb.24.2018.11.30.08.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:01:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] sbitmap: optimize wakeup check
Date:   Fri, 30 Nov 2018 09:01:18 -0700
Message-Id: <20181130160118.24683-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130160118.24683-1-axboe@kernel.dk>
References: <20181130160118.24683-1-axboe@kernel.dk>
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
 block/blk-mq-tag.c                       | 11 ++++----
 drivers/target/iscsi/iscsi_target_util.c | 12 +++++----
 include/linux/sbitmap.h                  | 34 ++++++++++++++++++++++++
 lib/sbitmap.c                            | 28 +++++++++++++++++++
 4 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 87bc5df72d48..2089c6c62f44 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -110,7 +110,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct sbitmap_queue *bt;
 	struct sbq_wait_state *ws;
-	DEFINE_WAIT(wait);
+	DEFINE_SBQ_WAIT(wait);
 	unsigned int tag_offset;
 	bool drop_ctx;
 	int tag;
@@ -154,8 +154,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
-		prepare_to_wait_exclusive(&ws->wait, &wait,
-						TASK_UNINTERRUPTIBLE);
+		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
 		if (tag != -1)
@@ -167,6 +166,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		bt_prev = bt;
 		io_schedule();
 
+		sbitmap_finish_wait(bt, ws, &wait);
+
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
 						data->ctx->cpu);
@@ -176,8 +177,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		else
 			bt = &tags->bitmap_tags;
 
-		finish_wait(&ws->wait, &wait);
-
 		/*
 		 * If destination hw queue is changed, fake wake up on
 		 * previous queue for compensating the wake up miss, so
@@ -192,7 +191,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (drop_ctx && data->ctx)
 		blk_mq_put_ctx(data->ctx);
 
-	finish_wait(&ws->wait, &wait);
+	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
 	return tag + tag_offset;
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 36b742932c72..86987da86dd6 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -150,24 +150,26 @@ void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
 static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
 {
 	int tag = -1;
-	DEFINE_WAIT(wait);
+	DEFINE_SBQ_WAIT(wait);
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
-		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
+		tag = sbitmap_queue_get(sbq, cpup);
 		if (tag >= 0)
 			break;
 		schedule();
 	}
 
-	finish_wait(&ws->wait, &wait);
+	sbitmap_finish_wait(sbq, ws, &wait);
 	return tag;
 }
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 07f117ee19dc..f0f49bbb2617 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -135,6 +135,11 @@ struct sbitmap_queue {
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
@@ -554,4 +559,33 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
  */
 void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
 
+struct sbq_wait {
+	int accounted;
+	struct wait_queue_entry wait;
+};
+
+#define DEFINE_SBQ_WAIT(name)							\
+	struct sbq_wait name = {						\
+		.accounted = 0,							\
+		.wait = {							\
+			.private	= current,				\
+			.func		= autoremove_wake_function,		\
+			.entry		= LIST_HEAD_INIT((name).wait.entry),	\
+		}								\
+	}
+
+/*
+ * Wrapper around prepare_to_wait_exclusive(), which maintains some extra
+ * internal state.
+ */
+void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
+				struct sbq_wait_state *ws,
+				struct sbq_wait *sbq_wait, int state);
+
+/*
+ * Must be paired with sbitmap_prepare_to_wait().
+ */
+void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
+				struct sbq_wait *sbq_wait);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index f6a9553617bd..90a295cc782c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -395,6 +395,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
+	atomic_set(&sbq->ws_active, 0);
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -510,6 +511,9 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
 
+	if (!atomic_read(&sbq->ws_active))
+		return NULL;
+
 	wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
@@ -635,6 +639,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 
 	seq_printf(m, "wake_batch=%u\n", sbq->wake_batch);
 	seq_printf(m, "wake_index=%d\n", atomic_read(&sbq->wake_index));
+	seq_printf(m, "ws_active=%d\n", atomic_read(&sbq->ws_active));
 
 	seq_puts(m, "ws={\n");
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
@@ -650,3 +655,26 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	seq_printf(m, "min_shallow_depth=%u\n", sbq->min_shallow_depth);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_show);
+
+void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
+			     struct sbq_wait_state *ws,
+			     struct sbq_wait *sbq_wait, int state)
+{
+	if (!sbq_wait->accounted) {
+		atomic_inc(&sbq->ws_active);
+		sbq_wait->accounted = 1;
+	}
+	prepare_to_wait_exclusive(&ws->wait, &sbq_wait->wait, state);
+}
+EXPORT_SYMBOL_GPL(sbitmap_prepare_to_wait);
+
+void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
+			 struct sbq_wait *sbq_wait)
+{
+	finish_wait(&ws->wait, &sbq_wait->wait);
+	if (sbq_wait->accounted) {
+		atomic_dec(&sbq->ws_active);
+		sbq_wait->accounted = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sbitmap_finish_wait);
-- 
2.17.1

