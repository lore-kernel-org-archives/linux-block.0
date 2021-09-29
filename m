Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7878C433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB347613CE
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbhI2HQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbhI2HQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 03:16:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4313EC06161C
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B0z2hterJsEZ0uB+UDzI9QETFX/AgAJ8GNSjVZy6apg=; b=G3d/rNg/yei0mkFmJ3sb1dG0SN
        4z/um29+ip7RHBdgcGYJ1oIhGpKSgj92NVhFIRKenpkvOmYO6ShdYHGAaDd09jS9J3zjdkMRxzkZA
        GWIzbDBLxtiH+WB9livHhyUZkAjnBRkq0GYVkYqqILz1+b7S5r/MZXukN4uqag0My8aD4HnGtzmsa
        5AaPXM59MkCcrACUfh+2r1D+rq2tFO5JV5U9TP8J69aYrO+ubAd9YP8pPkyyzz/m5AbF3PJM0jywn
        r59bjE9uG5h7AZiRYF7+Kr95Ox9UG268yp/WDkmt7Y84AnrfEynzrvQkneQSEu/1V+fTxl0ETKhpk
        4i7rMlnQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVTmr-00BavP-5G; Wed, 29 Sep 2021 07:14:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] block: call submit_bio_checks under q_usage_counter
Date:   Wed, 29 Sep 2021 09:12:37 +0200
Message-Id: <20210929071241.934472-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
References: <20210929071241.934472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure all bios check the current values of the queue under freeze
protection, i.e. to make sure the zero capacity set by del_gendisk
is actually seen before dispatching to the driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263b..c071f1a90b104 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -899,11 +899,18 @@ static blk_qc_t __submit_bio(struct bio *bio)
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	blk_qc_t ret = BLK_QC_T_NONE;
 
-	if (blk_crypto_bio_prep(&bio)) {
-		if (!disk->fops->submit_bio)
-			return blk_mq_submit_bio(bio);
+	if (unlikely(bio_queue_enter(bio) != 0))
+		return BLK_QC_T_NONE;
+
+	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
+		goto queue_exit;
+	if (disk->fops->submit_bio) {
 		ret = disk->fops->submit_bio(bio);
+		goto queue_exit;
 	}
+	return blk_mq_submit_bio(bio);
+
+queue_exit:
 	blk_queue_exit(disk->queue);
 	return ret;
 }
@@ -941,9 +948,6 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 		struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 		struct bio_list lower, same;
 
-		if (unlikely(bio_queue_enter(bio) != 0))
-			continue;
-
 		/*
 		 * Create a fresh bio_list for all subordinate requests.
 		 */
@@ -979,23 +983,12 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
-	blk_qc_t ret = BLK_QC_T_NONE;
+	blk_qc_t ret;
 
 	current->bio_list = bio_list;
 
 	do {
-		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-		if (unlikely(bio_queue_enter(bio) != 0))
-			continue;
-
-		if (!blk_crypto_bio_prep(&bio)) {
-			blk_queue_exit(disk->queue);
-			ret = BLK_QC_T_NONE;
-			continue;
-		}
-
-		ret = blk_mq_submit_bio(bio);
+		ret = __submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
@@ -1013,9 +1006,6 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
  */
 blk_qc_t submit_bio_noacct(struct bio *bio)
 {
-	if (!submit_bio_checks(bio))
-		return BLK_QC_T_NONE;
-
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-- 
2.30.2

