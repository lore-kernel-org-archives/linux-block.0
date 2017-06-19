Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH v4 04/12] block: Make most scsi_req_init() calls implicit
Date: Mon, 19 Jun 2017 15:07:53 -0700
Message-ID: <20170619220801.12557-5-bart.vanassche@wdc.com>
In-Reply-To: <20170619220801.12557-1-bart.vanassche@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

Instead of explicitly calling scsi_req_init() after blk_get_request(),
call that function from inside blk_get_request(). Add an
.initialize_rq_fn() callback function to the block drivers that need
it. Merge the IDE .init_rq_fn() function into .initialize_rq_fn()
because it is too small to keep it as a separate function. Keep the
scsi_req_init() call in ide_prep_sense() because it follows a
blk_rq_init() call.

References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
---
 block/bsg.c                        |  1 -
 block/scsi_ioctl.c                 |  3 ---
 drivers/block/pktcdvd.c            |  1 -
 drivers/cdrom/cdrom.c              |  1 -
 drivers/ide/ide-atapi.c            |  1 -
 drivers/ide/ide-cd.c               |  1 -
 drivers/ide/ide-cd_ioctl.c         |  1 -
 drivers/ide/ide-devsets.c          |  1 -
 drivers/ide/ide-disk.c             |  1 -
 drivers/ide/ide-ioctls.c           |  2 --
 drivers/ide/ide-park.c             |  2 --
 drivers/ide/ide-pm.c               |  2 --
 drivers/ide/ide-probe.c            |  6 +++---
 drivers/ide/ide-tape.c             |  1 -
 drivers/ide/ide-taskfile.c         |  1 -
 drivers/scsi/osd/osd_initiator.c   |  2 --
 drivers/scsi/osst.c                |  1 -
 drivers/scsi/scsi_error.c          |  1 -
 drivers/scsi/scsi_lib.c            | 10 +++++++++-
 drivers/scsi/scsi_transport_sas.c  |  6 ++++++
 drivers/scsi/sg.c                  |  2 --
 drivers/scsi/st.c                  |  1 -
 drivers/target/target_core_pscsi.c |  2 --
 fs/nfsd/blocklayout.c              |  1 -
 24 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 59d02dd31b0c..37663b664666 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -236,7 +236,6 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm)
 	rq = blk_get_request(q, op, GFP_KERNEL);
 	if (IS_ERR(rq))
 		return rq;
-	scsi_req_init(rq);
 
 	ret = blk_fill_sgv4_hdr_rq(q, rq, hdr, bd, has_write_perm);
 	if (ret)
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 4a294a5f7fab..f96c51f5df40 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -326,7 +326,6 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 	req = scsi_req(rq);
-	scsi_req_init(rq);
 
 	if (hdr->cmd_len > BLK_MAX_CDB) {
 		req->cmd = kzalloc(hdr->cmd_len, GFP_KERNEL);
@@ -456,7 +455,6 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		goto error_free_buffer;
 	}
 	req = scsi_req(rq);
-	scsi_req_init(rq);
 
 	cmdlen = COMMAND_SIZE(opcode);
 
@@ -542,7 +540,6 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	rq = blk_get_request(q, REQ_OP_SCSI_OUT, __GFP_RECLAIM);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
-	scsi_req_init(rq);
 	rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 	scsi_req(rq)->cmd[0] = cmd;
 	scsi_req(rq)->cmd[4] = data;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 26c04baae967..8ef703ccc4b6 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -708,7 +708,6 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 			     REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, __GFP_RECLAIM);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
-	scsi_req_init(rq);
 
 	if (cgc->buflen) {
 		ret = blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen,
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ff19cfc587f0..e36d160c458f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2201,7 +2201,6 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 			break;
 		}
 		req = scsi_req(rq);
-		scsi_req_init(rq);
 
 		ret = blk_rq_map_user(q, rq, NULL, ubuf, len, GFP_KERNEL);
 		if (ret) {
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index d7a49dcfa85e..37f61acf5a35 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -93,7 +93,6 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 	int error;
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	rq->special = (char *)pc;
 
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index d55e44ed82b5..81e18f9628d0 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -438,7 +438,6 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 
 		rq = blk_get_request(drive->queue,
 			write ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,  __GFP_RECLAIM);
-		scsi_req_init(rq);
 		memcpy(scsi_req(rq)->cmd, cmd, BLK_MAX_CDB);
 		ide_req(rq)->type = ATA_PRIV_PC;
 		rq->rq_flags |= rq_flags;
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 55cd736c39c6..9d26c9737e21 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -304,7 +304,6 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	int ret;
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	rq->rq_flags = RQF_QUIET;
 	blk_execute_rq(drive->queue, cd->disk, rq, 0);
diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index 9b69c32ee560..ef7c8c43a380 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -166,7 +166,6 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 		return setting->set(drive, arg);
 
 	rq = blk_get_request(q, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd_len = 5;
 	scsi_req(rq)->cmd[0] = REQ_DEVSET_EXEC;
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 7c06237f3479..241983da5fc4 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -478,7 +478,6 @@ static int set_multcount(ide_drive_t *drive, int arg)
 		return -EBUSY;
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_TASKFILE;
 
 	drive->mult_req = arg;
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 8c0d17297a7a..3661abb16a5f 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -126,7 +126,6 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 		struct request *rq;
 
 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-		scsi_req_init(rq);
 		ide_req(rq)->type = ATA_PRIV_TASKFILE;
 		blk_execute_rq(drive->queue, NULL, rq, 0);
 		err = scsi_req(rq)->result ? -EIO : 0;
@@ -224,7 +223,6 @@ static int generic_drive_reset(ide_drive_t *drive)
 	int ret = 0;
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd_len = 1;
 	scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 94e3107f59b9..1f264d5d3f3f 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -32,7 +32,6 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	spin_unlock_irq(&hwif->lock);
 
 	rq = blk_get_request(q, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	scsi_req(rq)->cmd[0] = REQ_PARK_HEADS;
 	scsi_req(rq)->cmd_len = 1;
 	ide_req(rq)->type = ATA_PRIV_MISC;
@@ -48,7 +47,6 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	 * timeout has expired, so power management will be reenabled.
 	 */
 	rq = blk_get_request(q, REQ_OP_DRV_IN, GFP_NOWAIT);
-	scsi_req_init(rq);
 	if (IS_ERR(rq))
 		goto out;
 
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 08b54bb3b705..544f02d673ca 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -19,7 +19,6 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 
 	memset(&rqpm, 0, sizeof(rqpm));
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_PM_SUSPEND;
 	rq->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_SUSPEND;
@@ -91,7 +90,6 @@ int generic_ide_resume(struct device *dev)
 
 	memset(&rqpm, 0, sizeof(rqpm));
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_PM_RESUME;
 	rq->rq_flags |= RQF_PREEMPT;
 	rq->special = &rqpm;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index b3f85250dea9..c60e5ffc9231 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -741,12 +741,12 @@ static void ide_port_tune_devices(ide_hwif_t *hwif)
 	}
 }
 
-static int ide_init_rq(struct request_queue *q, struct request *rq, gfp_t gfp)
+static void ide_initialize_rq(struct request *rq)
 {
 	struct ide_request *req = blk_mq_rq_to_pdu(rq);
 
+	scsi_req_init(rq);
 	req->sreq.sense = req->sense;
-	return 0;
 }
 
 /*
@@ -771,7 +771,7 @@ static int ide_init_queue(ide_drive_t *drive)
 		return 1;
 
 	q->request_fn = do_ide_request;
-	q->init_rq_fn = ide_init_rq;
+	q->initialize_rq_fn = ide_initialize_rq;
 	q->cmd_size = sizeof(struct ide_request);
 	queue_flag_set_unlocked(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
 	if (blk_init_allocated_queue(q) < 0) {
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 4d062c568777..fd57e8ccc47a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -855,7 +855,6 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 	BUG_ON(size < 0 || size % tape->blk_size);
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd[13] = cmd;
 	rq->rq_disk = tape->disk;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index ab1a32cdcb0a..4efe4c6e956c 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -433,7 +433,6 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 	rq = blk_get_request(drive->queue,
 		(cmd->tf_flags & IDE_TFLAG_WRITE) ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, __GFP_RECLAIM);
-	scsi_req_init(rq);
 	ide_req(rq)->type = ATA_PRIV_TASKFILE;
 
 	/*
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index 1e69a43b279d..ca45bf6d2bdb 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1574,7 +1574,6 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 			flags);
 	if (IS_ERR(req))
 		return req;
-	scsi_req_init(req);
 
 	for_each_bio(bio) {
 		struct bio *bounce_bio = bio;
@@ -1619,7 +1618,6 @@ static int _init_blk_request(struct osd_request *or,
 				ret = PTR_ERR(req);
 				goto out;
 			}
-			scsi_req_init(req);
 			or->in.req = or->request->next_rq = req;
 		}
 	} else if (has_in)
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index d54689c9216e..929ee7e88120 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -373,7 +373,6 @@ static int osst_execute(struct osst_request *SRpnt, const unsigned char *cmd,
 		return DRIVER_ERROR << 24;
 
 	rq = scsi_req(req);
-	scsi_req_init(req);
 	req->rq_flags |= RQF_QUIET;
 
 	SRpnt->bio = NULL;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 44904f41924c..304a7158540f 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1903,7 +1903,6 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	if (IS_ERR(req))
 		return;
 	rq = scsi_req(req);
-	scsi_req_init(req);
 
 	rq->cmd[0] = ALLOW_MEDIUM_REMOVAL;
 	rq->cmd[1] = 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index fb18ed284e55..5e7895d76998 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -250,7 +250,6 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
-	scsi_req_init(req);
 
 	if (bufflen &&	blk_rq_map_kern(sdev->request_queue, req,
 					buffer, bufflen, __GFP_RECLAIM))
@@ -1117,6 +1116,13 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 }
 EXPORT_SYMBOL(scsi_init_io);
 
+/* Called from inside blk_get_request() */
+static void scsi_initialize_rq(struct request *rq)
+{
+	scsi_req_init(rq);
+}
+
+/* Called after a request has been started. */
 void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
 	void *buf = cmd->sense_buffer;
@@ -2124,6 +2130,7 @@ struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 	q->request_fn = scsi_request_fn;
 	q->init_rq_fn = scsi_init_rq;
 	q->exit_rq_fn = scsi_exit_rq;
+	q->initialize_rq_fn = scsi_initialize_rq;
 
 	if (blk_init_allocated_queue(q) < 0) {
 		blk_cleanup_queue(q);
@@ -2148,6 +2155,7 @@ static const struct blk_mq_ops scsi_mq_ops = {
 #endif
 	.init_request	= scsi_init_request,
 	.exit_request	= scsi_exit_request,
+	.initialize_rq_fn = scsi_initialize_rq,
 	.map_queues	= scsi_map_queues,
 };
 
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index cc970c811bcb..ae55be2b2385 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -213,6 +213,11 @@ static void sas_host_release(struct device *dev)
 		blk_cleanup_queue(q);
 }
 
+static void sas_initialize_rq(struct request *rq)
+{
+	scsi_req_init(rq);
+}
+
 static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 {
 	struct request_queue *q;
@@ -230,6 +235,7 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 	q = blk_alloc_queue(GFP_KERNEL);
 	if (!q)
 		return -ENOMEM;
+	q->initialize_rq_fn = sas_initialize_rq;
 	q->cmd_size = sizeof(struct scsi_request);
 
 	if (rphy) {
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index f3387c6089c5..21225d62b0c1 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1732,8 +1732,6 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	}
 	req = scsi_req(rq);
 
-	scsi_req_init(rq);
-
 	if (hp->cmd_len > BLK_MAX_CDB)
 		req->cmd = long_cmdp;
 	memcpy(req->cmd, cmd, hp->cmd_len);
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 6b1c4ac54e66..8e5013d9cad4 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -549,7 +549,6 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return DRIVER_ERROR << 24;
 	rq = scsi_req(req);
-	scsi_req_init(req);
 	req->rq_flags |= RQF_QUIET;
 
 	mdata->null_mapped = 1;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 323ab47645d0..ceec0211e84e 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -992,8 +992,6 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 		goto fail;
 	}
 
-	scsi_req_init(req);
-
 	if (sgl) {
 		ret = pscsi_map_sg(cmd, sgl, sgl_nents, req);
 		if (ret)
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 47ed19c53f2e..c862c2489df0 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -232,7 +232,6 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 		goto out_free_buf;
 	}
 	req = scsi_req(rq);
-	scsi_req_init(rq);
 
 	error = blk_rq_map_kern(q, rq, buf, bufflen, GFP_KERNEL);
 	if (error)
-- 
2.13.1
