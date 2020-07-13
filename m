Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBEBC433E3
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCFD2077D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KelQ9BQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGMVN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMVN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9BC061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so19073667eje.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJMcJABSB/bCBpwMur78CQyT/owz2aaF5PWtEB9Jy/E=;
        b=KelQ9BQts1V2yhZzjuoSfy9mCLYfZtbGEavD0oO3ekJLWW+4hfYIu5OrdHBmQni+cL
         DWpQ9GIVNJ/j5Fk+iLvaq+/fcCNy3Wie0CNYWWubvMjC6trtIXJ1+lyT79t4Uibwyatq
         vkv4k7hmkKXIyjq7krAZRVtnJAs9aQ0UpjeaVI8lsvAR8ityfem1AU4eCxLjtd6B94uu
         1gpIxsDrtqS+vBbd1WKUGVvMISlwce0yE4bc7sR9AOMUw0s7LIS6X8JePWx116zTdFJa
         amLtrM0yi2adeY2WIkEN+4mDr8HtrH37w9dVb1J11dVJxeRSHDkzxxx4hIGsxAwX/mfd
         RwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJMcJABSB/bCBpwMur78CQyT/owz2aaF5PWtEB9Jy/E=;
        b=UsUR4AkxqMV46xNKmYJYBAr5Q+bddbvtO5/a+mQyJuyRwPePt3Yer1cZKTYbcWagmi
         h4z0YEMceHFXVoucB5C/e8oZ6DENsuwy2OrBQw41zScm/M1KRI7Jj217piX6buQR4rUw
         x1gKXckRSe5fb25/Q8efSXXvqgVEdI9FdfyDJCuo8C6I8YYsvg56IE+Oy8ilU7B/G6Nq
         O0ypfejAe7vGr5YDEJ/16rqEp66xhFsID3IowpnF9+bTynZHlwKQiuJiiu3b1qYI7UPX
         x4ygMV1TwxWexsJvuVMJPTn6FuRifVZMAtnenBpCEL8BY/5Pd5povJyQmrR8PkH9yVav
         sQXA==
X-Gm-Message-State: AOAM533djDkJuv+9Mgchhbhewt/OR/l9NIV4pkdj4P1uyyVJb/g+6TaV
        GjeSyA2nK2gszQ3U5RTQ4VzL/Q==
X-Google-Smtp-Source: ABdhPJySb9EyALbUVk4lMtN3lDF0dPtJ9EMxIr67gF6NR7n2N1g7t2ihMIf7t4S+qidOVWy9M+v+ZA==
X-Received: by 2002:a17:906:8688:: with SMTP id g8mr1511529ejx.505.1594674836490;
        Mon, 13 Jul 2020 14:13:56 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ab:24b8:5892:2244])
        by smtp.gmail.com with ESMTPSA id d5sm12715770eds.40.2020.07.13.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:13:56 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V2 4/4] block: call blk_additional_{latency,sector} only when io_extra_stats is true
Date:   Mon, 13 Jul 2020 23:13:21 +0200
Message-Id: <20200713211321.21123-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
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
index b67aedfbcefc..171e99ed820b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1458,7 +1458,8 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 		part_stat_lock();
 		part = req->part;
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
-		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
+		if (blk_queue_extra_io_stat(req->q))
+			blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
 #endif
 		part_stat_add(part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
@@ -1482,7 +1483,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		update_io_ticks(part, jiffies, true);
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
-		blk_additional_latency(part, sgrp, req, 0);
+		if (blk_queue_extra_io_stat(req->q))
+			blk_additional_latency(part, sgrp, req, 0);
 #endif
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
@@ -1516,7 +1518,8 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
-	blk_additional_sector(part, sgrp, sectors);
+	if (blk_queue_extra_io_stat(disk->queue))
+		blk_additional_sector(part, sgrp, sectors);
 #endif
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
@@ -1536,7 +1539,8 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 	part_stat_lock();
 	update_io_ticks(part, now, true);
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
-	blk_additional_latency(part, sgrp, NULL, start_time);
+	if (blk_queue_extra_io_stat(disk->queue))
+		blk_additional_latency(part, sgrp, NULL, start_time);
 #endif
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
-- 
2.17.1

