Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE3C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011D960F6E
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhIVR3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhIVR3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD77C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jxeLvb2sVuBkLJBMFla4xU/YWqPSe/vOO2Z+1ZdsSt0=; b=fdzIkyFmiafAzL1JjxgBqkqeOD
        FMpjtNL/RlWo6ekXB5TcQQAmQ+IRpcXRB5l4Sqm9CR8fUAUVSjv384a2XhfsUIno0grmOxmXu0mjz
        s/lfEccpTUUn9PyA1sQgYEpDXvA2bgjs7owLhHpCWQTS2IWrzzSNEUzIM/BCtXxNB7sErVBOKa+pe
        jY/5xznbSmzbTPqCqxKfybg3Gu3oMQivk0gtielJvoW6caUiYN8XgiVrJqKhO6jDgn5teZRrLee1S
        ScdVBhi/TQ5zu6RWRa2Oayey8uZzkKW6Xz9qDOm28FGjGN7Dg6yTMDpP4dIOmWCJWwrUjhXmwJtDK
        /v/iIJHQ==;
Received: from [2001:4bb8:184:72db:3a8e:1992:6715:6960] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT60U-004zBc-Jo; Wed, 22 Sep 2021 17:26:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] block: split bio_queue_enter from blk_queue_enter
Date:   Wed, 22 Sep 2021 19:22:20 +0200
Message-Id: <20210922172222.2453343-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922172222.2453343-1-hch@lst.de>
References: <20210922172222.2453343-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prepare for fixing a gendisk shutdown race, open code the
blk_queue_enter logic in bio_queue_enter.  This also removes the
pointless flags translation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4c078681f39b8..e951378855a02 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -475,18 +475,35 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 static inline int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
-	bool nowait = bio->bi_opf & REQ_NOWAIT;
-	int ret;
 
-	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
-	if (unlikely(ret)) {
-		if (nowait && !blk_queue_dying(q))
+	while (!blk_try_enter_queue(q, false)) {
+		if (bio->bi_opf & REQ_NOWAIT) {
+			if (blk_queue_dying(q))
+				goto dead;
 			bio_wouldblock_error(bio);
-		else
-			bio_io_error(bio);
+			return -EBUSY;
+		}
+
+		/*
+		 * read pair of barrier in blk_freeze_queue_start(), we need to
+		 * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
+		 * reading .mq_freeze_depth or queue dying flag, otherwise the
+		 * following wait may never return if the two reads are
+		 * reordered.
+		 */
+		smp_rmb();
+		wait_event(q->mq_freeze_wq,
+			   (!q->mq_freeze_depth &&
+			    blk_pm_resume_queue(false, q)) ||
+			   blk_queue_dying(q));
+		if (blk_queue_dying(q))
+			goto dead;
 	}
 
-	return ret;
+	return 0;
+dead:
+	bio_io_error(bio);
+	return -ENODEV;
 }
 
 void blk_queue_exit(struct request_queue *q)
-- 
2.30.2

