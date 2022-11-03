Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD18C43217
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 16:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKCQ0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiKCQ0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 12:26:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE5DEF3
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:26:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t25so6685298ejb.8
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oniB949cGpkQzmF8RGqGElqLHPXXDZ9tC1RFspuCDx8=;
        b=wEOAvDGOxysxKwXCpAssw1LzP1VmFIPMiCvp65zEgWLBpzXnnc9djw/US9EwE/a/N6
         JaRYLBqssEc8poJH5JQhFSQFhWUxR/J6tsmXxw8kaJTO28miJZuts+LjFRjGBMuXggqb
         jbzynyraZC8PKwK4K9Gyb7qo7bXvqgot09//cA56sfj/Y0D+CDaqA8tQM9+AR7RfX3HP
         xGpdfmOBgeYOdXBacelpM0d/tpSrD6LneI4t07Rc0HafeopztrMaa18NbZCbKLrS7+Sy
         VLx8Pse11TSLOKAjP4zdIRhNJnsSsDHiBSqrVZVjJqq6kZiFHTmCDX++tM+w/6CYWxqD
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oniB949cGpkQzmF8RGqGElqLHPXXDZ9tC1RFspuCDx8=;
        b=5o7I2CDWprriPloEle7tPU+DLce23YMDtzTSrQ2S7QyfrYwChOeo8GmN7MaUIh73mJ
         blHUre27audy22rdBFBReI3ZSzB9qhzKtNdjBtbNVEoO8/5ccMvsPq6n8ZUMnX63sUHR
         cPsZOTWl2O6O+LAagutzKuOBNiEUK7R1nGvSieGEK8elBrX5T5nZatATFAtr+CRh0Vdp
         abQXHERTG6bqXK9QXso6CsWyLjanCrifjxQOMOAbQWb9trBZDr6FIn4XTCNtbLKo6uQH
         cQVbkOh+xRiDfdNKG0jKzU+Dm1sJNWKO4gf+TcjapOFMpBsx2GP67Bkpo+lV37VBkW0/
         jIqA==
X-Gm-Message-State: ACrzQf0BwfmZPplyuGtuy6VqzqCY7Kgv2UFt2dzQ2e35624DlT8E62cI
        XDEOz3bE5DtIlxhPtJQhxYoZQw==
X-Google-Smtp-Source: AMsMyM4vzSubaVHEOkWwY49javGB0NLRixVqSMdtId7ER85GiFbN1Pb1DtPowZ1htOkcuaOyztpkgw==
X-Received: by 2002:a17:906:da86:b0:7ad:dc94:1b7 with SMTP id xh6-20020a170906da8600b007addc9401b7mr19781410ejb.288.1667492802603;
        Thu, 03 Nov 2022 09:26:42 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:42 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Thu,  3 Nov 2022 17:26:20 +0100
Message-Id: <20221103162623.10286-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103162623.10286-1-paolo.valente@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
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
index f44bac054aaf..c94b80e3f685 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2673,14 +2673,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
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
@@ -5620,18 +5622,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
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
@@ -5805,7 +5807,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -7022,13 +7025,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
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
index e27897d66a0f..f1c2e77cbf9a 100644
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

