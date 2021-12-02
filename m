Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81021C4332F
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 19:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhLBTvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbhLBTvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 14:51:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD8C06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 11:47:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j7so468453ilk.13
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Uybf0wFsteoJF8I7w5uQOwMJH19g+bkwAEBz2Amz1E=;
        b=fJA3xe30SFbsgkVUVyODeVt1V/M7seGud6iYwxzu3AweGxStGZFttIBF5lWeBOjZbF
         mh4vZTPszQBhIzBQLeQ/2K6L+HzQuPHXSdL++T/GXNvToJVRa6bT7dY6EgNN/bLzidR2
         fje/z/lu1RzeuFXqHOfm/OoOEmzRQhPDgbZ41/LaICE1G6I3FKhAm6wvfmNcxeHPu0EV
         7NMjUci5USjycFzzspb7reeXRdvgqXqIOy/dOjbWp+i4+SJHdbYropBpSXdpDfw2icuG
         Sb0Ci+QvxI8fAn5gCx27jzHF/ulcALZqTt7osgq5VOVL6fLL/DB2LJZ4FsXob140VL9n
         /iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Uybf0wFsteoJF8I7w5uQOwMJH19g+bkwAEBz2Amz1E=;
        b=f1GLS3HfVdTPocqCdg/2iRUQkBgJ8v4vADewzObbcZtUpLyZx7DUXp4rD5qm3XFvMy
         WbKO68tFdcroD2tK0DI/hUJ9/c12lpY2xYuB5MRJdRvNalt5J3TbZKlqtXktHm5AL3Hn
         2wHnt657H+DztlzJGXMEYyUr419JmJOOz0DK31cbGKxPIcIKMu8R6kY0+P0O/OjM9EiI
         MsrYlBAjmq84qS9ucnrpmGpVwklSMdW8vuSh9LPWLl5WJbdY5IPYLAagLVI/JiFYnY00
         b931hZtqVN0WbVSS2TMvGZcDU29PtTshaXZEaXh0o8Xo7VRJCI56A+/vyutGGqfaULr5
         UvMg==
X-Gm-Message-State: AOAM532w8SW71We7CJ5L4otzUc9/OlTiH1dhhzVWCPuKzIy+znsiHWRC
        Y/YOO0JY/fbpgX5az90nZEcW1ec9xFLddEke
X-Google-Smtp-Source: ABdhPJy/Z/zi0k5A0rppiy7gp3usRtDnTS0HQBCCA7kiD5sFxVImzmodP+aiy3vOC4X6euCaaCZ2iA==
X-Received: by 2002:a05:6e02:1541:: with SMTP id j1mr15701836ilu.100.1638474465292;
        Thu, 02 Dec 2021 11:47:45 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 18sm359477iln.83.2021.12.02.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:47:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: fix double bio queue when merging in cached request path
Date:   Thu,  2 Dec 2021 12:47:41 -0700
Message-Id: <20211202194741.810957-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202194741.810957-1-axboe@kernel.dk>
References: <20211202194741.810957-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we attempt to merge off the cached request path, we return NULL
if successful. This makes the caller believe that it's should allocate
a new request, and hence we end up with the bio both merged and associated
with a new request. This, predictably, leads to all sorts of crashes.

Pass in a pointer to the bio pointer, and clear it for the merge case.
Then the caller knows that the bio is already queued, and no new requests
need to get allocated.

Fixes: 5b13bc8a3fd5 ("blk-mq: cleanup request allocation")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ca33cb755c5f..fc4520e992b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2731,7 +2731,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 }
 
 static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio *bio, unsigned int nsegs)
+		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
 {
 	struct request *rq;
 
@@ -2741,19 +2741,21 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	if (!rq || rq->q != q)
 		return NULL;
 
-	if (unlikely(!submit_bio_checks(bio)))
+	if (unlikely(!submit_bio_checks(*bio)))
 		return NULL;
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
+		*bio = NULL;
 		return NULL;
-	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
+	}
+	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
 		return NULL;
 
-	rq->cmd_flags = bio->bi_opf;
+	rq->cmd_flags = (*bio)->bi_opf;
 	plug->cached_rq = rq_list_next(rq);
 	INIT_LIST_HEAD(&rq->queuelist);
-	rq_qos_throttle(q, bio);
+	rq_qos_throttle(q, *bio);
 	return rq;
 }
 
@@ -2789,8 +2791,10 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	rq = blk_mq_get_cached_request(q, plug, bio, nr_segs);
+	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
+		if (!bio)
+			return;
 		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
 			return;
-- 
2.34.1

