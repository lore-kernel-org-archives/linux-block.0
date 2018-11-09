Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 5/7] scsi: return blk_status_t from scsi_init_io and ->init_command
Date: Fri,  9 Nov 2018 14:42:39 +0100
Message-Id: <20181109134241.29346-6-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Replace the old BLKRREP_* values with the BLK_STS_ ones that they are
converted to later anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c    | 45 ++++++++++----------
 drivers/scsi/sd.c          | 85 +++++++++++++++++---------------------
 drivers/scsi/sd.h          |  6 +--
 drivers/scsi/sd_zbc.c      | 10 ++---
 drivers/scsi/sr.c          | 12 +++---
 include/scsi/scsi_cmnd.h   |  2 +-
 include/scsi/scsi_driver.h |  3 +-
 7 files changed, 78 insertions(+), 85 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1f84e2cec57b..3e3bdeee8f14 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1005,7 +1005,8 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 		scsi_io_completion_action(cmd, result);
 }
 
-static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
+static blk_status_t scsi_init_sgtable(struct request *req,
+		struct scsi_data_buffer *sdb)
 {
 	int count;
 
@@ -1014,7 +1015,7 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
 	 */
 	if (unlikely(sg_alloc_table_chained(&sdb->table,
 			blk_rq_nr_phys_segments(req), sdb->table.sgl)))
-		return BLKPREP_DEFER;
+		return BLK_STS_RESOURCE;
 
 	/* 
 	 * Next, walk the list, and fill in the addresses and sizes of
@@ -1024,7 +1025,7 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
 	BUG_ON(count > sdb->table.nents);
 	sdb->table.nents = count;
 	sdb->length = blk_rq_payload_bytes(req);
-	return BLKPREP_OK;
+	return BLK_STS_OK;
 }
 
 /*
@@ -1034,25 +1035,25 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
  *
  * Arguments:   cmd   - Command descriptor we wish to initialize
  *
- * Returns:     0 on success
- *		BLKPREP_DEFER if the failure is retryable
- *		BLKPREP_KILL if the failure is fatal
+ * Returns:     BLK_STS_OK on success
+ *		BLK_STS_RESOURCE if the failure is retryable
+ *		BLK_STS_IOERR if the failure is fatal
  */
-int scsi_init_io(struct scsi_cmnd *cmd)
+blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
-	int error = BLKPREP_KILL;
+	blk_status_t ret;
 
 	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
-		return BLKPREP_KILL;
+		return BLK_STS_IOERR;
 
-	error = scsi_init_sgtable(rq, &cmd->sdb);
-	if (error)
-		return error;
+	ret = scsi_init_sgtable(rq, &cmd->sdb);
+	if (ret)
+		return ret;
 
 	if (blk_bidi_rq(rq)) {
-		error = scsi_init_sgtable(rq->next_rq, rq->next_rq->special);
-		if (error)
+		ret = scsi_init_sgtable(rq->next_rq, rq->next_rq->special);
+		if (ret)
 			goto out_free_sgtables;
 	}
 
@@ -1066,7 +1067,7 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 			 * queues a command to a device on an adapter
 			 * that does not support DIX.
 			 */
-			error = BLKPREP_KILL;
+			ret = BLK_STS_IOERR;
 			goto out_free_sgtables;
 		}
 
@@ -1074,7 +1075,7 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl)) {
-			error = BLKPREP_DEFER;
+			ret = BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
 
@@ -1087,10 +1088,10 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 		cmd->prot_sdb->table.nents = count;
 	}
 
-	return BLKPREP_OK;
+	return BLK_STS_OK;
 out_free_sgtables:
 	scsi_mq_free_sgtables(cmd);
-	return error;
+	return ret;
 }
 EXPORT_SYMBOL(scsi_init_io);
 
@@ -1200,9 +1201,9 @@ static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
 	 * submit a request without an attached bio.
 	 */
 	if (req->bio) {
-		int ret = scsi_init_io(cmd);
-		if (unlikely(ret))
-			return prep_to_mq(ret);
+		blk_status_t ret = scsi_init_io(cmd);
+		if (unlikely(ret != BLK_STS_OK))
+			return ret;
 	} else {
 		BUG_ON(blk_rq_bytes(req));
 
@@ -1233,7 +1234,7 @@ static blk_status_t scsi_setup_fs_cmnd(struct scsi_device *sdev,
 
 	cmd->cmnd = scsi_req(req)->cmd = scsi_req(req)->__cmd;
 	memset(cmd->cmnd, 0, BLK_MAX_CDB);
-	return prep_to_mq(scsi_cmd_to_driver(cmd)->init_command(cmd));
+	return scsi_cmd_to_driver(cmd)->init_command(cmd);
 }
 
 static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3bb2b3351e35..4a6ed2fc8c71 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -114,7 +114,7 @@ static int sd_suspend_system(struct device *);
 static int sd_suspend_runtime(struct device *);
 static int sd_resume(struct device *);
 static void sd_rescan(struct device *);
-static int sd_init_command(struct scsi_cmnd *SCpnt);
+static blk_status_t sd_init_command(struct scsi_cmnd *SCpnt);
 static void sd_uninit_command(struct scsi_cmnd *SCpnt);
 static int sd_done(struct scsi_cmnd *);
 static void sd_eh_reset(struct scsi_cmnd *);
@@ -750,7 +750,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
-static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
+static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = cmd->request;
@@ -761,7 +761,7 @@ static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
 	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 	if (!rq->special_vec.bv_page)
-		return BLKPREP_DEFER;
+		return BLK_STS_RESOURCE;
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -784,7 +784,8 @@ static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_init_io(cmd);
 }
 
-static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
+static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
+		bool unmap)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = cmd->request;
@@ -794,7 +795,7 @@ static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
 
 	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 	if (!rq->special_vec.bv_page)
-		return BLKPREP_DEFER;
+		return BLK_STS_RESOURCE;
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -814,7 +815,8 @@ static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
 	return scsi_init_io(cmd);
 }
 
-static int sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd, bool unmap)
+static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
+		bool unmap)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = cmd->request;
@@ -824,7 +826,7 @@ static int sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd, bool unmap)
 
 	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 	if (!rq->special_vec.bv_page)
-		return BLKPREP_DEFER;
+		return BLK_STS_RESOURCE;
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -844,7 +846,7 @@ static int sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd, bool unmap)
 	return scsi_init_io(cmd);
 }
 
-static int sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
+static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 	struct scsi_device *sdp = cmd->device;
@@ -862,7 +864,7 @@ static int sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 	}
 
 	if (sdp->no_write_same)
-		return BLKPREP_INVALID;
+		return BLK_STS_TARGET;
 
 	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
 		return sd_setup_write_same16_cmnd(cmd, false);
@@ -939,7 +941,7 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
  * Will set up either WRITE SAME(10) or WRITE SAME(16) depending on
  * the preference indicated by the target device.
  **/
-static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
+static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 	struct scsi_device *sdp = cmd->device;
@@ -948,10 +950,10 @@ static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 	sector_t sector = blk_rq_pos(rq);
 	unsigned int nr_sectors = blk_rq_sectors(rq);
 	unsigned int nr_bytes = blk_rq_bytes(rq);
-	int ret;
+	blk_status_t ret;
 
 	if (sdkp->device->no_write_same)
-		return BLKPREP_INVALID;
+		return BLK_STS_TARGET;
 
 	BUG_ON(bio_offset(bio) || bio_iovec(bio).bv_len != sdp->sector_size);
 
@@ -992,7 +994,7 @@ static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 	return ret;
 }
 
-static int sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
+static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 
@@ -1005,10 +1007,10 @@ static int sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 	cmd->allowed = SD_MAX_RETRIES;
 
 	rq->timeout = rq->q->rq_timeout * SD_FLUSH_TIMEOUT_MULTIPLIER;
-	return BLKPREP_OK;
+	return BLK_STS_OK;
 }
 
-static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
+static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 {
 	struct request *rq = SCpnt->request;
 	struct scsi_device *sdp = SCpnt->device;
@@ -1018,18 +1020,14 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	sector_t threshold;
 	unsigned int this_count = blk_rq_sectors(rq);
 	unsigned int dif, dix;
-	int ret;
 	unsigned char protect;
+	blk_status_t ret;
 
 	ret = scsi_init_io(SCpnt);
-	if (ret != BLKPREP_OK)
+	if (ret != BLK_STS_OK)
 		return ret;
 	WARN_ON_ONCE(SCpnt != rq->special);
 
-	/* from here on until we're complete, any goto out
-	 * is used for a killable error condition */
-	ret = BLKPREP_KILL;
-
 	SCSI_LOG_HLQUEUE(1,
 		scmd_printk(KERN_INFO, SCpnt,
 			"%s: block=%llu, count=%d\n",
@@ -1042,7 +1040,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 						blk_rq_sectors(rq)));
 		SCSI_LOG_HLQUEUE(2, scmd_printk(KERN_INFO, SCpnt,
 						"Retry with 0x%p\n", SCpnt));
-		goto out;
+		return BLK_STS_IOERR;
 	}
 
 	if (sdp->changed) {
@@ -1051,7 +1049,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		 * the changed bit has been reset
 		 */
 		/* printk("SCSI disk has been changed or is not present. Prohibiting further I/O.\n"); */
-		goto out;
+		return BLK_STS_IOERR;
 	}
 
 	/*
@@ -1089,31 +1087,28 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		if ((block & 1) || (blk_rq_sectors(rq) & 1)) {
 			scmd_printk(KERN_ERR, SCpnt,
 				    "Bad block number requested\n");
-			goto out;
-		} else {
-			block = block >> 1;
-			this_count = this_count >> 1;
+			return BLK_STS_IOERR;
 		}
+		block = block >> 1;
+		this_count = this_count >> 1;
 	}
 	if (sdp->sector_size == 2048) {
 		if ((block & 3) || (blk_rq_sectors(rq) & 3)) {
 			scmd_printk(KERN_ERR, SCpnt,
 				    "Bad block number requested\n");
-			goto out;
-		} else {
-			block = block >> 2;
-			this_count = this_count >> 2;
+			return BLK_STS_IOERR;
 		}
+		block = block >> 2;
+		this_count = this_count >> 2;
 	}
 	if (sdp->sector_size == 4096) {
 		if ((block & 7) || (blk_rq_sectors(rq) & 7)) {
 			scmd_printk(KERN_ERR, SCpnt,
 				    "Bad block number requested\n");
-			goto out;
-		} else {
-			block = block >> 3;
-			this_count = this_count >> 3;
+			return BLK_STS_IOERR;
 		}
+		block = block >> 3;
+		this_count = this_count >> 3;
 	}
 	if (rq_data_dir(rq) == WRITE) {
 		SCpnt->cmnd[0] = WRITE_6;
@@ -1125,7 +1120,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[0] = READ_6;
 	} else {
 		scmd_printk(KERN_ERR, SCpnt, "Unknown command %d\n", req_op(rq));
-		goto out;
+		return BLK_STS_IOERR;
 	}
 
 	SCSI_LOG_HLQUEUE(2, scmd_printk(KERN_INFO, SCpnt,
@@ -1145,10 +1140,8 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		SCpnt->cmnd = mempool_alloc(sd_cdb_pool, GFP_ATOMIC);
 
-		if (unlikely(SCpnt->cmnd == NULL)) {
-			ret = BLKPREP_DEFER;
-			goto out;
-		}
+		if (unlikely(!SCpnt->cmnd))
+			return BLK_STS_RESOURCE;
 
 		SCpnt->cmd_len = SD_EXT_CDB_SIZE;
 		memset(SCpnt->cmnd, 0, SCpnt->cmd_len);
@@ -1216,7 +1209,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 			 */
 			scmd_printk(KERN_ERR, SCpnt,
 				    "FUA write on READ/WRITE(6) drive\n");
-			goto out;
+			return BLK_STS_IOERR;
 		}
 
 		SCpnt->cmnd[1] |= (unsigned char) ((block >> 16) & 0x1f);
@@ -1240,12 +1233,10 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	 * This indicates that the command is ready from our end to be
 	 * queued.
 	 */
-	ret = BLKPREP_OK;
- out:
-	return ret;
+	return BLK_STS_OK;
 }
 
-static int sd_init_command(struct scsi_cmnd *cmd)
+static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 
@@ -1261,7 +1252,7 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 		case SD_LBP_ZERO:
 			return sd_setup_write_same10_cmnd(cmd, false);
 		default:
-			return BLKPREP_INVALID;
+			return BLK_STS_TARGET;
 		}
 	case REQ_OP_WRITE_ZEROES:
 		return sd_setup_write_zeroes_cmnd(cmd);
@@ -1276,7 +1267,7 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 		return sd_zbc_setup_reset_cmnd(cmd);
 	default:
 		WARN_ON_ONCE(1);
-		return BLKPREP_KILL;
+		return BLK_STS_NOTSUPP;
 	}
 }
 
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 1d63f3a23ffb..7f43e6839bce 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -271,7 +271,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
 extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
-extern int sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
+extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
 extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			    struct scsi_sense_hdr *sshdr);
 extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
@@ -288,9 +288,9 @@ static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 
 static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}
 
-static inline int sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 {
-	return BLKPREP_INVALID;
+	return BLK_STS_TARGET;
 }
 
 static inline void sd_zbc_complete(struct scsi_cmnd *cmd,
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index e06c48c866e4..83365b29a4d8 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -185,7 +185,7 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
  *
  * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.
  */
-int sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
@@ -194,14 +194,14 @@ int sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 
 	if (!sd_is_zoned(sdkp))
 		/* Not a zoned device */
-		return BLKPREP_KILL;
+		return BLK_STS_IOERR;
 
 	if (sdkp->device->changed)
-		return BLKPREP_KILL;
+		return BLK_STS_IOERR;
 
 	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
 		/* Unaligned request */
-		return BLKPREP_KILL;
+		return BLK_STS_IOERR;
 
 	cmd->cmd_len = 16;
 	memset(cmd->cmnd, 0, cmd->cmd_len);
@@ -214,7 +214,7 @@ int sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = 0;
 	cmd->allowed = 0;
 
-	return BLKPREP_OK;
+	return BLK_STS_OK;
 }
 
 /**
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 54dd70ae9731..38ddbbfe5f3c 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -80,7 +80,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_WORM);
 static DEFINE_MUTEX(sr_mutex);
 static int sr_probe(struct device *);
 static int sr_remove(struct device *);
-static int sr_init_command(struct scsi_cmnd *SCpnt);
+static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt);
 static int sr_done(struct scsi_cmnd *);
 static int sr_runtime_suspend(struct device *dev);
 
@@ -384,22 +384,22 @@ static int sr_done(struct scsi_cmnd *SCpnt)
 	return good_bytes;
 }
 
-static int sr_init_command(struct scsi_cmnd *SCpnt)
+static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 {
 	int block = 0, this_count, s_size;
 	struct scsi_cd *cd;
 	struct request *rq = SCpnt->request;
-	int ret;
+	blk_status_t ret;
 
 	ret = scsi_init_io(SCpnt);
-	if (ret != BLKPREP_OK)
+	if (ret != BLK_STS_OK)
 		goto out;
 	WARN_ON_ONCE(SCpnt != rq->special);
 	cd = scsi_cd(rq->rq_disk);
 
 	/* from here on until we're complete, any goto out
 	 * is used for a killable error condition */
-	ret = BLKPREP_KILL;
+	ret = BLK_STS_IOERR;
 
 	SCSI_LOG_HLQUEUE(1, scmd_printk(KERN_INFO, SCpnt,
 		"Doing sr request, block = %d\n", block));
@@ -516,7 +516,7 @@ static int sr_init_command(struct scsi_cmnd *SCpnt)
 	 * This indicates that the command is ready from our end to be
 	 * queued.
 	 */
-	ret = BLKPREP_OK;
+	ret = BLK_STS_OK;
  out:
 	return ret;
 }
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index c891ada3c5c2..d6fd2aba0380 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -171,7 +171,7 @@ extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
 				 size_t *offset, size_t *len);
 extern void scsi_kunmap_atomic_sg(void *virt);
 
-extern int scsi_init_io(struct scsi_cmnd *cmd);
+extern blk_status_t scsi_init_io(struct scsi_cmnd *cmd);
 
 #ifdef CONFIG_SCSI_DMA
 extern int scsi_dma_map(struct scsi_cmnd *cmd);
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index fae8b465233e..6dffa8555a39 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -2,6 +2,7 @@
 #ifndef _SCSI_SCSI_DRIVER_H
 #define _SCSI_SCSI_DRIVER_H
 
+#include <linux/blk_types.h>
 #include <linux/device.h>
 
 struct module;
@@ -13,7 +14,7 @@ struct scsi_driver {
 	struct device_driver	gendrv;
 
 	void (*rescan)(struct device *);
-	int (*init_command)(struct scsi_cmnd *);
+	blk_status_t (*init_command)(struct scsi_cmnd *);
 	void (*uninit_command)(struct scsi_cmnd *);
 	int (*done)(struct scsi_cmnd *);
 	int (*eh_action)(struct scsi_cmnd *, int);
-- 
2.19.1
