Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD3EC636D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 09:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBBJNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBJNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 04:13:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE26D07C
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 01:12:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so846400pgh.7
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=an8+hPB2Xu1xsfmQo6cipch9deRYDDGNvCCNEsKDhlc=;
        b=A0hm7TQRQaX2uKwPkIU4Vezt9zPt6gUZY1/GlNoqlsBqdYoEkjiSZfh0p4YjMih5IL
         RCD6i2BuSeQpVsumt8b5IYmT8o58d4HEw4m0EQpVK1GNJitR1ObfJbw1J8SRzXcyX8sC
         mjiY5bSCOKsOUed05ovfnT5HKXOSz2DD1USvUDREmYIwfk8fqcopcFyot/VkaZEuuPab
         tfiYC6xzBr46syeVL6kc+ll24A+jTI3wFahRMEuyJHypAc9rwi0/z+T/gCI7L5bV/ZT1
         QWSZzjGKM9UQa3WDaO2wUB3pTgzYUWdCrYAHTwOhcm5LlpYJkfkKnlogpTPbO+zXqGpJ
         iPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an8+hPB2Xu1xsfmQo6cipch9deRYDDGNvCCNEsKDhlc=;
        b=evFSDQO3J/8Tl4r+3rA5NHGytL5rDSzAzKfWObbR9chW2aWjdxk9lLssZDTVPEVu3o
         SCRKvNlNsnbG69ed0ayvkwU7NQPhduXfO/jKtI53gwgk1Hr6u7gloBm1zsvClQYFLBLf
         /QPuOcnQHD/Lqvkn7pfXCgS3x+mZetRg6pmnFI6HcOXAP+rvs7w0/d7QLI+nHym63ZZ8
         I2ui5ACx2sw0Nw0QFp5p82xTGNz7oXPJaG+Le/g58YaBAbA+ZDPF6Cqfy5fETT8CsFjp
         EUsZrH5ru1NH4kO2WUEUs9+OdMkkEfq9HtQS58IfUYWzXcQi6j8gGBzQm1CgJjwLN3I7
         iwxg==
X-Gm-Message-State: AO0yUKVatZVxCLemaL8YQSrVXMlO2BfThycatjKBr4FpQ1mhLdP5+hOG
        gantDoBllg3OrVyjUksG1GA635UsBN7TJg==
X-Google-Smtp-Source: AK7set+hZfr1QgL4FFX6HpPdEMYvBxkJNy+3ChpZVQKR1l/4O9YxGhOjC5wNlF9ChrGjkp7tCkj+FQ==
X-Received: by 2002:a62:1593:0:b0:593:cda6:f402 with SMTP id 141-20020a621593000000b00593cda6f402mr5329237pfv.17.1675329149060;
        Thu, 02 Feb 2023 01:12:29 -0800 (PST)
Received: from localhost.localdomain ([132.226.22.23])
        by smtp.gmail.com with ESMTPSA id d6-20020a621d06000000b00593c434b1b8sm7570180pfd.48.2023.02.02.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:12:28 -0800 (PST)
From:   Juhyung Park <qkrwngud825@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Juhyung Park <qkrwngud825@gmail.com>
Subject: [PATCH] block: remove more NULL checks after bdev_get_queue()
Date:   Thu,  2 Feb 2023 18:11:51 +0900
Message-Id: <20230202091151.855784-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev_get_queue() never returns NULL. Several commits [1][2] have been made
before to remove such superfluous checks, but some still remained.

[1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
[2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")

Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 block/blk-zoned.c       | 4 ----
 include/linux/blkdev.h  | 7 +------
 kernel/trace/blktrace.c | 6 +-----
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 614b575be899..40a3e59fb8e0 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -342,8 +342,6 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
 
 	if (!bdev_is_zoned(bdev))
 		return -ENOTTY;
@@ -400,8 +398,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
 
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

