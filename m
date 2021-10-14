Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EFBC4332F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8C1610CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhJNOG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhJNOG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E4CC061760;
        Thu, 14 Oct 2021 07:04:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so19733206wrd.13;
        Thu, 14 Oct 2021 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+p8OcENyUnzjvyDDBY5EaQ2YYrwg2RAAMB9eV7d4z0=;
        b=pG/ynoYkNoyvyDHOEIWiS8JNH6LaK7+mS27IKNUfOps/joF/YLxvy6vBkQpwAbzuM+
         hOxCl4hSzFYIFTY8S5NKHbmY51M3TFCtU0C2491tHYYGWn3fLeyCItwqSwPW4y9vI3sI
         k4wTC0dea3B4FEjPVK81JBBT6BPcVo5N++2ESkWi+YucbgHTGfGXS8epNqMr5e154RKV
         fCdubKYLwZPlxKCdkLkQd+WFkZYs1+v1xYI7us7hQJydPeyALEYxtIWPJYZmBwdbr4Is
         LPgRa1DJpFyBr7f/znOso1iTsTsMiulCLv9hHhBumcdj2oHQEpjNbWwsZZtL7/rynxCf
         9wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+p8OcENyUnzjvyDDBY5EaQ2YYrwg2RAAMB9eV7d4z0=;
        b=Qpjd7WImtw2XvfXcNtJ02js9AEIQoDWc5lnNTCOTWw/uhtJRwKw07+TfYOe0A/Gmc/
         NGuPwovbMBC3wUXcSzoOhyD62QLNry9Yk9mXaR7hviX3I3KK3idM8EvpuN35c8IRO79I
         ZPr5M2nEatF1nnD6cUlAXu7883Pr4YDXPfSKjahKYyrBVbQWxm6MClJzIGu0Mko+wVfd
         /pYQL6qaOIe/8Mbtbevms087/el9eDMGG9By7295BvFDF6MP4gCsSuTQQhs4TIG9hYGk
         XwJWOsJP3nFXaV++8bPbH3IpPyhWc1kmkcHLX/qXLqw8bQFvxNfC0uEQ21dx3eLP4B3W
         Im6A==
X-Gm-Message-State: AOAM533PZNMWtSTfnPFb5l/Pyj6CSDRw7WCY9xKp7IDZWTMtYnuP+w2B
        89pl+21KrEU64dN+rma9AbE=
X-Google-Smtp-Source: ABdhPJyP3idTTRxTBKCwIhHjRslFHsPoOwpr1fHnaf9hN9lq6dkOJWw2aGBmKgsfnfux2OOdbMVsYA==
X-Received: by 2002:adf:b304:: with SMTP id j4mr7164576wrd.160.1634220261009;
        Thu, 14 Oct 2021 07:04:21 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:20 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 5/5] block: convert the rest of block to bdev_get_queue
Date:   Thu, 14 Oct 2021 15:03:30 +0100
Message-Id: <addf6ea988c04213697ba3684c853e4ed7642a39.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
References: <cover.1634219547.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert bdev->bd_disk->queue to bdev_get_queue(), it's uses a cached
queue pointer and so is fater.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio-integrity.c   |  2 +-
 block/blk-cgroup.c      | 16 ++++++++--------
 block/blk-crypto.c      |  2 +-
 block/blk-iocost.c      | 12 ++++++------
 block/blk-merge.c       |  2 +-
 block/blk-mq.c          |  2 +-
 block/blk-throttle.c    |  2 +-
 block/genhd.c           |  4 ++--
 block/partitions/core.c |  4 ++--
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 21234ff966d9..d25114715459 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -134,7 +134,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	iv = bip->bip_vec + bip->bip_vcnt;
 
 	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(bio->bi_bdev->bd_disk->queue,
+	    bvec_gap_to_prev(bdev_get_queue(bio->bi_bdev),
 			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
 		return 0;
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb48090eefce..cec86a705c89 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -621,7 +621,7 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx)
-	__acquires(rcu) __acquires(&bdev->bd_disk->queue->queue_lock)
+	__acquires(rcu) __acquires(&bdev->bd_queue->queue_lock)
 {
 	struct block_device *bdev;
 	struct request_queue *q;
@@ -632,7 +632,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	q = bdev->bd_disk->queue;
+	q = bdev_get_queue(bdev);
 
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
@@ -737,9 +737,9 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_disk->queue->queue_lock) __releases(rcu)
+	__releases(&ctx->bdev->bd_queue->queue_lock) __releases(rcu)
 {
-	spin_unlock_irq(&ctx->bdev->bd_disk->queue->queue_lock);
+	spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
 	rcu_read_unlock();
 	blkdev_put_no_open(ctx->bdev);
 }
@@ -842,7 +842,7 @@ static void blkcg_fill_root_iostats(void)
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct block_device *bdev = dev_to_bdev(dev);
 		struct blkcg_gq *blkg =
-			blk_queue_root_blkg(bdev->bd_disk->queue);
+			blk_queue_root_blkg(bdev_get_queue(bdev));
 		struct blkg_iostat tmp;
 		int cpu;
 
@@ -1801,7 +1801,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 
 	rcu_read_lock();
 	blkg = blkg_lookup_create(css_to_blkcg(css),
-				  bio->bi_bdev->bd_disk->queue);
+				  bdev_get_queue(bio->bi_bdev));
 	while (blkg) {
 		if (blkg_tryget(blkg)) {
 			ret_blkg = blkg;
@@ -1837,8 +1837,8 @@ void bio_associate_blkg_from_css(struct bio *bio,
 	if (css && css->parent) {
 		bio->bi_blkg = blkg_tryget_closest(bio, css);
 	} else {
-		blkg_get(bio->bi_bdev->bd_disk->queue->root_blkg);
-		bio->bi_blkg = bio->bi_bdev->bd_disk->queue->root_blkg;
+		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
+		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 103c2e2d50d6..8f53f4a1f9e2 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -280,7 +280,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	 * Success if device supports the encryption context, or if we succeeded
 	 * in falling back to the crypto API.
 	 */
-	if (blk_ksm_crypto_cfg_supported(bio->bi_bdev->bd_disk->queue->ksm,
+	if (blk_ksm_crypto_cfg_supported(bdev_get_queue(bio->bi_bdev)->ksm,
 					 &bc_key->crypto_cfg))
 		return true;
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b3880e4ba22a..a5b37cc65b17 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3165,12 +3165,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev->bd_disk->queue);
+	ioc = q_to_ioc(bdev_get_queue(bdev));
 	if (!ioc) {
-		ret = blk_iocost_init(bdev->bd_disk->queue);
+		ret = blk_iocost_init(bdev_get_queue(bdev));
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev->bd_disk->queue);
+		ioc = q_to_ioc(bdev_get_queue(bdev));
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3332,12 +3332,12 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev->bd_disk->queue);
+	ioc = q_to_ioc(bdev_get_queue(bdev));
 	if (!ioc) {
-		ret = blk_iocost_init(bdev->bd_disk->queue);
+		ret = blk_iocost_init(bdev_get_queue(bdev));
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev->bd_disk->queue);
+		ioc = q_to_ioc(bdev_get_queue(bdev));
 	}
 
 	spin_lock_irq(&ioc->lock);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 762da71f9fde..c96f29f398fc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -305,7 +305,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  */
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 {
-	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue((*bio)->bi_bdev);
 	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f42cf615c527..5cb5dd81a1d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2223,7 +2223,7 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
  */
 void blk_mq_submit_bio(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8cefd14deed5..39bb6e68a9a2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2063,7 +2063,7 @@ void blk_throtl_charge_bio_split(struct bio *bio)
 
 bool __blk_throtl_bio(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg);
diff --git a/block/genhd.c b/block/genhd.c
index e11ee23a4401..901bef22f186 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -861,7 +861,7 @@ ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
-	struct request_queue *q = bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct disk_stats stat;
 	unsigned int inflight;
 
@@ -905,7 +905,7 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
-	struct request_queue *q = bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int inflight[2];
 
 	if (queue_is_mq(q))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 3a4898433c43..9dbddc355b40 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -204,7 +204,7 @@ static ssize_t part_alignment_offset_show(struct device *dev,
 	struct block_device *bdev = dev_to_bdev(dev);
 
 	return sprintf(buf, "%u\n",
-		queue_limit_alignment_offset(&bdev->bd_disk->queue->limits,
+		queue_limit_alignment_offset(&bdev_get_queue(bdev)->limits,
 				bdev->bd_start_sect));
 }
 
@@ -214,7 +214,7 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 	struct block_device *bdev = dev_to_bdev(dev);
 
 	return sprintf(buf, "%u\n",
-		queue_limit_discard_alignment(&bdev->bd_disk->queue->limits,
+		queue_limit_discard_alignment(&bdev_get_queue(bdev)->limits,
 				bdev->bd_start_sect));
 }
 
-- 
2.33.0

