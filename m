Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 9/9] nvme: add support for streams and directives
Date: Mon, 26 Jun 2017 09:38:00 -0600
Message-Id: <1498491480-16306-10-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This adds support for Directives in NVMe, particular for the Streams
directive. Support for Directives is a new feature in NVMe 1.3. It
allows a user to pass in information about where to store the data, so
that it the device can do so most effiently. If an application is
managing and writing data with different life times, mixing differently
retentioned data onto the same locations on flash can cause write
amplification to grow. This, in turn, will reduce performance and life
time of the device.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 148 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |   4 ++
 include/linux/nvme.h     |  48 +++++++++++++++
 3 files changed, 196 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aee37b73231d..2d9835617953 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -65,6 +65,10 @@ static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
 
+static bool streams;
+module_param(streams, bool, 0644);
+MODULE_PARM_DESC(stream, "turn on support for Streams write directives");
+
 struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
 
@@ -297,6 +301,102 @@ struct request *nvme_alloc_request(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
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
+static int nvme_configure_directives(struct nvme_ctrl *ctrl)
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
+	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
+	return 0;
+}
+
+/*
+ * Write hint number to stream mappings
+ */
+static const unsigned int stream_mappings[BLK_MAX_WRITE_HINTS][BLK_MAX_WRITE_HINTS] = {
+	/* 0 or 1 stream, we don't use streams */
+	{ 0, },
+	{ 0, },
+	/* collapse short+medium to short, and long+extreme to medium */
+	{ WRITE_LIFE_NONE, WRITE_LIFE_SHORT, WRITE_LIFE_SHORT,
+		WRITE_LIFE_MEDIUM, WRITE_LIFE_MEDIUM },
+	/* collapse long+extreme to long */
+	{ WRITE_LIFE_NONE, WRITE_LIFE_SHORT, WRITE_LIFE_MEDIUM,
+		WRITE_LIFE_LONG, WRITE_LIFE_LONG },
+	/* 4 streams, no collapsing needed */
+	{ WRITE_LIFE_NONE, WRITE_LIFE_SHORT, WRITE_LIFE_MEDIUM,
+		WRITE_LIFE_LONG, WRITE_LIFE_EXTREME },
+};
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
+	streamid = opf_to_write_hint(req->cmd_flags);
+	if (streamid != WRITE_LIFE_NONE) {
+		streamid = stream_mappings[ctrl->nr_streams][streamid - 1];
+		*control |= NVME_RW_DTYPE_STREAMS;
+		*dsmgmt |= streamid << 16;
+	}
+
+	if (streamid < ARRAY_SIZE(req->q->write_hints))
+		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
+}
+
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
@@ -348,6 +448,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -375,6 +476,9 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
+		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
+
 	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
@@ -1094,8 +1198,15 @@ static void nvme_config_discard(struct nvme_ns *ns)
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
+		ns->queue->limits.discard_alignment = logical_block_size;
+		ns->queue->limits.discard_granularity = logical_block_size;
+	}
 	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
 	blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
@@ -1135,6 +1246,7 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 bs;
 
 	/*
@@ -1149,7 +1261,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 	blk_mq_freeze_queue(disk->queue);
 
-	if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
+	if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
 		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
 	if (ns->noiob)
@@ -1161,7 +1273,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
-	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
 }
@@ -1766,6 +1878,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
+	nvme_configure_directives(ctrl);
 
 	ctrl->identified = true;
 
@@ -2158,6 +2271,32 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -2187,6 +2326,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
+	nvme_setup_streams_ns(ctrl, ns);
 
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ec8c7363934d..f616835afc4c 100644
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
@@ -199,6 +201,8 @@ struct nvme_ns {
 	unsigned ns_id;
 	int lba_shift;
 	u16 ms;
+	u16 sgs;
+	u32 sws;
 	bool ext;
 	u8 pi_type;
 	unsigned long flags;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 291587a0743f..f516a975bb21 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -253,6 +253,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
 };
 
@@ -304,6 +305,19 @@ enum {
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
@@ -560,6 +574,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
+	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
 struct nvme_dsm_cmd {
@@ -634,6 +649,8 @@ enum nvme_admin_opcode {
 	nvme_admin_download_fw		= 0x11,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
+	nvme_admin_directive_send	= 0x19,
+	nvme_admin_directive_recv	= 0x1a,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -797,6 +814,24 @@ struct nvme_get_log_page_command {
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
@@ -927,6 +962,18 @@ struct nvme_dbbuf {
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
@@ -947,6 +994,7 @@ struct nvme_command {
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
 		struct nvme_dbbuf dbbuf;
+		struct nvme_directive_cmd directive;
 	};
 };
 
-- 
2.7.4
