Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:21:49 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 01/10] Initial multipath implementation.
Message-ID: <20170912042149.drr5dumro5grm7iu@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

This is intial implementation on multipath functionality. It is based on design that we will not change relation between nvme namespace and nvme controller. We added new request pool in controller structure to generate private structure for book keeping all IO transaction between multipath head device and child devices. It also has reference to  multipath head namespace and sibling controller have reference to head controller. As every controller maintain list of namespaces associated with it, multipath controller maintain list of sibling name spaces associated to it using mpathlist. The namespace structure also support  active passive mulitpath namespace connection using active flag. There is start_time flag in nvme namespace structure to check for any time restriction between consecutive failover back to any given namespace. There is congestion bio list per multipath device which is to store the bio when failover is in progress.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/nvme.h | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8f2a168..2e7d50e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,8 +27,14 @@ extern unsigned char nvme_io_timeout;
 extern unsigned char admin_timeout;
 #define ADMIN_TIMEOUT	(admin_timeout * HZ)
 
+extern unsigned char mpath_io_timeout;
+#define MPATH_IO_TIMEOUT   (mpath_io_timeout * HZ)
+
+extern unsigned int ns_failover_interval;
+#define NS_FAILOVER_INTERVAL   (ns_failover_interval * HZ)
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
+#define NVME_NS_ACTIVE_TIMEOUT  1
 
 extern struct workqueue_struct *nvme_wq;
 
@@ -168,6 +174,7 @@ struct nvme_ctrl {
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 
+	struct work_struct failover_work;
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
@@ -183,6 +190,17 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+	struct kmem_cache *mpath_req_slab;
+	char mpath_req_cache_name[16];
+	mempool_t *mpath_req_pool;
+#define NVME_CTRL_MULTIPATH 0
+#define NVME_CTRL_MPATH_CHILD 1
+	unsigned long flags;
+	unsigned int  cleanup_done;
+	void *mpath_ctrl;
+	struct delayed_work cleanup_work;
+	struct list_head mpath_namespace;
+	struct delayed_work cu_work;
 };
 
 struct nvme_ns {
@@ -211,9 +229,21 @@ struct nvme_ns {
 
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
-
+#define NVME_NS_MULTIPATH      2
+#define NVME_NS_ROOT           3
+#define NVME_NS_FO_IN_PROGRESS 4
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
+	struct nvme_ctrl *mpath_ctrl;
+	int active;
+	u8 nmic;
+	struct block_device *bdev;
+	wait_queue_head_t fq_full;
+	wait_queue_entry_t fq_cong_wait;
+	struct bio_list fq_cong;
+	unsigned long start_time;
+	struct list_head mpathlist;
+	u8 mpath_nguid[16];
 };
 
 struct nvme_ctrl_ops {
@@ -277,6 +307,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
+struct nvme_ctrl *nvme_init_mpath_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
@@ -287,6 +318,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_trigger_failover(struct nvme_ctrl *ctrl);
+int nvme_set_ns_active(struct nvme_ns *standby_ns, struct nvme_ns *mpath_ns,
+		int retry_cnt);
 
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
@@ -325,6 +359,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
+void nvme_mpath_ns_remove(struct nvme_ns *ns);
 
 #ifdef CONFIG_NVM
 int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);
-- 
2.9.3
