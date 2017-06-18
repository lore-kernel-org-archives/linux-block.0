Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:23 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 09/30] nvme: Move queue_count to the nvme_ctrl
Date: Sun, 18 Jun 2017 18:21:43 +0300
Message-Id: <1497799324-19598-10-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We are trying to move queues setup and teardown
to the core, introduce also ctrl max queues which
will tell us what is the maximum number of queues
allowed. For now just rdma, the rest will follow.

queue_count was replaced with sed
s/ctrl->queue_count/ctrl->ctrl.queue_count/g

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c | 47 ++++++++++++++++++++++-------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 67147b49d992..415a5ea4759c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -142,6 +142,8 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
+	u32 max_queues;
+	u32 queue_count;
 
 	u32 page_size;
 	u32 max_hw_sectors;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 099b3d7b6721..2b23f88bedfe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -104,7 +104,6 @@ struct nvme_rdma_queue {
 struct nvme_rdma_ctrl {
 	/* read only in the hot path */
 	struct nvme_rdma_queue	*queues;
-	u32			queue_count;
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
@@ -353,7 +352,7 @@ static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_rdma_ctrl *ctrl = data;
 	struct nvme_rdma_queue *queue = &ctrl->queues[hctx_idx + 1];
 
-	BUG_ON(hctx_idx >= ctrl->queue_count);
+	BUG_ON(hctx_idx >= ctrl->ctrl.max_queues);
 
 	hctx->driver_data = queue;
 	return 0;
@@ -587,7 +586,7 @@ static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i;
 
-	for (i = 1; i < ctrl->queue_count; i++)
+	for (i = 1; i < ctrl->ctrl.queue_count; i++)
 		nvme_rdma_free_queue(ctrl, i);
 }
 
@@ -595,7 +594,7 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i;
 
-	for (i = 1; i < ctrl->queue_count; i++)
+	for (i = 1; i < ctrl->ctrl.queue_count; i++)
 		nvme_rdma_stop_queue(ctrl, i);
 }
 
@@ -629,7 +628,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i, ret = 0;
 
-	for (i = 1; i < ctrl->queue_count; i++) {
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_start_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
@@ -647,13 +646,11 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues = ctrl->ctrl.max_queues - 1;
 	struct ib_device *ibdev = ctrl->device->dev;
-	unsigned int nr_io_queues;
 	int i, ret;
 
-	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
-
+	nr_io_queues = min(nr_io_queues, num_online_cpus());
 	/*
 	 * we map queues according to the device irq vectors for
 	 * optimal locality so we don't need more queues than
@@ -666,14 +663,14 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ctrl->queue_count = nr_io_queues + 1;
-	if (ctrl->queue_count < 2)
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
+	if (ctrl->ctrl.queue_count < 2)
 		return 0;
 
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-	for (i = 1; i < ctrl->queue_count; i++) {
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_alloc_queue(ctrl, i,
 				ctrl->ctrl.sqsize + 1);
 		if (ret)
@@ -715,7 +712,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		ctrl->tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
 			SG_CHUNK_SIZE * sizeof(struct scatterlist);
 		ctrl->tag_set.driver_data = ctrl;
-		ctrl->tag_set.nr_hw_queues = ctrl->queue_count - 1;
+		ctrl->tag_set.nr_hw_queues = ctrl->ctrl.max_queues - 1;
 		ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
 
 		ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
@@ -925,7 +922,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->ctrl.opts->nr_io_queues)
+	if (ctrl->ctrl.max_queues > 1)
 		nvme_rdma_destroy_io_queues(ctrl, false);
 
 	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -934,7 +931,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	if (ctrl->ctrl.opts->nr_io_queues) {
+	if (ctrl->ctrl.max_queues > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
@@ -961,15 +958,15 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 
-	for (i = 0; i < ctrl->queue_count; i++)
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
 		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 
-	if (ctrl->queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
-	if (ctrl->queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1)
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
@@ -1729,7 +1726,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
-	if (ctrl->ctrl.opts->nr_io_queues) {
+	if (ctrl->ctrl.max_queues > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
@@ -1797,7 +1794,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto out_destroy_admin;
 
-	if (ctrl->ctrl.opts->nr_io_queues) {
+	if (ctrl->ctrl.max_queues > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto out_destroy_io;
@@ -1806,7 +1803,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	if (ctrl->queue_count > 1) {
+	if (ctrl->ctrl.queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
 		nvme_queue_async_events(&ctrl->ctrl);
@@ -1884,12 +1881,12 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.max_queues = opts->nr_io_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
-	ctrl->queues = kcalloc(ctrl->queue_count, sizeof(*ctrl->queues),
+	ctrl->queues = kcalloc(ctrl->ctrl.max_queues, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
@@ -1928,7 +1925,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		opts->queue_size = ctrl->ctrl.sqsize + 1;
 	}
 
-	if (opts->nr_io_queues) {
+	if (ctrl->ctrl.max_queues > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, true);
 		if (ret)
 			goto out_remove_admin_queue;
@@ -1946,7 +1943,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	if (opts->nr_io_queues) {
+	if (ctrl->ctrl.max_queues > 1) {
 		nvme_queue_scan(&ctrl->ctrl);
 		nvme_queue_async_events(&ctrl->ctrl);
 	}
-- 
2.7.4
