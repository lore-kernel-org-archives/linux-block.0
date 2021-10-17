Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEEC433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC0D611C1
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhJQBkC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbhJQBkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B41BC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h27so5491794ila.5
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8OcUz0fb+TxP+b1ymvvoFMzaszn0xSCc26VaJnYFNDg=;
        b=MUuun0nepB4H+VC9Apr38JKcIN49MICoRd/0bgPJXLocemjxdNm6noNJL+BLd1zi1G
         e0B0NT0ZHFKJsEKEhiQNVBM4FxJbbztb+44MCv4UJi5MRuDl6u6AUOJpLJ+7WQvIlTzb
         lT8q4LUZiWim9lUMV6V4Nui7ooVRfva6HG3NuP2Dl3uZu6Qcj03Y1wZ6LOnLz/X+b+xX
         9N+Pm9T1r4ixuu+Kh1hpxvYdJAOxaZ+YmJazrhOAm2Lz8kR/5b081F8tcGKTRe2VjUQU
         Kyb7ymPqtjoByBOgmRTzUEVpouJD2F63hI0J7PuWBwg++DyjnJGsDknDud6YDqbPZ48b
         qeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8OcUz0fb+TxP+b1ymvvoFMzaszn0xSCc26VaJnYFNDg=;
        b=tWvZCd0Wq6yDfhqv+NePSLQb3N/tX1keBeK6pPmqPlJ/K17/qdJLirUHf+y8Da1mEg
         0wOLhKO9dPaiN84XRPCQmy2FhLmtxr0UbllGczd7kVOzffOH88dy3WpLrFmxhfR8o6ih
         7onX8tGgriFrH4iBbnqDGc3UXhE/RFurkZ852vICRWhxzWqxcsShTaQDoWl07L7mnDuV
         3j2Hjh5L54XMLeI/WK9FVXx6ZT1alieTQrpm0imIo+CpzYYiuT0JTasMJjdaP7Ooa9+h
         BMwll0kUzK4hnpWf+n99/I/P53OzOjwyViFy1X/0ahP8pXiiq6NXMtYM4nhI51GMEqaH
         vQTw==
X-Gm-Message-State: AOAM531DjDkB0LL0R6OzHZ+gTCOn+UVQzNS/OGoiME1RMwC9dxyG5AAC
        nmByqdh7qGQjCnMj1WBLVHu4S99CD8WPPQ==
X-Google-Smtp-Source: ABdhPJzCBVCUJYqbjbb4rK/ShbyY5ig3kdxqBC+o78FzSOH/l+WNUyhN+TqBX5CkOljmHNjOBbCzgQ==
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr9133522ilf.165.1634434672439;
        Sat, 16 Oct 2021 18:37:52 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/14] block: inline fast path of driver tag allocation
Date:   Sat, 16 Oct 2021 19:37:35 -0600
Message-Id: <20211017013748.76461-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
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
index 1bbe5de66c40..90bc93fe373e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1145,7 +1145,7 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-static bool __blk_mq_get_driver_tag(struct request *rq)
+static bool __blk_mq_alloc_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
@@ -1169,11 +1169,9 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
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
2.33.1

