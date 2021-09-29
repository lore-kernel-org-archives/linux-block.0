Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB61613CD
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244495AbhI2HRt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbhI2HRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 03:17:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C59C06161C
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ty1jaPD9W5GzryVdHqtgej2P/CWnW7mHqDsPlNTMRWI=; b=sG/NJvaYFHi2H6Pf2w2hK6luGl
        KgKHQ7IOnfoK1MXAcn58dClHwCQtdejvH8xuRfVDRPkgK4uWEhhvxzXtHAvvL74oreHsJg3gpvSRw
        q8Be2ft3HjcufEqvdRu2B8NpRmk8aSbG/kRvzEr0LyLl/IaBH5FSoziodYtrIUXfQmN9pN4Nj/591
        UatxucWW8Em0ytRKiDMQrl+/ZbnOi1VABAzwuy/HUNsKunRwwHcCXsj5ZWmYCQYfESpOT7CkgjyOc
        OFPNmkTguFokoi5NghHXWIROzCLvFrjs4EkwEB2Ju9UuV8HuwX90molQTsVnC2TPbbTopmhfwro/i
        FFb4XIow==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVTnh-00Baxg-O4; Wed, 29 Sep 2021 07:15:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 2/5] block: factor out a blk_try_enter_queue helper
Date:   Wed, 29 Sep 2021 09:12:38 +0200
Message-Id: <20210929071241.934472-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
References: <20210929071241.934472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out the code to try to get q_usage_counter without blocking into
a separate helper.  Both to improve code readability and to prepare for
splitting bio_queue_enter from blk_queue_enter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 block/blk-core.c | 60 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c071f1a90b104..7e9eadacf2dea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -416,6 +416,30 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
+static bool blk_try_enter_queue(struct request_queue *q, bool pm)
+{
+	rcu_read_lock();
+	if (!percpu_ref_tryget_live(&q->q_usage_counter))
+		goto fail;
+
+	/*
+	 * The code that increments the pm_only counter must ensure that the
+	 * counter is globally visible before the queue is unfrozen.
+	 */
+	if (blk_queue_pm_only(q) &&
+	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
+		goto fail_put;
+
+	rcu_read_unlock();
+	return true;
+
+fail_put:
+	percpu_ref_put(&q->q_usage_counter);
+fail:
+	rcu_read_unlock();
+	return false;
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -425,40 +449,18 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
 	const bool pm = flags & BLK_MQ_REQ_PM;
 
-	while (true) {
-		bool success = false;
-
-		rcu_read_lock();
-		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
-			/*
-			 * The code that increments the pm_only counter is
-			 * responsible for ensuring that that counter is
-			 * globally visible before the queue is unfrozen.
-			 */
-			if ((pm && queue_rpm_status(q) != RPM_SUSPENDED) ||
-			    !blk_queue_pm_only(q)) {
-				success = true;
-			} else {
-				percpu_ref_put(&q->q_usage_counter);
-			}
-		}
-		rcu_read_unlock();
-
-		if (success)
-			return 0;
-
+	while (!blk_try_enter_queue(q, pm)) {
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
 		/*
-		 * read pair of barrier in blk_freeze_queue_start(),
-		 * we need to order reading __PERCPU_REF_DEAD flag of
-		 * .q_usage_counter and reading .mq_freeze_depth or
-		 * queue dying flag, otherwise the following wait may
-		 * never return if the two reads are reordered.
+		 * read pair of barrier in blk_freeze_queue_start(), we need to
+		 * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
+		 * reading .mq_freeze_depth or queue dying flag, otherwise the
+		 * following wait may never return if the two reads are
+		 * reordered.
 		 */
 		smp_rmb();
-
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
 			    blk_pm_resume_queue(pm, q)) ||
@@ -466,6 +468,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (blk_queue_dying(q))
 			return -ENODEV;
 	}
+
+	return 0;
 }
 
 static inline int bio_queue_enter(struct bio *bio)
-- 
2.30.2

