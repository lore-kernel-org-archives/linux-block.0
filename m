Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E167C001B2
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiLVPWj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiLVPWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33362B60A
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so5617748ejc.10
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3zZZMG0A5pdKAAyUaekL8jQDpZ8Qr344X5n0IW3lcw=;
        b=GxYRj+E72k9tW2Hf+gV4ZANJfxGB+AO6MDrIVNSbNLKiUnO17/98bqnS3AjzYrDHq7
         kn+wL1HeYeBSApHqpGl392oSFYdDO0FvsfRZhtO22VZIGa7UM+Z+gncFbHUdj/LAh9+K
         MUhNkwqRjDFJ91qgJYQ/G0RkYES+ti5+WlZ4qwwKSwaOYto+BlPmNTIUiB3UTOvn4WKq
         cWUiuSp8FUU1/RjR+LHE/CorVFa4nDR21x6+Fz/AnkerGPSis+fHzjKmuw7iQ+17wKRA
         Tz47xEjXqes+Gfm/6VFzwr2OVi11J9ZnAF7Gzb/9dVlHhesQFOOfGx1dlGNLxNpMD+95
         bK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3zZZMG0A5pdKAAyUaekL8jQDpZ8Qr344X5n0IW3lcw=;
        b=ine7VURgboBMfdUxBe0JVCVJeqYgaSSaO0598W/xqdjQagza6WTiEEr/JzhnBgOAnB
         jmrho51AcKd+lMRTiFLrmoXfg7iBUneqhCVTGmSFjY4O7TQA8vGw3E2qqSRGSjIfKOt/
         kPu3FNidpQdtc9uxYVmcvIEEsD5MF4UBFQvow9E56GUc6sRIdjPvc5dyMX5qLVEbCixa
         0TAYAqriVMNU5Rq8MMFbmjmljNJDi9ncG+zL2AHye23hEMubU45YtAUAmUDZ9XP2E8Ll
         wvPpK1acS14RgayUK3qgzeuXDVFlcjWMnyLZzbzlGk1OieMFEoyS3cvEkIKHa/mAL3rb
         t0PQ==
X-Gm-Message-State: AFqh2kpf9IVtONfdpYUaJKB3qEzU/dj73Kj2j+7B0j18/29LALqviW5O
        2rcDAPaE1hmRhiZigdbJQc3J/cYEpdds2/LO
X-Google-Smtp-Source: AMrXdXtMUpNyxNI/vG+OfSKNlBvDZevYDJF+EogEHu4okivBB81/U2Lk3UlECyr9a23Us5GjUczycA==
X-Received: by 2002:a17:907:72d3:b0:7c0:fd1e:972e with SMTP id du19-20020a17090772d300b007c0fd1e972emr6330108ejc.46.1671722529509;
        Thu, 22 Dec 2022 07:22:09 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:09 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Thu, 22 Dec 2022 16:21:54 +0100
Message-Id: <20221222152157.61789-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222152157.61789-1-paolo.valente@linaro.org>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Similarly to sync bfq_queues, also async bfq_queues need to be split
on a per-actuator basis.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
 block/bfq-iosched.h |  8 ++++----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a9ac7b6f3b81..f29444d53e6a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2624,14 +2624,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
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
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				if (bfqg->async_bfqq[i][j][k])
+					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
+		if (bfqg->async_idle_bfqq[k])
+			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
+	}
 }
 
 static void bfq_end_wr(struct bfq_data *bfqd)
@@ -5579,18 +5581,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
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
@@ -5763,7 +5765,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -6986,13 +6989,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  */
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	int i, j;
+	int i, j, k;
 
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
 
-	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
+		__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
+	}
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5a6f888930ad..de2b2af643e5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -980,8 +980,8 @@ struct bfq_group {
 
 	struct bfq_data *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -998,8 +998,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

