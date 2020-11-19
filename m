Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8EC6369E
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D843B22227
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgKSQtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:49:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgKSQtc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 11:49:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44A50AC65;
        Thu, 19 Nov 2020 16:49:31 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] blk_interposer - Block Layer Interposer
Date:   Thu, 19 Nov 2020 17:49:23 +0100
Message-Id: <20201119164924.74401-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201119164924.74401-1-hare@suse.de>
References: <20201119164924.74401-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

The block layer interposer allows to intercept bio requests.
This allows you to connect device mapper and other kernel
modules to the block device stack on the fly.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c          | 34 +++++++++++++++++++++++++++++
 block/genhd.c             | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  6 ++++--
 include/linux/genhd.h     | 19 ++++++++++++++++
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e..130f0124d939 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1030,6 +1030,37 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
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
+		bio_set_flag(bio, BIO_INTERPOSED);
+		if (likely(blk_has_interposer(disk))) {
+			struct blk_interposer *ip = disk->interposer;
+			ret = ip->ip_submit_bio(ip, bio);
+
+			if (ret == BLK_QC_T_NONE)
+				blk_queue_exit(disk->queue);
+		} else {
+			/* interposer was removed */
+			bio_list_add(&current->bio_list[0], bio);
+			blk_queue_exit(bio->bi_disk->queue);
+		}
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
@@ -1055,6 +1086,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	if (blk_has_interposer(bio->bi_disk) &&
+	    !bio_flagged(bio, BIO_INTERPOSED))
+		return __submit_bio_interposed(bio);
 	if (!bio->bi_disk->fops->submit_bio)
 		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index 9387f050c248..17b43e2ed06a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -2364,3 +2364,58 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+/**
+ * blk_interposer_attach - Attach interposer to disk
+ * @disk: target disk
+ * @interposer: block device interposer
+ *
+ * Returns:
+ *     -EINVAL if @interposer is NULL.
+ *     -ENODEV if interposer is not initialized,
+ *     -EBUSY if the block device already has interposer.
+ */
+int blk_interposer_attach(struct gendisk *disk,
+			  struct blk_interposer *interposer)
+{
+	int ret = 0;
+
+	if (!interposer)
+		return -EINVAL;
+
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+	if (blk_has_interposer(disk))
+		ret = -EBUSY;
+	else
+		disk->interposer = interposer;
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_interposer_attach);
+
+/**
+ * blk_interposer_detach - Detach interposer from disk
+ * @disk: target disk
+ *
+ * Returns the attached interposer or NULL if none was attached.
+ */
+struct blk_interposer *blk_interposer_detach(struct gendisk *disk)
+{
+	struct blk_interposer *interposer;
+
+	if (WARN_ON(!disk))
+		return NULL;
+
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+	interposer = disk->interposer;
+	disk->interposer = NULL;
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return interposer;
+}
+EXPORT_SYMBOL_GPL(blk_interposer_detach);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc..996b803e5aa1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -207,7 +207,7 @@ struct bio {
 						 * top bits REQ_OP. Use
 						 * accessors.
 						 */
-	unsigned short		bi_flags;	/* status, etc and bvec pool number */
+	unsigned int		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
@@ -284,6 +284,8 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_INTERPOSED,		/* bio has been interposed and can be moved to
+				 * a different disk */
 	BIO_FLAG_LAST
 };
 
@@ -302,7 +304,7 @@ enum {
  * freed.
  */
 #define BVEC_POOL_BITS		(3)
-#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)
 # error "BVEC_POOL_BITS is too small"
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 03da3f603d30..f58ab391deda 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -164,6 +164,15 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
+struct blk_interposer;
+typedef blk_qc_t (*ip_submit_bio_t) (struct blk_interposer *ip, struct bio *bio);
+
+struct blk_interposer {
+	struct gendisk *ip_disk;
+	ip_submit_bio_t ip_submit_bio;
+	void *ip_private;
+};
+
 struct gendisk {
 	/* major, first_minor and minors are input parameters only,
 	 * don't use directly.  Use disk_devt() and disk_max_parts().
@@ -188,6 +197,7 @@ struct gendisk {
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
+	struct blk_interposer *interposer;
 	void *private_data;
 
 	int flags;
@@ -409,4 +419,13 @@ static inline dev_t blk_lookup_devt(const char *name, int partno)
 }
 #endif /* CONFIG_BLOCK */
 
+/*
+ * Block device interposing
+ */
+#define blk_has_interposer(d) ((d)->interposer != NULL)
+#define blk_interposer_active(ip) ((ip)->ip_disk != NULL)
+
+int blk_interposer_attach(struct gendisk *, struct blk_interposer *);
+struct blk_interposer * blk_interposer_detach(struct gendisk *);
+
 #endif /* _LINUX_GENHD_H */
-- 
2.16.4

