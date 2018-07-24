Return-Path: <prvs=736960120=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH for v4.18] blk-mq: Rename BLK_EH_DONE into BLK_EH_DONT_RESET_TIMER
Date: Tue, 24 Jul 2018 14:32:05 -0700
Message-Id: <20180724213205.11119-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

If a block driver timeout handler returns BLK_EH_DONE that means
either that the request has been completed or that the block driver
still owns the request. Since the name BLK_EH_DONE is misleading,
change it into BLK_EH_DONT_RESET_TIMER.

Fixes: 88b0cfad2888 ("block: document the blk_eh_timer_return values")
Fixes: 6600593cbd93 ("block: rename BLK_EH_NOT_HANDLED to BLK_EH_DONE")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 Documentation/scsi/scsi_eh.txt            |  4 ++--
 block/blk-mq.c                            |  2 +-
 block/blk-timeout.c                       |  2 +-
 drivers/block/mtip32xx/mtip32xx.c         |  2 +-
 drivers/block/nbd.c                       |  4 ++--
 drivers/block/null_blk_main.c             |  4 ++--
 drivers/message/fusion/mptsas.c           |  2 +-
 drivers/mmc/core/queue.c                  |  2 +-
 drivers/nvme/host/pci.c                   | 10 +++++-----
 drivers/nvme/host/rdma.c                  |  2 +-
 drivers/nvme/target/loop.c                |  2 +-
 drivers/s390/block/dasd.c                 |  6 +++---
 drivers/scsi/gdth.c                       |  2 +-
 drivers/scsi/libiscsi.c                   |  6 +++---
 drivers/scsi/megaraid/megaraid_sas_base.c |  2 +-
 drivers/scsi/mvumi.c                      |  2 +-
 drivers/scsi/qla4xxx/ql4_os.c             |  2 +-
 drivers/scsi/scsi_error.c                 |  4 ++--
 drivers/scsi/scsi_transport_fc.c          |  4 ++--
 drivers/scsi/scsi_transport_srp.c         |  4 ++--
 drivers/scsi/ufs/ufshcd.c                 |  6 +++---
 include/linux/blkdev.h                    |  2 +-
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
index 1b7436932a2b..59e085b28b31 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.txt
@@ -86,9 +86,9 @@ function
 	This indicates that more time is required to finish the
 	command.  Timer is restarted.  This action is counted as a
 	retry and only allowed scmd->allowed + 1(!) times.  Once the
-	limit is reached, action for BLK_EH_DONE is taken instead.
+	limit is reached, action for BLK_EH_DONT_RESET_TIMER is taken instead.
 
-    - BLK_EH_DONE
+    - BLK_EH_DONT_RESET_TIMER
         eh_timed_out() callback did not handle the command.
 	Step #2 is taken.
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..96e1a7f25875 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -774,7 +774,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		enum blk_eh_timer_return ret;
 
 		ret = req->q->mq_ops->timeout(req, reserved);
-		if (ret == BLK_EH_DONE)
+		if (ret == BLK_EH_DONT_RESET_TIMER)
 			return;
 		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
 	}
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index f2cfd56e1606..37df7f8f8516 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -90,7 +90,7 @@ static void blk_rq_timed_out(struct request *req)
 		blk_add_timer(req);
 		blk_clear_rq_complete(req);
 		break;
-	case BLK_EH_DONE:
+	case BLK_EH_DONT_RESET_TIMER:
 		/*
 		 * LLD handles this for now but in the future
 		 * we can send a request msg to abort the command
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c73626decb46..e28be7821d0c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3712,7 +3712,7 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 
 		cmd->status = BLK_STS_TIMEOUT;
 		blk_mq_complete_request(req);
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	}
 
 	if (test_bit(req->tag, dd->port->cmds_to_issue))
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3fb95c8d9fd8..67e17965e462 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -382,7 +382,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 			mutex_unlock(&cmd->lock);
 			nbd_requeue_cmd(cmd);
 			nbd_config_put(nbd);
-			return BLK_EH_DONE;
+			return BLK_EH_DONT_RESET_TIMER;
 		}
 	} else {
 		dev_err_ratelimited(nbd_to_dev(nbd),
@@ -395,7 +395,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	nbd_config_put(nbd);
 done:
 	blk_mq_complete_request(req);
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 /*
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 86cafa6d3b41..3617c9ac251a 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1320,7 +1320,7 @@ static enum blk_eh_timer_return null_rq_timed_out_fn(struct request *rq)
 {
 	pr_info("null: rq %p timed out\n", rq);
 	__blk_complete_request(rq);
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 static int null_rq_prep_fn(struct request_queue *q, struct request *req)
@@ -1383,7 +1383,7 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("null: rq %p timed out\n", rq);
 	blk_mq_complete_request(rq);
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 76a66da33996..b703ad68f426 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1929,7 +1929,7 @@ static enum blk_eh_timer_return mptsas_eh_timed_out(struct scsi_cmnd *sc)
 	MPT_SCSI_HOST *hd;
 	MPT_ADAPTER   *ioc;
 	VirtDevice    *vdevice;
-	enum blk_eh_timer_return rc = BLK_EH_DONE;
+	enum blk_eh_timer_return rc = BLK_EH_DONT_RESET_TIMER;
 
 	hd = shost_priv(sc->device->host);
 	if (hd == NULL) {
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 648eb6743ed5..ea32dcd6bfcf 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -113,7 +113,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 		}
 		/* No timeout (XXX: huh? comment doesn't make much sense) */
 		blk_mq_complete_request(req);
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	default:
 		/* Timeout is handled by mmc core */
 		return BLK_EH_RESET_TIMER;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..c2a0fbbd12ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1209,7 +1209,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	}
 
 	/*
@@ -1219,14 +1219,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	}
 
 	/*
 	 * Shutdown immediately if controller times out while starting. The
 	 * reset work will see the pci device disabled when it gets the forced
 	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_DONE.
+	 * shutdown, so we return BLK_EH_DONT_RESET_TIMER.
 	 */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_CONNECTING:
@@ -1236,7 +1236,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	default:
 		break;
 	}
@@ -1254,7 +1254,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		nvme_reset_ctrl(&dev->ctrl);
 
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	}
 
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 518c5b09038c..3c6a3385f9f9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1619,7 +1619,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..0b317fdb6fde 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -148,7 +148,7 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a9f60d0ee02e..d9bfebcc6aa7 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3010,7 +3010,7 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
  *
  * Return values:
  * BLK_EH_RESET_TIMER if the request should be left running
- * BLK_EH_DONE if the request is handled or terminated
+ * BLK_EH_DONT_RESET_TIMER if the request is handled or terminated
  *		      by the driver.
  */
 enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
@@ -3023,7 +3023,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 
 	cqr = blk_mq_rq_to_pdu(req);
 	if (!cqr)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 
 	spin_lock_irqsave(&cqr->dq->lock, flags);
 	device = cqr->startdev ? cqr->startdev : block->base;
@@ -3078,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 	spin_unlock(&block->queue_lock);
 	spin_unlock_irqrestore(&cqr->dq->lock, flags);
 
-	return rc ? BLK_EH_RESET_TIMER : BLK_EH_DONE;
+	return rc ? BLK_EH_RESET_TIMER : BLK_EH_DONT_RESET_TIMER;
 }
 
 static int dasd_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 85604795d8ee..fa18d3d1dc9c 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3882,7 +3882,7 @@ static enum blk_eh_timer_return gdth_timed_out(struct scsi_cmnd *scp)
 	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
 	u8 b, t;
 	unsigned long flags;
-	enum blk_eh_timer_return retval = BLK_EH_DONE;
+	enum blk_eh_timer_return retval = BLK_EH_DONT_RESET_TIMER;
 
 	TRACE(("%s() cmd 0x%x\n", scp->cmnd[0], __func__));
 	b = scp->device->channel;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index d6093838f5f2..6ede7e01df30 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1963,7 +1963,7 @@ static int iscsi_has_ping_timed_out(struct iscsi_conn *conn)
 
 enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 {
-	enum blk_eh_timer_return rc = BLK_EH_DONE;
+	enum blk_eh_timer_return rc = BLK_EH_DONT_RESET_TIMER;
 	struct iscsi_task *task = NULL, *running_task;
 	struct iscsi_cls_session *cls_session;
 	struct iscsi_session *session;
@@ -1982,7 +1982,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		 * Raced with completion. Blk layer has taken ownership
 		 * so let timeout code complete it now.
 		 */
-		rc = BLK_EH_DONE;
+		rc = BLK_EH_DONT_RESET_TIMER;
 		goto done;
 	}
 
@@ -1997,7 +1997,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		if (unlikely(system_state != SYSTEM_RUNNING)) {
 			sc->result = DID_NO_CONNECT << 16;
 			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
-			rc = BLK_EH_DONE;
+			rc = BLK_EH_DONT_RESET_TIMER;
 			goto done;
 		}
 		/*
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 71d97573a667..bd5bc1da9be1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2768,7 +2768,7 @@ blk_eh_timer_return megasas_reset_timer(struct scsi_cmnd *scmd)
 
 	if (time_after(jiffies, scmd->jiffies_at_alloc +
 				(scmd_timeout * 2) * HZ)) {
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 	}
 
 	instance = (struct megasas_instance *)scmd->device->host->hostdata;
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index b3cd9a6b1d30..84cdadd4bd78 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2155,7 +2155,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
 	mvumi_return_cmd(mhba, cmd);
 	spin_unlock_irqrestore(mhba->shost->host_lock, flags);
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 static int
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 0e13349dce57..ecabca8d815b 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -1848,7 +1848,7 @@ static enum blk_eh_timer_return qla4xxx_eh_cmd_timed_out(struct scsi_cmnd *sc)
 	struct iscsi_cls_session *session;
 	struct iscsi_session *sess;
 	unsigned long flags;
-	enum blk_eh_timer_return ret = BLK_EH_DONE;
+	enum blk_eh_timer_return ret = BLK_EH_DONT_RESET_TIMER;
 
 	session = starget_to_session(scsi_target(sc->device));
 	sess = session->dd_data;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 2715cdaa669c..b38b8e62e618 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -283,7 +283,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 enum blk_eh_timer_return scsi_times_out(struct request *req)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
-	enum blk_eh_timer_return rtn = BLK_EH_DONE;
+	enum blk_eh_timer_return rtn = BLK_EH_DONT_RESET_TIMER;
 	struct Scsi_Host *host = scmd->device->host;
 
 	trace_scsi_dispatch_cmd_timeout(scmd);
@@ -295,7 +295,7 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 	if (host->hostt->eh_timed_out)
 		rtn = host->hostt->eh_timed_out(scmd);
 
-	if (rtn == BLK_EH_DONE) {
+	if (rtn == BLK_EH_DONT_RESET_TIMER) {
 		/*
 		 * For blk-mq, we must set the request state to complete now
 		 * before sending the request to the scsi error handler. This
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 13948102ca29..63d283f298f3 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -2087,7 +2087,7 @@ fc_eh_timed_out(struct scsi_cmnd *scmd)
 	if (rport->port_state == FC_PORTSTATE_BLOCKED)
 		return BLK_EH_RESET_TIMER;
 
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 EXPORT_SYMBOL(fc_eh_timed_out);
 
@@ -3593,7 +3593,7 @@ fc_bsg_job_timeout(struct request *req)
 	/* the blk_end_sync_io() doesn't check the error */
 	if (inflight)
 		__blk_complete_request(req);
-	return BLK_EH_DONE;
+	return BLK_EH_DONT_RESET_TIMER;
 }
 
 /**
diff --git a/drivers/scsi/scsi_transport_srp.c b/drivers/scsi/scsi_transport_srp.c
index 4e46fdb2d7c9..03571512dca5 100644
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -604,7 +604,7 @@ EXPORT_SYMBOL(srp_reconnect_rport);
  *
  * If a timeout occurs while an rport is in the blocked state, ask the SCSI
  * EH to continue waiting (BLK_EH_RESET_TIMER). Otherwise let the SCSI core
- * handle the timeout (BLK_EH_DONE).
+ * handle the timeout (BLK_EH_DONT_RESET_TIMER).
  *
  * Note: This function is called from soft-IRQ context and with the request
  * queue lock held.
@@ -620,7 +620,7 @@ enum blk_eh_timer_return srp_timed_out(struct scsi_cmnd *scmd)
 	return rport && rport->fast_io_fail_tmo < 0 &&
 		rport->dev_loss_tmo < 0 &&
 		i->f->reset_timer_if_blocked && scsi_device_blocked(sdev) ?
-		BLK_EH_RESET_TIMER : BLK_EH_DONE;
+		BLK_EH_RESET_TIMER : BLK_EH_DONT_RESET_TIMER;
 }
 EXPORT_SYMBOL(srp_timed_out);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..2184222953b2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6682,12 +6682,12 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	bool found = false;
 
 	if (!scmd || !scmd->device || !scmd->device->host)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 
 	host = scmd->device->host;
 	hba = shost_priv(host);
 	if (!hba)
-		return BLK_EH_DONE;
+		return BLK_EH_DONT_RESET_TIMER;
 
 	spin_lock_irqsave(host->host_lock, flags);
 
@@ -6705,7 +6705,7 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	 * SCSI command was not actually dispatched to UFS driver, otherwise
 	 * let SCSI layer handle the error as usual.
 	 */
-	return found ? BLK_EH_DONE : BLK_EH_RESET_TIMER;
+	return found ? BLK_EH_DONT_RESET_TIMER : BLK_EH_RESET_TIMER;
 }
 
 static const struct attribute_group *ufshcd_driver_groups[] = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 331a6cb8805f..c5efca0f0600 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -328,7 +328,7 @@ typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
 typedef void (exit_rq_fn)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
-	BLK_EH_DONE,		/* drivers has completed the command */
+	BLK_EH_DONT_RESET_TIMER,/* driver completed or owns the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
-- 
2.18.0
