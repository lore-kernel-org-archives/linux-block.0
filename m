Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678FFC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E164E22
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBAB2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhBAB2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 20:28:30 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9F1C0613D6
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:49 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e7so14087437ile.7
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TEvXXAsJa+fbqAOogzDUhmQbgub7pRgv5YEZ6rqL9EQ=;
        b=TXEcvFxYy7au4/4Xe7uwC6ISy73FDyWQjVFOE1W8aU8HQ7epiwfNxhnKh3ICDbwJBg
         9FEU0ijiVekZO3YL+5LicuhtzbwFcrbSSv9jgWVT4GSnPauhf6/6t2xcec03afziXdpg
         XbSe4Oj3jkZugts6wos+PbQe2PtPLvjwnY0yfwON7pEx4pnHIhc7k9K1RhZfNN2eupld
         KUNGpIMDrs6NpmUHHZ1jnUoJwZhUytgp1Lw1KhwGsVEaFATFeAswULYvNIAiz/jyglkC
         5hntTBNuUUSHyNsVUaMje7979A2DQJAxdhv2UJZw2uCGkNv0JvqT5Q3S0CShqKcuUaWG
         sMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TEvXXAsJa+fbqAOogzDUhmQbgub7pRgv5YEZ6rqL9EQ=;
        b=EQ4ojgWFHqwu6mrqzkfoNb1EywXTE7Jo2x/dRUcgAVcVxDwMywWUBdE8SfJD14nEHJ
         MfDwOTBgKLXb68V5q/D2uYFQxT6kslwcqPBnVaVckszjDMbiyMrQL5GncGHHqWjvPGpn
         XZf3YD4FR0qn30wkZKafhHVQeRw9/bVVIiW9+9IXKXrnkl2Lju2phiNBMAnui873+TLT
         iWrNDttIgnodK+UGqaeqmISo6nIxNd5+DPaXvH/aQWTYeURr+6FMH6NjBsl3py7N85dY
         RCalZIq+vu4DslRBD4LPWWLmjXaEouXtF+DvdjanQ2jBAPJ+DfsZwWqM2XHH1qwcpVG+
         nKFQ==
X-Gm-Message-State: AOAM53089di3HKg2KvXCTvQPgPOfOKTBxfti5qGZ3jygkhbt3cJYi261
        l0IG+yOgjGCT2H0u8UJ69xxI/w==
X-Google-Smtp-Source: ABdhPJxKp3iFDlUaC8m9MO7gIcwzh7Gjyb3KkTbugIJcCFOstiqIhC3yXObeqY71y1Y97kly+F52SQ==
X-Received: by 2002:a05:6e02:e87:: with SMTP id t7mr11858960ilj.121.1612142868537;
        Sun, 31 Jan 2021 17:27:48 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:994d:fb60:3536:26f])
        by smtp.gmail.com with ESMTPSA id c19sm8539627ile.17.2021.01.31.17.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 17:27:47 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, hch@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 4/4] block: call blk_additional_{latency,sector} only when io_extra_stats is true
Date:   Mon,  1 Feb 2021 02:27:27 +0100
Message-Id: <20210201012727.28305-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
References: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now add check before call blk_additional_{latency,sector}, which guarntee
only those who really know about the attribute can account the additional
data.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bdd5fe6f92a0..a44684033382 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1265,10 +1265,14 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 }
 
 static void blk_additional_latency(struct block_device *part, const int sgrp,
+				   struct request_queue *q,
 				   unsigned long duration)
 {
 	unsigned int idx;
 
+	if (!blk_queue_io_extra_stat(q))
+		return;
+
 	duration /= NSEC_PER_MSEC;
 	duration /= HZ_TO_MSEC_NUM;
 	if (likely(duration > 0)) {
@@ -1281,10 +1285,13 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
 }
 
 static void blk_additional_sector(struct block_device *part, const int sgrp,
-				  unsigned int sectors)
+				  struct request_queue *q, unsigned int sectors)
 {
 	unsigned int idx;
 
+	if (!blk_queue_io_extra_stat(q))
+		return;
+
 	if (sectors == 1)
 		idx = 0;
 	else
@@ -1300,7 +1307,7 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
-		blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
+		blk_additional_sector(req->part, sgrp, req->q, bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1319,7 +1326,7 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
-		blk_additional_latency(req->part, sgrp,
+		blk_additional_latency(req->part, sgrp, req->q,
 				       now - req->start_time_ns);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
@@ -1353,7 +1360,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
-	blk_additional_sector(part, sgrp, sectors);
+	blk_additional_sector(part, sgrp, part->bd_disk->queue, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -1388,7 +1395,8 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
-	blk_additional_latency(part, sgrp, jiffies_to_nsecs(duration));
+	blk_additional_latency(part, sgrp, part->bd_disk->queue,
+			       jiffies_to_nsecs(duration));
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
-- 
2.17.1

