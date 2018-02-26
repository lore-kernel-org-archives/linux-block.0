Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Mike Christie <mchristi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: copy ioprio in __bio_clone_fast()
Date: Mon, 26 Feb 2018 11:55:52 +0100
Message-Id: <20180226105552.22120-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

We need to copy the io priority, too; otherwise the clone will run
with a different priority than the original one.

Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/bio.c          |   1 +
 drivers/vhost/npiv.c | 379 +++++----------------------------------------------
 2 files changed, 37 insertions(+), 343 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e1708db48258..e079911c640f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_ioprio = bio_src->bi_ioprio;
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
diff --git a/drivers/vhost/npiv.c b/drivers/vhost/npiv.c
index 20e2a66e332d..3527996aab3f 100644
--- a/drivers/vhost/npiv.c
+++ b/drivers/vhost/npiv.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- ****************************************************************************/
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -31,6 +31,7 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/miscdevice.h>
+#include <linux/mempool.h>
 #include <asm/unaligned.h>
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_proto.h>
@@ -87,8 +88,6 @@ struct vhost_npiv_cmd {
 	struct vhost_virtqueue *tvc_vq;
 	/* Pointer to vhost nexus memory */
 	struct vhost_npiv_nexus *tvc_nexus;
-	/* The TCM I/O descriptor that is accessed via container_of() */
-	struct se_cmd tvc_se_cmd;
 	/* work item used for cmwq dispatch to vhost_npiv_submission_work() */
 	struct work_struct work;
 	/* Copy of the incoming SCSI command descriptor block (CDB) */
@@ -101,11 +100,6 @@ struct vhost_npiv_cmd {
 	struct vhost_npiv_inflight *inflight;
 };
 
-struct vhost_npiv_nexus {
-	/* Pointer to TCM session for I_T Nexus */
-	struct se_session *tvn_se_sess;
-};
-
 struct vhost_npiv_tpg {
 	/* Vhost port target portal group tag for TCM */
 	u16 tport_tpgt;
@@ -121,25 +115,10 @@ struct vhost_npiv_tpg {
 	struct mutex tv_tpg_mutex;
 	/* Pointer to the TCM VHost I_T Nexus for this TPG endpoint */
 	struct vhost_npiv_nexus *tpg_nexus;
-	/* Pointer back to vhost_npiv_tport */
-	struct vhost_npiv_tport *tport;
-	/* Returned by vhost_npiv_make_tpg() */
-	struct se_portal_group se_tpg;
 	/* Pointer back to vhost_npiv, protected by tv_tpg_mutex */
 	struct vhost_npiv *vhost_npiv;
 };
 
-struct vhost_npiv_tport {
-	/* SCSI protocol the tport is providing */
-	u8 tport_proto_id;
-	/* Binary World Wide unique Port Name for Vhost Target port */
-	u64 tport_wwpn;
-	/* ASCII formatted WWPN for Vhost Target port */
-	char tport_name[VHOST_NPIV_NAMELEN];
-	/* Returned by vhost_npiv_make_tport() */
-	struct se_wwn tport_wwn;
-};
-
 struct vhost_npiv_evt {
 	/* event to be sent to guest */
 	struct virtio_scsi_event event;
@@ -195,6 +174,7 @@ struct vhost_npiv {
 };
 
 static struct workqueue_struct *vhost_npiv_workqueue;
+static struct mempool *vhost_npiv_cmd_pool;
 
 /* Global spinlock to protect vhost_npiv TPG list for vhost IOCTL access */
 static DEFINE_MUTEX(vhost_npiv_mutex);
@@ -253,132 +233,6 @@ static void vhost_npiv_put_inflight(struct vhost_npiv_inflight *inflight)
 	kref_put(&inflight->kref, vhost_npiv_done_inflight);
 }
 
-static int vhost_npiv_check_true(struct se_portal_group *se_tpg)
-{
-	return 1;
-}
-
-static int vhost_npiv_check_false(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
-static char *vhost_npiv_get_fabric_name(void)
-{
-	return "vhost";
-}
-
-static char *vhost_npiv_get_fabric_wwn(struct se_portal_group *se_tpg)
-{
-	struct vhost_npiv_tpg *tpg = container_of(se_tpg,
-				struct vhost_npiv_tpg, se_tpg);
-	struct vhost_npiv_tport *tport = tpg->tport;
-
-	return &tport->tport_name[0];
-}
-
-static u16 vhost_npiv_get_tpgt(struct se_portal_group *se_tpg)
-{
-	struct vhost_npiv_tpg *tpg = container_of(se_tpg,
-				struct vhost_npiv_tpg, se_tpg);
-	return tpg->tport_tpgt;
-}
-
-static int vhost_npiv_check_prot_fabric_only(struct se_portal_group *se_tpg)
-{
-	struct vhost_npiv_tpg *tpg = container_of(se_tpg,
-				struct vhost_npiv_tpg, se_tpg);
-
-	return tpg->tv_fabric_prot_type;
-}
-
-static u32 vhost_npiv_tpg_get_inst_index(struct se_portal_group *se_tpg)
-{
-	return 1;
-}
-
-static void vhost_npiv_release_cmd(struct se_cmd *se_cmd)
-{
-	struct vhost_npiv_cmd *tv_cmd = container_of(se_cmd,
-				struct vhost_npiv_cmd, tvc_se_cmd);
-	struct se_session *se_sess = tv_cmd->tvc_nexus->tvn_se_sess;
-	int i;
-
-	if (tv_cmd->tvc_sgl_count) {
-		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
-	}
-	if (tv_cmd->tvc_prot_sgl_count) {
-		for (i = 0; i < tv_cmd->tvc_prot_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
-	}
-
-	vhost_npiv_put_inflight(tv_cmd->inflight);
-	percpu_ida_free(&se_sess->sess_tag_pool, se_cmd->map_tag);
-}
-
-static u32 vhost_npiv_sess_get_index(struct se_session *se_sess)
-{
-	return 0;
-}
-
-static int vhost_npiv_write_pending(struct se_cmd *se_cmd)
-{
-	/* Go ahead and process the write immediately */
-	target_execute_cmd(se_cmd);
-	return 0;
-}
-
-static int vhost_npiv_write_pending_status(struct se_cmd *se_cmd)
-{
-	return 0;
-}
-
-static void vhost_npiv_set_default_node_attrs(struct se_node_acl *nacl)
-{
-	return;
-}
-
-static int vhost_npiv_get_cmd_state(struct se_cmd *se_cmd)
-{
-	return 0;
-}
-
-static void vhost_npiv_complete_cmd(struct vhost_npiv_cmd *cmd)
-{
-	struct vhost_npiv *vs = cmd->tvc_vhost;
-
-	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-
-	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
-}
-
-static int vhost_npiv_queue_data_in(struct se_cmd *se_cmd)
-{
-	struct vhost_npiv_cmd *cmd = container_of(se_cmd,
-				struct vhost_npiv_cmd, tvc_se_cmd);
-	vhost_npiv_complete_cmd(cmd);
-	return 0;
-}
-
-static int vhost_npiv_queue_status(struct se_cmd *se_cmd)
-{
-	struct vhost_npiv_cmd *cmd = container_of(se_cmd,
-				struct vhost_npiv_cmd, tvc_se_cmd);
-	vhost_npiv_complete_cmd(cmd);
-	return 0;
-}
-
-static void vhost_npiv_queue_tm_rsp(struct se_cmd *se_cmd)
-{
-	return;
-}
-
-static void vhost_npiv_aborted_task(struct se_cmd *se_cmd)
-{
-	return;
-}
-
 static void vhost_npiv_free_evt(struct vhost_npiv *vs, struct vhost_npiv_evt *evt)
 {
 	vs->vs_events_nr--;
@@ -411,20 +265,6 @@ vhost_npiv_allocate_evt(struct vhost_npiv *vs,
 	return evt;
 }
 
-static void vhost_npiv_free_cmd(struct vhost_npiv_cmd *cmd)
-{
-	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
-
-	/* TODO locking against target/backend threads? */
-	transport_generic_free_cmd(se_cmd, 0);
-
-}
-
-static int vhost_npiv_check_stop_free(struct se_cmd *se_cmd)
-{
-	return target_put_sess_cmd(se_cmd);
-}
-
 static void
 vhost_npiv_do_evt_work(struct vhost_npiv *vs, struct vhost_npiv_evt *evt)
 {
@@ -650,26 +490,19 @@ vhost_npiv_calc_sgls(struct iov_iter *iter, size_t bytes, int max_sgls)
 }
 
 static int
-vhost_npiv_iov_to_sgl(struct vhost_npiv_cmd *cmd, bool write,
+vhost_npiv_iov_to_req(struct vhost_npiv_cmd *cmd, bool write,
 		      struct iov_iter *iter,
-		      struct scatterlist *sg, int sg_count)
+		      struct request *req, int nr_pages)
 {
 	struct scatterlist *p = sg;
 	int ret;
+	struct bio_vec *vecs;
 
-	while (iov_iter_count(iter)) {
-		ret = vhost_npiv_map_to_sgl(cmd, iter, sg, write);
-		if (ret < 0) {
-			while (p < sg) {
-				struct page *page = sg_page(p++);
-				if (page)
-					put_page(page);
-			}
-			return ret;
-		}
-		sg += ret;
-	}
-	return 0;
+	vec = kmalloc(nr_pages * sizeof(struct bio_vec), GFP_KERNEL);
+	bio_init(req->bio, vecs, nr_pages);
+	req->bio->bi_end_io = vhost_npiv_end_io;
+
+	return bio_iov_iter_get_pages(req->bio, iter);
 }
 
 static int
@@ -678,61 +511,17 @@ vhost_npiv_mapal(struct vhost_npiv_cmd *cmd,
 		 size_t data_bytes, struct iov_iter *data_iter)
 {
 	int sgl_count, ret;
-	bool write = (cmd->tvc_data_direction == DMA_FROM_DEVICE);
-
-	if (prot_bytes) {
-		sgl_count = vhost_npiv_calc_sgls(prot_iter, prot_bytes,
-						 VHOST_NPIV_PREALLOC_PROT_SGLS);
-		if (sgl_count < 0)
-			return sgl_count;
-
-		sg_init_table(cmd->tvc_prot_sgl, sgl_count);
-		cmd->tvc_prot_sgl_count = sgl_count;
-		pr_debug("%s prot_sg %p prot_sgl_count %u\n", __func__,
-			 cmd->tvc_prot_sgl, cmd->tvc_prot_sgl_count);
-
-		ret = vhost_npiv_iov_to_sgl(cmd, write, prot_iter,
-					    cmd->tvc_prot_sgl,
-					    cmd->tvc_prot_sgl_count);
-		if (ret < 0) {
-			cmd->tvc_prot_sgl_count = 0;
-			return ret;
-		}
-	}
-	sgl_count = vhost_npiv_calc_sgls(data_iter, data_bytes,
-					 VHOST_NPIV_PREALLOC_SGLS);
-	if (sgl_count < 0)
-		return sgl_count;
-
-	sg_init_table(cmd->tvc_sgl, sgl_count);
-	cmd->tvc_sgl_count = sgl_count;
-	pr_debug("%s data_sg %p data_sgl_count %u\n", __func__,
-		  cmd->tvc_sgl, cmd->tvc_sgl_count);
-
-	ret = vhost_npiv_iov_to_sgl(cmd, write, data_iter,
-				    cmd->tvc_sgl, cmd->tvc_sgl_count);
-	if (ret < 0) {
-		cmd->tvc_sgl_count = 0;
-		return ret;
-	}
-	return 0;
-}
 
-static int vhost_npiv_to_tcm_attr(int attr)
-{
-	switch (attr) {
-	case VIRTIO_SCSI_S_SIMPLE:
-		return TCM_SIMPLE_TAG;
-	case VIRTIO_SCSI_S_ORDERED:
-		return TCM_ORDERED_TAG;
-	case VIRTIO_SCSI_S_HEAD:
-		return TCM_HEAD_TAG;
-	case VIRTIO_SCSI_S_ACA:
-		return TCM_ACA_TAG;
-	default:
-		break;
-	}
-	return TCM_SIMPLE_TAG;
+	if (WARN_ON(prot_bytes))
+		return -EOPNOTSUPP;
+
+	nr_pages = iov_iter_npages(data_iter, BIO_MAX_PAGES + 1);
+	req->bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, NULL);
+	bio_get(req->bio);
+	req->bio->bi_private = cmd;
+	req->bio->bi_end_io = vhost_npiv_end_io;
+
+	return bio_iov_iter_get_pages(req->bio, data_iter);
 }
 
 static void vhost_npiv_submission_work(struct work_struct *work)
@@ -890,7 +679,7 @@ vhost_npiv_handle_vq(struct vhost_npiv *vs, struct vhost_virtqueue *vq)
 			vhost_npiv_send_bad_target(vs, vq, head, out);
 			continue;
 		}
-			
+
 		/*
 		 * Determine data_direction by calculating the total outgoing
 		 * iovec sizes + incoming iovec sizes vs. virtio-scsi request +
@@ -1024,7 +813,6 @@ vhost_npiv_handle_vq(struct vhost_npiv *vs, struct vhost_virtqueue *vq)
 		req->timeout = timeout;
 		req->cmd_flags |= flags;
 		req->rq_flags |= rq_flags | RQF_QUIET;
-		req->end_io_data = vs
 
 		blk_execute_rq(req->q, NULL, req, 1);
 	}
@@ -1399,113 +1187,6 @@ static void vhost_npiv_deregister(void)
 	misc_deregister(&vhost_npiv_misc);
 }
 
-static char *vhost_npiv_dump_proto_id(struct vhost_npiv_tport *tport)
-{
-	switch (tport->tport_proto_id) {
-	case SCSI_PROTOCOL_SAS:
-		return "SAS";
-	case SCSI_PROTOCOL_FCP:
-		return "FCP";
-	case SCSI_PROTOCOL_ISCSI:
-		return "iSCSI";
-	default:
-		break;
-	}
-
-	return "Unknown";
-}
-
-static void
-vhost_npiv_do_plug(struct vhost_npiv_tpg *tpg,
-		  struct se_lun *lun, bool plug)
-{
-
-	struct vhost_npiv *vs = tpg->vhost_npiv;
-	struct vhost_virtqueue *vq;
-	u32 reason;
-
-	if (!vs)
-		return;
-
-	mutex_lock(&vs->dev.mutex);
-
-	if (plug)
-		reason = VIRTIO_SCSI_EVT_RESET_RESCAN;
-	else
-		reason = VIRTIO_SCSI_EVT_RESET_REMOVED;
-
-	vq = &vs->vqs[VHOST_NPIV_VQ_EVT].vq;
-	mutex_lock(&vq->mutex);
-	if (vhost_has_feature(vq, VIRTIO_SCSI_F_HOTPLUG))
-		vhost_npiv_send_evt(vs, tpg, lun,
-				   VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
-	mutex_unlock(&vq->mutex);
-	mutex_unlock(&vs->dev.mutex);
-}
-
-static void vhost_npiv_hotplug(struct vhost_npiv_tpg *tpg, struct se_lun *lun)
-{
-	vhost_npiv_do_plug(tpg, lun, true);
-}
-
-static void vhost_npiv_hotunplug(struct vhost_npiv_tpg *tpg, struct se_lun *lun)
-{
-	vhost_npiv_do_plug(tpg, lun, false);
-}
-
-static int vhost_npiv_port_link(struct se_portal_group *se_tpg,
-			       struct se_lun *lun)
-{
-	struct vhost_npiv_tpg *tpg = container_of(se_tpg,
-				struct vhost_npiv_tpg, se_tpg);
-
-	mutex_lock(&vhost_npiv_mutex);
-
-	mutex_lock(&tpg->tv_tpg_mutex);
-	tpg->tv_tpg_port_count++;
-	mutex_unlock(&tpg->tv_tpg_mutex);
-
-	vhost_npiv_hotplug(tpg, lun);
-
-	mutex_unlock(&vhost_npiv_mutex);
-
-	return 0;
-}
-
-static void vhost_npiv_port_unlink(struct se_portal_group *se_tpg,
-				  struct se_lun *lun)
-{
-	struct vhost_npiv_tpg *tpg = container_of(se_tpg,
-				struct vhost_npiv_tpg, se_tpg);
-
-	mutex_lock(&vhost_npiv_mutex);
-
-	mutex_lock(&tpg->tv_tpg_mutex);
-	tpg->tv_tpg_port_count--;
-	mutex_unlock(&tpg->tv_tpg_mutex);
-
-	vhost_npiv_hotunplug(tpg, lun);
-
-	mutex_unlock(&vhost_npiv_mutex);
-}
-
-static void vhost_npiv_free_cmd_map_res(struct se_session *se_sess)
-{
-	struct vhost_npiv_cmd *tv_cmd;
-	unsigned int i;
-
-	if (!se_sess->sess_cmd_map)
-		return;
-
-	for (i = 0; i < VHOST_NPIV_DEFAULT_TAGS; i++) {
-		tv_cmd = &((struct vhost_npiv_cmd *)se_sess->sess_cmd_map)[i];
-
-		kfree(tv_cmd->tvc_sgl);
-		kfree(tv_cmd->tvc_prot_sgl);
-		kfree(tv_cmd->tvc_upages);
-	}
-}
-
 static int __init vhost_npiv_init(void)
 {
 	int ret = -ENOMEM;
@@ -1514,22 +1195,34 @@ static int __init vhost_npiv_init(void)
 		" on "UTS_RELEASE"\n", VHOST_NPIV_VERSION, utsname()->sysname,
 		utsname()->machine);
 
+	vhost_npiv_cmd_pool = mempool_create_kmalloc_pool(VHOST_NPIV_MIN_CMDS,
+				sizeof (struct vhost_npiv_cmd));
+	if (!vhost_npiv_cmd_pool)
+		return -ENOMEM;
+
 	/*
 	 * Use our own dedicated workqueue for submitting I/O into
 	 * target core to avoid contention within system_wq.
 	 */
 	vhost_npiv_workqueue = alloc_workqueue("vhost_npiv", 0, 0);
-	if (!vhost_npiv_workqueue)
+	if (!vhost_npiv_workqueue) {
+		mempool_destroy(vhost_cmd_pool);
 		return -ENOMEM;
 		goto out;
 
-	return vhost_npiv_register();
+	ret = vhost_npiv_register();
+	if (ret < 0) {
+		destroy_workqueue(vhost_npiv_workqueue);
+		mempool_destroy(vhost_npiv_cmd_pool);
+	}
+	return ret;
 };
 
 static void vhost_npiv_exit(void)
 {
 	vhost_npiv_deregister();
 	destroy_workqueue(vhost_npiv_workqueue);
+	mempool_destroy(vhost_npiv_cmd_pool);
 };
 
 MODULE_DESCRIPTION("VHOST_NPIV passthrough");
-- 
2.12.3
