Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C267C54EBF
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 14:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbjACOzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 09:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjACOzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 09:55:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35169FD34
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 06:55:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy8so10337431ejc.13
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsWPGWHz4PsB9F2bSORsl2cpLwLReathmqV+xA12OGo=;
        b=nKMNURzhoK5XU7f8rSpM3To47grIJM+ZHDwjyFQMf5NMCYcosDi/AdcodXD0Zkm+gM
         yjpr1CjTaFvFRNyLLsrtZbikyS7D7lFKmlqXDfr+FhfgHU0nUrZD1LOv9lxTrkkzZ+ws
         sJ4vNN7ILBu4yLH32zNNAGqslw8WIVD2ZlE4PRAV5S8E7ezYL5V/0DuZ9/ysH334iISt
         aaQE+Z+3d2N1oEIxhi8CSejLYhV8oZfU9acNgzsYXwDOekx1fZmLf6Yhj+f6aW0EPfVw
         idN429IAiPtTduoEKQI8OMUWkODhbRkw2V4Fi43lZLDU1HnpRNG8oO+VfNkEcx0B1NFq
         O0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsWPGWHz4PsB9F2bSORsl2cpLwLReathmqV+xA12OGo=;
        b=XxF+XHGJXsvd9eWqe/WW97ypOrlq/8US4J5arTAVa3sex7n2OTzwJ0xBSXwtudNyB4
         hYHV9F18YMpkhGO9LEvZpiSO+R8XY7v/5Sa4XtxmahkrFrj8HM+g94f1dBT7mtr9Y9pe
         HOCtpUkZB+HmT20u7T3GVD3b1BOYvIF04mGwWSW3eI0HGhniLeReR9Fxp+fW8wpE/diQ
         RWYNAXdBpV2pv738obUciJwzwSPmAra29VbEYlFp4o+nJMHQsr6vAK0DW6ue0ZkqK8Yj
         2Iwzp+XWvMjRY1GOa3CCfpGwt3uh1EWn3jyG2aMhpHqqiNI3TnXOwkdLr92iqddkLC9v
         g+Ng==
X-Gm-Message-State: AFqh2kpfZgjlJ4kxJuVgEnU4WHWKsruNnuaGoG1je5PrT5EWw8J3/k4t
        zZ7GcGtelBl2YSHpwQcbASGH4QEXFDrv2FcT
X-Google-Smtp-Source: AMrXdXs02M/o1s6jHZ/t3xeo0oz6Mq1A59MbGXMJlqgPfxejObu5lu22+cdXtYO1Iw0zO3Sr8Sgnwg==
X-Received: by 2002:a17:906:7fc3:b0:7c1:10b8:e6a4 with SMTP id r3-20020a1709067fc300b007c110b8e6a4mr35703060ejs.19.1672757731786;
        Tue, 03 Jan 2023 06:55:31 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:31 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Tue,  3 Jan 2023 15:55:01 +0100
Message-Id: <20230103145503.71712-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 59 +++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  8 +++++-
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0859981726ac..56486f24b4c5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1793,10 +1793,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
 
@@ -7105,6 +7120,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7147,12 +7164,38 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
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
+
+	/* Otherwise use single-actuator dev info */
+	if (bfqd->num_actuators == 1) {
+		bfqd->sector[0] = 0;
+		bfqd->nr_sectors[0] = get_capacity(q->disk);
+	}
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index de2b2af643e5..830dda1f9322 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -814,7 +814,13 @@ struct bfq_data {
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

