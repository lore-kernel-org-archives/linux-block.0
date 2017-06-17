Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] nvme: add support for streams and directives
Date: Sat, 17 Jun 2017 13:59:54 -0600
Message-Id: <1497729594-4707-12-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This adds support for Directives in NVMe, particular for the Streams
directive. Support for Directives is a new feature in NVMe 1.3. It
allows a user to pass in information about where to store the data, so
that it the device can do so most effiently. If an application is
managing and writing data with different life times, mixing differently
retentioned data onto the same locations on flash can cause write
amplification to grow. This, in turn, will reduce performance and life
time of the device.

We default to allocating 4 streams, controller wide, so we can use them
on all name spaces. This is configurable with the 'streams' module
parameter. If a write stream is set in a write, flag is as such before
sending it to the device.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 170 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |   4 ++
 include/linux/nvme.h     |  48 +++++++++++++
 3 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d5813023a..637e9514b406 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -65,6 +65,10 @@ static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
 
+static char streams = 4;
+module_param(streams, byte, 0644);
+MODULE_PARM_DESC(streams, "if available, allocate this many streams");
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -330,10 +334,125 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 
 	return BLK_MQ_RQ_QUEUE_OK;
 }
+/*
+
+ * Returns number of streams allocated for use by, or -1 on error.
+ */
+static int nvme_streams_allocate(struct nvme_ctrl *ctrl, unsigned int nstreams)
+{
+	struct nvme_command c;
+	union nvme_result res;
+	int ret;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(0xffffffff);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_RESOURCE;
+	c.directive.dtype = NVME_DIR_STREAMS;
+	c.directive.endir = nstreams;
+
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res, NULL, 0, 0,
+					NVME_QID_ANY, 0, 0);
+	if (ret)
+		return -1;
+
+	return le32_to_cpu(res.u32) & 0xffff;
+}
+
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
+static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
+				  struct streams_directive_params *s, u32 nsid)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	memset(s, 0, sizeof(*s));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(nsid);
+	c.directive.numd = sizeof(*s);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
+	c.directive.dtype = NVME_DIR_STREAMS;
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, s, sizeof(*s));
+}
+
+static int nvme_setup_directives(struct nvme_ctrl *ctrl)
+{
+	struct streams_directive_params s;
+	int ret;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
+		return 0;
+	if (!streams)
+		return 0;
+
+	ret = nvme_enable_streams(ctrl);
+	if (ret)
+		return ret;
+
+	ret = nvme_get_stream_params(ctrl, &s, 0xffffffff);
+	if (ret)
+		return ret;
+
+	ctrl->nssa = le16_to_cpu(s.nssa);
+
+	ret = nvme_streams_allocate(ctrl, min_t(unsigned, streams, ctrl->nssa));
+	if (ret < 0)
+		return ret;
+
+	ctrl->nr_streams = ret;
+	dev_info(ctrl->device, "successfully enabled %d streams\n", ret);
+	return 0;
+}
+
+/*
+ * Check if 'req' has a write hint associated with it. If it does, assign
+ * a valid namespace stream to the write. If we haven't setup streams yet,
+ * kick off configuration and ignore the hints until that has completed.
+ */
+static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
+				     struct request *req, u16 *control,
+				     u32 *dsmgmt)
+{
+	enum rw_hint streamid;
+
+	streamid = (req->cmd_flags & REQ_WRITE_LIFE_MASK)
+			>> __REQ_WRITE_HINT_SHIFT;
+	if (streamid == WRITE_LIFE_NONE)
+		return;
+
+	/* for now just round-robin, do something more clever later */
+	if (streamid > ctrl->nr_streams)
+		streamid = (streamid % ctrl->nr_streams) + 1;
+
+	if (streamid < ARRAY_SIZE(req->q->write_hints))
+		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
+
+	*control |= NVME_RW_DTYPE_STREAMS;
+	*dsmgmt |= streamid << 16;
+}
 
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -351,6 +470,9 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
+		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
+
 	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
@@ -985,14 +1107,23 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 
 static void nvme_config_discard(struct nvme_ns *ns)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
+	struct nvme_ctrl *ctrl = ns->ctrl;
 
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	ns->queue->limits.discard_alignment = logical_block_size;
-	ns->queue->limits.discard_granularity = logical_block_size;
+	if (ctrl->nr_streams && ns->sws && ns->sgs) {
+		unsigned int sz = logical_block_size * ns->sws * ns->sgs;
+
+		ns->queue->limits.discard_alignment = sz;
+		ns->queue->limits.discard_granularity = sz;
+	} else {
+		u32 logical_block_size = queue_logical_block_size(ns->queue);
+
+		ns->queue->limits.discard_alignment = logical_block_size;
+		ns->queue->limits.discard_granularity = logical_block_size;
+	}
 	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
 	blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
@@ -1024,6 +1155,7 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 bs;
 
 	/*
@@ -1037,7 +1169,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 	blk_mq_freeze_queue(disk->queue);
 
-	if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
+	if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
 		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
@@ -1047,7 +1179,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
-	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
 }
@@ -1650,6 +1782,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
+	nvme_setup_directives(ctrl);
 
 	ctrl->identified = true;
 
@@ -2019,6 +2152,32 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	return ret;
 }
 
+static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	struct streams_directive_params s;
+	int ret;
+
+	if (!ctrl->nr_streams)
+		return 0;
+
+	ret = nvme_get_stream_params(ctrl, &s, ns->ns_id);
+	if (ret)
+		return ret;
+
+	ns->sws = le32_to_cpu(s.sws);
+	ns->sgs = le16_to_cpu(s.sgs);
+
+	if (ns->sws) {
+		unsigned int bs = 1 << ns->lba_shift;
+
+		blk_queue_io_min(ns->queue, bs * ns->sws);
+		if (ns->sgs)
+			blk_queue_io_opt(ns->queue, bs * ns->sws * ns->sgs);
+	}
+
+	return 0;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -2048,6 +2207,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
+	nvme_setup_streams_ns(ctrl, ns);
 
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..533f86acd961 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -147,6 +147,8 @@ struct nvme_ctrl {
 	u16 oncs;
 	u16 vid;
 	u16 oacs;
+	u16 nssa;
+	u16 nr_streams;
 	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
@@ -194,6 +196,8 @@ struct nvme_ns {
 	unsigned ns_id;
 	int lba_shift;
 	u16 ms;
+	u16 sgs;
+	u32 sws;
 	bool ext;
 	u8 pi_type;
 	unsigned long flags;
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
