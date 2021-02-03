Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A2C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CF664F8C
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhBCP40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:56:26 -0500
Received: from mx2.veeam.com ([64.129.123.6]:55108 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234576AbhBCP4C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 10:56:02 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id C5B05415BA;
        Wed,  3 Feb 2021 10:54:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612367676; bh=KRRIE1mjAT5i1J0tuyS17RP7x4cjxFiHD1kWlqdATWo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=N3j45aCkbC/Xd8JVHlYASGskT7MQWVIcATGx3ptYWDtvbT2NrHrxaF7ghP4/fFCTw
         bCz6ayPTzRn7vmcoTZQJmeNZcrtjtf4FuScyNOi2dnZoG4ogjdFNx6jyZfDa5dWkBP
         y9UXPrUccmqM72f9koaqgsyhb7sVrE6xwpdiNlQs=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Feb 2021 16:54:21 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavgel.tide@veeam.com>
Subject: [PATCH v4 2/6] block: add blk_interposer
Date:   Wed, 3 Feb 2021 18:53:54 +0300
Message-ID: <1612367638-3794-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265667062
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_interposer allows to intercept bio requests, remap bio to another devices or add new bios.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/bio.c               |  2 +
 block/blk-core.c          | 33 ++++++++++++++++
 block/genhd.c             | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  6 ++-
 include/linux/genhd.h     | 18 +++++++++
 5 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..f6f135eb84b5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
+	if (bio_flagged(bio_src, BIO_INTERPOSED))
+		bio_set_flag(bio, BIO_INTERPOSED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..c84bc42ba88b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1032,6 +1032,32 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 	return ret;
 }
 
+static blk_qc_t __submit_bio_interposed(struct bio *bio)
+{
+	struct bio_list bio_list[2] = { };
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	current->bio_list = bio_list;
+	if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_disk;
+
+		if (likely(blk_has_interposer(disk))) {
+			bio_set_flag(bio, BIO_INTERPOSED);
+			disk->interposer->ip_submit_bio(bio);
+		} else /* interposer was removed */
+			bio_list_add(&current->bio_list[0], bio);
+
+		blk_queue_exit(disk->queue);
+	}
+	current->bio_list = NULL;
+
+	/* Resubmit remaining bios */
+	while ((bio = bio_list_pop(&bio_list[0])))
+		ret = submit_bio_noacct(bio);
+
+	return ret;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1057,6 +1083,13 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	/*
+	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
+	 * created by the blk_interposer do not get to it for processing.
+	 */
+	if (blk_has_interposer(bio->bi_disk) &&
+	    !bio_flagged(bio, BIO_INTERPOSED))
+		return __submit_bio_interposed(bio);
 	if (!bio->bi_disk->fops->submit_bio)
 		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index 419548e92d82..39785a3ef703 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -30,6 +30,7 @@
 static struct kobject *block_depr;
 
 DECLARE_RWSEM(bdev_lookup_sem);
+DEFINE_MUTEX(bdev_interposer_mutex);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
@@ -2148,3 +2149,84 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+/**
+ * blk_interposer_attach - Attach interposer to disk
+ * @disk: target disk
+ * @interposer: block device interposer
+ * @ip_submit_bio: hook for submit_bio()
+ *
+ * Returns:
+ *     -EINVAL if @interposer is NULL.
+ *     -EPERM if queue is not frozen.
+ *     -EBUSY if the block device already has @interposer.
+ *     -EALREADY if the block device already has @interposer with same callback.
+ *
+ * Disk must be frozen by blk_mq_freeze_queue().
+ */
+int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *interposer,
+			  const ip_submit_bio_t ip_submit_bio)
+{
+	int ret = 0;
+
+	if (WARN_ON(!interposer))
+		return -EINVAL;
+
+	if (!blk_mq_is_queue_frozen(disk->queue))
+		return -EPERM;
+
+	mutex_lock(&bdev_interposer_mutex);
+	if (blk_has_interposer(disk)) {
+		if (disk->interposer->ip_submit_bio == ip_submit_bio)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+		goto out;
+	}
+
+	interposer->ip_submit_bio = ip_submit_bio;
+	interposer->disk = disk;
+
+	disk->interposer = interposer;
+out:
+	mutex_unlock(&bdev_interposer_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_interposer_attach);
+
+/**
+ * blk_interposer_detach - Detach interposer from disk
+ * @interposer: block device interposer
+ * @ip_submit_bio: hook for submit_bio()
+ *
+ * Disk must be frozen by blk_mq_freeze_queue().
+ */
+void blk_interposer_detach(struct blk_interposer *interposer,
+			  const ip_submit_bio_t ip_submit_bio)
+{
+	struct gendisk *disk;
+
+	if (WARN_ON(!interposer))
+		return;
+
+	mutex_lock(&bdev_interposer_mutex);
+
+	/* Check if the interposer is still active. */
+	disk = interposer->disk;
+	if (WARN_ON(!disk))
+		goto out;
+
+	if (WARN_ON(!blk_mq_is_queue_frozen(disk->queue)))
+		goto out;
+
+	/* Check if it is really our interposer. */
+	if (WARN_ON(disk->interposer->ip_submit_bio != ip_submit_bio))
+		goto out;
+
+	disk->interposer = NULL;
+	interposer->disk = NULL;
+out:
+	mutex_unlock(&bdev_interposer_mutex);
+}
+EXPORT_SYMBOL_GPL(blk_interposer_detach);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261b3b..6c1351d7b73f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -227,7 +227,7 @@ struct bio {
 						 * top bits REQ_OP. Use
 						 * accessors.
 						 */
-	unsigned short		bi_flags;	/* status, etc and bvec pool number */
+	unsigned int		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
@@ -304,6 +304,8 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_INTERPOSED,		/* bio has been interposed and can be moved to
+				 * a different disk */
 	BIO_FLAG_LAST
 };
 
@@ -322,7 +324,7 @@ enum {
  * freed.
  */
 #define BVEC_POOL_BITS		(3)
-#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)
 # error "BVEC_POOL_BITS is too small"
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..f68c8e83b4f1 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -134,6 +134,13 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
+typedef void (*ip_submit_bio_t) (struct bio *bio);
+
+struct blk_interposer {
+	ip_submit_bio_t ip_submit_bio;
+	struct gendisk *disk;
+};
+
 struct gendisk {
 	/* major, first_minor and minors are input parameters only,
 	 * don't use directly.  Use disk_devt() and disk_max_parts().
@@ -158,6 +165,7 @@ struct gendisk {
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
+	struct blk_interposer *interposer;
 	void *private_data;
 
 	int flags;
@@ -346,4 +354,14 @@ static inline void printk_all_partitions(void)
 }
 #endif /* CONFIG_BLOCK */
 
+/*
+ * block layer interposer
+ */
+#define blk_has_interposer(d) ((d)->interposer != NULL)
+
+int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *interposer,
+			  const ip_submit_bio_t ip_submit_bio);
+void blk_interposer_detach(struct blk_interposer *interposer,
+			   const ip_submit_bio_t ip_submit_bio);
+
 #endif /* _LINUX_GENHD_H */
-- 
2.20.1

