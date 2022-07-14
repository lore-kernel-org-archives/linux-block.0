Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A516C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiGNSHt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiGNSHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:48 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B483C58842
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:47 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id q5so1118926plr.11
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiX+JVcdyXyr2e823lT6fC9ehPzJoZGJfGMo/fvzh5s=;
        b=blqlD3XiSVyfWorsGFlIbhdyFqGTPLfKJjb6ba3y/qjTGHhvfbuQ0v0/pEIQ+b6iWG
         EpccdS2KXxN+e1lPhkdlnY8NA+WetlUlHiy76M90Vs7UFeD42kuSm3qIcmM9MhY3p7lG
         5OSp4LVscW6KQdr5eXWTyiBXz+VaOS2weXRBF1JyN19MOskFzOTd8mPj+j+lL5TEh4LG
         9fEUu1KjNrENngYO0riflZ45r/Mrd0dfzxI2PpTM767Rf14KXoCBYQbNqn48nQ3Vb/2O
         XrPFmR92ITl0mwYL1eggeoVYPzRXnFLiD1rNDQxsgo24B5yil5dER8uGOH7653cGlDg5
         bTIA==
X-Gm-Message-State: AJIora8iYAPM87RobJxtJYuwDxRKQ20S8pcHypJdVO+nCymOHkj6R/oW
        L9n3VPoD7UX1cIV0gS215wSqqJCT/4I=
X-Google-Smtp-Source: AGRyM1sMy943Lw70W0VvLpqcS98FaONPFfA4iAMWJoK3S69v4aq5MFZYx4RzVaIeUc4i5GkpzpniYg==
X-Received: by 2002:a17:90a:e008:b0:1ef:831a:1fff with SMTP id u8-20020a17090ae00800b001ef831a1fffmr17048904pjy.221.1657822067077;
        Thu, 14 Jul 2022 11:07:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 07/63] block/bfq: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:33 -0700
Message-Id: <20220714180729.1065367-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments and variables that represent
request flags or a bitwise combination of a request operation and
request flags. Rename those variables from 'op' into 'opf'.

This patch does not change any functionality.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c  | 26 +++++++++++++-------------
 block/bfq-iosched.c | 16 ++++++++--------
 block/bfq-iosched.h |  8 ++++----
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fc605791b1e..30b15a9a47c4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -220,46 +220,46 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
 }
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op)
+			      blk_opf_t opf)
 {
-	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
+	blkg_rwstat_add(&bfqg->stats.queued, opf, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
 	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf)
 {
-	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
+	blkg_rwstat_add(&bfqg->stats.queued, opf, -1);
 }
 
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf)
 {
-	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
+	blkg_rwstat_add(&bfqg->stats.merged, opf, 1);
 }
 
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op)
+				  u64 io_start_time_ns, blk_opf_t opf)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 	u64 now = ktime_get_ns();
 
 	if (now > io_start_time_ns)
-		blkg_rwstat_add(&stats->service_time, op,
+		blkg_rwstat_add(&stats->service_time, opf,
 				now - io_start_time_ns);
 	if (io_start_time_ns > start_time_ns)
-		blkg_rwstat_add(&stats->wait_time, op,
+		blkg_rwstat_add(&stats->wait_time, opf,
 				io_start_time_ns - start_time_ns);
 }
 
 #else /* CONFIG_BFQ_CGROUP_DEBUG */
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op) { }
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
+			      blk_opf_t opf) { }
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf) { }
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf) { }
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op) { }
+				  u64 io_start_time_ns, blk_opf_t opf) { }
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e6d7e6b01a05..c740b41fe0a4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -668,19 +668,19 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
  * significantly affect service guarantees coming from the BFQ scheduling
  * algorithm.
  */
-static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
-	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(op)) : NULL;
+	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(opf)) : NULL;
 	int depth;
 	unsigned limit = data->q->nr_requests;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(op) && !op_is_write(op)) {
+	if (op_is_sync(opf) && !op_is_write(opf)) {
 		depth = 0;
 	} else {
-		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
@@ -693,7 +693,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 		depth = 1;
 
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
-		__func__, bfqd->wr_busy_queues, op_is_sync(op), depth);
+		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
 	if (depth)
 		data->shallow_depth = depth;
 }
@@ -6104,7 +6104,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 static void bfq_update_insert_stats(struct request_queue *q,
 				    struct bfq_queue *bfqq,
 				    bool idle_timer_disabled,
-				    unsigned int cmd_flags)
+				    blk_opf_t cmd_flags)
 {
 	if (!bfqq)
 		return;
@@ -6129,7 +6129,7 @@ static void bfq_update_insert_stats(struct request_queue *q,
 static inline void bfq_update_insert_stats(struct request_queue *q,
 					   struct bfq_queue *bfqq,
 					   bool idle_timer_disabled,
-					   unsigned int cmd_flags) {}
+					   blk_opf_t cmd_flags) {}
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 static struct bfq_queue *bfq_init_rq(struct request *rq);
@@ -6141,7 +6141,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
-	unsigned int cmd_flags;
+	blk_opf_t cmd_flags;
 	LIST_HEAD(free);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ca8177d7bf7c..ad8e513d7e87 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -994,11 +994,11 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 
 void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op);
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
+			      blk_opf_t opf);
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf);
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf);
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op);
+				  u64 io_start_time_ns, blk_opf_t opf);
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
