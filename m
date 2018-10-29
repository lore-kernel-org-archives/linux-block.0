Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	David Miller <davem@davemloft.net>
Subject: [PATCH 04/29] ide: convert to blk-mq
Date: Mon, 29 Oct 2018 10:34:19 -0600
Message-Id: <20181029163444.9940-5-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

ide-disk and ide-cd tested as working just fine, ide-tape and
ide-floppy haven't. But the latter don't require changes, so they
should work without issue.

Add helper function to insert a request from a work queue, since we
cannot invoke the blk-mq request insertion from IRQ context.

Cc: David Miller <davem@davemloft.net>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-atapi.c |  25 ++++--
 drivers/ide/ide-cd.c    | 175 +++++++++++++++++++++-------------------
 drivers/ide/ide-disk.c  |   5 +-
 drivers/ide/ide-io.c    | 100 +++++++++++++----------
 drivers/ide/ide-park.c  |   4 +-
 drivers/ide/ide-pm.c    |  28 ++-----
 drivers/ide/ide-probe.c |  68 +++++++++++-----
 include/linux/ide.h     |  13 ++-
 8 files changed, 239 insertions(+), 179 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 8b2b72b93885..33210bc67618 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -172,8 +172,8 @@ EXPORT_SYMBOL_GPL(ide_create_request_sense_cmd);
 void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 {
 	struct request_sense *sense = &drive->sense_data;
-	struct request *sense_rq = drive->sense_rq;
-	struct scsi_request *req = scsi_req(sense_rq);
+	struct request *sense_rq;
+	struct scsi_request *req;
 	unsigned int cmd_len, sense_len;
 	int err;
 
@@ -196,9 +196,16 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	if (ata_sense_request(rq) || drive->sense_rq_armed)
 		return;
 
+	sense_rq = drive->sense_rq;
+	if (!sense_rq) {
+		sense_rq = blk_mq_alloc_request(drive->queue, REQ_OP_DRV_IN,
+					BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+		drive->sense_rq = sense_rq;
+	}
+	req = scsi_req(sense_rq);
+
 	memset(sense, 0, sizeof(*sense));
 
-	blk_rq_init(rq->q, sense_rq);
 	scsi_req_init(req);
 
 	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
@@ -207,6 +214,8 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 		if (printk_ratelimit())
 			printk(KERN_WARNING PFX "%s: failed to map sense "
 					    "buffer\n", drive->name);
+		blk_mq_free_request(sense_rq);
+		drive->sense_rq = NULL;
 		return;
 	}
 
@@ -226,6 +235,8 @@ EXPORT_SYMBOL_GPL(ide_prep_sense);
 
 int ide_queue_sense_rq(ide_drive_t *drive, void *special)
 {
+	struct request *sense_rq = drive->sense_rq;
+
 	/* deferred failure from ide_prep_sense() */
 	if (!drive->sense_rq_armed) {
 		printk(KERN_WARNING PFX "%s: error queuing a sense request\n",
@@ -233,12 +244,12 @@ int ide_queue_sense_rq(ide_drive_t *drive, void *special)
 		return -ENOMEM;
 	}
 
-	drive->sense_rq->special = special;
+	sense_rq->special = special;
 	drive->sense_rq_armed = false;
 
 	drive->hwif->rq = NULL;
 
-	elv_add_request(drive->queue, drive->sense_rq, ELEVATOR_INSERT_FRONT);
+	ide_insert_request_head(drive, sense_rq);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ide_queue_sense_rq);
@@ -270,10 +281,8 @@ void ide_retry_pc(ide_drive_t *drive)
 	 */
 	drive->hwif->rq = NULL;
 	ide_requeue_and_plug(drive, failed_rq);
-	if (ide_queue_sense_rq(drive, pc)) {
-		blk_start_request(failed_rq);
+	if (ide_queue_sense_rq(drive, pc))
 		ide_complete_rq(drive, BLK_STS_IOERR, blk_rq_bytes(failed_rq));
-	}
 }
 EXPORT_SYMBOL_GPL(ide_retry_pc);
 
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f9b59d41813f..4ecaf2ace4cb 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -258,11 +258,22 @@ static int ide_cd_breathe(ide_drive_t *drive, struct request *rq)
 		/*
 		 * take a breather
 		 */
-		blk_delay_queue(drive->queue, 1);
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(drive->queue, 1);
 		return 1;
 	}
 }
 
+static void ide_cd_free_sense(ide_drive_t *drive)
+{
+	if (!drive->sense_rq)
+		return;
+
+	blk_mq_free_request(drive->sense_rq);
+	drive->sense_rq = NULL;
+	drive->sense_rq_armed = false;
+}
+
 /**
  * Returns:
  * 0: if the request should be continued.
@@ -516,6 +527,82 @@ static bool ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
 	return false;
 }
 
+/* standard prep_rq_fn that builds 10 byte cmds */
+static int ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
+{
+	int hard_sect = queue_logical_block_size(q);
+	long block = (long)blk_rq_pos(rq) / (hard_sect >> 9);
+	unsigned long blocks = blk_rq_sectors(rq) / (hard_sect >> 9);
+	struct scsi_request *req = scsi_req(rq);
+
+	if (rq_data_dir(rq) == READ)
+		req->cmd[0] = GPCMD_READ_10;
+	else
+		req->cmd[0] = GPCMD_WRITE_10;
+
+	/*
+	 * fill in lba
+	 */
+	req->cmd[2] = (block >> 24) & 0xff;
+	req->cmd[3] = (block >> 16) & 0xff;
+	req->cmd[4] = (block >>  8) & 0xff;
+	req->cmd[5] = block & 0xff;
+
+	/*
+	 * and transfer length
+	 */
+	req->cmd[7] = (blocks >> 8) & 0xff;
+	req->cmd[8] = blocks & 0xff;
+	req->cmd_len = 10;
+	return BLKPREP_OK;
+}
+
+/*
+ * Most of the SCSI commands are supported directly by ATAPI devices.
+ * This transform handles the few exceptions.
+ */
+static int ide_cdrom_prep_pc(struct request *rq)
+{
+	u8 *c = scsi_req(rq)->cmd;
+
+	/* transform 6-byte read/write commands to the 10-byte version */
+	if (c[0] == READ_6 || c[0] == WRITE_6) {
+		c[8] = c[4];
+		c[5] = c[3];
+		c[4] = c[2];
+		c[3] = c[1] & 0x1f;
+		c[2] = 0;
+		c[1] &= 0xe0;
+		c[0] += (READ_10 - READ_6);
+		scsi_req(rq)->cmd_len = 10;
+		return BLKPREP_OK;
+	}
+
+	/*
+	 * it's silly to pretend we understand 6-byte sense commands, just
+	 * reject with ILLEGAL_REQUEST and the caller should take the
+	 * appropriate action
+	 */
+	if (c[0] == MODE_SENSE || c[0] == MODE_SELECT) {
+		scsi_req(rq)->result = ILLEGAL_REQUEST;
+		return BLKPREP_KILL;
+	}
+
+	return BLKPREP_OK;
+}
+
+static int ide_cdrom_prep_fn(ide_drive_t *drive, struct request *rq)
+{
+	if (!blk_rq_is_passthrough(rq)) {
+		scsi_req_init(scsi_req(rq));
+
+		return ide_cdrom_prep_fs(drive->queue, rq);
+	} else if (blk_rq_is_scsi(rq))
+		return ide_cdrom_prep_pc(rq);
+
+	return 0;
+}
+
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -675,7 +762,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 out_end:
 	if (blk_rq_is_scsi(rq) && rc == 0) {
 		scsi_req(rq)->resid_len = 0;
-		blk_end_request_all(rq, BLK_STS_OK);
+		blk_mq_end_request(rq, BLK_STS_OK);
 		hwif->rq = NULL;
 	} else {
 		if (sense && uptodate)
@@ -705,6 +792,8 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 		if (sense && rc == 2)
 			ide_error(drive, "request sense failure", stat);
 	}
+
+	ide_cd_free_sense(drive);
 	return ide_stopped;
 }
 
@@ -729,7 +818,7 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct request *rq)
 		 * We may be retrying this request after an error.  Fix up any
 		 * weirdness which might be present in the request packet.
 		 */
-		q->prep_rq_fn(q, rq);
+		ide_cdrom_prep_fn(drive, rq);
 	}
 
 	/* fs requests *must* be hardware frame aligned */
@@ -1323,82 +1412,6 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
 	return nslots;
 }
 
-/* standard prep_rq_fn that builds 10 byte cmds */
-static int ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
-{
-	int hard_sect = queue_logical_block_size(q);
-	long block = (long)blk_rq_pos(rq) / (hard_sect >> 9);
-	unsigned long blocks = blk_rq_sectors(rq) / (hard_sect >> 9);
-	struct scsi_request *req = scsi_req(rq);
-
-	q->initialize_rq_fn(rq);
-
-	if (rq_data_dir(rq) == READ)
-		req->cmd[0] = GPCMD_READ_10;
-	else
-		req->cmd[0] = GPCMD_WRITE_10;
-
-	/*
-	 * fill in lba
-	 */
-	req->cmd[2] = (block >> 24) & 0xff;
-	req->cmd[3] = (block >> 16) & 0xff;
-	req->cmd[4] = (block >>  8) & 0xff;
-	req->cmd[5] = block & 0xff;
-
-	/*
-	 * and transfer length
-	 */
-	req->cmd[7] = (blocks >> 8) & 0xff;
-	req->cmd[8] = blocks & 0xff;
-	req->cmd_len = 10;
-	return BLKPREP_OK;
-}
-
-/*
- * Most of the SCSI commands are supported directly by ATAPI devices.
- * This transform handles the few exceptions.
- */
-static int ide_cdrom_prep_pc(struct request *rq)
-{
-	u8 *c = scsi_req(rq)->cmd;
-
-	/* transform 6-byte read/write commands to the 10-byte version */
-	if (c[0] == READ_6 || c[0] == WRITE_6) {
-		c[8] = c[4];
-		c[5] = c[3];
-		c[4] = c[2];
-		c[3] = c[1] & 0x1f;
-		c[2] = 0;
-		c[1] &= 0xe0;
-		c[0] += (READ_10 - READ_6);
-		scsi_req(rq)->cmd_len = 10;
-		return BLKPREP_OK;
-	}
-
-	/*
-	 * it's silly to pretend we understand 6-byte sense commands, just
-	 * reject with ILLEGAL_REQUEST and the caller should take the
-	 * appropriate action
-	 */
-	if (c[0] == MODE_SENSE || c[0] == MODE_SELECT) {
-		scsi_req(rq)->result = ILLEGAL_REQUEST;
-		return BLKPREP_KILL;
-	}
-
-	return BLKPREP_OK;
-}
-
-static int ide_cdrom_prep_fn(struct request_queue *q, struct request *rq)
-{
-	if (!blk_rq_is_passthrough(rq))
-		return ide_cdrom_prep_fs(q, rq);
-	else if (blk_rq_is_scsi(rq))
-		return ide_cdrom_prep_pc(rq);
-
-	return 0;
-}
-
 struct cd_list_entry {
 	const char	*id_model;
 	const char	*id_firmware;
@@ -1508,7 +1521,7 @@ static int ide_cdrom_setup(ide_drive_t *drive)
 
 	ide_debug_log(IDE_DBG_PROBE, "enter");
 
-	blk_queue_prep_rq(q, ide_cdrom_prep_fn);
+	drive->prep_rq = ide_cdrom_prep_fn;
 	blk_queue_dma_alignment(q, 31);
 	blk_queue_update_dma_pad(q, 15);
 
@@ -1569,7 +1582,7 @@ static void ide_cd_release(struct device *dev)
 	if (devinfo->handle == drive)
 		unregister_cdrom(devinfo);
 	drive->driver_data = NULL;
-	blk_queue_prep_rq(drive->queue, NULL);
+	drive->prep_rq = NULL;
 	g->private_data = NULL;
 	put_disk(g);
 	kfree(info);
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index e3b4e659082d..f8567c8c9dd1 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -427,9 +427,8 @@ static void ide_disk_unlock_native_capacity(ide_drive_t *drive)
 		drive->dev_flags |= IDE_DFLAG_NOHPA; /* disable HPA on resume */
 }
 
-static int idedisk_prep_fn(struct request_queue *q, struct request *rq)
+static int idedisk_prep_fn(ide_drive_t *drive, struct request *rq)
 {
-	ide_drive_t *drive = q->queuedata;
 	struct ide_cmd *cmd;
 
 	if (req_op(rq) != REQ_OP_FLUSH)
@@ -548,7 +547,7 @@ static void update_flush(ide_drive_t *drive)
 
 		if (barrier) {
 			wc = true;
-			blk_queue_prep_rq(drive->queue, idedisk_prep_fn);
+			drive->prep_rq = idedisk_prep_fn;
 		}
 	}
 
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 0d93e0cfbeaf..5093c605c91c 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -67,7 +67,15 @@ int ide_end_rq(ide_drive_t *drive, struct request *rq, blk_status_t error,
 		ide_dma_on(drive);
 	}
 
-	return blk_end_request(rq, error, nr_bytes);
+	if (!blk_update_request(rq, error, nr_bytes)) {
+		if (rq == drive->sense_rq)
+			drive->sense_rq = NULL;
+
+		__blk_mq_end_request(rq, error);
+		return 0;
+	}
+
+	return 1;
 }
 EXPORT_SYMBOL_GPL(ide_end_rq);
 
@@ -307,8 +315,6 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
 
-	BUG_ON(!(rq->rq_flags & RQF_STARTED));
-
 #ifdef DEBUG
 	printk("%s: start_request: current=0x%08lx\n",
 		drive->hwif->name, (unsigned long) rq);
@@ -320,6 +326,9 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 		goto kill_rq;
 	}
 
+	if (drive->prep_rq && drive->prep_rq(drive, rq))
+		return ide_stopped;
+
 	if (ata_pm_request(rq))
 		ide_check_pm_state(drive, rq);
 
@@ -430,44 +439,38 @@ static inline void ide_unlock_host(struct ide_host *host)
 	}
 }
 
-static void __ide_requeue_and_plug(struct request_queue *q, struct request *rq)
-{
-	if (rq)
-		blk_requeue_request(q, rq);
-	if (rq || blk_peek_request(q)) {
-		/* Use 3ms as that was the old plug delay */
-		blk_delay_queue(q, 3);
-	}
-}
-
 void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
-	unsigned long flags;
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	__ide_requeue_and_plug(q, rq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	/* Use 3ms as that was the old plug delay */
+	if (rq) {
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(q, 3);
+	} else
+		blk_mq_delay_run_hw_queue(q->queue_hw_ctx[0], 3);
 }
 
 /*
  * Issue a new request to a device.
  */
-void do_ide_request(struct request_queue *q)
+blk_status_t ide_queue_rq(struct blk_mq_hw_ctx *hctx,
+			  const struct blk_mq_queue_data *bd)
 {
-	ide_drive_t	*drive = q->queuedata;
+	ide_drive_t	*drive = hctx->queue->queuedata;
 	ide_hwif_t	*hwif = drive->hwif;
 	struct ide_host *host = hwif->host;
 	struct request	*rq = NULL;
 	ide_startstop_t	startstop;
 
-	spin_unlock_irq(q->queue_lock);
-
 	/* HLD do_request() callback might sleep, make sure it's okay */
 	might_sleep();
 
 	if (ide_lock_host(host, hwif))
-		goto plug_device_2;
+		return BLK_STS_DEV_RESOURCE;
+
+	rq = bd->rq;
+	blk_mq_start_request(rq);
 
 	spin_lock_irq(&hwif->lock);
 
@@ -503,21 +506,16 @@ void do_ide_request(struct request_queue *q)
 		hwif->cur_dev = drive;
 		drive->dev_flags &= ~(IDE_DFLAG_SLEEPING | IDE_DFLAG_PARKED);
 
-		spin_unlock_irq(&hwif->lock);
-		spin_lock_irq(q->queue_lock);
 		/*
 		 * we know that the queue isn't empty, but this can happen
 		 * if the q->prep_rq_fn() decides to kill a request
 		 */
-		if (!rq)
-			rq = blk_fetch_request(drive->queue);
-
-		spin_unlock_irq(q->queue_lock);
-		spin_lock_irq(&hwif->lock);
-
 		if (!rq) {
-			ide_unlock_port(hwif);
-			goto out;
+			rq = bd->rq;
+			if (!rq) {
+				ide_unlock_port(hwif);
+				goto out;
+			}
 		}
 
 		/*
@@ -551,23 +549,24 @@ void do_ide_request(struct request_queue *q)
 		if (startstop == ide_stopped) {
 			rq = hwif->rq;
 			hwif->rq = NULL;
-			goto repeat;
+			if (rq)
+				goto repeat;
+			ide_unlock_port(hwif);
+			goto out;
 		}
-	} else
-		goto plug_device;
+	} else {
+plug_device:
+		spin_unlock_irq(&hwif->lock);
+		ide_unlock_host(host);
+		ide_requeue_and_plug(drive, rq);
+		return BLK_STS_OK;
+	}
+
 out:
 	spin_unlock_irq(&hwif->lock);
 	if (rq == NULL)
 		ide_unlock_host(host);
-	spin_lock_irq(q->queue_lock);
-	return;
-
-plug_device:
-	spin_unlock_irq(&hwif->lock);
-	ide_unlock_host(host);
-plug_device_2:
-	spin_lock_irq(q->queue_lock);
-	__ide_requeue_and_plug(q, rq);
+	return BLK_STS_OK;
 }
 
 static int drive_is_ready(ide_drive_t *drive)
@@ -887,3 +886,16 @@ void ide_pad_transfer(ide_drive_t *drive, int write, int len)
 	}
 }
 EXPORT_SYMBOL_GPL(ide_pad_transfer);
+
+void ide_insert_request_head(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwif->lock, flags);
+	list_add_tail(&rq->queuelist, &drive->rq_list);
+	spin_unlock_irqrestore(&hwif->lock, flags);
+
+	kblockd_schedule_work(&drive->rq_work);
+}
+EXPORT_SYMBOL_GPL(ide_insert_request_head);
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 622f0edb3945..de9e85cf74d1 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -27,7 +27,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 		spin_unlock_irq(&hwif->lock);
 
 		if (start_queue)
-			blk_run_queue(q);
+			blk_mq_run_hw_queues(q, true);
 		return;
 	}
 	spin_unlock_irq(&hwif->lock);
@@ -54,7 +54,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	scsi_req(rq)->cmd[0] = REQ_UNPARK_HEADS;
 	scsi_req(rq)->cmd_len = 1;
 	ide_req(rq)->type = ATA_PRIV_MISC;
-	elv_add_request(q, rq, ELEVATOR_INSERT_FRONT);
+	ide_insert_request_head(drive, rq);
 
 out:
 	return;
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 59217aa1d1fb..ea10507e5190 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -40,32 +40,20 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 	return ret;
 }
 
-static void ide_end_sync_rq(struct request *rq, blk_status_t error)
-{
-	complete(rq->end_io_data);
-}
-
 static int ide_pm_execute_rq(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	DECLARE_COMPLETION_ONSTACK(wait);
-
-	rq->end_io_data = &wait;
-	rq->end_io = ide_end_sync_rq;
 
 	spin_lock_irq(q->queue_lock);
 	if (unlikely(blk_queue_dying(q))) {
 		rq->rq_flags |= RQF_QUIET;
 		scsi_req(rq)->result = -ENXIO;
-		__blk_end_request_all(rq, BLK_STS_OK);
 		spin_unlock_irq(q->queue_lock);
+		blk_mq_end_request(rq, BLK_STS_OK);
 		return -ENXIO;
 	}
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT);
-	__blk_run_queue_uncond(q);
 	spin_unlock_irq(q->queue_lock);
-
-	wait_for_completion_io(&wait);
+	blk_execute_rq(q, NULL, rq, true);
 
 	return scsi_req(rq)->result ? -EIO : 0;
 }
@@ -79,6 +67,8 @@ int generic_ide_resume(struct device *dev)
 	struct ide_pm_state rqpm;
 	int err;
 
+	blk_mq_start_stopped_hw_queues(drive->queue, true);
+
 	if (ide_port_acpi(hwif)) {
 		/* call ACPI _PS0 / _STM only once */
 		if ((drive->dn & 1) == 0 || pair == NULL) {
@@ -226,15 +216,14 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 #endif
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND)
-		blk_stop_queue(q);
+		blk_mq_stop_hw_queues(q);
 	else
 		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	drive->hwif->rq = NULL;
 
-	if (blk_end_request(rq, BLK_STS_OK, 0))
-		BUG();
+	blk_mq_end_request(rq, BLK_STS_OK);
 }
 
 void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
@@ -260,7 +249,6 @@ void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 		ide_hwif_t *hwif = drive->hwif;
 		const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 		struct request_queue *q = drive->queue;
-		unsigned long flags;
 		int rc;
 #ifdef DEBUG_PM
 		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->name);
@@ -274,8 +262,6 @@ void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
 
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		blk_mq_start_hw_queues(q);
 	}
 }
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 3b75a7b7a284..40384838e439 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -750,6 +750,11 @@ static void ide_initialize_rq(struct request *rq)
 	req->sreq.sense = req->sense;
 }
 
+static const struct blk_mq_ops ide_mq_ops = {
+	.queue_rq		= ide_queue_rq,
+	.initialize_rq_fn	= ide_initialize_rq,
+};
+
 /*
  * init request queue
  */
@@ -759,6 +764,7 @@ static int ide_init_queue(ide_drive_t *drive)
 	ide_hwif_t *hwif = drive->hwif;
 	int max_sectors = 256;
 	int max_sg_entries = PRD_ENTRIES;
+	struct blk_mq_tag_set *set;
 
 	/*
 	 *	Our default set up assumes the normal IDE case,
@@ -767,19 +773,26 @@ static int ide_init_queue(ide_drive_t *drive)
 	 *	limits and LBA48 we could raise it but as yet
 	 *	do not.
 	 */
-	q = blk_alloc_queue_node(GFP_KERNEL, hwif_to_node(hwif), NULL);
-	if (!q)
+
+	set = &drive->tag_set;
+	set->ops = &ide_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 32;
+	set->reserved_tags = 1;
+	set->cmd_size = sizeof(struct ide_request);
+	set->numa_node = hwif_to_node(hwif);
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	if (blk_mq_alloc_tag_set(set))
 		return 1;
 
-	q->request_fn = do_ide_request;
-	q->initialize_rq_fn = ide_initialize_rq;
-	q->cmd_size = sizeof(struct ide_request);
-	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
-	if (blk_init_allocated_queue(q) < 0) {
-		blk_cleanup_queue(q);
+	q = blk_mq_init_queue(set);
+	if (IS_ERR(q)) {
+		blk_mq_free_tag_set(set);
 		return 1;
 	}
 
+	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
+
 	q->queuedata = drive;
 	blk_queue_segment_boundary(q, 0xffff);
 
@@ -965,8 +978,12 @@ static void drive_release_dev (struct device *dev)
 
 	ide_proc_unregister_device(drive);
 
+	if (drive->sense_rq)
+		blk_mq_free_request(drive->sense_rq);
+
 	blk_cleanup_queue(drive->queue);
 	drive->queue = NULL;
+	blk_mq_free_tag_set(&drive->tag_set);
 
 	drive->dev_flags &= ~IDE_DFLAG_PRESENT;
 
@@ -1133,6 +1150,28 @@ static void ide_port_cable_detect(ide_hwif_t *hwif)
 	}
 }
 
+/*
+ * Deferred request list insertion handler
+ */
+static void drive_rq_insert_work(struct work_struct *work)
+{
+	ide_drive_t *drive = container_of(work, ide_drive_t, rq_work);
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq;
+	LIST_HEAD(list);
+
+	spin_lock_irq(&hwif->lock);
+	if (!list_empty(&drive->rq_list))
+		list_splice_init(&drive->rq_list, &list);
+	spin_unlock_irq(&hwif->lock);
+
+	while (!list_empty(&list)) {
+		rq = list_first_entry(&list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_execute_rq_nowait(drive->queue, rq->rq_disk, rq, true, NULL);
+	}
+}
+
 static const u8 ide_hwif_to_major[] =
 	{ IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
 	  IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR };
@@ -1145,12 +1184,10 @@ static void ide_port_init_devices_data(ide_hwif_t *hwif)
 	ide_port_for_each_dev(i, drive, hwif) {
 		u8 j = (hwif->index * MAX_DRIVES) + i;
 		u16 *saved_id = drive->id;
-		struct request *saved_sense_rq = drive->sense_rq;
 
 		memset(drive, 0, sizeof(*drive));
 		memset(saved_id, 0, SECTOR_SIZE);
 		drive->id = saved_id;
-		drive->sense_rq = saved_sense_rq;
 
 		drive->media			= ide_disk;
 		drive->select			= (i << 4) | ATA_DEVICE_OBS;
@@ -1166,6 +1203,9 @@ static void ide_port_init_devices_data(ide_hwif_t *hwif)
 
 		INIT_LIST_HEAD(&drive->list);
 		init_completion(&drive->gendev_rel_comp);
+
+		INIT_WORK(&drive->rq_work, drive_rq_insert_work);
+		INIT_LIST_HEAD(&drive->rq_list);
 	}
 }
 
@@ -1255,7 +1295,6 @@ static void ide_port_free_devices(ide_hwif_t *hwif)
 	int i;
 
 	ide_port_for_each_dev(i, drive, hwif) {
-		kfree(drive->sense_rq);
 		kfree(drive->id);
 		kfree(drive);
 	}
@@ -1283,17 +1322,10 @@ static int ide_port_alloc_devices(ide_hwif_t *hwif, int node)
 		if (drive->id == NULL)
 			goto out_free_drive;
 
-		drive->sense_rq = kmalloc(sizeof(struct request) +
-				sizeof(struct ide_request), GFP_KERNEL);
-		if (!drive->sense_rq)
-			goto out_free_id;
-
 		hwif->devices[i] = drive;
 	}
 	return 0;
 
-out_free_id:
-	kfree(drive->id);
 out_free_drive:
 	kfree(drive);
 out_nomem:
diff --git a/include/linux/ide.h b/include/linux/ide.h
index c74b0321922a..079f8bc0b0f4 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/ata.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
@@ -529,6 +529,10 @@ struct ide_drive_s {
 
 	struct request_queue	*queue;	/* request queue */
 
+	int (*prep_rq)(struct ide_drive_s *, struct request *);
+
+	struct blk_mq_tag_set	tag_set;
+
 	struct request		*rq;	/* current request */
 	void		*driver_data;	/* extra driver data */
 	u16			*id;	/* identification info */
@@ -612,6 +616,10 @@ struct ide_drive_s {
 	bool sense_rq_armed;
 	struct request *sense_rq;
 	struct request_sense sense_data;
+
+	/* async sense insertion */
+	struct work_struct rq_work;
+	struct list_head rq_list;
 };
 
 typedef struct ide_drive_s ide_drive_t;
@@ -1089,6 +1097,7 @@ extern int ide_pci_clk;
 
 int ide_end_rq(ide_drive_t *, struct request *, blk_status_t, unsigned int);
 void ide_kill_rq(ide_drive_t *, struct request *);
+void ide_insert_request_head(ide_drive_t *, struct request *);
 
 void __ide_set_handler(ide_drive_t *, ide_handler_t *, unsigned int);
 void ide_set_handler(ide_drive_t *, ide_handler_t *, unsigned int);
@@ -1208,7 +1217,7 @@ extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
 extern void ide_timer_expiry(struct timer_list *t);
 extern irqreturn_t ide_intr(int irq, void *dev_id);
-extern void do_ide_request(struct request_queue *);
+extern blk_status_t ide_queue_rq(struct blk_mq_hw_ctx *, const struct blk_mq_queue_data *);
 extern void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq);
 
 void ide_init_disk(struct gendisk *, ide_drive_t *);
-- 
2.17.1
