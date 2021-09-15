Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7602FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC21610E8
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhIOG4o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhIOG4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:56:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA29AC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lmf8/SO/cQ5/smd0fwFRf1oT5ZgsqGCX/QDltKlGBew=; b=fFnaCgS+FugLGt9z+xJ8UxX1kg
        MLictbYAYd10M9BaT9XS9nOxu1y6K/1aQrBWcgZp2G9zxDLTKAGCn0o8QwdzvtBE46BtxEjgqMH7D
        rIKKieBy+GTf1xwPeOhETxLFNeUgRMICGeekNJZ3AoteBDcsx2DuRt1wprxlq2E6ZEoz83QMQd84u
        KS0hEbGUjrLisMkC6d07D6YQ9Mwkx1p8ek0zQrv588Tx2lOyzw3zGLhcrB4jd+pT+hGrBTVnfJtZU
        6TyFSsrOrAT7R+b/k7wM47BPySQuh4EwNGULcLz4CeNpXHhybvQNdYLIIAwhvwyo7xGzzNSd7z0w4
        UDb5edGg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOoD-00FRD8-Nn; Wed, 15 Sep 2021 06:54:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 16/17] block: move integrity handling out of <linux/blkdev.h>
Date:   Wed, 15 Sep 2021 08:40:43 +0200
Message-Id: <20210915064044.950534-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the integrity/metadata handling definitions out into a new header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c                        |   1 +
 block/bio-integrity.c               |   2 +-
 block/blk-core.c                    |   1 +
 block/blk-integrity.c               |   2 +-
 block/blk-merge.c                   |   1 +
 block/blk-mq.c                      |   1 +
 block/keyslot-manager.c             |   1 +
 block/t10-pi.c                      |   2 +-
 drivers/md/dm-bio-record.h          |   1 +
 drivers/md/dm-crypt.c               |   1 +
 drivers/md/dm-table.c               |   1 +
 drivers/md/md.c                     |   1 +
 drivers/nvdimm/core.c               |   1 +
 drivers/nvme/host/core.c            |   1 +
 drivers/nvme/host/pci.c             |   1 +
 drivers/nvme/host/rdma.c            |   1 +
 drivers/nvme/target/io-cmd-bdev.c   |   1 +
 drivers/nvme/target/rdma.c          |   1 +
 drivers/scsi/scsi_lib.c             |   1 +
 drivers/scsi/sd_dif.c               |   2 +-
 drivers/scsi/virtio_scsi.c          |   1 +
 drivers/target/target_core_iblock.c |   1 +
 include/linux/blk-integrity.h       | 183 ++++++++++++++++++++++++++++
 include/linux/blkdev.h              | 183 ----------------------------
 24 files changed, 205 insertions(+), 187 deletions(-)
 create mode 100644 include/linux/blk-integrity.h

diff --git a/block/bdev.c b/block/bdev.c
index cf2780cb44a74..567534c63f3d5 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -12,6 +12,7 @@
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
 #include <linux/module.h>
 #include <linux/blkpg.h>
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b47cddbbca17..21234ff966d9b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -6,7 +6,7 @@
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
 
-#include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/mempool.h>
 #include <linux/export.h>
 #include <linux/bio.h>
diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263b..22c2982bb0bdf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -18,6 +18,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-pm.h>
+#include <linux/blk-integrity.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69a12177dfb62..35e948ea7e625 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -6,7 +6,7 @@
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
 
-#include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
 #include <linux/mempool.h>
 #include <linux/bio.h>
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 39f210da399a6..5b4f23014df8a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/scatterlist.h>
 
 #include <trace/events/block.h>
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 61264bff6103a..21bf4c3f08259 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -10,6 +10,7 @@
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/kmemleak.h>
 #include <linux/mm.h>
 #include <linux/init.h>
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca1..1792159d12d18 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 
 struct blk_ksm_keyslot {
 	atomic_t slot_refs;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 00c203b2a921e..25a52a2a09a88 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/t10-pi.h>
-#include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/crc-t10dif.h>
 #include <linux/module.h>
 #include <net/checksum.h>
diff --git a/drivers/md/dm-bio-record.h b/drivers/md/dm-bio-record.h
index a3b71350eec84..745e3ab4aa0af 100644
--- a/drivers/md/dm-bio-record.h
+++ b/drivers/md/dm-bio-record.h
@@ -8,6 +8,7 @@
 #define DM_BIO_RECORD_H
 
 #include <linux/bio.h>
+#include <linux/blk-integrity.h>
 
 /*
  * There are lots of mutable fields in the bio struct that get
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 916b7da16de25..292f7896f7333 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -15,6 +15,7 @@
 #include <linux/key.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/crypto.h>
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2111daaacabaf..1fa4d5582dca5 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0c7018462eaee..5e6232386b0ce 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -41,6 +41,7 @@
 #include <linux/sched/signal.h>
 #include <linux/kthread.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/badblocks.h>
 #include <linux/sysctl.h>
 #include <linux/seq_file.h>
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 7de592d7eff45..6a45fa91e8a3e 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/device.h>
 #include <linux/ctype.h>
 #include <linux/ndctl.h>
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7efb31b87f37a..408392ec4600c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-integrity.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd75033..ca5bda26226ae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -10,6 +10,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
+#include <linux/blk-integrity.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a68704e39084e..61e22c7c28025 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -13,6 +13,7 @@
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-rdma.h>
+#include <linux/blk-integrity.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0fc2781ab9708..6139e1de50a66 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/module.h>
 #include "nvmet.h"
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44bb..38d1f292ecc20 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/atomic.h>
+#include <linux/blk-integrity.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/err.h>
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 572673873ddf8..33fd9a01330ce 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -21,6 +21,7 @@
 #include <linux/hardirq.h>
 #include <linux/scatterlist.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-integrity.h>
 #include <linux/ratelimit.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 4cadb26070a8f..349950616adc5 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -6,7 +6,7 @@
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
 
-#include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/t10-pi.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index c25ce8f0e0afc..b7c69b97f43ab 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -22,6 +22,7 @@
 #include <linux/virtio_scsi.h>
 #include <linux/cpu.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 4069a1edcfa34..d39b87e2ed100 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -16,6 +16,7 @@
 #include <linux/timer.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/bio.h>
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
new file mode 100644
index 0000000000000..8a038ea0717e4
--- /dev/null
+++ b/include/linux/blk-integrity.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BLK_INTEGRITY_H
+#define _LINUX_BLK_INTEGRITY_H
+
+#include <linux/blk-mq.h>
+
+struct request;
+
+enum blk_integrity_flags {
+	BLK_INTEGRITY_VERIFY		= 1 << 0,
+	BLK_INTEGRITY_GENERATE		= 1 << 1,
+	BLK_INTEGRITY_DEVICE_CAPABLE	= 1 << 2,
+	BLK_INTEGRITY_IP_CHECKSUM	= 1 << 3,
+};
+
+struct blk_integrity_iter {
+	void			*prot_buf;
+	void			*data_buf;
+	sector_t		seed;
+	unsigned int		data_size;
+	unsigned short		interval;
+	const char		*disk_name;
+};
+
+typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
+typedef void (integrity_prepare_fn) (struct request *);
+typedef void (integrity_complete_fn) (struct request *, unsigned int);
+
+struct blk_integrity_profile {
+	integrity_processing_fn		*generate_fn;
+	integrity_processing_fn		*verify_fn;
+	integrity_prepare_fn		*prepare_fn;
+	integrity_complete_fn		*complete_fn;
+	const char			*name;
+};
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+void blk_integrity_register(struct gendisk *, struct blk_integrity *);
+void blk_integrity_unregister(struct gendisk *);
+int blk_integrity_compare(struct gendisk *, struct gendisk *);
+int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
+				   struct scatterlist *);
+int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
+
+static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
+{
+	struct blk_integrity *bi = &disk->queue->integrity;
+
+	if (!bi->profile)
+		return NULL;
+
+	return bi;
+}
+
+static inline struct blk_integrity *
+bdev_get_integrity(struct block_device *bdev)
+{
+	return blk_get_integrity(bdev->bd_disk);
+}
+
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return q->integrity.profile;
+}
+
+static inline void blk_queue_max_integrity_segments(struct request_queue *q,
+						    unsigned int segs)
+{
+	q->limits.max_integrity_segments = segs;
+}
+
+static inline unsigned short
+queue_max_integrity_segments(const struct request_queue *q)
+{
+	return q->limits.max_integrity_segments;
+}
+
+/**
+ * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * @bi:		blk_integrity profile for device
+ * @sectors:	Size of the bio in 512-byte sectors
+ *
+ * Description: The block layer calculates everything in 512 byte
+ * sectors but integrity metadata is done in terms of the data integrity
+ * interval size of the storage device.  Convert the block layer sectors
+ * to the appropriate number of integrity intervals.
+ */
+static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
+						   unsigned int sectors)
+{
+	return sectors >> (bi->interval_exp - 9);
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
+}
+
+static inline bool blk_integrity_rq(struct request *rq)
+{
+	return rq->cmd_flags & REQ_INTEGRITY;
+}
+
+/*
+ * Return the first bvec that contains integrity data.  Only drivers that are
+ * limited to a single integrity segment should use this helper.
+ */
+static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+{
+	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
+		return NULL;
+	return rq->bio->bi_integrity->bip_vec;
+}
+#else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline int blk_rq_count_integrity_sg(struct request_queue *q,
+					    struct bio *b)
+{
+	return 0;
+}
+static inline int blk_rq_map_integrity_sg(struct request_queue *q,
+					  struct bio *b,
+					  struct scatterlist *s)
+{
+	return 0;
+}
+static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
+{
+	return NULL;
+}
+static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
+{
+	return NULL;
+}
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return false;
+}
+static inline int blk_integrity_compare(struct gendisk *a, struct gendisk *b)
+{
+	return 0;
+}
+static inline void blk_integrity_register(struct gendisk *d,
+					 struct blk_integrity *b)
+{
+}
+static inline void blk_integrity_unregister(struct gendisk *d)
+{
+}
+static inline void blk_queue_max_integrity_segments(struct request_queue *q,
+						    unsigned int segs)
+{
+}
+static inline unsigned short
+queue_max_integrity_segments(const struct request_queue *q)
+{
+	return 0;
+}
+
+static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
+						   unsigned int sectors)
+{
+	return 0;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return 0;
+}
+static inline int blk_integrity_rq(struct request *rq)
+{
+	return 0;
+}
+
+static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+{
+	return NULL;
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+#endif /* _LINUX_BLK_INTEGRITY_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index be534040ca9c3..56e60e5c09d07 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1555,189 +1555,6 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned lo
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-
-enum blk_integrity_flags {
-	BLK_INTEGRITY_VERIFY		= 1 << 0,
-	BLK_INTEGRITY_GENERATE		= 1 << 1,
-	BLK_INTEGRITY_DEVICE_CAPABLE	= 1 << 2,
-	BLK_INTEGRITY_IP_CHECKSUM	= 1 << 3,
-};
-
-struct blk_integrity_iter {
-	void			*prot_buf;
-	void			*data_buf;
-	sector_t		seed;
-	unsigned int		data_size;
-	unsigned short		interval;
-	const char		*disk_name;
-};
-
-typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
-typedef void (integrity_prepare_fn) (struct request *);
-typedef void (integrity_complete_fn) (struct request *, unsigned int);
-
-struct blk_integrity_profile {
-	integrity_processing_fn		*generate_fn;
-	integrity_processing_fn		*verify_fn;
-	integrity_prepare_fn		*prepare_fn;
-	integrity_complete_fn		*complete_fn;
-	const char			*name;
-};
-
-extern void blk_integrity_register(struct gendisk *, struct blk_integrity *);
-extern void blk_integrity_unregister(struct gendisk *);
-extern int blk_integrity_compare(struct gendisk *, struct gendisk *);
-extern int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
-				   struct scatterlist *);
-extern int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
-
-static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
-{
-	struct blk_integrity *bi = &disk->queue->integrity;
-
-	if (!bi->profile)
-		return NULL;
-
-	return bi;
-}
-
-static inline
-struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
-{
-	return blk_get_integrity(bdev->bd_disk);
-}
-
-static inline bool
-blk_integrity_queue_supports_integrity(struct request_queue *q)
-{
-	return q->integrity.profile;
-}
-
-static inline bool blk_integrity_rq(struct request *rq)
-{
-	return rq->cmd_flags & REQ_INTEGRITY;
-}
-
-static inline void blk_queue_max_integrity_segments(struct request_queue *q,
-						    unsigned int segs)
-{
-	q->limits.max_integrity_segments = segs;
-}
-
-static inline unsigned short
-queue_max_integrity_segments(const struct request_queue *q)
-{
-	return q->limits.max_integrity_segments;
-}
-
-/**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
- * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
- *
- * Description: The block layer calculates everything in 512 byte
- * sectors but integrity metadata is done in terms of the data integrity
- * interval size of the storage device.  Convert the block layer sectors
- * to the appropriate number of integrity intervals.
- */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
-{
-	return sectors >> (bi->interval_exp - 9);
-}
-
-static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-					       unsigned int sectors)
-{
-	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
-}
-
-/*
- * Return the first bvec that contains integrity data.  Only drivers that are
- * limited to a single integrity segment should use this helper.
- */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
-{
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
-}
-
-#else /* CONFIG_BLK_DEV_INTEGRITY */
-
-struct bio;
-struct block_device;
-struct gendisk;
-struct blk_integrity;
-
-static inline int blk_integrity_rq(struct request *rq)
-{
-	return 0;
-}
-static inline int blk_rq_count_integrity_sg(struct request_queue *q,
-					    struct bio *b)
-{
-	return 0;
-}
-static inline int blk_rq_map_integrity_sg(struct request_queue *q,
-					  struct bio *b,
-					  struct scatterlist *s)
-{
-	return 0;
-}
-static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
-{
-	return NULL;
-}
-static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
-{
-	return NULL;
-}
-static inline bool
-blk_integrity_queue_supports_integrity(struct request_queue *q)
-{
-	return false;
-}
-static inline int blk_integrity_compare(struct gendisk *a, struct gendisk *b)
-{
-	return 0;
-}
-static inline void blk_integrity_register(struct gendisk *d,
-					 struct blk_integrity *b)
-{
-}
-static inline void blk_integrity_unregister(struct gendisk *d)
-{
-}
-static inline void blk_queue_max_integrity_segments(struct request_queue *q,
-						    unsigned int segs)
-{
-}
-static inline unsigned short queue_max_integrity_segments(const struct request_queue *q)
-{
-	return 0;
-}
-
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
-{
-	return 0;
-}
-
-static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-					       unsigned int sectors)
-{
-	return 0;
-}
-
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
-{
-	return NULL;
-}
-
-#endif /* CONFIG_BLK_DEV_INTEGRITY */
-
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q);
-- 
2.30.2

