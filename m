Return-Path: <BATV+aee21d15a3e80231d125+5145+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 24 Sep 2017 06:03:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
Message-ID: <20170924130304.GA21904@infradead.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 05:18:49PM -1000, Linus Torvalds wrote:
> WTF? Why is this so hard? It used to be that IDE drove people crazy.
> Now it's NVMe and generic block layer stuff.

Can you please explain what problems you have with the nvme patches?
They are tiny and fix either user reported bugs, or fix the FC transport
to to use the right error code and sgl type constants per the spec.

That's exactly what we want to get into a tree now instead of waiting
another 6 weeks.

The diffstate and diff itself are below.

And the block stuff looks similar to me, but I haven't looked at the
details.

 host/core.c          |    9 +---
 host/fabrics.c       |   18 ++++----
 host/fc.c            |   21 +++++-----
 host/pci.c           |   34 +++++++++-------
 host/rdma.c          |    9 +++-
 target/core.c        |    9 ++--
 target/fabrics-cmd.c |    9 +++-
 target/fc.c          |   24 ++++++-----
 target/fcloop.c      |  104 +++++++++++++++++++--------------------------------
 target/nvmet.h       |    1
 10 files changed, 117 insertions(+), 121 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index acc816b67582..bb2aad078637 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -134,8 +134,6 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
-	if (jiffies - req->start_time >= req->timeout)
-		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
 	return true;
@@ -2590,7 +2588,7 @@ static void nvme_async_event_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, async_event_work);
 
 	spin_lock_irq(&ctrl->lock);
-	while (ctrl->event_limit > 0) {
+	while (ctrl->state == NVME_CTRL_LIVE && ctrl->event_limit > 0) {
 		int aer_idx = --ctrl->event_limit;
 
 		spin_unlock_irq(&ctrl->lock);
@@ -2677,7 +2675,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		/*FALLTHRU*/
 	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
-		queue_work(nvme_wq, &ctrl->async_event_work);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			queue_work(nvme_wq, &ctrl->async_event_work);
 		break;
 	default:
 		break;
@@ -2692,7 +2691,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		schedule_work(&ctrl->fw_act_work);
+		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 47307752dc65..555c976cc2ee 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -565,6 +565,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
+	opts->kato = NVME_DEFAULT_KATO;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -655,21 +656,22 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 
-			if (opts->discovery_nqn) {
-				pr_err("Discovery controllers cannot accept keep_alive_tmo != 0\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
 			if (token < 0) {
 				pr_err("Invalid keep_alive_tmo %d\n", token);
 				ret = -EINVAL;
 				goto out;
-			} else if (token == 0) {
+			} else if (token == 0 && !opts->discovery_nqn) {
 				/* Allowed for debug */
 				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
 			}
 			opts->kato = token;
+
+			if (opts->discovery_nqn && opts->kato) {
+				pr_err("Discovery controllers cannot accept KATO != 0\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
 			break;
 		case NVMF_OPT_CTRL_LOSS_TMO:
 			if (match_int(args, &token)) {
@@ -762,8 +764,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&opts->host->id, &hostid);
 
 out:
-	if (!opts->discovery_nqn && !opts->kato)
-		opts->kato = NVME_DEFAULT_KATO;
 	kfree(options);
 	return ret;
 }
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d2e882c0f496..af075e998944 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1376,7 +1376,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
 		status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
 	else if (freq->status)
-		status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 
 	/*
 	 * For the linux implementation, if we have an unsuccesful
@@ -1404,7 +1404,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		 */
 		if (freq->transferred_length !=
 			be32_to_cpu(op->cmd_iu.data_len)) {
-			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 			goto done;
 		}
 		result.u64 = 0;
@@ -1421,7 +1421,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
 			     sqe->common.command_id != cqe->command_id)) {
-			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 			goto done;
 		}
 		result = cqe->result;
@@ -1429,7 +1429,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		break;
 
 	default:
-		status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 		goto done;
 	}
 
@@ -1989,16 +1989,17 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	 * as well as those by FC-NVME spec.
 	 */
 	WARN_ON_ONCE(sqe->common.metadata);
-	WARN_ON_ONCE(sqe->common.dptr.prp1);
-	WARN_ON_ONCE(sqe->common.dptr.prp2);
 	sqe->common.flags |= NVME_CMD_SGL_METABUF;
 
 	/*
-	 * format SQE DPTR field per FC-NVME rules
-	 *    type=data block descr; subtype=offset;
-	 *    offset is currently 0.
+	 * format SQE DPTR field per FC-NVME rules:
+	 *    type=0x5     Transport SGL Data Block Descriptor
+	 *    subtype=0xA  Transport-specific value
+	 *    address=0
+	 *    length=length of the data series
 	 */
-	sqe->rw.dptr.sgl.type = NVME_SGL_FMT_OFFSET;
+	sqe->rw.dptr.sgl.type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+					NVME_SGL_FMT_TRANSPORT_A;
 	sqe->rw.dptr.sgl.length = cpu_to_le32(data_len);
 	sqe->rw.dptr.sgl.addr = 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a2121335f48..cb73bc8cad3b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/once.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
 #include <linux/t10-pi.h>
@@ -540,6 +541,20 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
+static void nvme_print_sgl(struct scatterlist *sgl, int nents)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+		dma_addr_t phys = sg_phys(sg);
+		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
+			"dma_address:%pad dma_length:%d\n",
+			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
+			sg_dma_len(sg));
+	}
+}
+
 static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -622,19 +637,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_OK;
 
  bad_sgl:
-	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
-				blk_rq_payload_bytes(req), iod->nents)) {
-		for_each_sg(iod->sg, sg, iod->nents, i) {
-			dma_addr_t phys = sg_phys(sg);
-			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-			       "dma_address:%pad dma_length:%d\n", i, &phys,
-					sg->offset, sg->length,
-					&sg_dma_address(sg),
-					sg_dma_len(sg));
-		}
-	}
+	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
+			"Invalid SGL for payload:%d nents:%d\n",
+			blk_rq_payload_bytes(req), iod->nents);
 	return BLK_STS_IOERR;
-
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
@@ -1313,11 +1319,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
+	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
 
-	nvme_init_queue(nvmeq, qid);
 	return result;
 
  release_sq:
@@ -1464,6 +1470,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 
 	nvmeq->cq_vector = 0;
+	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -2156,7 +2163,6 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto out;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 58983000964b..92a03ff5fb4d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -942,7 +942,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!changed) {
+		/* state change failure is ok if we're in DELETING state */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		return;
+	}
+
 	ctrl->ctrl.nr_reconnects = 0;
 
 	nvme_start_ctrl(&ctrl->ctrl);
@@ -962,7 +967,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c23eaf8e563..1b208beeef50 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -390,10 +390,10 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	if (status)
 		nvmet_set_status(req, status);
 
-	/* XXX: need to fill in something useful for sq_head */
-	req->rsp->sq_head = 0;
-	if (likely(req->sq)) /* may happen during early failure */
-		req->rsp->sq_id = cpu_to_le16(req->sq->qid);
+	if (req->sq->size)
+		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
+	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
+	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
 
 	if (req->ns)
@@ -420,6 +420,7 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 		u16 qid, u16 size)
 {
+	sq->sqhd = 0;
 	sq->qid = qid;
 	sq->size = size;
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 859a66725291..db3bf6b8bf9e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -109,9 +109,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue already connected!\n");
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
 	}
+	if (!sqsize) {
+		pr_warn("queue size zero!\n");
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	}
 
-	nvmet_cq_setup(ctrl, req->cq, qid, sqsize);
-	nvmet_sq_setup(ctrl, req->sq, qid, sqsize);
+	/* note: convert queue size from 0's-based value to 1's-based value */
+	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
+	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 421e43bf1dd7..58e010bdda3e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -148,7 +148,7 @@ struct nvmet_fc_tgt_assoc {
 	u32				a_id;
 	struct nvmet_fc_tgtport		*tgtport;
 	struct list_head		a_list;
-	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES];
+	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 };
 
@@ -608,7 +608,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	unsigned long flags;
 	int ret;
 
-	if (qid >= NVMET_NR_QUEUES)
+	if (qid > NVMET_NR_QUEUES)
 		return NULL;
 
 	queue = kzalloc((sizeof(*queue) +
@@ -783,6 +783,9 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	u16 qid = nvmet_fc_getqueueid(connection_id);
 	unsigned long flags;
 
+	if (qid > NVMET_NR_QUEUES)
+		return NULL;
+
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
@@ -888,7 +891,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	int i;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	for (i = NVMET_NR_QUEUES - 1; i >= 0; i--) {
+	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
 		queue = assoc->queues[i];
 		if (queue) {
 			if (!nvmet_fc_tgt_q_get(queue))
@@ -1910,8 +1913,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
 			spin_lock_irqsave(&fod->flock, flags);
 			fod->writedataactive = false;
 			spin_unlock_irqrestore(&fod->flock, flags);
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 		} else /* NVMET_FCOP_READDATA or NVMET_FCOP_READDATA_RSP */ {
 			fcpreq->fcp_error = ret;
 			fcpreq->transferred_length = 0;
@@ -1929,8 +1931,7 @@ __nvmet_fc_fod_op_abort(struct nvmet_fc_fcp_iod *fod, bool abort)
 	/* if in the middle of an io and we need to tear down */
 	if (abort) {
 		if (fcpreq->op == NVMET_FCOP_WRITEDATA) {
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return true;
 		}
 
@@ -1968,8 +1969,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 			fod->abort = true;
 			spin_unlock(&fod->flock);
 
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return;
 		}
 
@@ -2533,13 +2533,17 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 {
 	struct nvmet_fc_tgtport *tgtport = port->priv;
 	unsigned long flags;
+	bool matched = false;
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	if (tgtport->port == port) {
-		nvmet_fc_tgtport_put(tgtport);
+		matched = true;
 		tgtport->port = NULL;
 	}
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
+	if (matched)
+		nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1cb9847ec261..7b75d9de55ab 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -224,8 +224,6 @@ struct fcloop_nport {
 	struct fcloop_lport *lport;
 	struct list_head nport_list;
 	struct kref ref;
-	struct completion rport_unreg_done;
-	struct completion tport_unreg_done;
 	u64 node_name;
 	u64 port_name;
 	u32 port_role;
@@ -576,7 +574,7 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	tfcp_req->aborted = true;
 	spin_unlock(&tfcp_req->reqlock);
 
-	tfcp_req->status = NVME_SC_FC_TRANSPORT_ABORTED;
+	tfcp_req->status = NVME_SC_INTERNAL;
 
 	/*
 	 * nothing more to do. If io wasn't active, the transport should
@@ -630,6 +628,32 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	schedule_work(&inireq->iniwork);
 }
 
+static void
+fcloop_nport_free(struct kref *ref)
+{
+	struct fcloop_nport *nport =
+		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(nport);
+}
+
+static void
+fcloop_nport_put(struct fcloop_nport *nport)
+{
+	kref_put(&nport->ref, fcloop_nport_free);
+}
+
+static int
+fcloop_nport_get(struct fcloop_nport *nport)
+{
+	return kref_get_unless_zero(&nport->ref);
+}
+
 static void
 fcloop_localport_delete(struct nvme_fc_local_port *localport)
 {
@@ -644,8 +668,7 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
 
-	/* release any threads waiting for the unreg to complete */
-	complete(&rport->nport->rport_unreg_done);
+	fcloop_nport_put(rport->nport);
 }
 
 static void
@@ -653,8 +676,7 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
 
-	/* release any threads waiting for the unreg to complete */
-	complete(&tport->nport->tport_unreg_done);
+	fcloop_nport_put(tport->nport);
 }
 
 #define	FCLOOP_HW_QUEUES		4
@@ -722,6 +744,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		goto out_free_opts;
 	}
 
+	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = opts->wwnn;
 	pinfo.port_name = opts->wwpn;
 	pinfo.port_role = opts->roles;
@@ -804,32 +827,6 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
-static void
-fcloop_nport_free(struct kref *ref)
-{
-	struct fcloop_nport *nport =
-		container_of(ref, struct fcloop_nport, ref);
-	unsigned long flags;
-
-	spin_lock_irqsave(&fcloop_lock, flags);
-	list_del(&nport->nport_list);
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
-	kfree(nport);
-}
-
-static void
-fcloop_nport_put(struct fcloop_nport *nport)
-{
-	kref_put(&nport->ref, fcloop_nport_free);
-}
-
-static int
-fcloop_nport_get(struct fcloop_nport *nport)
-{
-	return kref_get_unless_zero(&nport->ref);
-}
-
 static struct fcloop_nport *
 fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 {
@@ -938,6 +935,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -EIO;
 
+	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = nport->node_name;
 	pinfo.port_name = nport->port_name;
 	pinfo.port_role = nport->port_role;
@@ -979,24 +977,12 @@ __unlink_remote_port(struct fcloop_nport *nport)
 }
 
 static int
-__wait_remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
+__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	int ret;
-
 	if (!rport)
 		return -EALREADY;
 
-	init_completion(&nport->rport_unreg_done);
-
-	ret = nvme_fc_unregister_remoteport(rport->remoteport);
-	if (ret)
-		return ret;
-
-	wait_for_completion(&nport->rport_unreg_done);
-
-	fcloop_nport_put(nport);
-
-	return ret;
+	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
 static ssize_t
@@ -1029,7 +1015,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __wait_remoteport_unreg(nport, rport);
+	ret = __remoteport_unreg(nport, rport);
 
 	return ret ? ret : count;
 }
@@ -1086,24 +1072,12 @@ __unlink_target_port(struct fcloop_nport *nport)
 }
 
 static int
-__wait_targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
+__targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	int ret;
-
 	if (!tport)
 		return -EALREADY;
 
-	init_completion(&nport->tport_unreg_done);
-
-	ret = nvmet_fc_unregister_targetport(tport->targetport);
-	if (ret)
-		return ret;
-
-	wait_for_completion(&nport->tport_unreg_done);
-
-	fcloop_nport_put(nport);
-
-	return ret;
+	return nvmet_fc_unregister_targetport(tport->targetport);
 }
 
 static ssize_t
@@ -1136,7 +1110,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __wait_targetport_unreg(nport, tport);
+	ret = __targetport_unreg(nport, tport);
 
 	return ret ? ret : count;
 }
@@ -1223,11 +1197,11 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __wait_targetport_unreg(nport, tport);
+		ret = __targetport_unreg(nport, tport);
 		if (ret)
 			pr_warn("%s: Failed deleting target port\n", __func__);
 
-		ret = __wait_remoteport_unreg(nport, rport);
+		ret = __remoteport_unreg(nport, rport);
 		if (ret)
 			pr_warn("%s: Failed deleting remote port\n", __func__);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7d261ab894f4..7b8e20adf760 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -74,6 +74,7 @@ struct nvmet_sq {
 	struct percpu_ref	ref;
 	u16			qid;
 	u16			size;
+	u16			sqhd;
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
