Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142CC3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B542339D
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfICPOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:14:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47248 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727667AbfICPOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 11:14:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 3 Sep 2019 18:14:15 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x83FEFl1016624;
        Tue, 3 Sep 2019 18:14:15 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/4] block: centrelize PI remapping logic to the block layer
Date:   Tue,  3 Sep 2019 18:14:12 +0300
Message-Id: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently dif_prepare/dif_complete functions are called during the
NVMe and SCSi layers command preparetion/completion, but their actual
place should be the block layer since T10-PI is a general data integrity
feature that is used by block storage protocols.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/blk-core.c         |  6 ++++++
 block/blk-mq.c           |  4 ++++
 block/t10-pi.c           | 11 ++++-------
 drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
 drivers/scsi/sd.c        | 28 ++++++++++------------------
 drivers/scsi/sd.h        |  1 -
 drivers/scsi/sd_dif.c    |  2 +-
 include/linux/genhd.h    |  1 +
 include/linux/t10-pi.h   | 10 ++++------
 9 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e1..58ecfd3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -34,6 +34,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/t10-pi.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 
@@ -1405,6 +1406,11 @@ bool blk_update_request(struct request *req, blk_status_t error,
 	if (!req->bio)
 		return false;
 
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    error == BLK_STS_OK)
+		t10_pi_complete(req,
+				nr_bytes / queue_logical_block_size(req->q));
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
 		print_req_error(req, error, __func__);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0835f4d..30ec078 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -30,6 +30,7 @@
 #include <trace/events/block.h>
 
 #include <linux/blk-mq.h>
+#include <linux/t10-pi.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -693,6 +694,9 @@ void blk_mq_start_request(struct request *rq)
 		 */
 		rq->nr_phys_segments++;
 	}
+
+	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
+		t10_pi_prepare(rq);
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c00946..a6d9722 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -171,7 +171,6 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 /**
  * t10_pi_prepare - prepare PI prior submitting request to device
  * @rq:              request with PI that should be prepared
- * @protection_type: PI type (Type 1/Type 2/Type 3)
  *
  * For Type 1/Type 2, the virtual start sector is the one that was
  * originally submitted by the block layer for the ref_tag usage. Due to
@@ -181,8 +180,9 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
  *
  * Type 3 does not have a reference tag so no remapping is required.
  */
-void t10_pi_prepare(struct request *rq, u8 protection_type)
+void t10_pi_prepare(struct request *rq)
 {
+	u8 protection_type = rq->rq_disk->protection_type;
 	const int tuple_sz = rq->q->integrity.tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
@@ -222,12 +222,10 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
 		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
 	}
 }
-EXPORT_SYMBOL(t10_pi_prepare);
 
 /**
  * t10_pi_complete - prepare PI prior returning request to the block layer
  * @rq:              request with PI that should be prepared
- * @protection_type: PI type (Type 1/Type 2/Type 3)
  * @intervals:       total elements to prepare
  *
  * For Type 1/Type 2, the virtual start sector is the one that was
@@ -239,9 +237,9 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
  *
  * Type 3 does not have a reference tag so no remapping is required.
  */
-void t10_pi_complete(struct request *rq, u8 protection_type,
-		     unsigned int intervals)
+void t10_pi_complete(struct request *rq, unsigned int intervals)
 {
+	u8 protection_type = rq->rq_disk->protection_type;
 	const int tuple_sz = rq->q->integrity.tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
@@ -276,4 +274,3 @@ void t10_pi_complete(struct request *rq, u8 protection_type,
 		}
 	}
 }
-EXPORT_SYMBOL(t10_pi_complete);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7b..b91ea60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -659,8 +659,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
-		} else if (req_op(req) == REQ_OP_WRITE) {
-			t10_pi_prepare(req, ns->pi_type);
 		}
 
 		switch (ns->pi_type) {
@@ -683,13 +681,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 void nvme_cleanup_cmd(struct request *req)
 {
-	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
-	    nvme_req(req)->status == 0) {
-		struct nvme_ns *ns = req->rq_disk->private_data;
-
-		t10_pi_complete(req, ns->pi_type,
-				blk_rq_bytes(req) >> ns->lba_shift);
-	}
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		struct nvme_ns *ns = req->rq_disk->private_data;
 		struct page *page = req->special_vec.bv_page;
@@ -1693,6 +1684,24 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
+static void nvme_set_disk_prot_type(struct nvme_ns *ns, struct gendisk *disk)
+{
+	switch (ns->pi_type) {
+	case NVME_NS_DPS_PI_TYPE1:
+		disk->protection_type = T10_PI_TYPE1_PROTECTION;
+		break;
+	case NVME_NS_DPS_PI_TYPE2:
+		disk->protection_type = T10_PI_TYPE2_PROTECTION;
+		break;
+	case NVME_NS_DPS_PI_TYPE3:
+		disk->protection_type = T10_PI_TYPE3_PROTECTION;
+		break;
+	default:
+		disk->protection_type = T10_PI_TYPE0_PROTECTION;
+		break;
+	}
+}
+
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
@@ -1712,6 +1721,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
+	nvme_set_disk_prot_type(ns, disk);
 
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 149d406..fa7e7d4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -55,7 +55,6 @@
 #include <linux/sed-opal.h>
 #include <linux/pm_runtime.h>
 #include <linux/pr.h>
-#include <linux/t10-pi.h>
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
@@ -309,7 +308,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 
-	return sprintf(buf, "%u\n", sdkp->protection_type);
+	return sprintf(buf, "%u\n", sdkp->disk->protection_type);
 }
 
 static ssize_t
@@ -329,7 +328,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 		return err;
 
 	if (val <= T10_PI_TYPE3_PROTECTION)
-		sdkp->protection_type = val;
+		sdkp->disk->protection_type = val;
 
 	return count;
 }
@@ -343,8 +342,8 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 	struct scsi_device *sdp = sdkp->device;
 	unsigned int dif, dix;
 
-	dif = scsi_host_dif_capable(sdp->host, sdkp->protection_type);
-	dix = scsi_host_dix_capable(sdp->host, sdkp->protection_type);
+	dif = scsi_host_dif_capable(sdp->host, sdkp->disk->protection_type);
+	dix = scsi_host_dix_capable(sdp->host, sdkp->disk->protection_type);
 
 	if (!dix && scsi_host_dix_capable(sdp->host, T10_PI_TYPE0_PROTECTION)) {
 		dif = 0;
@@ -1209,17 +1208,15 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 
 	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
 	dix = scsi_prot_sg_count(cmd);
-	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
-
-	if (write && dix)
-		t10_pi_prepare(cmd->request, sdkp->protection_type);
+	dif = scsi_host_dif_capable(cmd->device->host,
+				    sdkp->disk->protection_type);
 
 	if (dif || dix)
 		protect = sd_setup_protect_cmnd(cmd, dix, dif);
 	else
 		protect = 0;
 
-	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
+	if (protect && sdkp->disk->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
@@ -2051,11 +2048,6 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 					   "sd_done: completed %d of %d bytes\n",
 					   good_bytes, scsi_bufflen(SCpnt)));
 
-	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt) &&
-	    good_bytes)
-		t10_pi_complete(SCpnt->request, sdkp->protection_type,
-				good_bytes / scsi_prot_interval(SCpnt));
-
 	return good_bytes;
 }
 
@@ -2204,7 +2196,7 @@ static int sd_read_protection_type(struct scsi_disk *sdkp, unsigned char *buffer
 	else if (scsi_host_dif_capable(sdp->host, type))
 		ret = 1;
 
-	if (sdkp->first_scan || type != sdkp->protection_type)
+	if (sdkp->first_scan || type != sdkp->disk->protection_type)
 		switch (ret) {
 		case -ENODEV:
 			sd_printk(KERN_ERR, sdkp, "formatted with unsupported" \
@@ -2221,7 +2213,7 @@ static int sd_read_protection_type(struct scsi_disk *sdkp, unsigned char *buffer
 			break;
 		}
 
-	sdkp->protection_type = type;
+	sdkp->disk->protection_type = type;
 
 	return ret;
 }
@@ -2813,7 +2805,7 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 	if (sdp->type != TYPE_DISK && sdp->type != TYPE_ZBC)
 		return;
 
-	if (sdkp->protection_type == 0)
+	if (sdkp->disk->protection_type == 0)
 		return;
 
 	res = scsi_mode_sense(sdp, 1, 0x0a, buffer, 36, SD_TIMEOUT,
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 38c5094..770b6b0f 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -94,7 +94,6 @@ struct scsi_disk {
 	unsigned int	medium_access_timed_out;
 	u8		media_present;
 	u8		write_prot;
-	u8		protection_type;/* Data Integrity Field */
 	u8		provisioning_mode;
 	u8		zeroing_mode;
 	unsigned	ATO : 1;	/* state of disk ATO bit */
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 4cadb26..cbd0cce 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -28,7 +28,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp)
 {
 	struct scsi_device *sdp = sdkp->device;
 	struct gendisk *disk = sdkp->disk;
-	u8 type = sdkp->protection_type;
+	u8 type = sdkp->disk->protection_type;
 	struct blk_integrity bi;
 	int dif, dix;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330d..5f58736 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -219,6 +219,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u8 protection_type;/* Data Integrity Field */
 };
 
 static inline struct gendisk *part_to_disk(struct hd_struct *part)
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 3e2a80c..108008e 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -54,15 +54,13 @@ static inline u32 t10_pi_ref_tag(struct request *rq)
 extern const struct blk_integrity_profile t10_pi_type3_ip;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-extern void t10_pi_prepare(struct request *rq, u8 protection_type);
-extern void t10_pi_complete(struct request *rq, u8 protection_type,
-			    unsigned int intervals);
+extern void t10_pi_prepare(struct request *rq);
+extern void t10_pi_complete(struct request *rq, unsigned int intervals);
 #else
-static inline void t10_pi_complete(struct request *rq, u8 protection_type,
-				   unsigned int intervals)
+static inline void t10_pi_complete(struct request *rq, unsigned int intervals)
 {
 }
-static inline void t10_pi_prepare(struct request *rq, u8 protection_type)
+static inline void t10_pi_prepare(struct request *rq)
 {
 }
 #endif
-- 
1.8.3.1

