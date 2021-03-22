Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902FC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A9161980
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVHim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCVHib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 03:38:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD56C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=05RNuovLC8826n5nGcnM3ZFTkBnIL/J3sP0rbLctFVI=; b=Z4TV9xB3P9BEZmSuy5pUwdZVJU
        GNK1WdDgCbtT9YD/sZAL6fAvKIBv7joCNulX6ZMZw1MXR7s0bic5Tyt4PZmb+7paadGh33QPo6BhN
        sBZ8BjsfVTgDcs3MePDlzVMgqFWrfx1L8PIm5XKwgBDtF0yZt8E9eDn1LOtDlSqgT7ArK12oao2K1
        eaBUVzA4ueSmLqpwhAjw4ejUB+fGWI3lulxNWeomHi4NiGuOHckmCYl2edIS9MgvioZneVrCOyEK/
        l8aY0BxfuYgxez5r+WzL4VgISxHzpCeVjL9Kjp55FPRd1rINSsJHRFFE18dYRUFeAG24Njy/QQDJp
        Kcku3Dyg==;
Received: from [2001:4bb8:180:4ea2:5b87:a441:96f6:10e9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOF8B-0089qG-Nr; Mon, 22 Mar 2021 07:37:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] blk-mq: add a blk_mq_submit_bio_direct API
Date:   Mon, 22 Mar 2021 08:37:25 +0100
Message-Id: <20210322073726.788347-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210322073726.788347-1-hch@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds (back) and API for simple stacking drivers to submit a bio to
blk-mq queue.  The prime aim is to avoid blocking on the queue freeze
percpu ref, as a multipath driver really does not want to get blocked
on that when an underlying device is undergoing error recovery.  It also
happens to optimize away the small overhead of the curren->bio_list based
recursion avoidance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  2 +-
 block/blk-mq.c         | 37 +++++++++++++++++++++++++++++++++++++
 block/blk.h            |  1 +
 include/linux/blk-mq.h |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff20849738..4344f3c9058282 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,7 +792,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static noinline_for_stack bool submit_bio_checks(struct bio *bio)
+noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev->bd_disk->queue;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa43966..4ff85692843b49 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2286,6 +2286,43 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+/**
+ * blk_mq_submit_bio_direct - hand a bio directly to the driver for I/O
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This function behaves similar to submit_bio_noacct(), but does never waits
+ * for the queue to be unfreozen, instead it return false and lets the caller
+ * deal with the fallout.  It also does not protect against recursion and thus
+ * must only be used if the called driver is known to be blk-mq based.
+ */
+bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct request_queue *q = disk->queue;
+
+	if (WARN_ON_ONCE(!current->bio_list) ||
+	    WARN_ON_ONCE(disk->fops->submit_bio)) {
+		bio_io_error(bio);
+		goto fail;
+	}
+	if (!submit_bio_checks(bio))
+		goto fail;
+
+	if (unlikely(blk_queue_enter(q, BLK_MQ_REQ_NOWAIT)))
+		return false;
+	if (!blk_crypto_bio_prep(&bio))
+		goto fail_queue_exit;
+	*qc = blk_mq_submit_bio(bio);
+	return true;
+
+fail_queue_exit:
+	blk_queue_exit(disk->queue);
+fail:
+	*qc = BLK_QC_T_NONE;
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_mq_submit_bio_direct);
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e4e..c4c66b2a9ffb19 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -221,6 +221,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
+bool submit_bio_checks(struct bio *bio);
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b899089..6804f397106ada 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -615,6 +615,7 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 }
 
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
+bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
-- 
2.30.1

