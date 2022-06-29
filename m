Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0026DCCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiF2XcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF2XcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:06 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715338C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:06 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id n10so15530302plp.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feSJEKDnFhLLILfXTtW9atuS9w1hoZmHEU4GVdBF5L4=;
        b=zuPmlc4feHwfhNccCNqNpGxNld/x8JAfas21B3AlS49WJ5MfiRaFKrcNQeHH/kG0vI
         +wchiqxXCzn0Li5pub83UBEO5tOoNIkp4zZSput6NgvRhlPB1/UNEAgWuY4SCNneWYm2
         LCV8SG/x9RyowZYnPRJVG30e2+b31Ko81srWrUF3Ongm4sjcrRaBvEhj0F3b7DW20MuN
         5wQEOu+5kXnm9S7+wC8kjqS1LsJSCx2yDn/3byrc+JBd/eC+Qd7KtmxcXafvomFdBVfj
         r4yzR/33Tu+ZEPpJXCXQz40vO89m+Y/wrtwQLhGbI6FlQI2xnJvXlkyTsGqJyz39ffAG
         sQvg==
X-Gm-Message-State: AJIora842fgfL2vXl/H44RTYPWW0wzzV2/U2LDOD8fb2oqLhGV3LDhOI
        XsXw3I251586zHpT7hqk5A0aSX9+Y3E=
X-Google-Smtp-Source: AGRyM1tugGTUhSGdqnU4QL+LRtdYB2W6mpMigL/Pd3p1WJdfpAJtN3vdsspo4en9OHG9H3eVapJWXA==
X-Received: by 2002:a17:902:9a49:b0:16b:7ba6:9871 with SMTP id x9-20020a1709029a4900b0016b7ba69871mr12558465plv.10.1656545525374;
        Wed, 29 Jun 2022 16:32:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 07/63] block/bfq: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:30:49 -0700
Message-Id: <20220629233145.2779494-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments and variables that represent
request flags or a bitwise combination of a request operation and
request flags.

This patch does not change any functionality.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c  | 16 ++++++++--------
 block/bfq-iosched.c |  8 ++++----
 block/bfq-iosched.h |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fc605791b1e..af79028627a5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -220,7 +220,7 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
 }
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op)
+			      blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
@@ -228,18 +228,18 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
 }
 
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
 }
 
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op)
+				  u64 io_start_time_ns, blk_opf_t op)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 	u64 now = ktime_get_ns();
@@ -255,11 +255,11 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 #else /* CONFIG_BFQ_CGROUP_DEBUG */
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op) { }
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
+			      blk_opf_t op) { }
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op) { }
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op) { }
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op) { }
+				  u64 io_start_time_ns, blk_opf_t op) { }
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e6d7e6b01a05..a724fc882158 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -668,7 +668,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
  * significantly affect service guarantees coming from the BFQ scheduling
  * algorithm.
  */
-static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void bfq_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
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
index ca8177d7bf7c..6bde1f4ecc50 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -994,11 +994,11 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 
 void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op);
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
+			      blk_opf_t op);
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op);
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op);
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op);
+				  u64 io_start_time_ns, blk_opf_t op);
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
