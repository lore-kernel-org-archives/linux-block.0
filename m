Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] nvme: add support for streams and directives
Date: Wed, 14 Jun 2017 13:05:34 -0600
Message-Id: <1497467134-6323-12-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
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
is set in a write, flag is as such before sending it to the device.

Some debug stuff in this patch, dumping streams ID params when
we load nvme.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   1 +
 include/linux/nvme.h     |  48 ++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d5813023a..a389d62a528b 100644
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
 
@@ -331,9 +335,34 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
+static unsigned int nvme_get_write_stream(struct nvme_ns *ns,
+					  struct request *req)
+{
+	unsigned int streamid = 0;
+
+	if (req_op(req) != REQ_OP_WRITE || !blk_stream_valid(req->cmd_flags) ||
+	    !ns->nr_streams)
+		return 0;
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
+	if (streamid < BLK_MAX_STREAM)
+		req->q->stream_writes[streamid] += blk_rq_bytes(req) >> 9;
+
+	return (streamid % (ns->nr_streams + 1));
+}
+
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
+	unsigned int stream;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -351,6 +380,12 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	stream = nvme_get_write_stream(ns, req);
+	if (stream) {
+		control |= NVME_RW_DTYPE_STREAMS;
+		dsmgmt |= (stream << 16);
+	}
+
 	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
@@ -1073,6 +1108,109 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	return 0;
 }
 
+static int nvme_enable_streams(struct nvme_ns *ns)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_send;
+	c.directive.nsid = cpu_to_le32(ns->ns_id);
+	c.directive.doper = NVME_DIR_SND_ID_OP_ENABLE;
+	c.directive.dtype = NVME_DIR_IDENTIFY;
+	c.directive.tdtype = NVME_DIR_STREAMS;
+	c.directive.endir = NVME_DIR_ENDIR;
+
+	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
+}
+
+static int nvme_streams_params(struct nvme_ns *ns)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct streams_directive_params s;
+	struct nvme_command c;
+	int ret;
+
+	memset(&c, 0, sizeof(c));
+	memset(&s, 0, sizeof(s));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(ns->ns_id);
+	c.directive.numd = sizeof(s);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
+	c.directive.dtype = NVME_DIR_STREAMS;
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, &s, sizeof(s));
+	if (ret)
+		return ret;
+
+	s.msl = le16_to_cpu(s.msl);
+	s.nssa = le16_to_cpu(s.nssa);
+	s.nsso = le16_to_cpu(s.nsso);
+	s.sws = le32_to_cpu(s.sws);
+	s.sgs = le16_to_cpu(s.sgs);
+	s.nsa = le16_to_cpu(s.nsa);
+	s.nso = le16_to_cpu(s.nso);
+
+	dev_info(ctrl->device, "streams: msl=%u, nssa=%u, nsso=%u, sws=%u "
+				"sgs=%u, nsa=%u, nso=%u\n", s.msl, s.nssa,
+				s.nsso, s.sws, s.sgs, s.nsa, s.nso);
+	return 0;
+}
+
+static int nvme_streams_allocate(struct nvme_ns *ns, unsigned int streams)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+
+	c.directive.opcode = nvme_admin_directive_recv;
+	c.directive.nsid = cpu_to_le32(ns->ns_id);
+	c.directive.doper = NVME_DIR_RCV_ST_OP_RESOURCE;
+	c.directive.dtype = NVME_DIR_STREAMS;
+	c.directive.endir = streams;
+
+	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
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
+static void nvme_config_streams(struct nvme_ns *ns)
+{
+	int ret;
+
+	ret = nvme_enable_streams(ns);
+	if (ret)
+		return;
+
+	ret = nvme_streams_params(ns);
+	if (ret)
+		return;
+
+	ret = nvme_streams_allocate(ns, streams_per_ns);
+	if (ret)
+		return;
+
+	ret = nvme_streams_params(ns);
+	if (ret)
+		return;
+
+	ns->nr_streams = streams_per_ns;
+	dev_info(ns->ctrl->device, "successfully enabled streams\n");
+}
+
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -1606,6 +1744,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 
+	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
+		dev_info(ctrl->dev, "supports directives\n");
+
 	ctrl->npss = id->npss;
 	prev_apsta = ctrl->apsta;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
@@ -2060,6 +2201,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_id;
 	}
 
+	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
+		nvme_config_streams(ns);
+
 	disk = alloc_disk_node(0, node);
 	if (!disk)
 		goto out_free_id;
@@ -2112,6 +2256,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 					&nvme_ns_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
+		if (ns->nr_streams)
+			nvme_streams_deallocate(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..dc87c8284259 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -192,6 +192,7 @@ struct nvme_ns {
 	u8 uuid[16];
 
 	unsigned ns_id;
+	unsigned nr_streams;
 	int lba_shift;
 	u16 ms;
 	bool ext;
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
