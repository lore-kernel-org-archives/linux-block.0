Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E971C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90E820786
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhA0QJA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhA0PCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D70C061351
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 07:00:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b21so2802587edy.6
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooV+zYcH2UW7H93/HJsVkbGNha3ok5dAmhicUP0PDyw=;
        b=SERtrejDbIU66Dqc8InTYP1YkIPUZaIgkL144/shNCLfnHrupy2oqUIOtE/Zhm5USG
         94O1TJuZ4i0bbKwdQFnwmQyl2mg42DEyI04IcC13mMzo9T0VH4XOqMZomlD53z0hX/Ba
         WRZIq/a9nF1xSS41HfAzQdA8xDtg5c/ZfhxJ8YvOsJ9JtqTHABHhYriNlTxfTYv+GGpz
         +vdEPR3GQSd/NBT0s2oaUePKpfgiGSYGQFxa8YhoC99YGGK+eAaoCItzBgAfgCZO9FAL
         6bB9KrqxmzMRpQ9qbBg16O0YYhyLVnbjSu6eIepSQjgpSG0fElXjCW9V/e6wChGbwlXO
         7pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooV+zYcH2UW7H93/HJsVkbGNha3ok5dAmhicUP0PDyw=;
        b=pzGtSH94H/nn1Kn68VRtxxKk0Okm9qFyI7Yktz69jtQzAXr9A9rm/CkCX159BYW77o
         X3bnqWC7PCE/hB5hYBrsVDaTuWYK2Pa7URi8LGqhWcNm5SLLFyKNDMISR6pibLuaT/jq
         V2cXe7LOJr/ctPm6PJFGQbyzlHAKoPDFIIQq/TsEz0CalqhELUgWipBLI3MQ7jzTbu+w
         Bv5pLqKh3zh4OO/F1LxR6uGzr83E/blc3IuWY3uEvk3//B/+o6M43KI3BadMQoBmYzxN
         DNG2AlKSBJSPGAX5WfIyE7D0+OfZWguC/H7rRCG7IFcxhV8dBHmvlyXx2Ki1BgpXxro1
         yqcg==
X-Gm-Message-State: AOAM533gZ8DpNtGap/E8qJLcoK2teJShQexdts4JaX6zNnHaRW4rzyIJ
        1r2X/8rQmUgjciAjeC0AbDvRlA==
X-Google-Smtp-Source: ABdhPJyPQolfLbnD6xkrUssjvLjsj2SQfhEUMNQlOwRYJm5sVBj9DzLq8ASgyCQKWZh63WGHnGBILA==
X-Received: by 2002:a05:6402:13c8:: with SMTP id a8mr9211317edx.191.1611759599112;
        Wed, 27 Jan 2021 06:59:59 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:9172:bd00:1e95:fbc9])
        by smtp.gmail.com with ESMTPSA id j4sm1477140edt.18.2021.01.27.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:59:55 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/4] block: call blk_additional_{latency,sector} only when io_extra_stats is true
Date:   Wed, 27 Jan 2021 15:59:30 +0100
Message-Id: <20210127145930.8826-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If ADDITIONAL_DISKSTAT is enabled carelessly, then it is bad to people
who don't want the additional overhead.

Now add check before call blk_additional_{latency,sector}, which guarntee
only those who really know about the attribute can account the additional
data.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4271c5a8e685..f62cfc8f801e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1313,7 +1313,8 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
-		blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
+		if (blk_queue_io_extra_stat(req->q))
+			blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1332,7 +1333,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
-		blk_additional_latency(req->part, sgrp, req, 0);
+		if (blk_queue_io_extra_stat(req->q))
+			blk_additional_latency(req->part, sgrp, req, 0);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1365,7 +1367,8 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
-	blk_additional_sector(part, sgrp, sectors);
+	if (blk_queue_io_extra_stat(part->bd_disk->queue))
+		blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -1400,7 +1403,8 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
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

