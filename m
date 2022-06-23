Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BD2CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 15:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiFWPyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiFWPyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 11:54:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7D2DAB7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:54:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so28562860wra.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=uRLacAL6ka6PtJ0HziRUckZGmKMtwQvlNtHKaKXcMwhRLttnwXTbdOaqOYb/XQ56P/
         Gm7FebAqySHBvpfIn/yoLIf4kAj8yivf+QAqT+wH74CZYgbIoNxRHCHjOCuhwbKh76iy
         u78ddC+FDzKBhyYxOecG3Z8/bLRMs2PuUumvc4t1zmoAgq4USEJSm/ug3tcb9RI3HCVO
         RJi5mvoZoqHQClSa6bjyHJHq1BP8lJscFmh+r7Tbd/PC+M3oP+7S7fwCRnXrIizLrWE6
         aeoLEuwVrrPb7YhjHSN71cWGOX0zyMetaGpNzBduEfKFiVlNji3GYB9lduZFdIeYRVUd
         8LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=h5NRbHBjXRRjZ4XntRM9A4Bd30Q/8y+yEO9GUJoHX+p6UqRbbx1mAWF4j5pd5zHzjR
         GJNjdFb0u8IxDrMu8paHjixD9XsSQqxjJ3XS/yY/SMAQr/kVwOLeTLIiZ1Cf4UamweYf
         VH1TyVnEY64dZJzzQ9Wz8Jo1ay40Xog3F4KOxbc3a/XdmXxqkDltzFB7aVbApk7AWkK8
         xF9LgWAZEiaX0onzZR/vzv1C4nMHFgT7azpcVYDNLN074pJO+csIz2Zj2PUg+xQpWjDl
         L5nP9DqrOKbsjP16U2H1gwxFw+QQ4ZCCFGienLkCzAQMLfAutS8LPrw1fwe7ZeoFxgH5
         jqnw==
X-Gm-Message-State: AJIora+dQrAFJCwIdHBHS3y0LIRX1wAKFT9ANi/B62ohaSGUzPGLYNdx
        rywSwMmrkTym/orBdfecfgKpmw==
X-Google-Smtp-Source: AGRyM1uqH5ZZIYtMUAn0KomMm+4yAbM1LhYJzhdi318noi8uG1fqYvMAMCyUlkIxMTVnYs7HcHtDxA==
X-Received: by 2002:a5d:5c03:0:b0:21b:90e6:42bc with SMTP id cc3-20020a5d5c03000000b0021b90e642bcmr9275321wrb.36.1655999638599;
        Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 4/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Thu, 23 Jun 2022 17:53:31 +0200
Message-Id: <20220623155335.6147-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Similarly to sync bfq_queues, also async bfq_queues need to be split
on a per-actuator basis.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
 block/bfq-iosched.h |  8 ++++----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fa24f9074e6f..acc2282cf196 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2671,14 +2671,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 			     struct bfq_group *bfqg)
 {
-	int i, j;
-
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			if (bfqg->async_bfqq[i][j])
-				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
-	if (bfqg->async_idle_bfqq)
-		bfq_bfqq_end_wr(bfqg->async_idle_bfqq);
+	int i, j, k;
+
+	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				if (bfqg->async_bfqq[i][j][k])
+					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
+		if (bfqg->async_idle_bfqq[k])
+			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
+	}
 }
 
 static void bfq_end_wr(struct bfq_data *bfqd)
@@ -5598,18 +5600,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 					       struct bfq_group *bfqg,
-					       int ioprio_class, int ioprio)
+					       int ioprio_class, int ioprio, int act_idx)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &bfqg->async_bfqq[0][ioprio];
+		return &bfqg->async_bfqq[0][ioprio][act_idx];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_BE_NORM;
 		fallthrough;
 	case IOPRIO_CLASS_BE:
-		return &bfqg->async_bfqq[1][ioprio];
+		return &bfqg->async_bfqq[1][ioprio][act_idx];
 	case IOPRIO_CLASS_IDLE:
-		return &bfqg->async_idle_bfqq;
+		return &bfqg->async_idle_bfqq[act_idx];
 	default:
 		return NULL;
 	}
@@ -5783,7 +5785,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -6998,13 +7001,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  */
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	int i, j;
+	int i, j, k;
 
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
+	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
 
-	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
+	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
+	}
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e1ed18a9400d..8862c12e8031 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -961,8 +961,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -978,8 +978,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

