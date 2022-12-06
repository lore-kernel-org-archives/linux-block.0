Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A16C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 08:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiLFIQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLFIQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:16:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151417886
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 00:16:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a16so19165436edb.9
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 00:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BpKU2NYbTziJwWq6AjACejxgrhoAentIWtSJgkaJ4g=;
        b=yK7/MZoaRbZtgYXmF3MAZ+t8TxI0i+WFdOdvu8VLqq45rSubMmRh9JnjbAipy5b1mK
         xr8U8y7xEn7TiOv61nOBWtXAzfUFjRVwKSyjeiMbpUj5MwCtz4IsQLgU1uxiNCY4i5PT
         us6imHP7UkljpG4V5X5WVm+2bN9NyqTgcGI4GfhOjeND6DS9Vz13OUw5glG46yAhlaPt
         QaSY2Nazv0K1rJj2UOc0GkA7wUV7aDrfJYmxUENzZBB2keFOu150JGZLIBzu15DCwacS
         ETe1JiNKHvmacxeHj2brWDIms2hk/NprMtNKMPxcP4om2RNWOl7w42SuPZ6x06Cammjh
         DB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BpKU2NYbTziJwWq6AjACejxgrhoAentIWtSJgkaJ4g=;
        b=DrrQAJ/LJijngOINrtnyLYn6lQBKt8R8pIAikoLrznhr0wIFHHoLaNViUFtX/QXtTf
         fnrp6hDKpboLJUlrEgJkP81W601otFyieGFka+hNLC8gZ8I7Z6eteSkQI2HwAA4UTsdr
         22Tctwi+rzrqIhOohAYiZ6cXFmvTAulcsABYs74CwzJOADnfmLUp6UsA+ruZj581uGXN
         Ad45UGqhfHyQEShCrqshjGoAAyJ2dLuiOIe2VazIMZUYvWgcoKnNiIhlhPY1uDouBIwE
         6Vs7oSdlWHte0+H/QZIud4CAzuW5fJG1TSBeNLFVS/ku8Anp/Qikx1qIjRgnG1+5oJur
         Jb8g==
X-Gm-Message-State: ANoB5pnDs/ElAcgR8ysvdDWeb4yfGA5pxdHWW8VQqR6ZSa5C1QMKO4iN
        uMJCB2R0l37wH0EKYXINKPhCrQ==
X-Google-Smtp-Source: AA0mqf59IAODO9bKfkWzNiG9vFLbwCbvCtC8LtCopTIlBYCJaSxGXXQvl1TPULIVhdf/IwlQl3OASA==
X-Received: by 2002:aa7:d1c3:0:b0:46c:edb5:afea with SMTP id g3-20020aa7d1c3000000b0046cedb5afeamr4095540edp.315.1670314563597;
        Tue, 06 Dec 2022 00:16:03 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:16:03 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Tue,  6 Dec 2022 09:15:49 +0100
Message-Id: <20221206081551.28257-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206081551.28257-1-paolo.valente@linaro.org>
References: <20221206081551.28257-1-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 56 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h |  8 ++++++-
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6b1376ab8980..665e78035666 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1838,10 +1838,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
+	if (bfqd->num_actuators < 2)
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
 
@@ -7159,6 +7174,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7202,11 +7219,34 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue = q;
 
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
+			bfqd->num_actuators = 0;
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++) {
+				bfqd->sector[i] = ia_ranges->ia_range[i].sector;
+				bfqd->nr_sectors[i] =
+					ia_ranges->ia_range[i].nr_sectors;
+			}
+		}
+	} else {
+		bfqd->num_actuators = 0;
+	}
+
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

