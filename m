Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A4C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3812760F56
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhITL1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhITL1a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 07:27:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED470C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wM9ljo32u8IA+DsEVPLeOygnphzoWz71IcJFBVrpl+4=; b=gSyB+tM8M1Sg3O8qFI0nZz/RmS
        zl007OIgeq/UlQ8flYlcor96cHtgoNN+X2nS9gtmJ1wgCXjBBvIOYoGxqCcXqb5PJ/p4N9MuZSGrB
        igx2oCQ+J8PLqiMSz9J5uvz+66xh1xVmN/zNS7G6L7mTZFah+RVJ/zoufnrNT0q+dXiIbijrs4SHa
        iyY2h7iYmEB33I5a83L7HI0NyUMAyCNCKV0Y7MA1AJsYxFA9aNHhI/H0SN2hgSKSwlGDMPCJGaUes
        jh50hsq9qlZpPusiN6SWt12XhyKPS1VdoNdimyEE7/QtzSpX7NWMxfO+apkh7yIHUyJV5CkU+ZjZT
        zCXnuAWg==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHQJ-002c0w-Sg; Mon, 20 Sep 2021 11:25:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] block: split bio_queue_enter from blk_queue_enter
Date:   Mon, 20 Sep 2021 13:24:03 +0200
Message-Id: <20210920112405.1299667-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920112405.1299667-1-hch@lst.de>
References: <20210920112405.1299667-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prepare for fixing a gendisk shutdown race, open code the
blk_queue_enter logic in bio_queue_enter.  This also remove the
pointless flags translation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4c078681f39b8..be7cd1819b605 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -475,18 +475,32 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
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
 			bio_wouldblock_error(bio);
-		else
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
+		if (blk_queue_dying(q)) {
 			bio_io_error(bio);
+			return -ENODEV;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 void blk_queue_exit(struct request_queue *q)
-- 
2.30.2

