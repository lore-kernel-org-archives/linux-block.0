Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED6CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiGNSHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGNSHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:39 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82868474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:37 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 72so2305620pge.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5hlyhKmKNOzkCEoAxuneGvqASLSt9bOZq/X84HMVas=;
        b=N7yhCbwFx9wnVDkZmjNHLeFy457aC0Zin5CDByn+yxFoHFXcedazEtKcsAmL2WyJ1q
         cORjfm0/ef/fmYy+FM+bbPbaHpleQS7nkvqAfPIhH8iuAPDHnN48ssUViW0EzoyYEGRQ
         6SyL2rmx+j40oAH9vT/RHOAKMuJyylzXcAa6IHAuWsUZhJddx03qbdWKTyAXUf9Gy6nZ
         PBUeAXnUptLKYWfouvEwlvsHPbNArlPlfzUCelEzBbc22BYtdx1m/c65mto4pfOVTiCT
         qdGs1BmDq9AkQEMoYVcfWjZAxhC/8L9/9naxYVcE+gwhQSkeGZW/Wm5o3Y8p3QpC7nik
         grfQ==
X-Gm-Message-State: AJIora9Z572EvP7Gel3dN1Ncq0N2KQxp4P0xLNgfKrNFR3q4BymmLU4v
        jf+b/LYDEvTkxyg/c3nwcgw=
X-Google-Smtp-Source: AGRyM1uFlWdS4qoHkUXL0OEtJ/gp4yufINjmyXgPS4OeA/+Iq8VToK4uyu0HzTHuUcCO7C7w/AyKLw==
X-Received: by 2002:a05:6a00:24c1:b0:51c:784:cb59 with SMTP id d1-20020a056a0024c100b0051c0784cb59mr9625251pfv.57.1657822057056;
        Thu, 14 Jul 2022 11:07:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 01/63] treewide: Rename enum req_opf into enum req_op
Date:   Thu, 14 Jul 2022 11:06:27 -0700
Message-Id: <20220714180729.1065367-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The type name enum req_opf is misleading since it suggests that values of
this type include both an operation type and flags. Since values of this
type represent an operation only, change the type name into enum req_op.

Convert the enum req_op documentation into kernel-doc format. Move a few
definitions such that the enum req_op documentation occurs just above
the enum req_op definition.

The name "req_opf" was introduced by commit ef295ecf090d ("block: better op
and flags encoding").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c                 |  7 +++----
 drivers/block/null_blk/main.c     |  9 ++++-----
 drivers/block/null_blk/null_blk.h | 12 +++++-------
 drivers/block/null_blk/trace.h    |  2 +-
 drivers/block/null_blk/zoned.c    |  4 ++--
 drivers/md/dm-integrity.c         |  2 +-
 drivers/nvme/target/zns.c         |  4 ++--
 drivers/scsi/sd_zbc.c             |  2 +-
 drivers/ufs/core/ufshpb.c         |  5 ++---
 fs/zonefs/super.c                 |  5 ++---
 fs/zonefs/trace.h                 |  2 +-
 include/linux/blk_types.h         | 16 ++++++++--------
 include/linux/blkdev.h            |  2 +-
 13 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7c017458d5ce..a264621d4905 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -256,9 +256,8 @@ static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
  *    The operation to execute on each zone can be a zone reset, open, close
  *    or finish request.
  */
-int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
-		     sector_t sector, sector_t nr_sectors,
-		     gfp_t gfp_mask)
+int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
+		     sector_t sector, sector_t nr_sectors, gfp_t gfp_mask)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
@@ -397,7 +396,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	void __user *argp = (void __user *)arg;
 	struct request_queue *q;
 	struct blk_zone_range zrange;
-	enum req_opf op;
+	enum req_op op;
 	int ret;
 
 	if (!argp)
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4e03a020ee3c..8b224ede2e33 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1310,7 +1310,7 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 }
 
 static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_opf op,
+						     enum req_op op,
 						     sector_t sector,
 						     sector_t nr_sectors)
 {
@@ -1381,9 +1381,8 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 	}
 }
 
-blk_status_t null_process_cmd(struct nullb_cmd *cmd,
-			      enum req_opf op, sector_t sector,
-			      unsigned int nr_sectors)
+blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
+			      sector_t sector, unsigned int nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	blk_status_t ret;
@@ -1401,7 +1400,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 }
 
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
-				    sector_t nr_sectors, enum req_opf op)
+				    sector_t nr_sectors, enum req_op op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 8359b43842f2..6fbf0a1b2622 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -136,9 +136,8 @@ struct nullb {
 
 blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
 				 sector_t nr_sectors);
-blk_status_t null_process_cmd(struct nullb_cmd *cmd,
-			      enum req_opf op, sector_t sector,
-			      unsigned int nr_sectors);
+blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
+			      sector_t sector, unsigned int nr_sectors);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
@@ -146,9 +145,8 @@ int null_register_zoned_dev(struct nullb *nullb);
 void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
-blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
-				    enum req_opf op, sector_t sector,
-				    sector_t nr_sectors);
+blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
+				    sector_t sector, sector_t nr_sectors);
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
 #else
@@ -164,7 +162,7 @@ static inline int null_register_zoned_dev(struct nullb *nullb)
 }
 static inline void null_free_zoned_dev(struct nullb_device *dev) {}
 static inline blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
-			enum req_opf op, sector_t sector, sector_t nr_sectors)
+			enum req_op op, sector_t sector, sector_t nr_sectors)
 {
 	return BLK_STS_NOTSUPP;
 }
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 86d6c12c603c..6b2b370e786f 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -36,7 +36,7 @@ TRACE_EVENT(nullb_zone_op,
 	    TP_ARGS(cmd, zone_no, zone_cond),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
-		__field(enum req_opf, op)
+		__field(enum req_op, op)
 		__field(unsigned int, zone_no)
 		__field(unsigned int, zone_cond)
 	    ),
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 64b06caab984..55a69e48ef8b 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -600,7 +600,7 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 	return BLK_STS_OK;
 }
 
-static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
+static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
 				   sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -653,7 +653,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	return ret;
 }
 
-blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
+blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 				    sector_t sector, sector_t nr_sectors)
 {
 	struct nullb_device *dev;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 3d5a0ce123c9..148978ad03a8 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -298,7 +298,7 @@ struct dm_integrity_io {
 	struct work_struct work;
 
 	struct dm_integrity_c *ic;
-	enum req_opf op;
+	enum req_op op;
 	bool fua;
 
 	struct dm_integrity_range range;
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c0ee21fcab81..b233c0943fec 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -308,7 +308,7 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
 	queue_work(zbd_wq, &req->z.zmgmt_work);
 }
 
-static inline enum req_opf zsa_req_op(u8 zsa)
+static inline enum req_op zsa_req_op(u8 zsa)
 {
 	switch (zsa) {
 	case NVME_ZONE_OPEN:
@@ -465,7 +465,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
-	enum req_opf op = zsa_req_op(req->cmd->zms.zsa);
+	enum req_op op = zsa_req_op(req->cmd->zms.zsa);
 	struct block_device *bdev = req->ns->bdev;
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index b8c97456506a..bd15624c6322 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -529,7 +529,7 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	unsigned int zno = blk_rq_zone_no(rq);
-	enum req_opf op = req_op(rq);
+	enum req_op op = req_op(rq);
 	unsigned long flags;
 
 	/*
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index de2bb8401bc4..24f1ee82c215 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -433,9 +433,8 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	return 0;
 }
 
-static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb,
-					 int rgn_idx, enum req_opf dir,
-					 bool atomic)
+static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb, int rgn_idx,
+					 enum req_op dir, bool atomic)
 {
 	struct ufshpb_req *rq;
 	struct request *req;
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9c0eef1ff32a..a221ddb12da6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -60,8 +60,7 @@ static void zonefs_account_active(struct inode *inode)
 	}
 }
 
-static inline int zonefs_zone_mgmt(struct inode *inode,
-				   enum req_opf op)
+static inline int zonefs_zone_mgmt(struct inode *inode, enum req_op op)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret;
@@ -525,7 +524,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	loff_t old_isize;
-	enum req_opf op;
+	enum req_op op;
 	int ret = 0;
 
 	/*
diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index f369d7d50303..21501da764bd 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -20,7 +20,7 @@
 #define show_dev(dev) MAJOR(dev), MINOR(dev)
 
 TRACE_EVENT(zonefs_zone_mgmt,
-	    TP_PROTO(struct inode *inode, enum req_opf op),
+	    TP_PROTO(struct inode *inode, enum req_op op),
 	    TP_ARGS(inode, op),
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a24d4078fb21..0e6a2af7ed3d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -337,8 +337,12 @@ enum {
 
 typedef __u32 __bitwise blk_mq_req_flags_t;
 
-/*
- * Operations and flags common to the bio and request structures.
+#define REQ_OP_BITS	8
+#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
+#define REQ_FLAG_BITS	24
+
+/**
+ * enum req_op - Operations common to the bio and request structures.
  * We use 8 bits for encoding the operation, and the remaining 24 for flags.
  *
  * The least significant bit of the operation number indicates the data
@@ -350,11 +354,7 @@ typedef __u32 __bitwise blk_mq_req_flags_t;
  * If a operation does not transfer data the least significant bit has no
  * meaning.
  */
-#define REQ_OP_BITS	8
-#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
-#define REQ_FLAG_BITS	24
-
-enum req_opf {
+enum req_op {
 	/* read sectors from the device */
 	REQ_OP_READ		= 0,
 	/* write sectors to the device */
@@ -509,7 +509,7 @@ static inline bool op_is_discard(unsigned int op)
  * due to its different handling in the block layer and device response in
  * case of command failure.
  */
-static inline bool op_is_zone_mgmt(enum req_opf op)
+static inline bool op_is_zone_mgmt(enum req_op op)
 {
 	switch (op & REQ_OP_MASK) {
 	case REQ_OP_ZONE_RESET:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2775763c51b9..ec072a5129bf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -322,7 +322,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 unsigned int bdev_nr_zones(struct block_device *bdev);
-extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
+extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
 int blk_revalidate_disk_zones(struct gendisk *disk,
