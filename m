Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/6] ide: don't use req->special
Date: Fri,  9 Nov 2018 19:32:08 +0100
Message-Id: <20181109183208.19879-7-hch@lst.de>
In-Reply-To: <20181109183208.19879-1-hch@lst.de>
References: <20181109183208.19879-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Just replace it with a field of the same name in struct ide_req.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-atapi.c    |  4 ++--
 drivers/ide/ide-cd.c       |  4 ++--
 drivers/ide/ide-devsets.c  |  4 ++--
 drivers/ide/ide-disk.c     |  6 +++---
 drivers/ide/ide-eh.c       |  2 +-
 drivers/ide/ide-floppy.c   |  2 +-
 drivers/ide/ide-io.c       | 14 +++++++++-----
 drivers/ide/ide-park.c     |  4 ++--
 drivers/ide/ide-pm.c       | 12 ++++++------
 drivers/ide/ide-tape.c     |  2 +-
 drivers/ide/ide-taskfile.c |  2 +-
 include/linux/ide.h        |  1 +
 12 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 33210bc67618..da58020a144e 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -94,7 +94,7 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_MISC;
-	rq->special = (char *)pc;
+	ide_req(rq)->special = pc;
 
 	if (buf && bufflen) {
 		error = blk_rq_map_kern(drive->queue, rq, buf, bufflen,
@@ -244,7 +244,7 @@ int ide_queue_sense_rq(ide_drive_t *drive, void *special)
 		return -ENOMEM;
 	}
 
-	sense_rq->special = special;
+	ide_req(sense_rq)->special = special;
 	drive->sense_rq_armed = false;
 
 	drive->hwif->rq = NULL;
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 4ecaf2ace4cb..fb24093c9aa6 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -211,12 +211,12 @@ static void cdrom_analyze_sense_data(ide_drive_t *drive,
 static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct request *rq)
 {
 	/*
-	 * For ATA_PRIV_SENSE, "rq->special" points to the original
+	 * For ATA_PRIV_SENSE, "ide_req(rq)->special" points to the original
 	 * failed request.  Also, the sense data should be read
 	 * directly from rq which might be different from the original
 	 * sense buffer if it got copied during mapping.
 	 */
-	struct request *failed = (struct request *)rq->special;
+	struct request *failed = ide_req(rq)->special;
 	void *sense = bio_data(rq->bio);
 
 	if (failed) {
diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index f4f8afdf8bbe..f2f93ed40356 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -171,7 +171,7 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 	scsi_req(rq)->cmd_len = 5;
 	scsi_req(rq)->cmd[0] = REQ_DEVSET_EXEC;
 	*(int *)&scsi_req(rq)->cmd[1] = arg;
-	rq->special = setting->set;
+	ide_req(rq)->special = setting->set;
 
 	blk_execute_rq(q, NULL, rq, 0);
 	ret = scsi_req(rq)->result;
@@ -182,7 +182,7 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 
 ide_startstop_t ide_do_devset(ide_drive_t *drive, struct request *rq)
 {
-	int err, (*setfunc)(ide_drive_t *, int) = rq->special;
+	int err, (*setfunc)(ide_drive_t *, int) = ide_req(rq)->special;
 
 	err = setfunc(drive, *(int *)&scsi_req(rq)->cmd[1]);
 	if (err)
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index f8567c8c9dd1..1333d291cb19 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -434,8 +434,8 @@ static int idedisk_prep_fn(ide_drive_t *drive, struct request *rq)
 	if (req_op(rq) != REQ_OP_FLUSH)
 		return BLKPREP_OK;
 
-	if (rq->special) {
-		cmd = rq->special;
+	if (ide_req(rq)->special) {
+		cmd = ide_req(rq)->special;
 		memset(cmd, 0, sizeof(*cmd));
 	} else {
 		cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
@@ -455,7 +455,7 @@ static int idedisk_prep_fn(ide_drive_t *drive, struct request *rq)
 	rq->cmd_flags &= ~REQ_OP_MASK;
 	rq->cmd_flags |= REQ_OP_DRV_OUT;
 	ide_req(rq)->type = ATA_PRIV_TASKFILE;
-	rq->special = cmd;
+	ide_req(rq)->special = cmd;
 	cmd->rq = rq;
 
 	return BLKPREP_OK;
diff --git a/drivers/ide/ide-eh.c b/drivers/ide/ide-eh.c
index 47d5f3379748..e1323e058454 100644
--- a/drivers/ide/ide-eh.c
+++ b/drivers/ide/ide-eh.c
@@ -125,7 +125,7 @@ ide_startstop_t ide_error(ide_drive_t *drive, const char *msg, u8 stat)
 	/* retry only "normal" I/O: */
 	if (blk_rq_is_passthrough(rq)) {
 		if (ata_taskfile_request(rq)) {
-			struct ide_cmd *cmd = rq->special;
+			struct ide_cmd *cmd = ide_req(rq)->special;
 
 			if (cmd)
 				ide_complete_cmd(drive, cmd, stat, err);
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index a8df300f949c..780d33ccc5d8 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -276,7 +276,7 @@ static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
 		switch (ide_req(rq)->type) {
 		case ATA_PRIV_MISC:
 		case ATA_PRIV_SENSE:
-			pc = (struct ide_atapi_pc *)rq->special;
+			pc = (struct ide_atapi_pc *)ide_req(rq)->special;
 			break;
 		default:
 			BUG();
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 5093c605c91c..11ffcc802929 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -111,7 +111,7 @@ void ide_complete_cmd(ide_drive_t *drive, struct ide_cmd *cmd, u8 stat, u8 err)
 	}
 
 	if (rq && ata_taskfile_request(rq)) {
-		struct ide_cmd *orig_cmd = rq->special;
+		struct ide_cmd *orig_cmd = ide_req(rq)->special;
 
 		if (cmd->tf_flags & IDE_TFLAG_DYN)
 			kfree(orig_cmd);
@@ -261,7 +261,7 @@ EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
 static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
 		struct request *rq)
 {
-	struct ide_cmd *cmd = rq->special;
+	struct ide_cmd *cmd = ide_req(rq)->special;
 
 	if (cmd) {
 		if (cmd->protocol == ATA_PROT_PIO) {
@@ -352,7 +352,7 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 		if (ata_taskfile_request(rq))
 			return execute_drive_cmd(drive, rq);
 		else if (ata_pm_request(rq)) {
-			struct ide_pm_state *pm = rq->special;
+			struct ide_pm_state *pm = ide_req(rq)->special;
 #ifdef DEBUG_PM
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, pm->pm_step);
@@ -460,16 +460,20 @@ blk_status_t ide_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ide_drive_t	*drive = hctx->queue->queuedata;
 	ide_hwif_t	*hwif = drive->hwif;
 	struct ide_host *host = hwif->host;
-	struct request	*rq = NULL;
+	struct request	*rq = bd->rq;
 	ide_startstop_t	startstop;
 
+	if (!(rq->rq_flags & RQF_DONTPREP)) {
+		rq->rq_flags |= RQF_DONTPREP;
+		ide_req(rq)->special = NULL;
+	}
+
 	/* HLD do_request() callback might sleep, make sure it's okay */
 	might_sleep();
 
 	if (ide_lock_host(host, hwif))
 		return BLK_STS_DEV_RESOURCE;
 
-	rq = bd->rq;
 	blk_mq_start_request(rq);
 
 	spin_lock_irq(&hwif->lock);
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index de9e85cf74d1..102aa3bc3e7f 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -36,7 +36,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	scsi_req(rq)->cmd[0] = REQ_PARK_HEADS;
 	scsi_req(rq)->cmd_len = 1;
 	ide_req(rq)->type = ATA_PRIV_MISC;
-	rq->special = &timeout;
+	ide_req(rq)->special = &timeout;
 	blk_execute_rq(q, NULL, rq, 1);
 	rc = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
@@ -67,7 +67,7 @@ ide_startstop_t ide_do_park_unpark(ide_drive_t *drive, struct request *rq)
 
 	memset(&cmd, 0, sizeof(cmd));
 	if (scsi_req(rq)->cmd[0] == REQ_PARK_HEADS) {
-		drive->sleep = *(unsigned long *)rq->special;
+		drive->sleep = *(unsigned long *)ide_req(rq)->special;
 		drive->dev_flags |= IDE_DFLAG_SLEEPING;
 		tf->command = ATA_CMD_IDLEIMMEDIATE;
 		tf->feature = 0x44;
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index ea10507e5190..a8c53c98252d 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -21,7 +21,7 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 	memset(&rqpm, 0, sizeof(rqpm));
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_PM_SUSPEND;
-	rq->special = &rqpm;
+	ide_req(rq)->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_SUSPEND;
 	if (mesg.event == PM_EVENT_PRETHAW)
 		mesg.event = PM_EVENT_FREEZE;
@@ -82,7 +82,7 @@ int generic_ide_resume(struct device *dev)
 	memset(&rqpm, 0, sizeof(rqpm));
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_PREEMPT);
 	ide_req(rq)->type = ATA_PRIV_PM_RESUME;
-	rq->special = &rqpm;
+	ide_req(rq)->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_RESUME;
 	rqpm.pm_state = PM_EVENT_ON;
 
@@ -101,7 +101,7 @@ int generic_ide_resume(struct device *dev)
 
 void ide_complete_power_step(ide_drive_t *drive, struct request *rq)
 {
-	struct ide_pm_state *pm = rq->special;
+	struct ide_pm_state *pm = ide_req(rq)->special;
 
 #ifdef DEBUG_PM
 	printk(KERN_INFO "%s: complete_power_step(step: %d)\n",
@@ -131,7 +131,7 @@ void ide_complete_power_step(ide_drive_t *drive, struct request *rq)
 
 ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
 {
-	struct ide_pm_state *pm = rq->special;
+	struct ide_pm_state *pm = ide_req(rq)->special;
 	struct ide_cmd cmd = { };
 
 	switch (pm->pm_step) {
@@ -203,7 +203,7 @@ ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
 void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
-	struct ide_pm_state *pm = rq->special;
+	struct ide_pm_state *pm = ide_req(rq)->special;
 	unsigned long flags;
 
 	ide_complete_power_step(drive, rq);
@@ -228,7 +228,7 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 
 void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 {
-	struct ide_pm_state *pm = rq->special;
+	struct ide_pm_state *pm = ide_req(rq)->special;
 
 	if (blk_rq_is_private(rq) &&
 	    ide_req(rq)->type == ATA_PRIV_PM_SUSPEND &&
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 34c1165226a4..db1a65f4b490 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -639,7 +639,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 		goto out;
 	}
 	if (req->cmd[13] & REQ_IDETAPE_PC1) {
-		pc = (struct ide_atapi_pc *)rq->special;
+		pc = (struct ide_atapi_pc *)ide_req(rq)->special;
 		req->cmd[13] &= ~(REQ_IDETAPE_PC1);
 		req->cmd[13] |= REQ_IDETAPE_PC2;
 		goto out;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index c21d5c50ae3a..17b2e379e872 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -440,7 +440,7 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 			goto put_req;
 	}
 
-	rq->special = cmd;
+	ide_req(rq)->special = cmd;
 	cmd->rq = rq;
 
 	blk_execute_rq(drive->queue, NULL, rq, 0);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 079f8bc0b0f4..975c662e8707 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -50,6 +50,7 @@ struct ide_request {
 	struct scsi_request sreq;
 	u8 sense[SCSI_SENSE_BUFFERSIZE];
 	u8 type;
+	void *special;
 };
 
 static inline struct ide_request *ide_req(struct request *rq)
-- 
2.19.1
