Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD0C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C905F23B2F
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbhANPsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbhANPsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:17 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F1C061794
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:32 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h18so4818446qtr.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rQiteVCxoBWutnawrqGu3qFkhS4PTdd43xyBddh3/+Y=;
        b=HFuO8i9XZqAgUTRptYDPtYA3XeZBkEp5/BGbnCK98kkXOi73ZiYZsNR2HMGW7zfetj
         TNbjcYrV6P/OnqiTGR4PCAkMhFrvIXAaAc+8iUWpAaqkhhMRXTKU6rMrrT7gKVykBcjA
         JhgfelXllBeTBMqv7tzSNRl0FWZRxnUOUjWW23v8sFEafJiarXHpZAoK4uLWbngn6Lnh
         Klj51v8gvOZnGr0mSQGYKOtwNT96OdmPYzEpVzKSVGEAF3W/bsUiSZlo3uvR8vhukMfV
         ryggZc58z4s4V1uCEB3Z9VonV9THRje3A09PaFjpA1UGraofATL0PmYbCy5BhTOf1NBu
         fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rQiteVCxoBWutnawrqGu3qFkhS4PTdd43xyBddh3/+Y=;
        b=Llzr8dMIqPavVFEw4aVVLQ2eYsUqxAmEhRRyVB2djk/RWQ+5jLcDU8QiYEuKfK0SU/
         OeEeSzX0lRTecv2BTTRYz2jK/U9WyxTwwCEyWv6FI+3wHc5Uu1ls6I+yK8jhPzZzt6+R
         AuFUh0j8sqNbstSgPWzWZd7aaA4/OgQLiJKvAemD4KvATEn+FlqR9qM4doKzdpj1uFp4
         9CjcUTiujAMQrWvT2t4fvQqCMtkWZKYQy5hLkhgtWtwZejSOs1CEr8H8SG1uqzotSbzD
         QeV/GO/zwErxs6kHQaFzxyQoiH2KMHlHIbL6a10qirrxVxN1Zi6ohS+IqCVUV5CI8hcY
         RdKg==
X-Gm-Message-State: AOAM532ftgVo7vrB7eeldq3iZCRVaH3t+Z34UFQQcARaeAs9GlV1CQBI
        lRatzEcLMBftTEOlR0vz6nXKDgJjpmLW6w5xEEgnZ6q7FttDIJuTggsDEuYqubuBTUARJMS5MyZ
        +L0UQx/mTQW/AbIc1lY5huHIRD9LRFQ2a3Pv9dM4r17/09RzBv7AcpQYt0HXHUuAELKo4
X-Google-Smtp-Source: ABdhPJwrcaTLhhnNcxZsQ6jw7FyV0YKxvrm6mEVXy8dUFIzzPwJaDWzSLOLinvMc3mhnHCwcoMBhT2PSqcM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:452f:: with SMTP id l15mr7697781qvu.49.1610639251249;
 Thu, 14 Jan 2021 07:47:31 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:17 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-2-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/7] block: make blk_bio_segment_split() able to fail and
 return error
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Till now, blk_bio_segment_split() always succeeded and returned a split
bio if necessary. Instead, allow it to return an error code to indicate
errors (and pass a pointer to the split bio as an argument instead).

blk_bio_segment_split() is only called by __blk_queue_split(), which has
been updated to return the error code from blk_bio_segment_split().

This patch also updates all callers of __blk_queue_split() and
blk_queue_split() to handle any error returned by those functions.

blk_bio_segment_split() needs to be able to fail because future patches
will ensure that the size of the split bio is aligned to the data unit
size of the bio crypt context of the bio (if it exists). It's possible
that the largest aligned size that satisfies all the requirements of
blk_bio_segment_split() is 0, at which point we need error out.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-merge.c             | 36 +++++++++++++++++++++++++----------
 block/blk-mq.c                |  5 ++++-
 block/blk.h                   |  2 +-
 drivers/block/drbd/drbd_req.c |  5 ++++-
 drivers/block/pktcdvd.c       |  3 ++-
 drivers/block/ps3vram.c       |  5 ++++-
 drivers/block/rsxx/dev.c      |  3 ++-
 drivers/block/umem.c          |  5 ++++-
 drivers/lightnvm/pblk-init.c  | 13 ++++++++++---
 drivers/md/dm.c               |  8 ++++++--
 drivers/md/md.c               |  5 ++++-
 drivers/nvme/host/multipath.c |  5 ++++-
 drivers/s390/block/dcssblk.c  |  3 ++-
 drivers/s390/block/xpram.c    |  3 ++-
 include/linux/blkdev.h        |  2 +-
 15 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..a23a91e12e24 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -229,6 +229,7 @@ static bool bvec_split_segs(const struct request_queue *q,
  * @bio:  [in] bio to be split
  * @bs:	  [in] bio set to allocate the clone from
  * @segs: [out] number of segments in the bio with the first half of the sectors
+ * @split: [out] The split bio, if @bio is split
  *
  * Clone @bio, update the bi_iter of the clone to represent the first sectors
  * of @bio and update @bio->bi_iter to represent the remaining sectors. The
@@ -241,11 +242,14 @@ static bool bvec_split_segs(const struct request_queue *q,
  * original bio is not freed before the cloned bio. The caller is also
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
+ *
+ * Return: 0 on success, negative on error
  */
-static struct bio *blk_bio_segment_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *segs)
+static int blk_bio_segment_split(struct request_queue *q,
+				 struct bio *bio,
+				 struct bio_set *bs,
+				 unsigned *segs,
+				 struct bio **split)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
@@ -276,7 +280,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	}
 
 	*segs = nsegs;
-	return NULL;
+	*split = NULL;
+	return 0;
 split:
 	*segs = nsegs;
 
@@ -287,7 +292,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
-	return bio_split(bio, sectors, GFP_NOIO, bs);
+	*split = bio_split(bio, sectors, GFP_NOIO, bs);
+	return 0;
 }
 
 /**
@@ -302,11 +308,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  * the responsibility of the caller to ensure that
  * @bio->bi_disk->queue->bio_split is only released after processing of the
  * split bio has finished.
+ *
+ * Return: 0 on succes, negative on error
  */
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
+int __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 {
 	struct request_queue *q = (*bio)->bi_disk->queue;
 	struct bio *split = NULL;
+	int err;
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
@@ -337,7 +346,10 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 			*nr_segs = 1;
 			break;
 		}
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
+		err = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs,
+					    &split);
+		if (err)
+			return err;
 		break;
 	}
 
@@ -350,6 +362,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 		submit_bio_noacct(*bio);
 		*bio = split;
 	}
+
+	return 0;
 }
 
 /**
@@ -361,12 +375,14 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
  * a new bio from @bio->bi_disk->queue->bio_split, it is the responsibility of
  * the caller to ensure that @bio->bi_disk->queue->bio_split is only released
  * after processing of the split bio has finished.
+ *
+ * Return: 0 on success, negative on error
  */
-void blk_queue_split(struct bio **bio)
+int blk_queue_split(struct bio **bio)
 {
 	unsigned int nr_segs;
 
-	__blk_queue_split(bio, &nr_segs);
+	return __blk_queue_split(bio, &nr_segs);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f285a9123a8b..43fe5be6bbb7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2143,7 +2143,10 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	bool hipri;
 
 	blk_queue_bounce(q, &bio);
-	__blk_queue_split(&bio, &nr_segs);
+	if (__blk_queue_split(&bio, &nr_segs)) {
+		bio_io_error(bio);
+		goto queue_exit;
+	}
 
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..22096c8272cb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -218,7 +218,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
+int __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 330f851cb8f0..1baaaad22bff 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1598,7 +1598,10 @@ blk_qc_t drbd_submit_bio(struct bio *bio)
 	struct drbd_device *device = bio->bi_disk->private_data;
 	unsigned long start_jif;
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
 
 	start_jif = jiffies;
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b8bb8ec7538d..702f7e5564ff 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2372,7 +2372,8 @@ static blk_qc_t pkt_submit_bio(struct bio *bio)
 	char b[BDEVNAME_SIZE];
 	struct bio *split;
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio))
+		goto end_io;
 
 	pd = bio->bi_disk->queue->queuedata;
 	if (!pd) {
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index b71d28372ef3..772e0c3e7036 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -587,7 +587,10 @@ static blk_qc_t ps3vram_submit_bio(struct bio *bio)
 
 	dev_dbg(&dev->core, "%s\n", __func__);
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
 
 	spin_lock_irq(&priv->lock);
 	busy = !bio_list_empty(&priv->list);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index edacefff6e35..e9d3538a2625 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -126,7 +126,8 @@ static blk_qc_t rsxx_submit_bio(struct bio *bio)
 	struct rsxx_bio_meta *bio_meta;
 	blk_status_t st = BLK_STS_IOERR;
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio))
+		goto req_err;
 
 	might_sleep();
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 2b95d7b33b91..ac1e8a0750a9 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -527,7 +527,10 @@ static blk_qc_t mm_submit_bio(struct bio *bio)
 		 (unsigned long long)bio->bi_iter.bi_sector,
 		 bio->bi_iter.bi_size);
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
 
 	spin_lock_irq(&card->lock);
 	*card->biotail = bio;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b6246f73895c..42873e04edf4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -63,15 +63,22 @@ static blk_qc_t pblk_submit_bio(struct bio *bio)
 	 * constraint. Writes can be of arbitrary size.
 	 */
 	if (bio_data_dir(bio) == READ) {
-		blk_queue_split(&bio);
+		if (blk_queue_split(&bio)) {
+			bio_io_error(bio);
+			return BLK_QC_T_NONE;
+		}
 		pblk_submit_read(pblk, bio);
 	} else {
 		/* Prevent deadlock in the case of a modest LUN configuration
 		 * and large user I/Os. Unless stalled, the rate limiter
 		 * leaves at least 256KB available for user I/O.
 		 */
-		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
-			blk_queue_split(&bio);
+		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl)) {
+			if (blk_queue_split(&bio)) {
+				bio_io_error(bio);
+				return BLK_QC_T_NONE;
+			}
+		}
 
 		pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b3c3c8b4cb42..f304cb017176 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1654,8 +1654,12 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	 * Use blk_queue_split() for abnormal IO (e.g. discard, writesame, etc)
 	 * otherwise associated queue_limits won't be imposed.
 	 */
-	if (is_abnormal_io(bio))
-		blk_queue_split(&bio);
+	if (is_abnormal_io(bio)) {
+		if (blk_queue_split(&bio)) {
+			bio_io_error(bio);
+			goto out;
+		}
+	}
 
 	ret = __split_and_process_bio(md, map, bio);
 out:
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ca409428b4fc..66c9cc95d14d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -498,7 +498,10 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
 
 	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9ac762b28811..34874dc5258f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -307,7 +307,10 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	 * different queue via blk_steal_bios(), so we need to use the bio_split
 	 * pool from the original queue to allocate the bvecs from.
 	 */
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio)) {
+		bio_io_error(bio);
+		return ret;
+	}
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 299e77ec2c41..33904f527f62 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -876,7 +876,8 @@ dcssblk_submit_bio(struct bio *bio)
 	unsigned long source_addr;
 	unsigned long bytes_done;
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio))
+		goto fail;
 
 	bytes_done = 0;
 	dev_info = bio->bi_disk->private_data;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index c2536f7767b3..6f2f772e81e8 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -191,7 +191,8 @@ static blk_qc_t xpram_submit_bio(struct bio *bio)
 	unsigned long page_addr;
 	unsigned long bytes;
 
-	blk_queue_split(&bio);
+	if (blk_queue_split(&bio))
+		goto fail;
 
 	if ((bio->bi_iter.bi_sector & 7) != 0 ||
 	    (bio->bi_iter.bi_size & 4095) != 0)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..b4b44d7262e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -926,7 +926,7 @@ extern void blk_rq_unprep_clone(struct request *rq);
 extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
 extern int blk_rq_append_bio(struct request *rq, struct bio **bio);
-extern void blk_queue_split(struct bio **);
+extern int blk_queue_split(struct bio **);
 extern int scsi_verify_blk_ioctl(struct block_device *, unsigned int);
 extern int scsi_cmd_blk_ioctl(struct block_device *, fmode_t,
 			      unsigned int, void __user *);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

