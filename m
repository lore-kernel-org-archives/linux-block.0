Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA4C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE842080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aSBJLmT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE842080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeKRICG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so11857824pgg.1
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PncRR/XNvCzHFApU1TwopG2wJbE77TRgVK2hhkw731Y=;
        b=aSBJLmT0aMpIufp82xThHgCg3ZyqhDefx8lfo0CMzaDL7a/HfZl1Ip6yImObblr605
         GLxn1lSZr2TVrm1yznT1LRxF5kQkowtFMgidjV5c6jP4hE0DOoIRPgAknFNckT39mN/q
         F8fwK4gCOK1X7uDpcqmntsgCIOFj589lG/aB5JzERLc3GsrT21j+rP2nWfvMMZbhzvUc
         RoVwzx+U3AfBp2YIO59TbaewQNtQkuw09MQD7nLMnerxV0WAk1DPGecrhlO/mzGPe4TH
         hzWg3cxwMIZ8HkkSVL+vEiJtzD53eWbhvvMBEONsBQ4P0q8Nm1TKml7EAe1YsdYfL4EU
         gB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PncRR/XNvCzHFApU1TwopG2wJbE77TRgVK2hhkw731Y=;
        b=NmyARzlAnmoLfsTLFt4HayvUAgfLDt7JnXIUZdqqUjVx8yKOJcikPSmD16fBE+3eqi
         DHwXuacZucU6+5I/Kuc70B/6kIP1qKj+pB6tiHO/3OWevGjrWMSY8LDFuqUjhUgBlklW
         zB+FNaOoGFaZi+Wdo0sUFrMRaHQlgxz4BccEDxUm5xzG0Auk7FXlORPbuxtwRq3SacfW
         faEs97niZrj7YnoM7h/QUeIa1a8xDco3Ogr5WtjoEaW4kjPcQgu+qI4Q39TjcYROSpr4
         8XzqbZ7jQd+dReh5lgT9xMX2zqxb4HR+pYNXykI6o82WqyRDrkG76BRBkfu2WTQd7acq
         3jnw==
X-Gm-Message-State: AGRZ1gIpDVVWWCbWkrExORShHEX9pwNcZQb7VmMQQ3v/aCeGEVH+jr5Q
        kb1F0GzK+RF8zTFJ7PG/WCWxhgwE8rg=
X-Google-Smtp-Source: AJdET5eHlLE3mnf1/TVZSIj/gHtJAPEkX89yr2ox5Rds9Ayax1KpaREZk/NgIP3XkkBf3fh9bG9syA==
X-Received: by 2002:a62:d504:: with SMTP id d4mr4604539pfg.38.1542491042036;
        Sat, 17 Nov 2018 13:44:02 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] block: avoid ordered task state change for polled IO
Date:   Sat, 17 Nov 2018 14:43:48 -0700
Message-Id: <20181117214354.822-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the core poll helper, the task state setting don't need
to imply any atomics, as it's the current task itself that
is being modified and we're not going to sleep.

For IRQ driven, the wakeup path have the necessary barriers
to not need us using the heavy handed version of the task
state setting.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 4 ++--
 fs/block_dev.c | 7 +++++--
 fs/iomap.c     | 3 ++-
 mm/page_io.c   | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

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
index 4d79bc80fb41..64ba27b8b754 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -237,9 +237,11 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	qc = submit_bio(&bio);
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
 		if (!READ_ONCE(bio.bi_private))
 			break;
+
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(bdev_get_queue(bdev), qc))
 			io_schedule();
@@ -415,7 +417,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
 		if (!READ_ONCE(dio->waiter))
 			break;
 
diff --git a/fs/iomap.c b/fs/iomap.c
index b0462b363bad..c5df035ace6f 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1888,7 +1888,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			return -EIOCBQUEUED;
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 57572ff46016..a7271fa481f6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -405,7 +405,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_get(bio);
 	qc = submit_bio(bio);
 	while (synchronous) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-- 
2.17.1

