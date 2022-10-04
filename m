Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7277CC4332F
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 09:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJDJS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJDJSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 05:18:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB52CC9F
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 02:18:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id 13so27528369ejn.3
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=l+UIb4gZXZG3uGXDlB18D6HZRF8vRFCQApKatTByEppalxPDlWiHfl1aaj9TGcWOxz
         2uSfdtWdM3CZYbNaHcB6h5iOBdAU/lD0De8VguByFCwZ9I7v9AZvQkjNghAWIIMF9L0f
         mY05CFAqwg0uCyVfFSHemj+5whXaPlI+C2Cl2oFVOpgu/GtBE3NFUBiE/BKv/njoqzBj
         U1NYPiIno9laBz02HdFJHy/7A3Cp4AwP3v+2o0QNceRisj7GAjlGhH+ZwT1PwpWif5AS
         /sew+Za9n+/PVmc+LfW8Jkgyy3U1kTsMCFK776jwXvXZqE/rXOOT3HDhpx9zowOJGxNk
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=PJwuk2NcxgWz7/fskmxCNOpIPZVdQV+n7Ti8mOm2B86X4X0N8+vIGDaURgkI1vSN5l
         pZeFmYndL5UVGnXQBxjKU3jTabOsBbXJoB4TPCiwo46tRkuQKOnSkAZFyFEsOVTvBDQ4
         hXNr/kTEhkTVk1GKk0oE17SOx7g39n8XeCLAb2nzIXmQ7Nc1+7LJmqxf2D0mBB2dPZa9
         mKytbD2WLstcdRab5B+1TKLwS7j9hUEDpTWWTqPVfYKc+cnpZprJ8dkK3UTGntwTAHbA
         vwSNciM4vG6grXSkUqRjJ8DPUHM9NFtU8n69OI40MazN7Osp3bEPWbKDbsIxeMwpkc/K
         /wzw==
X-Gm-Message-State: ACrzQf0IyyR9D1gWt2zTsIa+UXglFnImrVLr8KeUbj8j3BA5ZIFVAXtQ
        J3CWmwX2YEm71ZRInDnshTaotA==
X-Google-Smtp-Source: AMsMyM4852Ofi1vOzRjJJ5cGlC6fQY+Aht9yTkCucAzISP3WafSTRuiWRaIySIwH1OfRF1Naq8C9hg==
X-Received: by 2002:a17:906:845b:b0:78c:7971:1799 with SMTP id e27-20020a170906845b00b0078c79711799mr4911645ejy.715.1664875128978;
        Tue, 04 Oct 2022 02:18:48 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 4/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Tue,  4 Oct 2022 11:18:12 +0200
Message-Id: <20221004091816.79799-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
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

