Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D69C04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40A82145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1DCXmHQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40A82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeK3MUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:20:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41430 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeK3MUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:20:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so1914632pfi.8
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 17:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2isTtU6ZW1+uv3+wCp2lDXoJRGJAYdxg3nwsKFtDNI=;
        b=1DCXmHQ8jOcueTJ8+ei63X9WEHVoy50JWYwhXskieIeY0j4vfKtMOackNwm+TyPbhW
         n4WHwkwRuTZyvb8vDOCeqRIfVZawzYlNMv2o46Ld+vlLx/cg0UjiMVYBQFY0yLYwyewg
         acGqmzxFMdHWpuu5JYGaDVfnwanIW39UWHs3UDbbWSWVbRyMiB7Ml8UHryUrLHFmuypD
         usUGIoWXmhAkUyQMNoERK4Bd+pyThGXPpQt4lfnC5YATmcywhYdRP/vp6nkNOEpvB9rg
         gFuxQ3HZC0igLF+Tz2qsIpkyMMP4SjeUCOGZdlhBRcgvvnriGR4uRxlof7gg2bvMJBbk
         3bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2isTtU6ZW1+uv3+wCp2lDXoJRGJAYdxg3nwsKFtDNI=;
        b=cHxv1YK/6pYfmRlZpkmVWkyj0wGITKwJFXks0LBgXoZVfEZrGcYySA2Dazj9xOZqwc
         wUge4N5T27zFjMd+7HB42Scx3/q2R9Q6gHJS6xo+o/0ln/sYuabJO3Lpgev/4aRzTi3E
         5mpvsYxRa1eSVSVL3hV+05pwnsdC2laiRQvhe7bfgB/8D7DS0sd1k3gEObhASVxCsdaB
         aXYLOVCzlkX4Sx8Olg2e8P2AoPvnqmY0RuAAwJqYoAzwvzmglV3DL03T3cfqUAQ+aine
         GoJSsSZTVSIbHmXjbvX0ReVrDFaPIXCUbRKpa0OPYen8npmQJ5RuOhXMRNLeLXPchfDM
         qTJA==
X-Gm-Message-State: AA+aEWbJyhns9X775Z74wd+7B1DcwExVeVS6mG0MbMXNEiIflmw34gl8
        +/pTrGqy/FXu/5LwBsZJ/3wKxV3d02E=
X-Google-Smtp-Source: AFSGD/VRH5oWhOJ5x/hs7R5Me7UD1EXay0Pg5Un8olN5J9633ptm9RWNy5gFdxIHBf/HZWdz127rgQ==
X-Received: by 2002:a62:5793:: with SMTP id i19mr3679449pfj.49.1543540364222;
        Thu, 29 Nov 2018 17:12:44 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm4841749pfn.94.2018.11.29.17.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:12:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] sbitmap: optimize wakeup check
Date:   Thu, 29 Nov 2018 18:12:34 -0700
Message-Id: <20181130011234.32674-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130011234.32674-1-axboe@kernel.dk>
References: <20181130011234.32674-1-axboe@kernel.dk>
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
 block/blk-mq-tag.c                       |  7 +++----
 drivers/target/iscsi/iscsi_target_util.c |  8 +++++---
 include/linux/sbitmap.h                  | 19 +++++++++++++++++++
 lib/sbitmap.c                            | 21 +++++++++++++++++++++
 4 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 87bc5df72d48..66c3a1c887ed 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
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
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 36b742932c72..d7d03d601732 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -152,13 +152,15 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
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
@@ -167,7 +169,7 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
 		schedule();
 	}
 
-	finish_wait(&ws->wait, &wait);
+	sbitmap_finish_wait(sbq, ws, &wait);
 	return tag;
 }
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 13eb8973bd10..dbfbac0c4daa 100644
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
@@ -554,4 +559,18 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
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
index 04db31f4dfda..1cc21f916276 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -384,6 +384,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
+	atomic_set(&sbq->ws_active, 0);
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -499,6 +500,9 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
 
+	if (!atomic_read(&sbq->ws_active))
+		return NULL;
+
 	wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
@@ -639,3 +643,20 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
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

