Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1EE61357
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbhI2HSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244525AbhI2HSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 03:18:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F4C06161C
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oxI/8lPEJfWtWdBWVtbiXUIJPjdaqcR+MzFeL86W57w=; b=Prv8Fqo/qYnH2DAdxNJ5nFgMMl
        FT3olYTuXnNCwy1Pi0pCFIzUBM0+H7V/dyRgBVRvf5ujyXwi561yQxc9jZpviXa1SjfBt5B9V5Rzs
        eF7A2rMP1sa0/MwIbh1xxe43jVhtepssP0EOU283xudr7/60Y7VNb/c0hNUb/zoMKlnCEFS6+431Q
        jKHNI5YBX2MoRMqBfgLkPU0WdPaSLUdftLSjUJJW4ErAy9cyPavd/ra9Pg/fJQiNMpDPWa/bcUAEK
        +Y+2Vhg++Ofi8PnEcsZ9r90LAgt7LTlVsNuiNFX9iS8V5Ghv/xOzd9gUXM84ZFaXkLQtjPQMJ0TAU
        CdQHXgGg==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVTog-00Bb0X-2o; Wed, 29 Sep 2021 07:16:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 3/5] block: split bio_queue_enter from blk_queue_enter
Date:   Wed, 29 Sep 2021 09:12:39 +0200
Message-Id: <20210929071241.934472-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
References: <20210929071241.934472-1-hch@lst.de>
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
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 block/blk-core.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7e9eadacf2dea..43f5da707d8e3 100644
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

