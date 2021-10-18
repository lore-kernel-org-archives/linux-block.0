Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B9661074
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhJRRx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhJRRx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:27 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a8so15737918ilj.10
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+DV643unX74TTLFqfijj2SncIcFWXHZQrz3bUct0Ho=;
        b=UTPFJjvMgIDuDbmHWe2U/33gugkvPjp9ARfEt+FaCr3eg7wdEazFK63BAuSlTWABkw
         ofi97GJ59e2Vkdwp3fxQIH+d3AHnDS4X8mqb2WQp48lyMMXLMtdQynIHf05TUL/lSu5g
         RhcKkInMbSeOZV6GcYV8DwbzkJdy106SikXKkdew9i892ourcMl3DuKaPat/+yofdlzZ
         6Do1JHdlFqEyWaxYy0XAb3kaYExIU0Ovhp+6vUJZt10ZKdhN3bVpt/K65k95JkwDJ7Im
         zYfyiI1IrXHuYK0aKDO3mkfh0ZuRWGOWUX38pcBgaHdq9dwC5yAbuWQNHkFTSagLZSOj
         cObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+DV643unX74TTLFqfijj2SncIcFWXHZQrz3bUct0Ho=;
        b=0ReZ7Lhx6GzDwIrEiZCe5gEZE8hv5jO0D0AmyVRe2yX9FPcFuy35UejpFG8Q6bnuDl
         vqf27LFZcO9uGZaPYAxCY3qBZG0DJpsw44Z6HK9NV9ZCLRuDwircHxbvF6VlEOtJ8ytN
         hUBShAKhlvZtYA/gP12Q5nCRaGAS9HV2/DQxXV6PxdtfnyMgazDb7g8zF2MibVe7qdM3
         xljiUlfYuf421m2xkPkb+vMZUyHNtoLcN33rZhY0pU7a0t7e+tneF+aSqFQtH5MQElZr
         IVmjbLjxgzp2plYQM/Fe49d1F1i6eCGuMtbiGgv5MEOVs+EGMEI9AlkNqelD8SYRAeXp
         VB4Q==
X-Gm-Message-State: AOAM533k6ZEVEz34gkrXzKC5q9hEveZaPR/GhIYS7ItbG2a8OBiqPdVU
        xHcnYYaZM4NJNqo591OZ4wz+/AVm09Nh+g==
X-Google-Smtp-Source: ABdhPJxRp6Ndx4iw/ooQVho1nvW7bcPR29OHvmj0fA9gTf3U8qZDIX95eQZWAwmoCkLsR7Rp+YQxLA==
X-Received: by 2002:a92:cd89:: with SMTP id r9mr15573669ilb.261.1634579475095;
        Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] block: move blk_mq_tag_to_rq() inline
Date:   Mon, 18 Oct 2021 11:51:08 -0600
Message-Id: <20211018175109.401292-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in the fast path of driver issue or completion, and it's a single
array index operation. Move it inline to avoid a function call for it.

This does mean making struct blk_mq_tags block layer public, but there's
not really much in there.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.h     | 23 -----------------------
 block/blk-mq.c         | 11 -----------
 include/linux/blk-mq.h | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 78ae2fb8e2a4..df787b5a23bd 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -4,29 +4,6 @@
 
 struct blk_mq_alloc_data;
 
-/*
- * Tag address space map.
- */
-struct blk_mq_tags {
-	unsigned int nr_tags;
-	unsigned int nr_reserved_tags;
-
-	atomic_t active_queues;
-
-	struct sbitmap_queue bitmap_tags;
-	struct sbitmap_queue breserved_tags;
-
-	struct request **rqs;
-	struct request **static_rqs;
-	struct list_head page_list;
-
-	/*
-	 * used to clear request reference in rqs[] before freeing one
-	 * request pool
-	 */
-	spinlock_t lock;
-};
-
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
 					unsigned int reserved_tags,
 					int node, int alloc_policy);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3d5010d93059..9a73e2c3ce32 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1112,17 +1112,6 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
-struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
-{
-	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(blk_mq_tag_to_rq);
-
 static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       void *priv, bool reserved)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 656fe34bdb6c..6cf35de151a9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -7,6 +7,7 @@
 #include <linux/srcu.h>
 #include <linux/lockdep.h>
 #include <linux/scatterlist.h>
+#include <linux/prefetch.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -675,7 +676,40 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		unsigned int op, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
-struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
+
+/*
+ * Tag address space map.
+ */
+struct blk_mq_tags {
+	unsigned int nr_tags;
+	unsigned int nr_reserved_tags;
+
+	atomic_t active_queues;
+
+	struct sbitmap_queue bitmap_tags;
+	struct sbitmap_queue breserved_tags;
+
+	struct request **rqs;
+	struct request **static_rqs;
+	struct list_head page_list;
+
+	/*
+	 * used to clear request reference in rqs[] before freeing one
+	 * request pool
+	 */
+	spinlock_t lock;
+};
+
+static inline struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
+					       unsigned int tag)
+{
+	if (tag < tags->nr_tags) {
+		prefetch(tags->rqs[tag]);
+		return tags->rqs[tag];
+	}
+
+	return NULL;
+}
 
 enum {
 	BLK_MQ_UNIQUE_TAG_BITS = 16,
-- 
2.33.1

