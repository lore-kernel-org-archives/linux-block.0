Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FEC4332F
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D28260F38
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhJLRRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhJLRRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 13:17:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB5C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a8so10077623ilj.10
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HLs0CmpAPY3EVG7/L3VvvsOJvkU9nIsqMksW0qy4n4=;
        b=WBCCmcd+nCJs9Ev3rmsRxDdwspOfDOIcskEgOjuV0r8gvVFInyBzWN5sXXzLEqQQp1
         zQHGD1nFSRfVEs96wmdL7CRCyQchwMcVhCz7DkTNJBHUUHLoLaO8/iqNd4kDrq5/qKY8
         B4kpS5jy0sgeqVBig3n3XeZMiriJ1BMlocg6zIMBrzG9DTyAVJxNXFoNe31LwZcPu7o6
         DQMyxZvcbQyRlWrwVLwLIDkXJNOnR0Hp2KoZ/0kby/L8m+P8gLRPqi3nylEyOPPogGrS
         stxublrzvd01kpiRlOe2C3Qqv6Or2BIYGIxPBTlOcA5N0/2enZlzy5xSOTs4oq2eEUVc
         BRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HLs0CmpAPY3EVG7/L3VvvsOJvkU9nIsqMksW0qy4n4=;
        b=6GXmCMfughFM3mPtKR3UJY9/VewHtnHa0dPo2bqJJJPr7ZvICCUqTAXKAW08UD5nAA
         FPMwK5gAMRKR+pZnYNbYQeiZGbUo2g56puMwjyFP3G1xDIYwQ+sH14QiCyiWPQ5qtKy7
         KCcTvuXcK1BtBEmPGZ8kLi9iD13QxtKff7rBebuQptzxN0QOBRevL8YATq7Mmrfve9xw
         HL8M8U5bKrxGy0VlJ/Kd17fUO8DdTBZn2SnJkXioixFCOGhPNnCDe86xXF4OpSjB26PZ
         2P2DOdokylcAcY6Wu1pyt0UXsxlDhtZjp2tfJZhtGCt35DEbgttxroGd32U+VYAz2vsJ
         i6eQ==
X-Gm-Message-State: AOAM531ASeEvBzQ+h/BlImawLUuCUwoZw2zwELBFQXCkoW3zDKDvkhnH
        sV3i1ulJ7WxjE7Mu5SSmd+jw41biW+TI4Q==
X-Google-Smtp-Source: ABdhPJzXbG39SwVcolF/OuRjyyvDUahh8cQrVSYqEm6ASPIYPPT3w5tYjaHMkePAgZOzQcuhkWp+9A==
X-Received: by 2002:a05:6e02:1be4:: with SMTP id y4mr14044117ilv.295.1634058928227;
        Tue, 12 Oct 2021 10:15:28 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w15sm4577824ill.23.2021.10.12.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 10:15:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: improve batched tag allocation
Date:   Tue, 12 Oct 2021 11:15:25 -0600
Message-Id: <20211012171525.665644-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012171525.665644-1-axboe@kernel.dk>
References: <20211012171525.665644-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a blk_mq_get_tags() helper, which uses the new sbitmap API for
allocating a batch of tags all at once. This both simplifies the block
code for batched allocation, and it is also more efficient than just
doing repeated calls into __sbitmap_queue_get().

This reduces the sbitmap overhead in peak runs from ~3% to ~1% and
yields a performanc increase from 6.6M IOPS to 6.8M IOPS for a single
CPU core.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c | 15 ++++++++++++
 block/blk-mq-tag.h |  2 ++
 block/blk-mq.c     | 57 ++++++++++++++++++++++++++++++----------------
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 72a2724a4eee..c43b97201161 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -86,6 +86,21 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return __sbitmap_queue_get(bt);
 }
 
+unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
+			      unsigned int *offset)
+{
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct sbitmap_queue *bt = &tags->bitmap_tags;
+	unsigned long ret;
+
+	if (data->shallow_depth ||data->flags & BLK_MQ_REQ_RESERVED ||
+	    data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		return 0;
+	ret = __sbitmap_queue_get_batch(bt, nr_tags, offset);
+	*offset += tags->nr_reserved_tags;
+	return ret;
+}
+
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d8ce89fa1686..71c2f7d8e9b7 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -38,6 +38,8 @@ extern int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
 			       int node, int alloc_policy);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
+unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
+			      unsigned int *offset);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f42cf615c527..7027a25c5271 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -408,15 +408,39 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		blk_mq_tag_busy(data->hctx);
 
 	/*
-	 * Waiting allocations only fail because of an inactive hctx.  In that
-	 * case just retry the hctx assignment and tag allocation as CPU hotplug
-	 * should have migrated us to an online CPU by now.
+	 * Try batched alloc if we want more than 1 tag.
 	 */
-	do {
+	if (data->nr_tags > 1) {
+		unsigned long tags;
+		unsigned int tag_offset;
+		int i, nr = 0;
+
+		tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+		if (unlikely(!tags)) {
+			data->nr_tags = 1;
+			goto retry;
+		}
+		for (i = 0; tags; i++) {
+			if (!(tags & (1UL << i)))
+				continue;
+			tag = tag_offset + i;
+			tags &= ~(1UL << i);
+			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+			rq->rq_next = *data->cached_rq;
+			*data->cached_rq = rq;
+		}
+		data->nr_tags -= nr;
+	} else {
+		/*
+		 * Waiting allocations only fail because of an inactive hctx.
+		 * In that case just retry the hctx assignment and tag
+		 * allocation as CPU hotplug should have migrated us to an
+		 * online CPU by now.
+		 */
 		tag = blk_mq_get_tag(data);
 		if (tag == BLK_MQ_NO_TAG) {
 			if (data->flags & BLK_MQ_REQ_NOWAIT)
-				break;
+				return NULL;
 			/*
 			 * Give up the CPU and sleep for a random short time to
 			 * ensure that thread using a realtime scheduling class
@@ -427,23 +451,16 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 			goto retry;
 		}
 
-		rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
-		if (!--data->nr_tags || e ||
-		    (data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-			return rq;
-
-		/* link into the cached list */
-		rq->rq_next = *data->cached_rq;
-		*data->cached_rq = rq;
-		data->flags |= BLK_MQ_REQ_NOWAIT;
-	} while (1);
+		return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+	}
 
-	if (!data->cached_rq)
-		return NULL;
+	if (data->cached_rq) {
+		rq = *data->cached_rq;
+		*data->cached_rq = rq->rq_next;
+		return rq;
+	}
 
-	rq = *data->cached_rq;
-	*data->cached_rq = rq->rq_next;
-	return rq;
+	return NULL;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
-- 
2.33.0

