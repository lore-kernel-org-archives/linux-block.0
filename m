Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50595C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0316A2086B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UtL1+wZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0316A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbeKNBl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40740 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:29 -0500
Received: by mail-io1-f65.google.com with SMTP id r7-v6so9076920iog.7
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3QTSyKfY52eaKEQnnBSr2hXmi3YRIQACfEK6foU/bE=;
        b=UtL1+wZmkLMoO+F6QQmcXux58xNjFL2HOgH1GHhgFPFVFc9GMq/ab0pKUKGsAfAGdA
         gegrFrqwQ90QEvN9zCQXN769Bj9t7CegKJqKG0WILivY4M0uRuTtrvOQrS8zLgUBwZTm
         os7Agl6Q/RZXG5XLXfwevJKxh3K2N0WBJju2XglhCnMlZ9WAQxQCRyW963AAQfMf5tWn
         0gt+/nvi/b6/IA0tkksX/VJYl7dfw7yiigyiVxso7PjdIACnObVq+uRT7bJMtcImDP2t
         hu/Rl+Vsmf6IUBlg+BVUKKG35LzW+riGKAYRBxeCnsrumdw1U3Z+DEa8RtRbdczwDvM5
         ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R3QTSyKfY52eaKEQnnBSr2hXmi3YRIQACfEK6foU/bE=;
        b=m6Exrw9G1NGo9tCbICFu1NGu/GTIlOyR0wCKr+X5vafrRhQ3F9PRjfJmcwy3LwjMho
         xwwSK2QIPIaXI4NR/kN98MHGnmcU/zyjI2Q2zVWLfsp7lrFZnihA70y8T05jnMzTVRGF
         jpI9qbFVjgRSjL+1YUbzq8xz0XMp4LrXpj7Q2aOQawZtBPL2a4Oa4y9t9qHEw7259wf+
         mw1FvL+8rU3cYnixtY79ePsUXPw2Ib15Juw94Xqya70+3ZRIn2Q/CHy1ul+Fi6pmqitK
         xYU2dRsuYUOEwXgAkGouVbk3IXSApx0qNjNl6Yi1mtPJMcCI9sa//Fe53MVUkD3zvmmQ
         iImQ==
X-Gm-Message-State: AGRZ1gJrrn/e+QnU/0XT/sA5RS1iMfO5Cin3ywPEvcxcB+XUe0Nv0Q/h
        //BD8ybqSKx5pzOAwPZUk5aeziZrhjM=
X-Google-Smtp-Source: AJdET5e3EHMqfxBNxhlC0gjP89X++GBDcHZYcVn4fr4bg20gR0LgFae/PAywMxenlK2IF9l9qousew==
X-Received: by 2002:a6b:9309:: with SMTP id v9-v6mr4019472iod.239.1542123769688;
        Tue, 13 Nov 2018 07:42:49 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] block: add polled wakeup task helper
Date:   Tue, 13 Nov 2018 08:42:28 -0700
Message-Id: <20181113154233.15256-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're polling for IO on a device that doesn't use interrupts, then
IO completion loop (and wake of task) is done by submitting task itself.
If that is the case, then we don't need to enter the wake_up_process()
function, we can simply mark ourselves as TASK_RUNNING.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c         |  6 ++----
 fs/iomap.c             |  3 +--
 include/linux/blkdev.h | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2f920c03996e..0ed9be8906a8 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -181,8 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 	struct task_struct *waiter = bio->bi_private;
 
 	WRITE_ONCE(bio->bi_private, NULL);
-	smp_wmb();
-	wake_up_process(waiter);
+	blk_wake_io_task(waiter);
 }
 
 static ssize_t
@@ -309,8 +308,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
-			smp_wmb();
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		}
 	}
 
diff --git a/fs/iomap.c b/fs/iomap.c
index 7898927e758e..a182699e28db 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1526,8 +1526,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->submit.waiter;
 
 			WRITE_ONCE(dio->submit.waiter, NULL);
-			smp_wmb();
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ad8474ec8c58..d1ef8cbbea04 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1798,4 +1798,23 @@ static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 
 #endif /* CONFIG_BLOCK */
 
+static inline void blk_wake_io_task(struct task_struct *waiter)
+{
+	/*
+	 * If we're polling, the task itself is doing the completions. For
+	 * that case, we don't need to signal a wakeup, it's enough to just
+	 * mark us as RUNNING.
+	 */
+	if (waiter == current)
+		__set_current_state(TASK_RUNNING);
+	else {
+		/*
+		 * Ensure the callers waiter store is ordered and seen
+		 * by the ->bi_end_io() function.
+		 */
+		smp_wmb();
+		wake_up_process(waiter);
+	}
+}
+
 #endif
-- 
2.17.1

