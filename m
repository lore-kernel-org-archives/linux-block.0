Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F04C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D142F20823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBXZJ1xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfARLwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:52:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53608 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfARLwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 06:52:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so4234066wmb.3
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T27H7ztOcp7A/3V22IUmBI8925liW6dEWx0lFYpzxQM=;
        b=KBXZJ1xr/Gu0llfl5PqSk6cW/UpSN10BkwwI+mbh83BYmn3Od9x+bRjey4zR/RiNqU
         VGKn1Zjq6+69gkWbvt4PvxyX/aiEEnwU6peo0Rt5njglMFdxEZMoVYF/y1eEPsbM+1Ts
         oUvCpdXtySPwkRZ7eC80EX7yqjPvMh3HpMhB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T27H7ztOcp7A/3V22IUmBI8925liW6dEWx0lFYpzxQM=;
        b=pDV0PZUSoV9ybRTVPjB9CORv7W5bhkl/D8dTuxvcgtbnMm0Qa2rTwjnbN3AqtU+oYv
         b6PQj/JgtU+SnasYfwAdEaYRIiJ5ktRLiwAY2PO1JP6nqzo6Z9tYVKpYOWVyxJIGs/fs
         LLcsIzAU0io+H2Ku/PQOegsrOJ3s2Zvule7HJ4K7nlwWGgb+TYqTgSsBKzfWyU/grQWO
         Np8RyB1WZ4/fgfUhUTeUUcIe6QGpg7xtpC2v77YSno34u+W40mgDgv0MWgxbBSbGDVVZ
         mkXrpRCWmOYJncDpUMDvv6x5sS30gQ/1IwDRRgFMtcxN55WR7pH4iXftN0WQqUPOXuMl
         otEg==
X-Gm-Message-State: AJcUukeJ58knUu55nFBF5J3qy/0mLKRvcePyirP+LhS/Hnb55poE0z/3
        VP2Wu7JNKBme227CZeRdP0vrww==
X-Google-Smtp-Source: ALg8bN6daXGHkjgeAObO/TRteINYs9FQMD40/CShcIJ9lWRnn40t3epdsBj1ZfA5b9exKRWu52boOg==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr15884561wme.41.1547812355617;
        Fri, 18 Jan 2019 03:52:35 -0800 (PST)
Received: from localhost.localdomain (146-241-71-93.dyn.eolo.it. [146.241.71.93])
        by smtp.gmail.com with ESMTPSA id i13sm75183049wrw.32.2019.01.18.03.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 03:52:35 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, hurikhan77+bko@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RFC 2/2] Revert "bfq: calculate shallow depths at init time"
Date:   Fri, 18 Jan 2019 12:52:19 +0100
Message-Id: <20190118115219.63576-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118115219.63576-1-paolo.valente@linaro.org>
References: <20190118115219.63576-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit f0635b8a416e3b99dc6fd9ac3ce534764869d0c8.
---
 block/bfq-iosched.c | 117 +++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8cc3032b66de..92214d58510c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -520,6 +520,54 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 	}
 }
 
+/*
+ * See the comments on bfq_limit_depth for the purpose of
+ * the depths set in the function. Return minimum shallow depth we'll use.
+ */
+static unsigned int bfq_update_depths(struct bfq_data *bfqd,
+				      struct sbitmap_queue *bt)
+{
+	unsigned int i, j, min_shallow = UINT_MAX;
+	bfqd->sb_shift = bt->sb.shift;
+
+	/*
+	 * In-word depths if no bfq_queue is being weight-raised:
+	 * leaving 25% of tags only for sync reads.
+	 *
+	 * In next formulas, right-shift the value
+	 * (1U<<bfqd->sb_shift), instead of computing directly
+	 * (1U<<(bfqd->sb_shift - something)), to be robust against
+	 * any possible value of bfqd->sb_shift, without having to
+	 * limit 'something'.
+	 */
+	/* no more than 50% of tags for async I/O */
+	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
+	/*
+	 * no more than 75% of tags for sync writes (25% extra tags
+	 * w.r.t. async I/O, to prevent async I/O from starving sync
+	 * writes)
+	 */
+	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
+
+	/*
+	 * In-word depths in case some bfq_queue is being weight-
+	 * raised: leaving ~63% of tags for sync reads. This is the
+	 * highest percentage for which, in our tests, application
+	 * start-up times didn't suffer from any regression due to tag
+	 * shortage.
+	 */
+	/* no more than ~18% of tags for async I/O */
+	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
+	/* no more than ~37% of tags for sync writes (~20% extra tags) */
+	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
+
+	return min_shallow;
+}
+
 /*
  * Async I/O can easily starve sync I/O (both sync reads and sync
  * writes), by consuming all tags. Similarly, storms of sync writes,
@@ -529,11 +577,20 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
  */
 static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
+	struct sbitmap_queue *bt;
 
 	if (op_is_sync(op) && !op_is_write(op))
 		return;
 
+	bt = &tags->bitmap_tags;
+
+	if (unlikely(bfqd->sb_shift != bt->sb.shift)) {
+		unsigned int min_shallow = bfq_update_depths(bfqd, bt);
+		sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+	}
+
 	data->shallow_depth =
 		bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
 
@@ -5295,65 +5352,6 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
 }
 
-/*
- * See the comments on bfq_limit_depth for the purpose of
- * the depths set in the function. Return minimum shallow depth we'll use.
- */
-static unsigned int bfq_update_depths(struct bfq_data *bfqd,
-				      struct sbitmap_queue *bt)
-{
-	unsigned int i, j, min_shallow = UINT_MAX;
-	bfqd->sb_shift = bt->sb.shift;
-
-	/*
-	 * In-word depths if no bfq_queue is being weight-raised:
-	 * leaving 25% of tags only for sync reads.
-	 *
-	 * In next formulas, right-shift the value
-	 * (1U<<bfqd->sb_shift), instead of computing directly
-	 * (1U<<(bfqd->sb_shift - something)), to be robust against
-	 * any possible value of bfqd->sb_shift, without having to
-	 * limit 'something'.
-	 */
-	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
-	/*
-	 * no more than 75% of tags for sync writes (25% extra tags
-	 * w.r.t. async I/O, to prevent async I/O from starving sync
-	 * writes)
-	 */
-	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
-
-	/*
-	 * In-word depths in case some bfq_queue is being weight-
-	 * raised: leaving ~63% of tags for sync reads. This is the
-	 * highest percentage for which, in our tests, application
-	 * start-up times didn't suffer from any regression due to tag
-	 * shortage.
-	 */
-	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
-	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
-
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < 2; j++)
-			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
-
-	return min_shallow;
-}
-
-static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
-{
-	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
-	unsigned int min_shallow;
-
-	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
-	return 0;
-}
-
 static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
@@ -5773,7 +5771,6 @@ static struct elevator_type iosched_bfq_mq = {
 		.requests_merged	= bfq_requests_merged,
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
-		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
 	},
-- 
2.20.1

