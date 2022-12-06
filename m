Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93DFC3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 16:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiLFQc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiLFQcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 11:32:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBC2F003
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 08:32:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so7466731ejc.12
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY/PyYvl5yef9dzUBwOoFODLyiHOEVf2zJot7jAU88w=;
        b=DSKhn7CIMJB3E1zujAn8BZChULAiSzolcGsUHfl4zoMFGsNHAn3KYkSFAa/o+1gRBI
         OXovq2jiPdKVZbdIYL4vDCcSQT69md8e2Y2TOcXdNqct45reVYw8oXOGEhhOdJWUkxQF
         3XenC6+47ubOOakXAI1nw50YvkdUB5u8FU+k7MszNAeUYeze+ZP4EXnx1MQlI/aKzU/u
         NDoMPENA4hCCnzKI7eevMAtuCffWBoyMcqoWHcj8HiDTAgP7JDiDkQ5G1U3z9QlazkFw
         RmK3VCEXq5yzYcP5hn376MNUHVckSKrgygSFGNM5oCqOPfh3ngh+TSCeLwm6S7Vh0cMg
         Mwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZY/PyYvl5yef9dzUBwOoFODLyiHOEVf2zJot7jAU88w=;
        b=mNb2GI6BfFeXtRaDGecbv+tsBIDLy8Ee1lzz5zRQkfwUfxqk7Kisbx2yNNz3JVNA7t
         oX1sJLMrtIR477QvogLPDna0t7FslvYzXdRW9azMbupc2ZpzDSraqMVLKYtxfWWlPMyS
         TbCXm9B3SXe1nEd07APeNTI853/UFZH2dzmL0FROMZGVYMT3/yqXlOf846/Bp7YLlR8m
         IfNfXVa0ClfBxrSP8DsR2HEciFL/pVlS1JlSHYecRsBH5KD67QP6A1JL91TN1nlPwy09
         YakFygJZeiF4sOFhAZ7DAR+uak0Ez6AscBLxOHvlW9ANiqUNL+fUwYn0iuMEKZoDakKB
         tQ9g==
X-Gm-Message-State: ANoB5pl6qmN6likyOnQxoFs4Ale7CWdJYQaCRN0ulhLhUGyDCJRvYBDD
        f6xV6MGQFebcES/U3zbStrGQ2g==
X-Google-Smtp-Source: AA0mqf4N0d2tqvn2g5Ntd5MMupUUGeFRAVQulLEkIF3tZFrEpa0y67AjA8pSFM06fQwgdHo0Wt7viQ==
X-Received: by 2002:a17:906:1713:b0:7a3:fc74:7fb4 with SMTP id c19-20020a170906171300b007a3fc747fb4mr77082586eje.17.1670344336430;
        Tue, 06 Dec 2022 08:32:16 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id t5-20020a056402020500b0046ac460da13sm1170104edv.53.2022.12.06.08.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:32:16 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V8 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Tue,  6 Dec 2022 17:32:01 +0100
Message-Id: <20221206163203.30071-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206163203.30071-1-paolo.valente@linaro.org>
References: <20221206163203.30071-1-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 53 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h |  8 ++++++-
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dcecba3c6e23..a5361c287657 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1839,10 +1839,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
  */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment (to keep incomplete mechanisms off).
-	 */
+	unsigned int i;
+	sector_t end;
+
+	/* no search needed if one or zero ranges present */
+	if (bfqd->num_actuators == 1)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		if (end >= bfqd->sector[i] &&
+		    end < bfqd->sector[i] + bfqd->nr_sectors[i])
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -7160,6 +7175,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7202,12 +7219,32 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	bfqd->num_actuators = 1;
 	/*
-	 * Multi-actuator support not complete yet, unconditionally
-	 * set to only one actuator for the moment (to keep incomplete
-	 * mechanisms off).
+	 * If the disk supports multiple actuators, copy independent
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
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++) {
+				bfqd->sector[i] = ia_ranges->ia_range[i].sector;
+				bfqd->nr_sectors[i] =
+					ia_ranges->ia_range[i].nr_sectors;
+			}
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 1450990dba32..953980de6b4b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -810,7 +810,13 @@ struct bfq_data {
 	 * case of single-actuator drives.
 	 */
 	unsigned int num_actuators;
-
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	sector_t sector[BFQ_MAX_ACTUATORS];
+	sector_t nr_sectors[BFQ_MAX_ACTUATORS];
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

