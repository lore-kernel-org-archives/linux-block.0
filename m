Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FEBC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB94D2146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Juge2bx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB94D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbeKPGBD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so816187pgr.11
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FMTs3C4r9EHC31s/sU7DDsf/1xn5v8SxFDlkXY61qcI=;
        b=Juge2bx+u+W9xtKjSrjv7BrE6t9ix65K3/FhVQABXyl6ukFxi4L3ILMwwEJ1SrOoyL
         Kk2vQmG4OpWCquoHikM2NoZl3NO26t03aXawqH2EI0/pGYacpZcONoQ9uEez+7oXBgh1
         a9pBXgUXoBJfqAs/JxBGaJQmeQ+CrWev29wAT8KSXvaCyB8D071PrU7bmrYyiEz3Xfp8
         2lcbJ90EQeyXczXzFaDlC87qVbF7H2ZwJl5YYZBs3XxT/irK+zwjTd1B+4KEhexR+gfR
         McW3QtUqmsTSKXXScwCM/W9srJFUM+eiYQGDmAfZM2C6ohaXzROdEwWMvFSyVCeHhe84
         /Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FMTs3C4r9EHC31s/sU7DDsf/1xn5v8SxFDlkXY61qcI=;
        b=Q9k4gQtyzFeLjIVnabLJDJIyw5n+cAN4Bq9W6EpCqeDxeNvPtQAMvjWZMwNV/O7qmD
         /zqAwfT4fT48PMbL20O2wenhSluNhOWG8c7SEbli5xSQL4FPKjLD+IRhS5J7VO2DlqWf
         hBiMWcvjhT8txp1u+IXrh6km7DS1KmWfuR6qA421+FtEhnY8Cd4XnS3gjP5SZ1TByM8x
         g8UL2ITxJTGW1i432G7/p4XGyXBksYSCk3x1srtXNBODjyfnqImclP8WlmLztnBJ6fik
         XJ2SZXbPApiaLUcFa06bO1We9/rSjwueMjwPKgVJqSC0d/4ibv2JXo5fHI4WiaH2Bj2d
         7GMQ==
X-Gm-Message-State: AGRZ1gIf6DHCdqLGLpAL5A7ErC6SUotpB+xOCC5wICygsd0a9C9wmSjx
        1qa1/cCC8llg4G+deYd8FGsxvCJNcyY=
X-Google-Smtp-Source: AJdET5cEKlTcH7fQETz1Ob4oMCJEpgdf7hlZqOt45OCd2/SraTspObtPXltJbROABrBAK0eJfOLFfg==
X-Received: by 2002:a62:704a:: with SMTP id l71-v6mr7832104pfc.68.1542311510912;
        Thu, 15 Nov 2018 11:51:50 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] block: add polled wakeup task helper
Date:   Thu, 15 Nov 2018 12:51:29 -0700
Message-Id: <20181115195135.22812-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
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
 fs/block_dev.c         |  4 ++--
 fs/iomap.c             |  2 +-
 include/linux/blkdev.h | 13 +++++++++++++
 mm/page_io.c           |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5b754f84c814..0ed9be8906a8 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -181,7 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 	struct task_struct *waiter = bio->bi_private;
 
 	WRITE_ONCE(bio->bi_private, NULL);
-	wake_up_process(waiter);
+	blk_wake_io_task(waiter);
 }
 
 static ssize_t
@@ -308,7 +308,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		}
 	}
 
diff --git a/fs/iomap.c b/fs/iomap.c
index 3373ea4984d9..38c9bc63296a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1525,7 +1525,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		if (dio->wait_for_completion) {
 			struct task_struct *waiter = dio->submit.waiter;
 			WRITE_ONCE(dio->submit.waiter, NULL);
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 41aaa05e42c1..91c44f7a7f62 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1772,4 +1772,17 @@ static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 
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
+	else
+		wake_up_process(waiter);
+}
+
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index 008f6d00c47c..f277459db805 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -140,7 +140,7 @@ static void end_swap_bio_read(struct bio *bio)
 	unlock_page(page);
 	WRITE_ONCE(bio->bi_private, NULL);
 	bio_put(bio);
-	wake_up_process(waiter);
+	blk_wake_io_task(waiter);
 	put_task_struct(waiter);
 }
 
-- 
2.17.1

