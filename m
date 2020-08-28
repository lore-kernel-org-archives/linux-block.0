Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BCC433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DE920872
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NbWA4hl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgH1Clf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgH1Cle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 22:41:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391A7C061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 19:41:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so4739671pgd.5
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AqtXz+RzNuaCJACJob/RUBKlvL71GZDoXYs785TEnX0=;
        b=NbWA4hl1VBsaBS2r7yd03Nh/ZwScUYe5MoSNB4nrvAAUxFHkANuUWnVThkOdoD26FD
         DhTTh9d5HfCVImAZAtsfP8rHZaj3bP4MJSNMMK9qh82zFj3gg9ogscQTx3VDlccVDY8v
         27ca7B71Q48gmD/yhOYgsFkW84oDe+g7LY2+PZ0ooPsLfUl465vnUMXpsuVrAjXLm36I
         3GIt7ZxewRXcd6SVNBjBVQetecEzbAJQBvS8KemyvuJU9UOE8vuRfnK+IYCnHa7XI6Dk
         2Orv3SaflusvwQ44Q46Aiz7L+RrID+0kofRC0ro2Vk+mgm2Cej7iZPC7gtGPeZ5gKQFb
         hDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AqtXz+RzNuaCJACJob/RUBKlvL71GZDoXYs785TEnX0=;
        b=HX77Mio1pmH405c/X3oVqt1Ny7SktJnaaq3AzvRY6JgQvLWTa/QmT6rjoOLTq4Bm3D
         JGbs7YqDdMZT+1DMEBJNIsKlifPJoltTwFmAxCjzIxiKS1oLOgWeHa0dYaTzoWVwXO6x
         Lxu/XREjlLmztElzlBBugOQaWm7n6c4sFt03p+IrMF9Iug8/fLU1hMQ7//XvCqae23K7
         sd3unUlmqkpJ5tqvy9hurZP/A1OTtnYohebGNkZCiydKykKfmnUlgJHye8UWu1RFu/fO
         z3b7vnjTycyQ+M0G4p/1P2RGIu0YA43+lOJA5Q9zdASmaJ3E71OGoy4taKuKqRh0apYq
         gcIg==
X-Gm-Message-State: AOAM533VEdTLz+4WdzKFhyUpe7MSMUn2YUWANKc6nSDQ+k9hqSG1A8lG
        sd384K0+cuI9/Y/np+YtXMQ19uSrD0HEx2tD
X-Google-Smtp-Source: ABdhPJzBxDs1uqnFZawkGiIq7T6AsVUz5Shkj4O1iQKnWJ+9elrkKG7xRUZQDgnyfzdGexQEqVdOFg==
X-Received: by 2002:aa7:96f4:: with SMTP id i20mr14422182pfq.312.1598582493083;
        Thu, 27 Aug 2020 19:41:33 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e23sm3569109pgb.79.2020.08.27.19.41.31
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 19:41:32 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] block: defer task/vm accounting until successful
Message-ID: <bcee7873-198d-1e4a-27b6-8209f6154787@kernel.dk>
Date:   Thu, 27 Aug 2020 20:41:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently increment the task/vm counts when we first attempt to queue a
bio. But this isn't necessarily correct - if the request allocation fails
with -EAGAIN, for example, and the caller retries, then we'll over-account
by as many retries as are done.

This can happen for polled IO, where we cannot wait for requests. Hence
retries can get aggressive, if we're running out of requests. If this
happens, then watching the IO rates in vmstat are incorrect as they count
every issue attempt as successful and hence the stats are inflated by
quite a lot potentially.

Abstract out the accounting function, and move the blk-mq accounting into
blk_mq_make_request() when we know we got a request. For the non-mq path,
just do it when the bio is queued.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..aabd016faf79 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
-#include <linux/task_io_accounting_ops.h>
 #include <linux/fault-inject.h>
 #include <linux/list_sort.h>
 #include <linux/delay.h>
@@ -1113,6 +1112,8 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	struct bio_list bio_list_on_stack[2];
 	blk_qc_t ret = BLK_QC_T_NONE;
 
+	blk_account_bio(bio);
+
 	BUG_ON(bio->bi_next);
 
 	bio_list_init(&bio_list_on_stack[0]);
@@ -1232,35 +1233,6 @@ blk_qc_t submit_bio(struct bio *bio)
 	if (blkcg_punt_bio_submit(bio))
 		return BLK_QC_T_NONE;
 
-	/*
-	 * If it's a regular read/write or a barrier with data attached,
-	 * go through the normal accounting stuff before submission.
-	 */
-	if (bio_has_data(bio)) {
-		unsigned int count;
-
-		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
-			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
-		else
-			count = bio_sectors(bio);
-
-		if (op_is_write(bio_op(bio))) {
-			count_vm_events(PGPGOUT, count);
-		} else {
-			task_io_account_read(bio->bi_iter.bi_size);
-			count_vm_events(PGPGIN, count);
-		}
-
-		if (unlikely(block_dump)) {
-			char b[BDEVNAME_SIZE];
-			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
-			current->comm, task_pid_nr(current),
-				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
-				(unsigned long long)bio->bi_iter.bi_sector,
-				bio_devname(bio, b), count);
-		}
-	}
-
 	/*
 	 * If we're reading data that is part of the userspace workingset, count
 	 * submission time as memory stall.  When the device is congested, or
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0015a1892153..b77c66dfc19c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -27,6 +27,7 @@
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
+#include <linux/task_io_accounting_ops.h>
 
 #include <trace/events/block.h>
 
@@ -2111,6 +2112,39 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	}
 }
 
+void blk_account_bio(struct bio *bio)
+{
+	unsigned int count;
+
+	/*
+	 * If it's a regular read/write or a barrier with data attached,
+	 * go through the normal accounting stuff before submission.
+	 */
+	if (unlikely(!bio_has_data(bio)))
+		return;
+
+	if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
+		count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
+	else
+		count = bio_sectors(bio);
+
+	if (op_is_write(bio_op(bio))) {
+		count_vm_events(PGPGOUT, count);
+	} else {
+		task_io_account_read(bio->bi_iter.bi_size);
+		count_vm_events(PGPGIN, count);
+	}
+
+	if (unlikely(block_dump)) {
+		char b[BDEVNAME_SIZE];
+		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
+		current->comm, task_pid_nr(current),
+			op_is_write(bio_op(bio)) ? "WRITE" : "READ",
+			(unsigned long long)bio->bi_iter.bi_sector,
+			bio_devname(bio, b), count);
+	}
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2165,6 +2199,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	blk_account_bio(bio);
 	trace_block_getrq(q, bio, bio->bi_opf);
 
 	rq_qos_track(q, rq, bio);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 863a2f3346d4..10e66e190fac 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -253,4 +253,6 @@ static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
 	return NULL;
 }
 
+void blk_account_bio(struct bio *bio);
+
 #endif
-- 
Jens Axboe

