Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4921C636D3
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 02:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBCClO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 21:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCClN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 21:41:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A384B64
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 18:41:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be8so3925002plb.7
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 18:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnoc01wvPRQJ52KrNVkh97yIIzRWBJfpGiQjcsA49QA=;
        b=OS1T3tEZUlhCOzmKC4/aCwUPFQ0rCwIAYrGSRY+TvY2LlfhVP+pMft84bCxYIPgW6W
         mK8PE49axPPucfHU1GLvur73ukRDNtLXdqFPb7SmVXYVAhkoyQD5lulDDsH8Raw8Gg3f
         wMCMQ9VoNSq2Yqdbsa6P+52/8b50DADOaaqHbjrF9jTJTKym5uTne2i3D4vjln4XPkLC
         4qF5RTCEScJvrKlO9PXTOXmubD8ixeo/hRoEVIV4ohXuzI5DMhx+Gk+2O1uKSbCwwqLP
         bwdTFvBwQ6sTmRac3TvVacBijxkqE4Hq7ENjz3O8W7NdUr6oz676Y+OJmoOEizcIFj4m
         rq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnoc01wvPRQJ52KrNVkh97yIIzRWBJfpGiQjcsA49QA=;
        b=Ql4jz+ytA2wVyQ3VhwVzqwBgFBDuJhKXUjHQKAmhGUqtnSk2sO66Ufv1uINpxYSS6I
         NJoMqYNQq4f+DfdloWkvc4u6T7D8B/LgMsgARvy0rrJjJWPSK1Qta6FDtdvc0QupbO7M
         sCV2xQ6XCJkIglmYKQy8iJWC6CG/3PJH9SEIaiWEqcSEA/A1K5gQvm+0uRJgJUuglEXc
         3N1vlgwdjr2R/UvTtz4ys5U5yQ2bA1xx5yf/gOZmq41f8bVjOgNuukpycHRu0yfM139q
         aDXBj/v1SFyOytvr7fS0WVL7Rzk3AnJdJ6BJx/HQmehGg32prN3eWZrFP/qI4ivcK3MX
         CNOg==
X-Gm-Message-State: AO0yUKWepwVQkTRV1pibZpkpYgWk3GIAluXTsx3Pt4APfks+pDcDwo10
        P/2bgUcvCesj9UNTgbauxDeNIrXb5NXjzA==
X-Google-Smtp-Source: AK7set/3Tr5K6OgoHIKsmWuu82lwT4REN62BF267FOXdf2R6wlWI0lwcbbjLFSW6Mlf0tGhZ78uJ0Q==
X-Received: by 2002:a05:6a20:6a82:b0:be:b3c5:dabe with SMTP id bi2-20020a056a206a8200b000beb3c5dabemr8521461pzb.41.1675392071060;
        Thu, 02 Feb 2023 18:41:11 -0800 (PST)
Received: from localhost.localdomain ([132.226.22.23])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00248e00b00593deb1a329sm414872pfv.66.2023.02.02.18.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:41:10 -0800 (PST)
From:   Juhyung Park <qkrwngud825@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Juhyung Park <qkrwngud825@gmail.com>
Subject: [PATCH v2] block: remove more NULL checks after bdev_get_queue()
Date:   Fri,  3 Feb 2023 11:40:29 +0900
Message-Id: <20230203024029.48260-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev_get_queue() never returns NULL. Several commits [1][2] have been made
before to remove such superfluous checks, but some still remained.

For places where bdev_get_queue() is called solely for NULL checks, it is
removed entirely.

[1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
[2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")

Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 block/blk-zoned.c       | 10 ----------
 include/linux/blkdev.h  |  7 +------
 kernel/trace/blktrace.c |  6 +-----
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 614b575be899..fce9082384d6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -334,17 +334,12 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	void __user *argp = (void __user *)arg;
 	struct zone_report_args args;
-	struct request_queue *q;
 	struct blk_zone_report rep;
 	int ret;
 
 	if (!argp)
 		return -EINVAL;
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	if (!bdev_is_zoned(bdev))
 		return -ENOTTY;
 
@@ -391,7 +386,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	struct request_queue *q;
 	struct blk_zone_range zrange;
 	enum req_op op;
 	int ret;
@@ -399,10 +393,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!argp)
 		return -EINVAL;
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	if (!bdev_is_zoned(bdev))
 		return -ENOTTY;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b9637d63e6f0..89dd9b02b45b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1276,12 +1276,7 @@ static inline bool bdev_nowait(struct block_device *bdev)
 
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_zoned_model(q);
-
-	return BLK_ZONED_NONE;
+	return blk_queue_zoned_model(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_is_zoned(struct block_device *bdev)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 918a7d12df8f..e5e8963d6808 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -729,14 +729,10 @@ EXPORT_SYMBOL_GPL(blk_trace_startstop);
  **/
 int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 {
-	struct request_queue *q;
+	struct request_queue *q = bdev_get_queue(bdev);
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	mutex_lock(&q->debugfs_mutex);
 
 	switch (cmd) {
-- 
2.39.1

