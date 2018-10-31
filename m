Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/30] scsi: kill off the legacy IO path
Date: Wed, 31 Oct 2018 11:59:01 -0600
Message-Id: <20181031175922.8849-10-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Cc: linux-scsi@vger.kernel.org
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/scsi/scsi-parameters.txt |   5 -
 drivers/scsi/Kconfig                   |  12 -
 drivers/scsi/cxlflash/main.c           |   6 -
 drivers/scsi/hosts.c                   |  29 +-
 drivers/scsi/lpfc/lpfc_scsi.c          |   2 +-
 drivers/scsi/qedi/qedi_main.c          |   3 +-
 drivers/scsi/qla2xxx/qla_os.c          |  30 +-
 drivers/scsi/scsi.c                    |   5 +-
 drivers/scsi/scsi_debug.c              |   3 +-
 drivers/scsi/scsi_error.c              |   2 +-
 drivers/scsi/scsi_lib.c                | 603 ++-----------------------
 drivers/scsi/scsi_priv.h               |   1 -
 drivers/scsi/scsi_scan.c               |  10 +-
 drivers/scsi/scsi_sysfs.c              |   8 +-
 drivers/scsi/ufs/ufshcd.c              |   6 -
 include/scsi/scsi_host.h               |  18 +-
 include/scsi/scsi_tcq.h                |  14 +-
 17 files changed, 77 insertions(+), 680 deletions(-)

diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/scsi-parameters.txt
index 92999d4e0cb8..25a4b4cf04a6 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.txt
@@ -97,11 +97,6 @@ parameters may be changed at runtime by the command
 			allowing boot to proceed.  none ignores them, expecting
 			user space to do the scan.
 
-	scsi_mod.use_blk_mq=
-			[SCSI] use blk-mq I/O path by default
-			See SCSI_MQ_DEFAULT in drivers/scsi/Kconfig.
-			Format: <y/n>
-
 	sim710=		[SCSI,HW]
 			See header of drivers/scsi/sim710.c.
 
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 70988c381268..ff5a569fdbcb 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -50,18 +50,6 @@ config SCSI_NETLINK
 	default	n
 	depends on NET
 
-config SCSI_MQ_DEFAULT
-	bool "SCSI: use blk-mq I/O path by default"
-	default y
-	depends on SCSI
-	---help---
-	  This option enables the blk-mq based I/O path for SCSI devices by
-	  default.  With this option the scsi_mod.use_blk_mq module/boot
-	  option defaults to Y, without it to N, but it can still be
-	  overridden either way.
-
-	  If unsure say Y.
-
 config SCSI_PROC_FS
 	bool "legacy /proc/scsi/ support"
 	depends on SCSI && PROC_FS
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 6637116529aa..abdc9eac4173 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3088,12 +3088,6 @@ static ssize_t hwq_mode_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	if ((mode == HWQ_MODE_TAG) && !shost_use_blk_mq(shost)) {
-		dev_info(cfgdev, "SCSI-MQ is not enabled, use a different "
-			 "HWQ steering mode.\n");
-		return -EINVAL;
-	}
-
 	afu->hwq_mode = mode;
 
 	return count;
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ea4b0bb0c1cd..cc71136ba300 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -222,18 +222,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	if (error)
 		goto fail;
 
-	if (shost_use_blk_mq(shost)) {
-		error = scsi_mq_setup_tags(shost);
-		if (error)
-			goto fail;
-	} else {
-		shost->bqt = blk_init_tags(shost->can_queue,
-				shost->hostt->tag_alloc_policy);
-		if (!shost->bqt) {
-			error = -ENOMEM;
-			goto fail;
-		}
-	}
+	error = scsi_mq_setup_tags(shost);
+	if (error)
+		goto fail;
 
 	if (!shost->shost_gendev.parent)
 		shost->shost_gendev.parent = dev ? dev : &platform_bus;
@@ -309,8 +300,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_disable(&shost->shost_gendev);
 	pm_runtime_set_suspended(&shost->shost_gendev);
 	pm_runtime_put_noidle(&shost->shost_gendev);
-	if (shost_use_blk_mq(shost))
-		scsi_mq_destroy_tags(shost);
+	scsi_mq_destroy_tags(shost);
  fail:
 	return error;
 }
@@ -344,13 +334,8 @@ static void scsi_host_dev_release(struct device *dev)
 		kfree(dev_name(&shost->shost_dev));
 	}
 
-	if (shost_use_blk_mq(shost)) {
-		if (shost->tag_set.tags)
-			scsi_mq_destroy_tags(shost);
-	} else {
-		if (shost->bqt)
-			blk_free_tags(shost->bqt);
-	}
+	if (shost->tag_set.tags)
+		scsi_mq_destroy_tags(shost);
 
 	kfree(shost->shost_data);
 
@@ -472,8 +457,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	else
 		shost->dma_boundary = 0xffffffff;
 
-	shost->use_blk_mq = scsi_use_blk_mq || shost->hostt->force_blk_mq;
-
 	device_initialize(&shost->shost_gendev);
 	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
 	shost->shost_gendev.bus = &scsi_bus_type;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4fa6703a9ec9..baed2b891efb 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3914,7 +3914,7 @@ int lpfc_sli4_scmd_to_wqidx_distr(struct lpfc_hba *phba,
 	uint32_t tag;
 	uint16_t hwq;
 
-	if (cmnd && shost_use_blk_mq(cmnd->device->host)) {
+	if (cmnd) {
 		tag = blk_mq_unique_tag(cmnd->request);
 		hwq = blk_mq_unique_tag_to_hwq(tag);
 
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 105b0e4d7818..311eb22068e1 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -644,8 +644,7 @@ static struct qedi_ctx *qedi_host_alloc(struct pci_dev *pdev)
 	qedi->max_active_conns = ISCSI_MAX_SESS_PER_HBA;
 	qedi->max_sqes = QEDI_SQ_SIZE;
 
-	if (shost_use_blk_mq(shost))
-		shost->nr_hw_queues = MIN_NUM_CPUS_MSIX(qedi);
+	shost->nr_hw_queues = MIN_NUM_CPUS_MSIX(qedi);
 
 	pci_set_drvdata(pdev, qedi);
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 8794e54f43a9..3e2665c66bc4 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -857,13 +857,9 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	}
 
 	if (ha->mqenable) {
-		if (shost_use_blk_mq(vha->host)) {
-			tag = blk_mq_unique_tag(cmd->request);
-			hwq = blk_mq_unique_tag_to_hwq(tag);
-			qpair = ha->queue_pair_map[hwq];
-		} else if (vha->vp_idx && vha->qpair) {
-			qpair = vha->qpair;
-		}
+		tag = blk_mq_unique_tag(cmd->request);
+		hwq = blk_mq_unique_tag_to_hwq(tag);
+		qpair = ha->queue_pair_map[hwq];
 
 		if (qpair)
 			return qla2xxx_mqueuecommand(host, cmd, qpair);
@@ -3153,7 +3149,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto probe_failed;
 	}
 
-	if (ha->mqenable && shost_use_blk_mq(host)) {
+	if (ha->mqenable) {
 		/* number of hardware queues supported by blk/scsi-mq*/
 		host->nr_hw_queues = ha->max_qpairs;
 
@@ -3265,25 +3261,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	    base_vha->mgmt_svr_loop_id, host->sg_tablesize);
 
 	if (ha->mqenable) {
-		bool mq = false;
 		bool startit = false;
 
-		if (QLA_TGT_MODE_ENABLED()) {
-			mq = true;
+		if (QLA_TGT_MODE_ENABLED())
 			startit = false;
-		}
 
-		if ((ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED) &&
-		    shost_use_blk_mq(host)) {
-			mq = true;
+		if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
 			startit = true;
-		}
 
-		if (mq) {
-			/* Create start of day qpairs for Block MQ */
-			for (i = 0; i < ha->max_qpairs; i++)
-				qla2xxx_create_qpair(base_vha, 5, 0, startit);
-		}
+		/* Create start of day qpairs for Block MQ */
+		for (i = 0; i < ha->max_qpairs; i++)
+			qla2xxx_create_qpair(base_vha, 5, 0, startit);
 	}
 
 	if (ha->flags.running_gold_fw)
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index fc1356d101b0..99db3f4316b5 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -780,11 +780,8 @@ MODULE_LICENSE("GPL");
 module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
 
-#ifdef CONFIG_SCSI_MQ_DEFAULT
+/* Kill module parameter */
 bool scsi_use_blk_mq = true;
-#else
-bool scsi_use_blk_mq = false;
-#endif
 module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | S_IRUGO);
 
 static int __init init_scsi(void)
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 60bcc6df97a9..4740f1e9dd17 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5881,8 +5881,7 @@ static int sdebug_driver_probe(struct device *dev)
 	}
 	/* Decide whether to tell scsi subsystem that we want mq */
 	/* Following should give the same answer for each host */
-	if (shost_use_blk_mq(hpnt))
-		hpnt->nr_hw_queues = submit_queues;
+	hpnt->nr_hw_queues = submit_queues;
 
 	sdbg_host->shost = hpnt;
 	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c736d61b1648..fff128aa9ec2 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -308,7 +308,7 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		 * error handler. In that case we can return immediately as no
 		 * further action is required.
 		 */
-		if (req->q->mq_ops && !blk_mq_mark_complete(req))
+		if (!blk_mq_mark_complete(req))
 			return rtn;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b0345924a92..651be30ba96a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -168,8 +168,6 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 {
 	struct scsi_device *device = cmd->device;
-	struct request_queue *q = device->request_queue;
-	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1, scmd_printk(KERN_INFO, cmd,
 		"Inserting command %p into mlqueue\n", cmd));
@@ -190,26 +188,20 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 * before blk_cleanup_queue() finishes.
 	 */
 	cmd->result = 0;
-	if (q->mq_ops) {
-		/*
-		 * Before a SCSI command is dispatched,
-		 * get_device(&sdev->sdev_gendev) is called and the host,
-		 * target and device busy counters are increased. Since
-		 * requeuing a request causes these actions to be repeated and
-		 * since scsi_device_unbusy() has already been called,
-		 * put_device(&device->sdev_gendev) must still be called. Call
-		 * put_device() after blk_mq_requeue_request() to avoid that
-		 * removal of the SCSI device can start before requeueing has
-		 * happened.
-		 */
-		blk_mq_requeue_request(cmd->request, true);
-		put_device(&device->sdev_gendev);
-		return;
-	}
-	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, cmd->request);
-	kblockd_schedule_work(&device->requeue_work);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	/*
+	 * Before a SCSI command is dispatched,
+	 * get_device(&sdev->sdev_gendev) is called and the host,
+	 * target and device busy counters are increased. Since
+	 * requeuing a request causes these actions to be repeated and
+	 * since scsi_device_unbusy() has already been called,
+	 * put_device(&device->sdev_gendev) must still be called. Call
+	 * put_device() after blk_mq_requeue_request() to avoid that
+	 * removal of the SCSI device can start before requeueing has
+	 * happened.
+	 */
+	blk_mq_requeue_request(cmd->request, true);
+	put_device(&device->sdev_gendev);
 }
 
 /*
@@ -370,10 +362,7 @@ void scsi_device_unbusy(struct scsi_device *sdev)
 
 static void scsi_kick_queue(struct request_queue *q)
 {
-	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, false);
-	else
-		blk_run_queue(q);
+	blk_mq_run_hw_queues(q, false);
 }
 
 /*
@@ -534,10 +523,7 @@ static void scsi_run_queue(struct request_queue *q)
 	if (!list_empty(&sdev->host->starved_list))
 		scsi_starved_list_run(sdev->host);
 
-	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, false);
-	else
-		blk_run_queue(q);
+	blk_mq_run_hw_queues(q, false);
 }
 
 void scsi_requeue_run_queue(struct work_struct *work)
@@ -550,42 +536,6 @@ void scsi_requeue_run_queue(struct work_struct *work)
 	scsi_run_queue(q);
 }
 
-/*
- * Function:	scsi_requeue_command()
- *
- * Purpose:	Handle post-processing of completed commands.
- *
- * Arguments:	q	- queue to operate on
- *		cmd	- command that may need to be requeued.
- *
- * Returns:	Nothing
- *
- * Notes:	After command completion, there may be blocks left
- *		over which weren't finished by the previous command
- *		this can be for a number of reasons - the main one is
- *		I/O errors in the middle of the request, in which case
- *		we need to request the blocks that come after the bad
- *		sector.
- * Notes:	Upon return, cmd is a stale pointer.
- */
-static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct request *req = cmd->request;
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	blk_unprep_request(req);
-	req->special = NULL;
-	scsi_put_command(cmd);
-	blk_requeue_request(q, req);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
-	scsi_run_queue(q);
-
-	put_device(&sdev->sdev_gendev);
-}
-
 void scsi_run_host_queues(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
@@ -626,42 +576,6 @@ static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 	scsi_del_cmd_from_list(cmd);
 }
 
-/*
- * Function:    scsi_release_buffers()
- *
- * Purpose:     Free resources allocate for a scsi_command.
- *
- * Arguments:   cmd	- command that we are bailing.
- *
- * Lock status: Assumed that no lock is held upon entry.
- *
- * Returns:     Nothing
- *
- * Notes:       In the event that an upper level driver rejects a
- *		command, we must release resources allocated during
- *		the __init_io() function.  Primarily this would involve
- *		the scatter-gather table.
- */
-static void scsi_release_buffers(struct scsi_cmnd *cmd)
-{
-	if (cmd->sdb.table.nents)
-		sg_free_table_chained(&cmd->sdb.table, false);
-
-	memset(&cmd->sdb, 0, sizeof(cmd->sdb));
-
-	if (scsi_prot_sg_count(cmd))
-		sg_free_table_chained(&cmd->prot_sdb->table, false);
-}
-
-static void scsi_release_bidi_buffers(struct scsi_cmnd *cmd)
-{
-	struct scsi_data_buffer *bidi_sdb = cmd->request->next_rq->special;
-
-	sg_free_table_chained(&bidi_sdb->table, false);
-	kmem_cache_free(scsi_sdb_cache, bidi_sdb);
-	cmd->request->next_rq->special = NULL;
-}
-
 /* Returns false when no more bytes to process, true if there are more */
 static bool scsi_end_request(struct request *req, blk_status_t error,
 		unsigned int bytes, unsigned int bidi_bytes)
@@ -687,37 +601,22 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		destroy_rcu_head(&cmd->rcu);
 	}
 
-	if (req->mq_ctx) {
-		/*
-		 * In the MQ case the command gets freed by __blk_mq_end_request,
-		 * so we have to do all cleanup that depends on it earlier.
-		 *
-		 * We also can't kick the queues from irq context, so we
-		 * will have to defer it to a workqueue.
-		 */
-		scsi_mq_uninit_cmd(cmd);
-
-		__blk_mq_end_request(req, error);
-
-		if (scsi_target(sdev)->single_lun ||
-		    !list_empty(&sdev->host->starved_list))
-			kblockd_schedule_work(&sdev->requeue_work);
-		else
-			blk_mq_run_hw_queues(q, true);
-	} else {
-		unsigned long flags;
-
-		if (bidi_bytes)
-			scsi_release_bidi_buffers(cmd);
-		scsi_release_buffers(cmd);
-		scsi_put_command(cmd);
+	/*
+	 * In the MQ case the command gets freed by __blk_mq_end_request,
+	 * so we have to do all cleanup that depends on it earlier.
+	 *
+	 * We also can't kick the queues from irq context, so we
+	 * will have to defer it to a workqueue.
+	 */
+	scsi_mq_uninit_cmd(cmd);
 
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_finish_request(req, error);
-		spin_unlock_irqrestore(q->queue_lock, flags);
+	__blk_mq_end_request(req, error);
 
-		scsi_run_queue(q);
-	}
+	if (scsi_target(sdev)->single_lun ||
+	    !list_empty(&sdev->host->starved_list))
+		kblockd_schedule_work(&sdev->requeue_work);
+	else
+		blk_mq_run_hw_queues(q, true);
 
 	put_device(&sdev->sdev_gendev);
 	return false;
@@ -766,13 +665,7 @@ static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 				      struct request_queue *q)
 {
 	/* A new command will be prepared and issued. */
-	if (q->mq_ops) {
-		scsi_mq_requeue_cmd(cmd);
-	} else {
-		/* Unprep request and put it back at head of the queue. */
-		scsi_release_buffers(cmd);
-		scsi_requeue_command(q, cmd);
-	}
+	scsi_mq_requeue_cmd(cmd);
 }
 
 /* Helper for scsi_io_completion() when special action required. */
@@ -1147,9 +1040,7 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
  */
 int scsi_init_io(struct scsi_cmnd *cmd)
 {
-	struct scsi_device *sdev = cmd->device;
 	struct request *rq = cmd->request;
-	bool is_mq = (rq->mq_ctx != NULL);
 	int error = BLKPREP_KILL;
 
 	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
@@ -1160,17 +1051,6 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 		goto err_exit;
 
 	if (blk_bidi_rq(rq)) {
-		if (!rq->q->mq_ops) {
-			struct scsi_data_buffer *bidi_sdb =
-				kmem_cache_zalloc(scsi_sdb_cache, GFP_ATOMIC);
-			if (!bidi_sdb) {
-				error = BLKPREP_DEFER;
-				goto err_exit;
-			}
-
-			rq->next_rq->special = bidi_sdb;
-		}
-
 		error = scsi_init_sgtable(rq->next_rq, rq->next_rq->special);
 		if (error)
 			goto err_exit;
@@ -1210,14 +1090,7 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 
 	return BLKPREP_OK;
 err_exit:
-	if (is_mq) {
-		scsi_mq_free_sgtables(cmd);
-	} else {
-		scsi_release_buffers(cmd);
-		cmd->request->special = NULL;
-		scsi_put_command(cmd);
-		put_device(&sdev->sdev_gendev);
-	}
+	scsi_mq_free_sgtables(cmd);
 	return error;
 }
 EXPORT_SYMBOL(scsi_init_io);
@@ -1423,75 +1296,6 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 	return ret;
 }
 
-static int
-scsi_prep_return(struct request_queue *q, struct request *req, int ret)
-{
-	struct scsi_device *sdev = q->queuedata;
-
-	switch (ret) {
-	case BLKPREP_KILL:
-	case BLKPREP_INVALID:
-		scsi_req(req)->result = DID_NO_CONNECT << 16;
-		/* release the command and kill it */
-		if (req->special) {
-			struct scsi_cmnd *cmd = req->special;
-			scsi_release_buffers(cmd);
-			scsi_put_command(cmd);
-			put_device(&sdev->sdev_gendev);
-			req->special = NULL;
-		}
-		break;
-	case BLKPREP_DEFER:
-		/*
-		 * If we defer, the blk_peek_request() returns NULL, but the
-		 * queue must be restarted, so we schedule a callback to happen
-		 * shortly.
-		 */
-		if (atomic_read(&sdev->device_busy) == 0)
-			blk_delay_queue(q, SCSI_QUEUE_DELAY);
-		break;
-	default:
-		req->rq_flags |= RQF_DONTPREP;
-	}
-
-	return ret;
-}
-
-static int scsi_prep_fn(struct request_queue *q, struct request *req)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
-	int ret;
-
-	ret = scsi_prep_state_check(sdev, req);
-	if (ret != BLKPREP_OK)
-		goto out;
-
-	if (!req->special) {
-		/* Bail if we can't get a reference to the device */
-		if (unlikely(!get_device(&sdev->sdev_gendev))) {
-			ret = BLKPREP_DEFER;
-			goto out;
-		}
-
-		scsi_init_command(sdev, cmd);
-		req->special = cmd;
-	}
-
-	cmd->tag = req->tag;
-	cmd->request = req;
-	cmd->prot_op = SCSI_PROT_NORMAL;
-
-	ret = scsi_setup_cmnd(sdev, req);
-out:
-	return scsi_prep_return(q, req, ret);
-}
-
-static void scsi_unprep_fn(struct request_queue *q, struct request *req)
-{
-	scsi_uninit_cmd(blk_mq_rq_to_pdu(req));
-}
-
 /*
  * scsi_dev_queue_ready: if we can send requests to sdev, return 1 else
  * return 0.
@@ -1511,14 +1315,8 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 		/*
 		 * unblock after device_blocked iterates to zero
 		 */
-		if (atomic_dec_return(&sdev->device_blocked) > 0) {
-			/*
-			 * For the MQ case we take care of this in the caller.
-			 */
-			if (!q->mq_ops)
-				blk_delay_queue(q, SCSI_QUEUE_DELAY);
+		if (atomic_dec_return(&sdev->device_blocked) > 0)
 			goto out_dec;
-		}
 		SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
 				   "unblocking device at zero depth\n"));
 	}
@@ -1653,13 +1451,13 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
  * needs to return 'not busy'. Otherwise, request stacking drivers
  * may hold requests forever.
  */
-static int scsi_lld_busy(struct request_queue *q)
+static bool scsi_mq_lld_busy(struct request_queue *q)
 {
 	struct scsi_device *sdev = q->queuedata;
 	struct Scsi_Host *shost;
 
 	if (blk_queue_dying(q))
-		return 0;
+		return false;
 
 	shost = sdev->host;
 
@@ -1670,48 +1468,9 @@ static int scsi_lld_busy(struct request_queue *q)
 	 * in SCSI layer.
 	 */
 	if (scsi_host_in_recovery(shost) || scsi_device_is_busy(sdev))
-		return 1;
-
-	return 0;
-}
-
-static bool scsi_mq_lld_busy(struct request_queue *q)
-{
-	return scsi_lld_busy(q);
-}
-
-/*
- * Kill a request for a dead device
- */
-static void scsi_kill_request(struct request *req, struct request_queue *q)
-{
-	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
-	struct scsi_device *sdev;
-	struct scsi_target *starget;
-	struct Scsi_Host *shost;
-
-	blk_start_request(req);
-
-	scmd_printk(KERN_INFO, cmd, "killing request\n");
-
-	sdev = cmd->device;
-	starget = scsi_target(sdev);
-	shost = sdev->host;
-	scsi_init_cmd_errh(cmd);
-	cmd->result = DID_NO_CONNECT << 16;
-	atomic_inc(&cmd->device->iorequest_cnt);
-
-	/*
-	 * SCSI request completion path will do scsi_device_unbusy(),
-	 * bump busy counts.  To bump the counters, we need to dance
-	 * with the locks as normal issue path does.
-	 */
-	atomic_inc(&sdev->device_busy);
-	atomic_inc(&shost->host_busy);
-	if (starget->can_queue > 0)
-		atomic_inc(&starget->target_busy);
+		return true;
 
-	blk_complete_request(req);
+	return false;
 }
 
 static void scsi_softirq_done(struct request *rq)
@@ -1834,158 +1593,6 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	return 0;
 }
 
-/**
- * scsi_done - Invoke completion on finished SCSI command.
- * @cmd: The SCSI Command for which a low-level device driver (LLDD) gives
- * ownership back to SCSI Core -- i.e. the LLDD has finished with it.
- *
- * Description: This function is the mid-level's (SCSI Core) interrupt routine,
- * which regains ownership of the SCSI command (de facto) from a LLDD, and
- * calls blk_complete_request() for further processing.
- *
- * This function is interrupt context safe.
- */
-static void scsi_done(struct scsi_cmnd *cmd)
-{
-	trace_scsi_dispatch_cmd_done(cmd);
-	blk_complete_request(cmd->request);
-}
-
-/*
- * Function:    scsi_request_fn()
- *
- * Purpose:     Main strategy routine for SCSI.
- *
- * Arguments:   q       - Pointer to actual queue.
- *
- * Returns:     Nothing
- *
- * Lock status: request queue lock assumed to be held when called.
- *
- * Note: See sd_zbc.c sd_zbc_write_lock_zone() for write order
- * protection for ZBC disks.
- */
-static void scsi_request_fn(struct request_queue *q)
-	__releases(q->queue_lock)
-	__acquires(q->queue_lock)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct Scsi_Host *shost;
-	struct scsi_cmnd *cmd;
-	struct request *req;
-
-	/*
-	 * To start with, we keep looping until the queue is empty, or until
-	 * the host is no longer able to accept any more requests.
-	 */
-	shost = sdev->host;
-	for (;;) {
-		int rtn;
-		/*
-		 * get next queueable request.  We do this early to make sure
-		 * that the request is fully prepared even if we cannot
-		 * accept it.
-		 */
-		req = blk_peek_request(q);
-		if (!req)
-			break;
-
-		if (unlikely(!scsi_device_online(sdev))) {
-			sdev_printk(KERN_ERR, sdev,
-				    "rejecting I/O to offline device\n");
-			scsi_kill_request(req, q);
-			continue;
-		}
-
-		if (!scsi_dev_queue_ready(q, sdev))
-			break;
-
-		/*
-		 * Remove the request from the request list.
-		 */
-		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
-			blk_start_request(req);
-
-		spin_unlock_irq(q->queue_lock);
-		cmd = blk_mq_rq_to_pdu(req);
-		if (cmd != req->special) {
-			printk(KERN_CRIT "impossible request in %s.\n"
-					 "please mail a stack trace to "
-					 "linux-scsi@vger.kernel.org\n",
-					 __func__);
-			blk_dump_rq_flags(req, "foo");
-			BUG();
-		}
-
-		/*
-		 * We hit this when the driver is using a host wide
-		 * tag map. For device level tag maps the queue_depth check
-		 * in the device ready fn would prevent us from trying
-		 * to allocate a tag. Since the map is a shared host resource
-		 * we add the dev to the starved list so it eventually gets
-		 * a run when a tag is freed.
-		 */
-		if (blk_queue_tagged(q) && !(req->rq_flags & RQF_QUEUED)) {
-			spin_lock_irq(shost->host_lock);
-			if (list_empty(&sdev->starved_entry))
-				list_add_tail(&sdev->starved_entry,
-					      &shost->starved_list);
-			spin_unlock_irq(shost->host_lock);
-			goto not_ready;
-		}
-
-		if (!scsi_target_queue_ready(shost, sdev))
-			goto not_ready;
-
-		if (!scsi_host_queue_ready(q, shost, sdev))
-			goto host_not_ready;
-	
-		if (sdev->simple_tags)
-			cmd->flags |= SCMD_TAGGED;
-		else
-			cmd->flags &= ~SCMD_TAGGED;
-
-		/*
-		 * Finally, initialize any error handling parameters, and set up
-		 * the timers for timeouts.
-		 */
-		scsi_init_cmd_errh(cmd);
-
-		/*
-		 * Dispatch the command to the low-level driver.
-		 */
-		cmd->scsi_done = scsi_done;
-		rtn = scsi_dispatch_cmd(cmd);
-		if (rtn) {
-			scsi_queue_insert(cmd, rtn);
-			spin_lock_irq(q->queue_lock);
-			goto out_delay;
-		}
-		spin_lock_irq(q->queue_lock);
-	}
-
-	return;
-
- host_not_ready:
-	if (scsi_target(sdev)->can_queue > 0)
-		atomic_dec(&scsi_target(sdev)->target_busy);
- not_ready:
-	/*
-	 * lock q, handle tag, requeue req, and decrement device_busy. We
-	 * must return with queue_lock held.
-	 *
-	 * Decrementing device_busy without checking it is OK, as all such
-	 * cases (host limits or settings) should run the queue at some
-	 * later time.
-	 */
-	spin_lock_irq(q->queue_lock);
-	blk_requeue_request(q, req);
-	atomic_dec(&sdev->device_busy);
-out_delay:
-	if (!atomic_read(&sdev->device_busy) && !scsi_device_blocked(sdev))
-		blk_delay_queue(q, SCSI_QUEUE_DELAY);
-}
-
 static inline blk_status_t prep_to_mq(int ret)
 {
 	switch (ret) {
@@ -2248,77 +1855,6 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(__scsi_init_queue);
 
-static int scsi_old_init_rq(struct request_queue *q, struct request *rq,
-			    gfp_t gfp)
-{
-	struct Scsi_Host *shost = q->rq_alloc_data;
-	const bool unchecked_isa_dma = shost->unchecked_isa_dma;
-	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
-
-	memset(cmd, 0, sizeof(*cmd));
-
-	if (unchecked_isa_dma)
-		cmd->flags |= SCMD_UNCHECKED_ISA_DMA;
-	cmd->sense_buffer = scsi_alloc_sense_buffer(unchecked_isa_dma, gfp,
-						    NUMA_NO_NODE);
-	if (!cmd->sense_buffer)
-		goto fail;
-	cmd->req.sense = cmd->sense_buffer;
-
-	if (scsi_host_get_prot(shost) >= SHOST_DIX_TYPE0_PROTECTION) {
-		cmd->prot_sdb = kmem_cache_zalloc(scsi_sdb_cache, gfp);
-		if (!cmd->prot_sdb)
-			goto fail_free_sense;
-	}
-
-	return 0;
-
-fail_free_sense:
-	scsi_free_sense_buffer(unchecked_isa_dma, cmd->sense_buffer);
-fail:
-	return -ENOMEM;
-}
-
-static void scsi_old_exit_rq(struct request_queue *q, struct request *rq)
-{
-	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
-
-	if (cmd->prot_sdb)
-		kmem_cache_free(scsi_sdb_cache, cmd->prot_sdb);
-	scsi_free_sense_buffer(cmd->flags & SCMD_UNCHECKED_ISA_DMA,
-			       cmd->sense_buffer);
-}
-
-struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
-{
-	struct Scsi_Host *shost = sdev->host;
-	struct request_queue *q;
-
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
-	if (!q)
-		return NULL;
-	q->cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size;
-	q->rq_alloc_data = shost;
-	q->request_fn = scsi_request_fn;
-	q->init_rq_fn = scsi_old_init_rq;
-	q->exit_rq_fn = scsi_old_exit_rq;
-	q->initialize_rq_fn = scsi_initialize_rq;
-
-	if (blk_init_allocated_queue(q) < 0) {
-		blk_cleanup_queue(q);
-		return NULL;
-	}
-
-	__scsi_init_queue(shost, q);
-	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
-	blk_queue_prep_rq(q, scsi_prep_fn);
-	blk_queue_unprep_rq(q, scsi_unprep_fn);
-	blk_queue_softirq_done(q, scsi_softirq_done);
-	blk_queue_rq_timed_out(q, scsi_times_out);
-	blk_queue_lld_busy(q, scsi_lld_busy);
-	return q;
-}
-
 static const struct blk_mq_ops scsi_mq_ops = {
 	.get_budget	= scsi_mq_get_budget,
 	.put_budget	= scsi_mq_put_budget,
@@ -2386,10 +1922,7 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 {
 	struct scsi_device *sdev = NULL;
 
-	if (q->mq_ops) {
-		if (q->mq_ops == &scsi_mq_ops)
-			sdev = q->queuedata;
-	} else if (q->request_fn == scsi_request_fn)
+	if (q->mq_ops == &scsi_mq_ops)
 		sdev = q->queuedata;
 	if (!sdev || !get_device(&sdev->sdev_gendev))
 		sdev = NULL;
@@ -2992,39 +2525,6 @@ void sdev_evt_send_simple(struct scsi_device *sdev,
 }
 EXPORT_SYMBOL_GPL(sdev_evt_send_simple);
 
-/**
- * scsi_request_fn_active() - number of kernel threads inside scsi_request_fn()
- * @sdev: SCSI device to count the number of scsi_request_fn() callers for.
- */
-static int scsi_request_fn_active(struct scsi_device *sdev)
-{
-	struct request_queue *q = sdev->request_queue;
-	int request_fn_active;
-
-	WARN_ON_ONCE(sdev->host->use_blk_mq);
-
-	spin_lock_irq(q->queue_lock);
-	request_fn_active = q->request_fn_active;
-	spin_unlock_irq(q->queue_lock);
-
-	return request_fn_active;
-}
-
-/**
- * scsi_wait_for_queuecommand() - wait for ongoing queuecommand() calls
- * @sdev: SCSI device pointer.
- *
- * Wait until the ongoing shost->hostt->queuecommand() calls that are
- * invoked from scsi_request_fn() have finished.
- */
-static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
-{
-	WARN_ON_ONCE(sdev->host->use_blk_mq);
-
-	while (scsi_request_fn_active(sdev))
-		msleep(20);
-}
-
 /**
  *	scsi_device_quiesce - Block user issued commands.
  *	@sdev:	scsi device to quiesce.
@@ -3148,7 +2648,6 @@ EXPORT_SYMBOL(scsi_target_resume);
 int scsi_internal_device_block_nowait(struct scsi_device *sdev)
 {
 	struct request_queue *q = sdev->request_queue;
-	unsigned long flags;
 	int err = 0;
 
 	err = scsi_device_set_state(sdev, SDEV_BLOCK);
@@ -3164,14 +2663,7 @@ int scsi_internal_device_block_nowait(struct scsi_device *sdev)
 	 * block layer from calling the midlayer with this device's
 	 * request queue. 
 	 */
-	if (q->mq_ops) {
-		blk_mq_quiesce_queue_nowait(q);
-	} else {
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
-
+	blk_mq_quiesce_queue_nowait(q);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
@@ -3202,12 +2694,8 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_internal_device_block_nowait(sdev);
-	if (err == 0) {
-		if (q->mq_ops)
-			blk_mq_quiesce_queue(q);
-		else
-			scsi_wait_for_queuecommand(sdev);
-	}
+	if (err == 0)
+		blk_mq_quiesce_queue(q);
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
@@ -3216,15 +2704,8 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
 void scsi_start_queue(struct scsi_device *sdev)
 {
 	struct request_queue *q = sdev->request_queue;
-	unsigned long flags;
 
-	if (q->mq_ops) {
-		blk_mq_unquiesce_queue(q);
-	} else {
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	blk_mq_unquiesce_queue(q);
 }
 
 /**
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 99f1db5e467e..5f21547b2ad2 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -92,7 +92,6 @@ extern void scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);
 extern void scsi_requeue_run_queue(struct work_struct *work);
-extern struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev);
 extern struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev);
 extern void scsi_start_queue(struct scsi_device *sdev);
 extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 78ca63dfba4a..dd0d516f65e2 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -266,10 +266,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	 */
 	sdev->borken = 1;
 
-	if (shost_use_blk_mq(shost))
-		sdev->request_queue = scsi_mq_alloc_queue(sdev);
-	else
-		sdev->request_queue = scsi_old_alloc_queue(sdev);
+	sdev->request_queue = scsi_mq_alloc_queue(sdev);
 	if (!sdev->request_queue) {
 		/* release fn is set up in scsi_sysfs_device_initialise, so
 		 * have to free and put manually here */
@@ -280,11 +277,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
 	sdev->request_queue->queuedata = sdev;
 
-	if (!shost_use_blk_mq(sdev->host)) {
-		blk_queue_init_tags(sdev->request_queue,
-				    sdev->host->cmd_per_lun, shost->bqt,
-				    shost->hostt->tag_alloc_policy);
-	}
 	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
 					sdev->host->cmd_per_lun : 1);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 3aee9464a7bf..12e2c2829df2 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -367,7 +367,6 @@ store_shost_eh_deadline(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store_shost_eh_deadline);
 
-shost_rd_attr(use_blk_mq, "%d\n");
 shost_rd_attr(unique_id, "%u\n");
 shost_rd_attr(cmd_per_lun, "%hd\n");
 shost_rd_attr(can_queue, "%hd\n");
@@ -386,6 +385,13 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
 
+static ssize_t
+show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, 20, "1\n");
+}
+static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
+
 static struct attribute *scsi_sysfs_shost_attrs[] = {
 	&dev_attr_use_blk_mq.attr,
 	&dev_attr_unique_id.attr,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 23d7cca36ff0..fb308ea8e9a5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8100,12 +8100,6 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		goto out_error;
 	}
 
-	/*
-	 * Do not use blk-mq at this time because blk-mq does not support
-	 * runtime pm.
-	 */
-	host->use_blk_mq = false;
-
 	hba = shost_priv(host);
 	hba->host = host;
 	hba->dev = dev;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 5ea06d310a25..aa760df8c6b3 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -11,7 +11,6 @@
 #include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 
-struct request_queue;
 struct block_device;
 struct completion;
 struct module;
@@ -22,7 +21,6 @@ struct scsi_target;
 struct Scsi_Host;
 struct scsi_host_cmd_pool;
 struct scsi_transport_template;
-struct blk_queue_tags;
 
 
 /*
@@ -547,14 +545,8 @@ struct Scsi_Host {
 	struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
 
-	/*
-	 * Area to keep a shared tag map (if needed, will be
-	 * NULL if not).
-	 */
-	union {
-		struct blk_queue_tag	*bqt;
-		struct blk_mq_tag_set	tag_set;
-	};
+	/* Area to keep a shared tag map */
+	struct blk_mq_tag_set	tag_set;
 
 	atomic_t host_busy;		   /* commands actually active on low-level */
 	atomic_t host_blocked;
@@ -648,7 +640,6 @@ struct Scsi_Host {
 	/* The controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
-	unsigned use_blk_mq:1;
 	unsigned use_cmd_list:1;
 
 	/* Host responded with short (<36 bytes) INQUIRY result */
@@ -742,11 +733,6 @@ static inline int scsi_host_in_recovery(struct Scsi_Host *shost)
 		shost->tmf_in_progress;
 }
 
-static inline bool shost_use_blk_mq(struct Scsi_Host *shost)
-{
-	return shost->use_blk_mq;
-}
-
 extern int scsi_queue_work(struct Scsi_Host *, struct work_struct *);
 extern void scsi_flush_work(struct Scsi_Host *);
 
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index e192a0caa850..6053d46e794e 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -23,19 +23,15 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
 		int tag)
 {
 	struct request *req = NULL;
+	u16 hwq;
 
 	if (tag == SCSI_NO_TAG)
 		return NULL;
 
-	if (shost_use_blk_mq(shost)) {
-		u16 hwq = blk_mq_unique_tag_to_hwq(tag);
-
-		if (hwq < shost->tag_set.nr_hw_queues) {
-			req = blk_mq_tag_to_rq(shost->tag_set.tags[hwq],
-				blk_mq_unique_tag_to_tag(tag));
-		}
-	} else {
-		req = blk_map_queue_find_tag(shost->bqt, tag);
+	hwq = blk_mq_unique_tag_to_hwq(tag);
+	if (hwq < shost->tag_set.nr_hw_queues) {
+		req = blk_mq_tag_to_rq(shost->tag_set.tags[hwq],
+					blk_mq_unique_tag_to_tag(tag));
 	}
 
 	if (!req)
-- 
2.17.1
