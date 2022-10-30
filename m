Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DFFA3745
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ3KDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJ3KDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37CC23F
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud5so22856641ejc.4
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0jpEUiIStstn+cz9/9ycvh0etWYQc/7Lgp1ggYo6Sw=;
        b=Pkc1XWViIueLswGPwN/I3OqzS7h/cpEacd6eJo4Ox3Jaj4auWsLxY8H+eHhQbfZwRD
         XOHTF0roKn+zZoEmsuyC6vkLOz8mEgN0JQshN6I1VxjapsOrLnNL7mm1/Y4OmCxXj+Qk
         L7gm1cthaMVcLQlHjVdf6lqZvSjYpp63pN0nuvpM1Ifck3HVrDqDucK7+J3rZCUbN1S7
         nvpo5hagUfc+/DgMLJtVHcs/jdIaushxUGwrjwDK4hLX0f5HJGnnhgUMIpQ1ZpcUXxR1
         0ElKUXESHZyiyad1V7csYj3tfFXyORTkbtVstwkjCMAP6z7H2qiVkH40GCPbqMG9BaO8
         Hnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0jpEUiIStstn+cz9/9ycvh0etWYQc/7Lgp1ggYo6Sw=;
        b=rnKbBWhgZqMBEzc0JwVoGDhrpTxS9/PmqstCZyoUV5cA6VjfjdjnynLREMC/kmcmBR
         ZcbTxUBzfPeC+gHN4dF1U4wYb7K1QXN1wOUaHdtE3rCq4tloCqMcXCFm8ww+i+paZI1S
         igWs3gP0HtPk2kuGCCBhHAullPVUfbiut5v7Kq/XVJXjLTW6cS6kaZLyQz5HElqblqJ1
         veyI1ePyET2I+waJ1PErHTq5vemHVBSOaGplOK2ka3/9mPtL9wC6PcXXXz3Rns3QO1yT
         ifLhixplBXzo3/K90UBg8WMe7QVzYv7hV44gmmXrtjZzY0pjhqflF1HsSRX4e3iNtE+B
         0Srw==
X-Gm-Message-State: ACrzQf3yAqcApqvNDYgc/iOncvQ447f4Sx5ynMVd2+DRsmOR5Of0vq2S
        fFMtM5Chfb2MtH1F1SPWVdv2yA==
X-Google-Smtp-Source: AMsMyM6e8rNz8OtmSdbJsYu4hPjyGmD3JUoWOtWMIIiIiWQk09CHvwBZmvrYZmT5jKSoZE9xWAtm/Q==
X-Received: by 2002:a17:907:6e03:b0:78e:1c82:1f2a with SMTP id sd3-20020a1709076e0300b0078e1c821f2amr7190243ejc.611.1667124221217;
        Sun, 30 Oct 2022 03:03:41 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:40 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V5 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Sun, 30 Oct 2022 11:02:58 +0100
Message-Id: <20221030100300.3085-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221030100300.3085-1-paolo.valente@linaro.org>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Federico Gavioli <f.gavioli97@gmail.com>

This patch implements the code to gather the content of the
independent_access_ranges structure from the request_queue and copy
it into the queue's bfq_data. This copy is done at queue initialization.

We copy the access ranges into the bfq_data to avoid taking the queue
lock each time we access the ranges.

This implementation, however, puts a limit to the maximum independent
ranges supported by the scheduler. Such a limit is equal to the constant
BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
dynamic memory.

Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h |  5 +++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f1ea24775d90..6f464d422098 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1833,10 +1833,26 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 /* get the index of the actuator that will serve bio */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment.
-	 */
+	struct blk_independent_access_range *iar;
+	unsigned int i;
+	sector_t end;
+
+	/* no search needed if one or zero ranges present */
+	if (bfqd->num_actuators < 2)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		iar = &(bfqd->ia_ranges[i]);
+		if (end >= iar->sector && end < iar->sector + iar->nr_sectors)
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -2481,7 +2497,6 @@ static void bfq_remove_request(struct request_queue *q,
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
-
 }
 
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
@@ -7154,6 +7169,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7197,10 +7214,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue = q;
 
 	/*
-	 * Multi-actuator support not complete yet, default to single
-	 * actuator for the moment.
+	 * If the disk supports multiple actuators, we copy the independent
+	 * access ranges from the request queue structure.
 	 */
-	bfqd->num_actuators = 1;
+	spin_lock_irq(&q->queue_lock);
+	if (ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+			bfqd->num_actuators = 0;
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++)
+				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
+		}
+	} else {
+		bfqd->num_actuators = 0;
+	}
+
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f1c2e77cbf9a..90130a893c8f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -811,6 +811,11 @@ struct bfq_data {
 	 */
 	unsigned int num_actuators;
 
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

