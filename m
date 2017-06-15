Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/12] nvme: add support for streams and directives
Date: Thu, 15 Jun 2017 10:42:10 -0600
Message-Id: <1497544930-19174-13-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This adds support for Directives in NVMe, particular for the Streams
directive. Support for Directives is a new feature in NVMe 1.3. It
allows a user to pass in information about where to store the data,
so that it the device can do so most effiently. If an application is
managing and writing data with different life times, mixing differently
retentioned data onto the same locations on flash can cause write
amplification to grow. This, in turn, will reduce performance and
life time of the device.

We default to allocating 4 streams per name space, but it is
configurable with the 'streams_per_ns' module option. If a write stream
is set in a write, flag is as such before sending it to the device. The
streams are allocated lazily - if we get a write request with a life
time hint, then background allocate streams and use them once that
is done.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   5 ++
 include/linux/nvme.h     |  48 +++++++++++++
 3 files changed, 228 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d5813023a..30a6473b68cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -65,6 +65,10 @@ static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
 
+static char streams_per_ns = 4;
+module_param(streams_per_ns, byte, 0644);
+MODULE_PARM_DESC(streams_per_ns, "if available, allocate this many streams per NS");
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -331,6 +335,151 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
+static int nvme_enable_streams(struct nvme_ctrl *ctrl)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_send;
+	c.directive.nsid = cpu_to_le32(0xffffffff);
+	c.directive.doper = NVME_DIR_SND_ID_OP_ENABLE;
+	c.directive.dtype = NVME_DIR_IDENTIFY;
+	c.directive.tdtype = NVME_DIR_STREAMS;
+	c.directive.endir = NVME_DIR_ENDIR;
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
+}
+
+static int nvme_probe_directives(struct nvme_ctrl *ctrl)
+{
+	struct streams_directive_params s;
+	struct nvme_command c;
+	int ret;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
+		return 0;
+
+	ret = nvme_enable_streams(ctrl);
+	if (ret)
+		return ret;
+
+	memset(&c, 0, sizeof(c));
+	memset(&s, 0, sizeof(s));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(0xffffffff);
+	c.directive.numd = sizeof(s);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
+	c.directive.dtype = NVME_DIR_STREAMS;
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, &s, sizeof(s));
+	if (ret)
+		return ret;
+
+	ctrl->nssa = le16_to_cpu(s.nssa);
+	return 0;
+}
+
+/*
+ * Returns number of streams allocated for use by this ns, or -1 on error.
+ */
+static int nvme_streams_allocate(struct nvme_ns *ns, unsigned int streams)
+{
+	struct nvme_command c;
+	union nvme_result res;
+	int ret;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(ns->ns_id);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_RESOURCE;
+	c.directive.dtype = NVME_DIR_STREAMS;
+	c.directive.endir = streams;
+
+	ret = __nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, &res, NULL, 0, 0,
+					NVME_QID_ANY, 0, 0);
+	if (ret)
+		return -1;
+
+	return le32_to_cpu(res.u32) & 0xffff;
+}
+
+static int nvme_streams_deallocate(struct nvme_ns *ns)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_send;
+	c.directive.nsid = cpu_to_le32(ns->ns_id);
+	c.directive.doper = NVME_DIR_SND_ST_OP_REL_RSC;
+	c.directive.dtype = NVME_DIR_STREAMS;
+
+	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
+}
+
+static void nvme_write_hint_work(struct work_struct *work)
+{
+	struct nvme_ns *ns = container_of(work, struct nvme_ns, write_hint_work);
+	int ret, nr_streams;
+
+	if (ns->nr_streams)
+		return;
+
+	nr_streams = streams_per_ns;
+	if (nr_streams > ns->ctrl->nssa)
+		nr_streams = ns->ctrl->nssa;
+
+	ret = nvme_streams_allocate(ns, nr_streams);
+	if (ret <= 0)
+		goto err;
+
+	ns->nr_streams = ret;
+	dev_info(ns->ctrl->device, "successfully enabled %d streams\n", ret);
+	return;
+err:
+	dev_info(ns->ctrl->device, "failed enabling streams\n");
+	ns->ctrl->failed_streams = true;
+}
+
+static void nvme_configure_streams(struct nvme_ns *ns)
+{
+	/*
+	 * If we already called this function, we've either marked it
+	 * as a failure or set the number of streams.
+	 */
+	if (ns->ctrl->failed_streams)
+		return;
+	if (ns->nr_streams)
+		return;
+	schedule_work(&ns->write_hint_work);
+}
+
+static unsigned int nvme_get_write_stream(struct nvme_ns *ns,
+					  struct request *req)
+{
+	unsigned int streamid = 0;
+
+	if (req->cmd_flags & REQ_WRITE_SHORT)
+		streamid = 1;
+	else if (req->cmd_flags & REQ_WRITE_MEDIUM)
+		streamid = 2;
+	else if (req->cmd_flags & REQ_WRITE_LONG)
+		streamid = 3;
+	else if (req->cmd_flags & REQ_WRITE_EXTREME)
+		streamid = 4;
+
+	req->q->stream_writes[streamid] += blk_rq_bytes(req) >> 9;
+
+	if (streamid <= ns->nr_streams)
+		return streamid;
+
+	/* for now just round-robin, do something more clever later */
+	return (streamid % (ns->nr_streams + 1));
+}
+
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -351,6 +500,25 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	/*
+	 * If we support streams and it isn't enabled, so so now. Until it's
+	 * enabled, we won't flag the write with a stream. If we don't support
+	 * streams, just ignore the life time hint.
+	 */
+	if (req_op(req) == REQ_OP_WRITE && op_write_hint_valid(req->cmd_flags)) {
+		struct nvme_ctrl *ctrl = ns->ctrl;
+
+		if (ns->nr_streams) {
+			unsigned int stream = nvme_get_write_stream(ns, req);
+
+			if (stream) {
+				control |= NVME_RW_DTYPE_STREAMS;
+				dsmgmt |= (stream << 16);
+			}
+		} else if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
+			nvme_configure_streams(ns);
+	}
+
 	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
@@ -1650,6 +1818,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
+	nvme_probe_directives(ctrl);
 
 	ctrl->identified = true;
 
@@ -2049,6 +2218,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
+	INIT_WORK(&ns->write_hint_work, nvme_write_hint_work);
+
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_revalidate_ns(ns, &id))
@@ -2105,6 +2276,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	flush_work(&ns->write_hint_work);
+
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
@@ -2112,6 +2285,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 					&nvme_ns_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
+		if (ns->nr_streams)
+			nvme_streams_deallocate(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..918b6126d38b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -118,6 +118,7 @@ enum nvme_ctrl_state {
 struct nvme_ctrl {
 	enum nvme_ctrl_state state;
 	bool identified;
+	bool failed_streams;
 	spinlock_t lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
@@ -147,6 +148,7 @@ struct nvme_ctrl {
 	u16 oncs;
 	u16 vid;
 	u16 oacs;
+	u16 nssa;
 	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
@@ -192,6 +194,7 @@ struct nvme_ns {
 	u8 uuid[16];
 
 	unsigned ns_id;
+	unsigned nr_streams;
 	int lba_shift;
 	u16 ms;
 	bool ext;
@@ -203,6 +206,8 @@ struct nvme_ns {
 
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
+
+	struct work_struct write_hint_work;
 };
 
 struct nvme_ctrl_ops {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bacf37ef..8b2f5b140134 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -245,6 +245,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
 };
 
@@ -295,6 +296,19 @@ enum {
 };
 
 enum {
+	NVME_DIR_IDENTIFY		= 0x00,
+	NVME_DIR_STREAMS		= 0x01,
+	NVME_DIR_SND_ID_OP_ENABLE	= 0x01,
+	NVME_DIR_SND_ST_OP_REL_ID	= 0x01,
+	NVME_DIR_SND_ST_OP_REL_RSC	= 0x02,
+	NVME_DIR_RCV_ID_OP_PARAM	= 0x01,
+	NVME_DIR_RCV_ST_OP_PARAM	= 0x01,
+	NVME_DIR_RCV_ST_OP_STATUS	= 0x02,
+	NVME_DIR_RCV_ST_OP_RESOURCE	= 0x03,
+	NVME_DIR_ENDIR			= 0x01,
+};
+
+enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
@@ -535,6 +549,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
+	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
 struct nvme_dsm_cmd {
@@ -604,6 +619,8 @@ enum nvme_admin_opcode {
 	nvme_admin_download_fw		= 0x11,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
+	nvme_admin_directive_send	= 0x19,
+	nvme_admin_directive_recv	= 0x1a,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -756,6 +773,24 @@ struct nvme_get_log_page_command {
 	__u32			rsvd14[2];
 };
 
+struct nvme_directive_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			numd;
+	__u8			doper;
+	__u8			dtype;
+	__le16			dspec;
+	__u8			endir;
+	__u8			tdtype;
+	__u16			rsvd15;
+
+	__u32			rsvd16[3];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -886,6 +921,18 @@ struct nvme_dbbuf {
 	__u32			rsvd12[6];
 };
 
+struct streams_directive_params {
+	__u16	msl;
+	__u16	nssa;
+	__u16	nsso;
+	__u8	rsvd[10];
+	__u32	sws;
+	__u16	sgs;
+	__u16	nsa;
+	__u16	nso;
+	__u8	rsvd2[6];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -906,6 +953,7 @@ struct nvme_command {
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
 		struct nvme_dbbuf dbbuf;
+		struct nvme_directive_cmd directive;
 	};
 };
 
-- 
2.7.4
