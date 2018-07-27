Return-Path: <prvs=7391cfe80=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/5] blk-mq: Introduce the timeout handler return code BLK_EH_DONT_COMPLETE
Date: Fri, 27 Jul 2018 15:56:16 -0700
Message-Id: <20180727225620.17855-2-bart.vanassche@wdc.com>
In-Reply-To: <20180727225620.17855-1-bart.vanassche@wdc.com>
References: <20180727225620.17855-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

If a block driver timeout handler returns BLK_EH_DONE that means
either that the request has been completed or that the block driver
still owns the request and that the request has not yet been
completed. Since the name BLK_EH_DONE is misleading in the latter
case, introduce the return code BLK_EH_DONT_COMPLETE. See also
commits 88b0cfad2888 ("block: document the blk_eh_timer_return
values") and 6600593cbd93 ("block: rename BLK_EH_NOT_HANDLED to
BLK_EH_DONE").

Suggested-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 Documentation/scsi/scsi_eh.txt            |  4 ++--
 block/blk-mq.c                            | 10 ++++++++--
 block/blk-timeout.c                       |  9 ++++++++-
 drivers/block/nbd.c                       |  2 +-
 drivers/message/fusion/mptsas.c           |  2 +-
 drivers/s390/block/dasd.c                 |  6 +++---
 drivers/scsi/gdth.c                       |  2 +-
 drivers/scsi/libiscsi.c                   |  6 +++---
 drivers/scsi/megaraid/megaraid_sas_base.c |  2 +-
 drivers/scsi/mvumi.c                      |  2 +-
 drivers/scsi/qla4xxx/ql4_os.c             |  2 +-
 drivers/scsi/scsi_error.c                 |  4 ++--
 drivers/scsi/scsi_transport_fc.c          |  9 ++++++---
 drivers/scsi/scsi_transport_srp.c         |  4 ++--
 drivers/scsi/ufs/ufshcd.c                 |  6 +++---
 include/linux/blkdev.h                    |  3 ++-
 16 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
index 1b7436932a2b..20d6044b9a6c 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.txt
@@ -86,9 +86,9 @@ function
 	This indicates that more time is required to finish the
 	command.  Timer is restarted.  This action is counted as a
 	retry and only allowed scmd->allowed + 1(!) times.  Once the
-	limit is reached, action for BLK_EH_DONE is taken instead.
+	limit is reached, action for BLK_EH_DONT_COMPLETE is taken instead.
 
-    - BLK_EH_DONE
+    - BLK_EH_DONT_COMPLETE
         eh_timed_out() callback did not handle the command.
 	Step #2 is taken.
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..8e9beb4ddeb0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -774,9 +774,15 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		enum blk_eh_timer_return ret;
 
 		ret = req->q->mq_ops->timeout(req, reserved);
-		if (ret == BLK_EH_DONE)
+		switch (ret) {
+		case BLK_EH_DONE:
+		case BLK_EH_DONT_COMPLETE:
 			return;
-		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
+		case BLK_EH_RESET_TIMER:
+			break;
+		default:
+			WARN_ON_ONCE(true);
+		}
 	}
 
 	blk_add_timer(req);
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index f2cfd56e1606..38992c098026 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -90,7 +90,7 @@ static void blk_rq_timed_out(struct request *req)
 		blk_add_timer(req);
 		blk_clear_rq_complete(req);
 		break;
-	case BLK_EH_DONE:
+	case BLK_EH_DONT_COMPLETE:
 		/*
 		 * LLD handles this for now but in the future
 		 * we can send a request msg to abort the command
@@ -98,6 +98,13 @@ static void blk_rq_timed_out(struct request *req)
 		 * the blk layer.
 		 */
 		break;
+	case BLK_EH_DONE:
+		/*
+		 * The LLD completed the request by calling
+		 * __blk_complete_request().
+		 */
+		WARN_ON_ONCE(true);
+		break;
 	default:
 		printk(KERN_ERR "block: bad eh return: %d\n", ret);
 		break;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3fb95c8d9fd8..1a5a33e84dee 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -382,7 +382,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 			mutex_unlock(&cmd->lock);
 			nbd_requeue_cmd(cmd);
 			nbd_config_put(nbd);
-			return BLK_EH_DONE;
+			return BLK_EH_DONT_COMPLETE;
 		}
 	} else {
 		dev_err_ratelimited(nbd_to_dev(nbd),
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 76a66da33996..eae1b2613d69 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1929,7 +1929,7 @@ static enum blk_eh_timer_return mptsas_eh_timed_out(struct scsi_cmnd *sc)
 	MPT_SCSI_HOST *hd;
 	MPT_ADAPTER   *ioc;
 	VirtDevice    *vdevice;
-	enum blk_eh_timer_return rc = BLK_EH_DONE;
+	enum blk_eh_timer_return rc = BLK_EH_DONT_COMPLETE;
 
 	hd = shost_priv(sc->device->host);
 	if (hd == NULL) {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a9f60d0ee02e..5756c2fc3544 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3010,7 +3010,7 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
  *
  * Return values:
  * BLK_EH_RESET_TIMER if the request should be left running
- * BLK_EH_DONE if the request is handled or terminated
+ * BLK_EH_DONT_COMPLETE if the request is handled or terminated
  *		      by the driver.
  */
 enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
@@ -3023,7 +3023,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 
 	cqr = blk_mq_rq_to_pdu(req);
 	if (!cqr)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_COMPLETE;
 
 	spin_lock_irqsave(&cqr->dq->lock, flags);
 	device = cqr->startdev ? cqr->startdev : block->base;
@@ -3078,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 	spin_unlock(&block->queue_lock);
 	spin_unlock_irqrestore(&cqr->dq->lock, flags);
 
-	return rc ? BLK_EH_RESET_TIMER : BLK_EH_DONE;
+	return rc ? BLK_EH_RESET_TIMER : BLK_EH_DONT_COMPLETE;
 }
 
 static int dasd_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 85604795d8ee..9a2bec642986 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3882,7 +3882,7 @@ static enum blk_eh_timer_return gdth_timed_out(struct scsi_cmnd *scp)
 	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
 	u8 b, t;
 	unsigned long flags;
-	enum blk_eh_timer_return retval = BLK_EH_DONE;
+	enum blk_eh_timer_return retval = BLK_EH_DONT_COMPLETE;
 
 	TRACE(("%s() cmd 0x%x\n", scp->cmnd[0], __func__));
 	b = scp->device->channel;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index d6093838f5f2..2db9c760835f 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1963,7 +1963,7 @@ static int iscsi_has_ping_timed_out(struct iscsi_conn *conn)
 
 enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 {
-	enum blk_eh_timer_return rc = BLK_EH_DONE;
+	enum blk_eh_timer_return rc = BLK_EH_DONT_COMPLETE;
 	struct iscsi_task *task = NULL, *running_task;
 	struct iscsi_cls_session *cls_session;
 	struct iscsi_session *session;
@@ -1982,7 +1982,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		 * Raced with completion. Blk layer has taken ownership
 		 * so let timeout code complete it now.
 		 */
-		rc = BLK_EH_DONE;
+		rc = BLK_EH_DONT_COMPLETE;
 		goto done;
 	}
 
@@ -1997,7 +1997,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		if (unlikely(system_state != SYSTEM_RUNNING)) {
 			sc->result = DID_NO_CONNECT << 16;
 			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
-			rc = BLK_EH_DONE;
+			rc = BLK_EH_DONT_COMPLETE;
 			goto done;
 		}
 		/*
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 71d97573a667..47c292f0b8ae 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2768,7 +2768,7 @@ blk_eh_timer_return megasas_reset_timer(struct scsi_cmnd *scmd)
 
 	if (time_after(jiffies, scmd->jiffies_at_alloc +
 				(scmd_timeout * 2) * HZ)) {
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_COMPLETE;
 	}
 
 	instance = (struct megasas_instance *)scmd->device->host->hostdata;
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index b3cd9a6b1d30..2b41d2f64e50 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2155,7 +2155,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
 	mvumi_return_cmd(mhba, cmd);
 	spin_unlock_irqrestore(mhba->shost->host_lock, flags);
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_COMPLETE;
 }
 
 static int
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 0e13349dce57..0d5d13983217 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -1848,7 +1848,7 @@ static enum blk_eh_timer_return qla4xxx_eh_cmd_timed_out(struct scsi_cmnd *sc)
 	struct iscsi_cls_session *session;
 	struct iscsi_session *sess;
 	unsigned long flags;
-	enum blk_eh_timer_return ret = BLK_EH_DONE;
+	enum blk_eh_timer_return ret = BLK_EH_DONT_COMPLETE;
 
 	session = starget_to_session(scsi_target(sc->device));
 	sess = session->dd_data;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 2715cdaa669c..a885f4f23591 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -283,7 +283,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 enum blk_eh_timer_return scsi_times_out(struct request *req)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
-	enum blk_eh_timer_return rtn = BLK_EH_DONE;
+	enum blk_eh_timer_return rtn = BLK_EH_DONT_COMPLETE;
 	struct Scsi_Host *host = scmd->device->host;
 
 	trace_scsi_dispatch_cmd_timeout(scmd);
@@ -295,7 +295,7 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 	if (host->hostt->eh_timed_out)
 		rtn = host->hostt->eh_timed_out(scmd);
 
-	if (rtn == BLK_EH_DONE) {
+	if (rtn == BLK_EH_DONT_COMPLETE) {
 		/*
 		 * For blk-mq, we must set the request state to complete now
 		 * before sending the request to the scsi error handler. This
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 13948102ca29..a23941f195e3 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -2087,7 +2087,7 @@ fc_eh_timed_out(struct scsi_cmnd *scmd)
 	if (rport->port_state == FC_PORTSTATE_BLOCKED)
 		return BLK_EH_RESET_TIMER;
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_COMPLETE;
 }
 EXPORT_SYMBOL(fc_eh_timed_out);
 
@@ -3591,9 +3591,12 @@ fc_bsg_job_timeout(struct request *req)
 	}
 
 	/* the blk_end_sync_io() doesn't check the error */
-	if (inflight)
+	if (inflight) {
 		__blk_complete_request(req);
-	return BLK_EH_DONE;
+		return BLK_EH_DONE;
+	} else {
+		return BLK_EH_DONT_COMPLETE;
+	}
 }
 
 /**
diff --git a/drivers/scsi/scsi_transport_srp.c b/drivers/scsi/scsi_transport_srp.c
index 4e46fdb2d7c9..6c73b4c520cf 100644
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -604,7 +604,7 @@ EXPORT_SYMBOL(srp_reconnect_rport);
  *
  * If a timeout occurs while an rport is in the blocked state, ask the SCSI
  * EH to continue waiting (BLK_EH_RESET_TIMER). Otherwise let the SCSI core
- * handle the timeout (BLK_EH_DONE).
+ * handle the timeout (BLK_EH_DONT_COMPLETE).
  *
  * Note: This function is called from soft-IRQ context and with the request
  * queue lock held.
@@ -620,7 +620,7 @@ enum blk_eh_timer_return srp_timed_out(struct scsi_cmnd *scmd)
 	return rport && rport->fast_io_fail_tmo < 0 &&
 		rport->dev_loss_tmo < 0 &&
 		i->f->reset_timer_if_blocked && scsi_device_blocked(sdev) ?
-		BLK_EH_RESET_TIMER : BLK_EH_DONE;
+		BLK_EH_RESET_TIMER : BLK_EH_DONT_COMPLETE;
 }
 EXPORT_SYMBOL(srp_timed_out);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..1042fff318d5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6682,12 +6682,12 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	bool found = false;
 
 	if (!scmd || !scmd->device || !scmd->device->host)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_COMPLETE;
 
 	host = scmd->device->host;
 	hba = shost_priv(host);
 	if (!hba)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_COMPLETE;
 
 	spin_lock_irqsave(host->host_lock, flags);
 
@@ -6705,7 +6705,7 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	 * SCSI command was not actually dispatched to UFS driver, otherwise
 	 * let SCSI layer handle the error as usual.
 	 */
-	return found ? BLK_EH_DONE : BLK_EH_RESET_TIMER;
+	return found ? BLK_EH_DONT_COMPLETE : BLK_EH_RESET_TIMER;
 }
 
 static const struct attribute_group *ufshcd_driver_groups[] = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 050d599f5ea9..8f924fba80b9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -328,7 +328,8 @@ typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
 typedef void (exit_rq_fn)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
-	BLK_EH_DONE,		/* drivers has completed the command */
+	BLK_EH_DONE,		/* driver has completed the command */
+	BLK_EH_DONT_COMPLETE,	/* driver owns the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
-- 
2.18.0
