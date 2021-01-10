Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DCBC43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DF722CAF
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbhAJJqE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:46:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48834C0617A4
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ce23so20452396ejb.8
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hf/mF6iwnrVFlIuClv3PcBYTzfxrz6M0GNkOg7s98nM=;
        b=EprqDYrmfym7cJ0YEoYR0CbcvJG3noO3YzCGn/zI6MF6UIJ4PtythWtgbo/iQZXjNg
         opAJ+MMXsBVhFM7uXGmeSO9G/7+cNS2XVwZ1hsSwcSkjwrhnUb/6Ae286op4uFGghwtm
         h6dgQ1tlEuZpELzp7wDHZ4mYkeXdyYMID+1z1mlyjAye/eiUXgQePcSbChMig9V10/9b
         yr55KOqcJhN4mc+VP811+wdNnITI6GFfko8vM98yYw0ZZeZ5Y8lS8hnIp1glSuMIh4I2
         SsKtAVidcMaprol8dbYBuWO4DkavoZQmvU8zUrXcbZ5Y3K4Fy05UfRiPF0TDk8hVzt7a
         +htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hf/mF6iwnrVFlIuClv3PcBYTzfxrz6M0GNkOg7s98nM=;
        b=i4GAs583DW/VKSizgO9i7/GcMykeIQxplhw9VIndapYvi02Rn1+rJrHBa6fFyhBDh6
         aUUF97JOpxs8ilb7BMGuXHoPaSo37upgzLNE6BZZ7KHPUIJV/U9lYoJlS/4k76xlnPM6
         9yEguUZ0xInquUDklrRt9q7Vkoy2nB+hpJW6Zx5+MAVyfjfKScwHqmhYVRt8RZBqfYxJ
         GmVbPyspzietvqyx8YjKhyrsdvEl6U30SLJAw1sTdaABr+cIScNg9yR/HkS7ln+sCxZu
         PReV8APMVOyKgdgOjmjHzGg7OdS7GELWhYY8mmqSQP2LhPF+BVJVCFt0CI54ItDWgJf9
         GoPg==
X-Gm-Message-State: AOAM530NRsAooim8klwja6Qv302gtfFzlib+pL8910pJk+nBOvbUhFLZ
        PqS53rS1YXCwEMlR3sPHcGx8gA==
X-Google-Smtp-Source: ABdhPJyhJBECWKPtxe6RSyS9IDwuyMuIprm5wt2YT0YLKP60qNy6LhkWVbF8SZaaDngCVbSQDN/F/g==
X-Received: by 2002:a17:906:7d09:: with SMTP id u9mr7223201ejo.380.1610271921876;
        Sun, 10 Jan 2021 01:45:21 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f4fd:e8ab:2d54:e8c])
        by smtp.gmail.com with ESMTPSA id k15sm5549675ejc.79.2021.01.10.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 01:45:21 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V4 4/4] block: call blk_additional_{latency,sector} only when io_extra_stats is true
Date:   Sun, 10 Jan 2021 10:44:57 +0100
Message-Id: <20210110094457.6624-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
References: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If ADDITIONAL_DISKSTAT is enabled carelessly, then it is bad to people
who don't want the additional overhead.

Now add check before call blk_additional_{latency,sector}, which guarntee
only those who really know about the attribute can account the additional
data.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 719595578bc8..c38287d34825 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1326,7 +1326,8 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
-		blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
+		if (blk_queue_io_extra_stat(req->q))
+			blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1345,7 +1346,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
-		blk_additional_latency(req->part, sgrp, req, 0);
+		if (blk_queue_io_extra_stat(req->q))
+			blk_additional_latency(req->part, sgrp, req, 0);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1374,7 +1376,8 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
-	blk_additional_sector(part, sgrp, sectors);
+	if (blk_queue_io_extra_stat(part->bd_disk->queue))
+		blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -1406,7 +1409,8 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
-	blk_additional_latency(part, sgrp, NULL, start_time);
+	if (blk_queue_io_extra_stat(part->bd_disk->queue))
+		blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
-- 
2.17.1

