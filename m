Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 1/7] ide: cleanup ->prep_rq calling convention
Date: Fri,  9 Nov 2018 14:42:35 +0100
Message-Id: <20181109134241.29346-2-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The return value is just used as a binary yes/no decicsion, so switch
it to a bool instead of the old BLKPREP_* values returned as an int.

Also clean up a few related comments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-cd.c   | 22 +++++++++++-----------
 drivers/ide/ide-disk.c |  8 ++++----
 drivers/ide/ide-io.c   |  4 ++--
 include/linux/ide.h    |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 4ecaf2ace4cb..69c1aede5f93 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -527,8 +527,8 @@ static bool ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
 	return false;
 }
 
-/* standard prep_rq_fn that builds 10 byte cmds */
-static int ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
+/* standard prep_rq that builds 10 byte cmds */
+static bool ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
 {
 	int hard_sect = queue_logical_block_size(q);
 	long block = (long)blk_rq_pos(rq) / (hard_sect >> 9);
@@ -554,14 +554,14 @@ static int ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
 	req->cmd[7] = (blocks >> 8) & 0xff;
 	req->cmd[8] = blocks & 0xff;
 	req->cmd_len = 10;
-	return BLKPREP_OK;
+	return true;
 }
 
 /*
  * Most of the SCSI commands are supported directly by ATAPI devices.
  * This transform handles the few exceptions.
  */
-static int ide_cdrom_prep_pc(struct request *rq)
+static bool ide_cdrom_prep_pc(struct request *rq)
 {
 	u8 *c = scsi_req(rq)->cmd;
 
@@ -575,7 +575,7 @@ static int ide_cdrom_prep_pc(struct request *rq)
 		c[1] &= 0xe0;
 		c[0] += (READ_10 - READ_6);
 		scsi_req(rq)->cmd_len = 10;
-		return BLKPREP_OK;
+		return true;
 	}
 
 	/*
@@ -585,13 +585,13 @@ static int ide_cdrom_prep_pc(struct request *rq)
 	 */
 	if (c[0] == MODE_SENSE || c[0] == MODE_SELECT) {
 		scsi_req(rq)->result = ILLEGAL_REQUEST;
-		return BLKPREP_KILL;
+		return false;
 	}
 
-	return BLKPREP_OK;
+	return true;
 }
 
-static int ide_cdrom_prep_fn(ide_drive_t *drive, struct request *rq)
+static bool ide_cdrom_prep_rq(ide_drive_t *drive, struct request *rq)
 {
 	if (!blk_rq_is_passthrough(rq)) {
 		scsi_req_init(scsi_req(rq));
@@ -600,7 +600,7 @@ static int ide_cdrom_prep_fn(ide_drive_t *drive, struct request *rq)
 	} else if (blk_rq_is_scsi(rq))
 		return ide_cdrom_prep_pc(rq);
 
-	return 0;
+	return true;
 }
 
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
@@ -818,7 +818,7 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct request *rq)
 		 * We may be retrying this request after an error.  Fix up any
 		 * weirdness which might be present in the request packet.
 		 */
-		ide_cdrom_prep_fn(drive, rq);
+		ide_cdrom_prep_rq(drive, rq);
 	}
 
 	/* fs requests *must* be hardware frame aligned */
@@ -1521,7 +1521,7 @@ static int ide_cdrom_setup(ide_drive_t *drive)
 
 	ide_debug_log(IDE_DBG_PROBE, "enter");
 
-	drive->prep_rq = ide_cdrom_prep_fn;
+	drive->prep_rq = ide_cdrom_prep_rq;
 	blk_queue_dma_alignment(q, 31);
 	blk_queue_update_dma_pad(q, 15);
 
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index f8567c8c9dd1..724db9af0d82 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -427,12 +427,12 @@ static void ide_disk_unlock_native_capacity(ide_drive_t *drive)
 		drive->dev_flags |= IDE_DFLAG_NOHPA; /* disable HPA on resume */
 }
 
-static int idedisk_prep_fn(ide_drive_t *drive, struct request *rq)
+static bool idedisk_prep_rq(ide_drive_t *drive, struct request *rq)
 {
 	struct ide_cmd *cmd;
 
 	if (req_op(rq) != REQ_OP_FLUSH)
-		return BLKPREP_OK;
+		return true;
 
 	if (rq->special) {
 		cmd = rq->special;
@@ -458,7 +458,7 @@ static int idedisk_prep_fn(ide_drive_t *drive, struct request *rq)
 	rq->special = cmd;
 	cmd->rq = rq;
 
-	return BLKPREP_OK;
+	return true;
 }
 
 ide_devset_get(multcount, mult_count);
@@ -547,7 +547,7 @@ static void update_flush(ide_drive_t *drive)
 
 		if (barrier) {
 			wc = true;
-			drive->prep_rq = idedisk_prep_fn;
+			drive->prep_rq = idedisk_prep_rq;
 		}
 	}
 
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 5093c605c91c..64e72640acf8 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -326,7 +326,7 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 		goto kill_rq;
 	}
 
-	if (drive->prep_rq && drive->prep_rq(drive, rq))
+	if (drive->prep_rq && !drive->prep_rq(drive, rq))
 		return ide_stopped;
 
 	if (ata_pm_request(rq))
@@ -508,7 +508,7 @@ blk_status_t ide_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		/*
 		 * we know that the queue isn't empty, but this can happen
-		 * if the q->prep_rq_fn() decides to kill a request
+		 * if ->prep_rq() decides to kill a request
 		 */
 		if (!rq) {
 			rq = bd->rq;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 079f8bc0b0f4..272704ff21ee 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -529,7 +529,7 @@ struct ide_drive_s {
 
 	struct request_queue	*queue;	/* request queue */
 
-	int (*prep_rq)(struct ide_drive_s *, struct request *);
+	bool (*prep_rq)(struct ide_drive_s *, struct request *);
 
 	struct blk_mq_tag_set	tag_set;
 
-- 
2.19.1
