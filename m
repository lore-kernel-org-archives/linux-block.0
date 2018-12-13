Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD7C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08320811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7TKE6Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE08320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeLMVeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:34:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeLMVeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=38sEy+G4G9ArGYJ3B4IT6rYIhWAn9rGtIETJZfIEphI=; b=k7TKE6Kw2vTrkm95CryGiYLoI
        WhAsItmwDl3VLc872Ycqm7aMfCPqX8tj6n0UHcYwJwLnwuhSRxkOG2stXAG+uR02HJbE+1wK29ZCq
        +GxLlAsXR097B23vYIZuZwxQOlnLIwAuMET8QEn81KV1S6lNmAsu/8RSWLwkJVofV+YvoX0M8OVuJ
        n5OhIBYnvPpomMGVK/QfZLpgEZxu/3qOmwdlN1ChEHe4uGlz6cHwUMPV0Z1JihYU/VJxKvYZJVvHr
        78TtU8EkHDSbRDhFV/NrB3f6TpJoShz3UCZxFUrtCwQKQ6UFvqqa4nrjvu8iiETBZzqVmFL/7MvxX
        bJFqw6LAg==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXYcZ-0002ho-C5; Thu, 13 Dec 2018 21:34:15 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 6/6] nvme-rdma: implement polling queue map
Date:   Thu, 13 Dec 2018 13:34:10 -0800
Message-Id: <20181213213410.9841-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213213410.9841-1-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When passed with nr_poll_queues setup additional queues with cq polling
context IB_POLL_DIRECT (no interrupts) and make sure to set
QUEUE_FLAG_POLL on the connect_q. In addition add the third queue
mapping for polling queues.

nvmf connect on this queue is polled for like all other requests so make
nvmf_connect_io_queue poll for polling queues.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 58 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b907ed43814f..80b3113b45fb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -162,6 +162,13 @@ static inline int nvme_rdma_queue_idx(struct nvme_rdma_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+static bool nvme_rdma_poller_queue(struct nvme_rdma_queue *queue)
+{
+	return nvme_rdma_queue_idx(queue) >
+		queue->ctrl->ctrl.opts->nr_io_queues +
+		queue->ctrl->ctrl.opts->nr_write_queues;
+}
+
 static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
 {
 	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
@@ -440,6 +447,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	const int send_wr_factor = 3;			/* MR, SEND, INV */
 	const int cq_factor = send_wr_factor + 1;	/* + RECV */
 	int comp_vector, idx = nvme_rdma_queue_idx(queue);
+	enum ib_poll_context poll_ctx;
 	int ret;
 
 	queue->device = nvme_rdma_find_get_device(queue->cm_id);
@@ -456,10 +464,16 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	 */
 	comp_vector = idx == 0 ? idx : idx - 1;
 
+	/* Polling queues need direct cq polling context */
+	if (nvme_rdma_poller_queue(queue))
+		poll_ctx = IB_POLL_DIRECT;
+	else
+		poll_ctx = IB_POLL_SOFTIRQ;
+
 	/* +1 for ib_stop_cq */
 	queue->ib_cq = ib_alloc_cq(ibdev, queue,
 				cq_factor * queue->queue_size + 1,
-				comp_vector, IB_POLL_SOFTIRQ);
+				comp_vector, poll_ctx);
 	if (IS_ERR(queue->ib_cq)) {
 		ret = PTR_ERR(queue->ib_cq);
 		goto out_put_dev;
@@ -595,15 +609,17 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 {
+	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
+	bool poll = nvme_rdma_poller_queue(queue);
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, false);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, poll);
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
 	if (!ret)
-		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[idx].flags);
+		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	else
 		dev_info(ctrl->ctrl.device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
@@ -646,6 +662,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 				ibdev->num_comp_vectors);
 
 	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
+	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
@@ -716,7 +733,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
-		set->nr_maps = 2 /* default + read */;
+		set->nr_maps = HCTX_MAX_TYPES;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -864,6 +881,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
+
+		if (ctrl->ctrl.opts->nr_poll_queues)
+			blk_queue_flag_set(QUEUE_FLAG_POLL,
+				ctrl->ctrl.connect_q);
 	} else {
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
 			ctrl->ctrl.queue_count - 1);
@@ -1742,6 +1763,14 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_rdma_queue *queue = hctx->driver_data;
+	struct ib_cq *cq = queue->ib_cq;
+
+	return ib_process_cq_direct(cq, -1);
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1772,6 +1801,21 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->device->dev, 0);
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
 			ctrl->device->dev, 0);
+
+	if (ctrl->ctrl.opts->nr_poll_queues) {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_poll_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset =
+				ctrl->ctrl.opts->nr_io_queues;
+		if (ctrl->ctrl.opts->nr_write_queues)
+			set->map[HCTX_TYPE_POLL].queue_offset +=
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	return 0;
 }
 
@@ -1783,6 +1827,7 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_hctx	= nvme_rdma_init_hctx,
 	.timeout	= nvme_rdma_timeout,
 	.map_queues	= nvme_rdma_map_queues,
+	.poll		= nvme_rdma_poll,
 };
 
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
@@ -1927,7 +1972,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
+				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -1979,7 +2025,7 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
-			  NVMF_OPT_NR_WRITE_QUEUES,
+			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
2.17.1

