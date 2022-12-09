Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E38C4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLIJpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLIJoz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 04:44:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592485F6F4
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 01:44:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t17so10264438eju.1
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOHHhqR2S54Aod/+Wvm2K6i0oD15P47f+sL8oLcqEKQ=;
        b=COHjF90WB3erJjLE7d/tTt/ZqNjZG3jWz3bjz+uG5SB8sDWNuCESyH3s5lNy2xcwRs
         WYGrfXtMUv268Pw30VWJVIuGzP2dq9lemIsLVRKYRjM7bhanSSRJkzzmCSKYpCYOw2od
         OPx01Xu2a4XX/9Kiy5jeZrYRQtJ5H4P6dTWsdIA6lOKJpkNn0jypFwv3IsapLOjgqGMo
         wDiw34NRETQnC6xftmF6o7KxCFsao25zmkwdjqYj+NhI4U8Yk2hJ0qrcLrzieB00mmAg
         VRDMqHKlnI1RsrebBC+fULc+tUm+D+T5onycnQ42131R1ZjA142jimQ/+EpiwFKm3la+
         eGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOHHhqR2S54Aod/+Wvm2K6i0oD15P47f+sL8oLcqEKQ=;
        b=DasKPksON/jhphXwzBf78MeU2Qr/1evylLphBazTqIgw9xyqNk8jVGAvTyRiKe9XCK
         /x/XggLAiz3pi1plSa+U+sBCp1YqIlNZoA651VMSni84AqezuY1B0YoHIYumHXkxZZo5
         51U4ewotwqfhvU4gbEljYwNeMAGcdaFtIMWuJ/Yj+n3dBKB3BWxhWS0vjasX1OCienHe
         dPBZEJ+ZjQdBfRXWTf2KkTS+jRcUX/rEj6ycjDTydC6NoXQ6+NwKojh52prHLYko8/rp
         NPzdGu+lW9dMjK/G5GSiaXfXjyoLUWsCNcdzXRGRn5XZxuB0jiMlwI9uOJH0bcDPcc2z
         D+/A==
X-Gm-Message-State: ANoB5plsQTq/MbOCvY+HWz98KSVxrn8NvLh6PqmIkQpiYqfnGi4horgj
        axabcQvRkwJM201zL3NUZPxU9Q==
X-Google-Smtp-Source: AA0mqf6Wd4oM+eXPpsJ8Vm4h9akqsP3e78OJhpp4wLC+oqggT1lkR4QFeuD9Eu/nPyx6m6ndpvSx1Q==
X-Received: by 2002:a17:906:814d:b0:7c0:9b4a:76a with SMTP id z13-20020a170906814d00b007c09b4a076amr4315291ejw.28.1670579092858;
        Fri, 09 Dec 2022 01:44:52 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id oz18-20020a170906cd1200b007c11f2a3b3dsm353421ejb.107.2022.12.09.01.44.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:44:52 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V10 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Fri,  9 Dec 2022 10:44:39 +0100
Message-Id: <20221209094442.36896-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209094442.36896-1-paolo.valente@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
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
index 48a2a57097c9..e6684442d775 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2680,14 +2680,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
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
@@ -5636,18 +5638,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
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
@@ -5820,7 +5822,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -7037,13 +7040,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
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
index a685aa32b037..1450990dba32 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -976,8 +976,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -993,8 +993,8 @@ struct bfq_group {
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

