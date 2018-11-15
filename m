Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3CC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA62146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zqcKF6d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AA62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeKPGBC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44904 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so9953185plq.11
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MP5P1AyoI9WZaMp7Yr6iSxvqTi6dTbNRiicBr3AUvQI=;
        b=zqcKF6d/G2RY0eSaetQhZ4NiwwGA+kOFBmETwTDrKAGeM9bRGMj6b8ZLV5vtE5yyuI
         NxqUpXWPKB5PQZDvBUZxqWEQAi9Hwwtzl9HfcKTelEk/WrJ+qayfSLIvSW/L+FoIizID
         nMc+tyC1bFsEviQ2BmMPTgBTuj9BsLacYezNYzpuGnX3Hw2rjvCeOaY8TMnyhqMxP5X5
         uxEc2HISp6pEMAemRqFiiDrAwwXPKCZZ7xFWH4+lEYKJguWehoHm2BeToprEvHEt7PVO
         M4WqkvNAon0vYZBUCm2pf3OuAExQ746SjBp9Zb2flv18w28SX+B3HR44z1404LJl92bB
         WfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MP5P1AyoI9WZaMp7Yr6iSxvqTi6dTbNRiicBr3AUvQI=;
        b=OM3Qfl5SZ33HJn6CTcSaUQQ0D4grrjdODfusq5HI4xsUxOmIi06pbL0/xrj7zPPH4k
         GToZFBWj8u4YUdGVvPGj18ZjmK1CmSRXuXJR/ejMCGVb/H+zg3cTaprGvGy8fGDg8maM
         yWhSH4jkjeTPI2p3CMOSQ8oJZV8YEhmSbrxhq6f6beJwRpbheYy7TsYA5bc/voLjF576
         VeSXppVundgxTbWsWvBPhEoxqI/svL31r4TAF3D6GSdwIYDwcGph7WAoF8z/jn8cwDHz
         NzeeWCBML+iYpuSQX/Z5PlHeoYo3MjKDBUHz1wyLBoiJNi0OQduo86Phvxc/iLF8NMOW
         JCqQ==
X-Gm-Message-State: AGRZ1gLDzsWrDNV6NLYxPDM6aXAF7+XzxCRIFPgD2y7gNnf8uMnZji85
        8oJX5Bz+uLxJPzr13hpDpZ7b1rV8jv8=
X-Google-Smtp-Source: AJdET5dme0s+6Zn5RRzTfdeWkoif/Qq0pM+yH+vSIIuv7YOBG6HBxjpDxVUBb/XkV3FpN69e7AemVw==
X-Received: by 2002:a17:902:2ec5:: with SMTP id r63-v6mr7839372plb.330.1542311508808;
        Thu, 15 Nov 2018 11:51:48 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] block: avoid ordered task state change for polled IO
Date:   Thu, 15 Nov 2018 12:51:28 -0700
Message-Id: <20181115195135.22812-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure that writes to the dio/bio waiter field are ordered
correctly. With the smp_rmb() before the READ_ONCE() check,
we should be able to use a more relaxed ordering for the
task state setting. We don't need a heavier barrier on
the wakeup side after writing the waiter field, since we
either going to be in the task we care about, or go through
wake_up_process() which implies a strong enough barrier.

For the core poll helper, the task state setting don't need
to imply any atomics, as it's the current task itself that
is being modified and we're not going to sleep.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 4 ++--
 fs/block_dev.c | 9 +++++++--
 fs/iomap.c     | 4 +++-
 mm/page_io.c   | 4 +++-
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b246ed44c0..7fc4abb4cc36 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3331,12 +3331,12 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		ret = q->mq_ops->poll(hctx, rq->tag);
 		if (ret > 0) {
 			hctx->poll_success++;
-			set_current_state(TASK_RUNNING);
+			__set_current_state(TASK_RUNNING);
 			return true;
 		}
 
 		if (signal_pending_state(state, current))
-			set_current_state(TASK_RUNNING);
+			__set_current_state(TASK_RUNNING);
 
 		if (current->state == TASK_RUNNING)
 			return true;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index c039abfb2052..5b754f84c814 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -237,9 +237,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	qc = submit_bio(&bio);
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
+		smp_rmb();
 		if (!READ_ONCE(bio.bi_private))
 			break;
+
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(bdev_get_queue(bdev), qc))
 			io_schedule();
@@ -403,7 +406,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
+		smp_rmb();
 		if (!READ_ONCE(dio->waiter))
 			break;
 
diff --git a/fs/iomap.c b/fs/iomap.c
index f61d13dfdf09..3373ea4984d9 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1888,7 +1888,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			return -EIOCBQUEUED;
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+
+			smp_rmb();
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
diff --git a/mm/page_io.c b/mm/page_io.c
index d4d1c89bcddd..008f6d00c47c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -405,7 +405,9 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_get(bio);
 	qc = submit_bio(bio);
 	while (synchronous) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
+		smp_rmb();
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-- 
2.17.1

