Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A460EC4332F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F20611C1
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244804AbhJQBkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbhJQBkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061D6C06176D
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k3so11258419ilu.2
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHOundxYtcxO0NTIkPzychbX+B4635OsvZ2Zvbw8uAA=;
        b=XT8/tPvVRpLafVm612NSkk2On4c8hHvfyu1J3chZaRnricIF3FWT0CDHLvrft3H4im
         JneH2ZgHEgIdNr0ibaVZwms/I63HJwJ5iLLvi7ag/9EwmA1B4dO8qKPkI+nHZ+zAnElA
         zBcRgZju7rqDrj8pz0c60Iv1GXs4EFvdHBByjfkenhiaPdbM9mFcanAx5dFsl0olsTL2
         nWB0AiHqcTu5JYh6a9L3mfz0xMCFIfl3ZqiiLQhA/Bd+XneS0QADkwu/YMueNt27dkry
         8VhtSoJZ5EZozzfNHBrR//0rnCtXfBoP2xum5f+Hi5I/MTOojtX97O+2KHsaSPDvdPAB
         LawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHOundxYtcxO0NTIkPzychbX+B4635OsvZ2Zvbw8uAA=;
        b=FIO3dNh4s9hF12hlFAI/t9/277Vc0Vr8CNcdo0OtaqubRGJvlKZlTBzQ+UIwqdYuQq
         SpjXOs1tBmauPhhN3fGqi5LfhDAzeobtWRLpu7J+7RW6G2TuYECrXJCWxerA0cSDlVWQ
         OIocXSmTcsju3xK7mQsAcTxaFeK/H6uGBnESYMTYHcQr95kL48AfERMWB8+pdFhSPu9L
         SvLHf3gCR404iltLfTwO97Yd7P/6LDcfXwpQ1/blViuo0nqAKNRdxHkStZJmN+4APHdl
         WTyxtjy7kqzC7Mw+NVuAGds9StWfEMrhue6tPPCfFCy2Kdp/KG7F2ZFwz1LU3WiRiJCx
         Md/A==
X-Gm-Message-State: AOAM533xnRxzZYzBzKg7qOBB+KWS73mR96zI77QutMVj3Nlj4YrLrmOk
        hKO/LFp1rj56/AeJ/W/9T4qOaeFFNh/mZA==
X-Google-Smtp-Source: ABdhPJy2giWR3J3NQjRD655dtzg+DlrNtYrCeBFy7d9+2iHBYIWm75O0iPvchuqy2qLBT0j6In5nDg==
X-Received: by 2002:a05:6e02:1baf:: with SMTP id n15mr8812619ili.249.1634434678696;
        Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/14] block: move blk_mq_tag_to_rq() inline
Date:   Sat, 16 Oct 2021 19:37:44 -0600
Message-Id: <20211017013748.76461-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
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
 include/linux/blk-mq.h | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 71c2f7d8e9b7..e617c7220626 100644
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
index cd1249284c1f..064fdeeb1be5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1069,17 +1069,6 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
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
index 95c3bd3a008e..1dccea9505e5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -685,7 +685,40 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
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

