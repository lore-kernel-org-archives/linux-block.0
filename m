Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E42FC4707E
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769A8613EB
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhEUUXN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUUXM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:23:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D7B1613AD;
        Fri, 21 May 2021 20:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621628509;
        bh=s5R8liv2e9b+NMC/W3KpvbN+ScdQ20DcEYaDuNm+xiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgL0ooJQj5zqO/8hV6c6qCzytHsFlK3dnPiYAyBEBOckDuBmbS198Ngk8NmIRqgL9
         GEpQVjWBNjpHgk12UeWL+uMnyOSm9ZQZdpfQiqP7Y9sgbneH4vHIQiWAGEyrVYv3HT
         LKxPreY+PxNetUFH8F6Vj8OEZ6eGpPjSVxZSDm3UDugRw3OQ8eUa2CzVcHRBVtBK5I
         NmltgbHeZSgsRv3xpXBSBGLk0/4R90e28aS32hqtoEJRKC//aL6+ejrqlq+OjVovDi
         OY9mo1gJZ45rmv03b5p+qWVu2IAY5Yy3BGpQHmcDHQ6XtUnB/q1qTOJaEUCV23Ztrn
         Osrw7mAHtSJmA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Date:   Fri, 21 May 2021 13:21:43 -0700
Message-Id: <20210521202145.3674904-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The generic blk_execute_rq() knows how to handle polled completions. Use
that instead of implementing an nvme specific handler.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
No changes since v2

 drivers/nvme/host/core.c    | 38 +++++--------------------------------
 drivers/nvme/host/fabrics.c | 13 ++++++-------
 drivers/nvme/host/fabrics.h |  2 +-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    |  3 +--
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 8 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 762125f2905f..1a73eed61eee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1012,31 +1012,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
-static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
-{
-	struct completion *waiting = rq->end_io_data;
-
-	rq->end_io_data = NULL;
-	complete(waiting);
-}
-
-static void nvme_execute_rq_polled(struct request_queue *q,
-		struct gendisk *bd_disk, struct request *rq, int at_head)
-{
-	DECLARE_COMPLETION_ONSTACK(wait);
-
-	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
-
-	rq->cmd_flags |= REQ_HIPRI;
-	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
-
-	while (!completion_done(&wait)) {
-		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
-		cond_resched();
-	}
-}
-
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -1044,7 +1019,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll)
+		blk_mq_req_flags_t flags)
 {
 	struct request *req;
 	int ret;
@@ -1065,10 +1040,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	if (poll)
-		nvme_execute_rq_polled(req->q, NULL, req, at_head);
-	else
-		blk_execute_rq(NULL, req, at_head);
+	blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -1085,7 +1057,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1449,7 +1421,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
+			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2048,7 +2020,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len, 0,
-			NVME_QID_ANY, 1, 0, false);
+			NVME_QID_ANY, 1, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a2bb7fc63a73..133ef9a62f53 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -151,7 +151,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -198,7 +198,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -396,7 +396,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -420,7 +420,6 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  * @qid:	NVMe I/O queue number for the new I/O connection between
  *		host and target (note qid == 0 is illegal as this is
  *		the Admin queue, per NVMe standard).
- * @poll:	Whether or not to poll for the completion of the connect cmd.
  *
  * This function issues a fabrics-protocol connection
  * of a NVMe I/O queue (via NVMe Fabrics "Connect" command)
@@ -432,7 +431,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 {
 	struct nvme_command cmd;
 	struct nvmf_connect_data *data;
@@ -459,7 +458,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index d7f7974dc208..b698a3e5cb35 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -178,7 +178,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll);
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d9ab9e7871d0..e4495ee55552 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2346,7 +2346,7 @@ nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 					(qsize / 5));
 		if (ret)
 			break;
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			break;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0015860ec12b..84bff995a308 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -658,7 +658,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll);
+		blk_mq_req_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37943dc4c2c1..36c018762701 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -680,11 +680,10 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 {
 	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
-	bool poll = nvme_rdma_poll_queue(queue);
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, poll);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d07eb13d8713..f18e2beceed1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1559,7 +1559,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx, false);
+		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
 		ret = nvmf_connect_admin_queue(nctrl);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 74b3b150e1a5..9718c06abe38 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -335,7 +335,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			return ret;
 		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
-- 
2.25.4

