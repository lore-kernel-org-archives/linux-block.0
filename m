Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:22:54 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 03/10] Failover timeout and time between failover same ns.
Message-ID: <20170912042254.qbmbojaifl7roxsu@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Module load parameters for failover timeout and timeout between two failover on same target. This will take care of failover not being caused due to link flapping activity. The nvme_mpath_priv data structure does the book keeping of the bio data in case when IO failure happens and bio data needs to be reset to initial state for an IO to new path.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37046ac..934548a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -28,6 +28,7 @@
 #include <linux/t10-pi.h>
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
+#include <linux/kthread.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -68,14 +69,63 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+unsigned char mpath_io_timeout = 60;
+module_param(mpath_io_timeout, byte, 0644);
+MODULE_PARM_DESC(mpath_io_timeout, "timeout in seconds for multipath IO");
+EXPORT_SYMBOL_GPL(mpath_io_timeout);
+
+unsigned int ns_failover_interval = 60;
+module_param_named(failover_interval, ns_failover_interval, uint, 0644);
+MODULE_PARM_DESC(failover_interval,
+		 "Minimum internval in secs to fallback on same namespace during multipath.");
+EXPORT_SYMBOL_GPL(ns_failover_interval);
+
 struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
 
+#define NVME_MPATH_NS_AVAIL	0
+#define NVME_NO_MPATH_NS_AVAIL	1
+
+#define NVME_MAX_MPATH_PRIV	4096  /* This number suppport IO depth of 128 for upto 32 Queue per controller.*/
+
+static LIST_HEAD(nvme_mpath_ctrl_list);
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
+static struct task_struct *nvme_mpath_thread;
+static wait_queue_head_t nvme_mpath_kthread_wait;
+static void nvme_mpath_flush_io_work(struct work_struct *work);
+
 static struct class *nvme_class;
 
+struct nvme_mpath_priv {
+	struct nvme_ns *ns;
+	struct nvme_ns *mpath_ns;
+	struct block_device *bi_bdev;
+	unsigned long bi_flags;
+	sector_t bi_sector;
+	unsigned short bi_idx;
+	unsigned short bi_vcnt;
+	unsigned int bi_phys_segments;
+	void  *bi_private;
+	size_t nr_bytes;
+	struct bio *bio;
+	struct bio_vec *bvec;
+	bio_end_io_t *bi_end_io;
+	int nr_retries;
+	unsigned long start_time;
+	struct hd_struct *part;
+};
+
+struct nvme_failover_data {
+	struct nvme_ns *standby_ns;
+	struct nvme_ns *active_ns;
+	struct nvme_ns *mpath_ns;
+	int retries;
+};
+
+
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
-- 
2.9.3
