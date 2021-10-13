Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC76C4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9136660ED4
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJMQvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJMQvq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:51:46 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B164C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w10so359218ilc.13
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3K8KowZzxNUqVAWzdkigAtin3UILSDTRqPa51/1XxI=;
        b=p3HxtEQsg7U+FqUS8heoSgV9nlHRRVZOOrnOn4PjS9xN9gu9GEhKAdXSSyddqWynxx
         1ILitWvpt++WFKZheDwXgbHrvK2dXreQFhXNVrg2o51e/tK4EAnyzRT3d/6JGQ9MpZ6i
         q+qllrKt29Av7AZz+SgcMG9I18t8PSTEj1Q0A71TRHypgs+7TNXnrvHx/BlKoHmFwFo+
         h1OFI0cHqrhekPPaCXWrq8o/eNZd2zdPAPNN3jrQqhpXFrRUoemM2aJrClvPSkqklsQP
         Q//P4oColJtSWydfNzaV/GmKLBkJnYWKpBKmxcwu/pEfozyTcDOrYYiU8pYbDKCaGUsp
         9qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3K8KowZzxNUqVAWzdkigAtin3UILSDTRqPa51/1XxI=;
        b=nQt5hWhtvUVzccbLbg38hFiQIKSeUqaezX5fGw1XFccjOGWah2+HMCyDTyKVi/85OY
         PNMD2GuIFedkY16ImNcZV77+cod8CFVnwf7UNNs68vzA2y2SdGiSVlCi5zHZANimQwhp
         nwlij4BsF+wx6awAh+gFMGlvlcdcJeVW6E8oDAIdX5wXJtUKUxjaqyAH+YQDvZYV/LDy
         LjOgrsV62HkQryGz8fE3Lx1tGb9TtzgWewvxQ6LxcSNK+E/V605vvGQjjq5JixSu5fJC
         FS40AKhlgT3ElyJfPrjmJOXOYNWheKGNsUvivORXA0uUgneLsbdRd697e1zkwA1SZlY9
         w+DQ==
X-Gm-Message-State: AOAM530nCBQ94QrxsJGUWmQNsI+rGZ+tAZtOrwMsRTVbgxrIOpsUlqsu
        1dns9sSj172uJGDIA8NQmBOxojNZq43+rQ==
X-Google-Smtp-Source: ABdhPJy+vD3t6NCemv+DvVD1jMOofoAUWfRz/HXy+8odR+LWqAndYDAmZ2VX1S+jxU+H0tiwdnjdIA==
X-Received: by 2002:a05:6e02:16c6:: with SMTP id 6mr115024ilx.220.1634143782264;
        Wed, 13 Oct 2021 09:49:42 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm17217ilg.87.2021.10.13.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:49:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block: inline fast path of driver tag allocation
Date:   Wed, 13 Oct 2021 10:49:35 -0600
Message-Id: <20211013164937.985367-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013164937.985367-1-axboe@kernel.dk>
References: <20211013164937.985367-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we don't use an IO scheduler or have shared tags, then we don't need
to call into this external function at all. This saves ~2% for such
a setup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c |  8 +++-----
 block/blk-mq.h | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 46a91e5fabc5..fe3e926c20a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1135,7 +1135,7 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-static bool __blk_mq_get_driver_tag(struct request *rq)
+static bool __blk_mq_alloc_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
@@ -1159,11 +1159,9 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	return true;
 }
 
-bool blk_mq_get_driver_tag(struct request *rq)
+bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq)
 {
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
+	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
 		return false;
 
 	if ((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8be447995106..ceed0a001c76 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -264,7 +264,20 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
-bool blk_mq_get_driver_tag(struct request *rq);
+bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
+
+static inline bool blk_mq_get_driver_tag(struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (rq->tag != BLK_MQ_NO_TAG &&
+	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		hctx->tags->rqs[rq->tag] = rq;
+		return true;
+	}
+
+	return __blk_mq_get_driver_tag(hctx, rq);
+}
 
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
-- 
2.33.0

