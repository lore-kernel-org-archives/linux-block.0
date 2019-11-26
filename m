Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88291C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6279020678
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKZR5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:57:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42861 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfKZR5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:57:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so9534079pfh.9
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVAGa5wHGZVQTdnJfY1Fz6cSSmZXI39aRTwBcdpUujA=;
        b=S+rwZpC/ckr7Riva4s1rXDkzDY/JyVpJzw5xFQYCri7RhpW4i6wZ/odcFO/+fiPPwt
         R7ttjc9AK2+2pgG8BQQUCZsvqbY5dRXD3nw4UXuLVq7pD1yv/U3kPlWENOGqIqpJQEvq
         sFet7SCxgJVW/g9iggJwqpKHiUTvAbHh3FcbQVXsB7HjPHQ3rFO4s1/4AWUYzjvEXzqC
         tJJHl3qaUzRaS4ti7DomtrTM9kfGiNQI8BzszriJYYMahMAesUQVQEzIW0SfWEI95BMC
         1o4jdB4Bjcr8DThp+Eestlpyi0xDTXWuAOzHxZnAhcXFlZVvMVK5F7sdl8uMEdaJ3tUC
         hAOg==
X-Gm-Message-State: APjAAAVhA+pAzYU754GBfAcqEwZlugwxbHeTK0rMXw30KWnZuoTVN9Xg
        6L9MoW84ktLO1rsaXfYfZlAlwPMV
X-Google-Smtp-Source: APXvYqyiV0VDoZ5mpAefkcKB3/kgIKmua3DFH/oI2busNc2GeeUIBRLigF9vCnqISqkjBj5vyw82wg==
X-Received: by 2002:a62:e914:: with SMTP id j20mr43546380pfh.245.1574791028508;
        Tue, 26 Nov 2019 09:57:08 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 82sm13178715pfa.115.2019.11.26.09.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:57:07 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] blk-mq: Move the TAG_ACTIVE and SCHED_RESTART flags from hctx into blk_mq_tags
Date:   Tue, 26 Nov 2019 09:56:55 -0800
Message-Id: <20191126175656.67638-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191126175656.67638-1-bvanassche@acm.org>
References: <20191126175656.67638-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If each hardware queue has its own tag set it's fine to manage these
flags per hardware queue. Since the next patch will share tag sets across
hardware queues, move these flags into blk_mq_tags. This patch does not
change any functionality.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-mq-sched.c   |  8 ++++----
 block/blk-mq-sched.h   |  2 +-
 block/blk-mq-tag.c     |  8 ++++----
 block/blk-mq-tag.h     | 10 ++++++++++
 include/linux/blk-mq.h |  2 --
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..3678e95ec947 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -211,8 +211,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
 static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
-	HCTX_STATE_NAME(TAG_ACTIVE),
-	HCTX_STATE_NAME(SCHED_RESTART),
 };
 #undef HCTX_STATE_NAME
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..7d98b6513148 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -64,18 +64,18 @@ void blk_mq_sched_assign_ioc(struct request *rq)
  */
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state))
 		return;
 
-	set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	set_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
 
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (!test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state))
 		return;
-	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	clear_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
 
 	blk_mq_run_hw_queue(hctx, true);
 }
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021fc3a11..15174a646468 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -82,7 +82,7 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 {
-	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	return test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
 }
 
 #endif
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..a60e1b4a8158 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -23,8 +23,8 @@
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
-	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+	if (!test_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state) &&
+	    !test_and_set_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
 		atomic_inc(&hctx->tags->active_queues);
 
 	return true;
@@ -48,7 +48,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 
-	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+	if (!test_and_clear_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
 		return;
 
 	atomic_dec(&tags->active_queues);
@@ -67,7 +67,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 
 	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
 		return true;
-	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+	if (!test_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
 		return true;
 
 	/*
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d0c10d043891..f75fa936b090 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -4,6 +4,11 @@
 
 #include "blk-mq.h"
 
+enum {
+	BLK_MQ_T_ACTIVE		= 1,
+	BLK_MQ_T_SCHED_RESTART	= 2,
+};
+
 /*
  * Tag address space map.
  */
@@ -11,6 +16,11 @@ struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
 
+	/**
+	 * @state: BLK_MQ_T_* flags. Defines the state of the hw
+	 * queue (active, scheduled to restart).
+	 */
+	unsigned long	state;
 	atomic_t active_queues;
 
 	struct sbitmap_queue bitmap_tags;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..522631d108af 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -394,8 +394,6 @@ enum {
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
 	BLK_MQ_S_STOPPED	= 0,
-	BLK_MQ_S_TAG_ACTIVE	= 1,
-	BLK_MQ_S_SCHED_RESTART	= 2,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
