Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA0C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 02:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EC5611C0
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 02:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDZCx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Apr 2021 22:53:57 -0400
Received: from mail.synology.com ([211.23.38.101]:59696 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhDZCx5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 22:53:57 -0400
Received: from localhost.localdomain (unknown [10.17.32.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 00A5DCE78097;
        Mon, 26 Apr 2021 10:53:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1619405595; bh=dVx9faadfusiKGT3NWzUGZglxAEAUfwUfk8yVdfbifU=;
        h=From:To:Cc:Subject:Date;
        b=Jmua+9b+Hpz+1gZT+agm/MOTDfPOODRISpr4uhK5gAuE9OwX1ZbHUaG38KgRONMvO
         VBYKWfjzfcmTMekA5wPXeVw4UZZZOwJYp0YUgpoqVXyBseGkQmmoiW1CVouejXCkh7
         CyHNj80Lg0bRezn1YVQhhr0BWVhJgSP/NZK6UvLA=
From:   taochiu <taochiu@synology.com>
To:     hch@lst.de, chaitanya.kulkarni@wdc.com, kbusch@kernel.org,
        axboe@fb.com, sagi@grimberg.me, james.smart@broadcom.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Tao Chiu <taochiu@synology.com>,
        Cody Wong <codywong@synology.com>,
        Leon Chien <leonchien@synology.com>
Subject: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines to core
Date:   Mon, 26 Apr 2021 10:53:10 +0800
Message-Id: <20210426025310.3005573-1-taochiu@synology.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tao Chiu <taochiu@synology.com>

queue_rq() in pci only checks if the dispatched queue (nvmeq) is ready,
e.g. not being suspended. Since nvme_alloc_admin_tags() in reset flow
restarts the admin queue, users are able to submit admin commands to a
controller before reset_work() completes. Commands submitted under this
condition may interfere with commands that performs identify, IO queue
setup in reset_work(), and may result in a hang described in the
following patch.

As seen in the fabrics, user commands are prevented from being executed
under inproper controller states. We may reuse this logic to maintain a
clear admin queue during reset_work().

Signed-off-by: Tao Chiu <taochiu@synology.com>
Signed-off-by: Cody Wong <codywong@synology.com>
Reviewed-by: Leon Chien <leonchien@synology.com>
---
 drivers/nvme/host/core.c    | 60 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.c | 57 -----------------------------------
 drivers/nvme/host/fabrics.h | 13 --------
 drivers/nvme/host/fc.c      |  4 +--
 drivers/nvme/host/nvme.h    | 15 ++++++++++
 drivers/nvme/host/rdma.c    |  4 +--
 drivers/nvme/host/tcp.c     |  4 +--
 drivers/nvme/target/loop.c  |  4 +--
 8 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40f08e6325ef..4fe8919aae53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -633,6 +633,66 @@ static struct request *nvme_alloc_request_qid(struct request_queue *q,
 	return req;
 }
 
+/*
+ * For something we're not in a state to send to the device the default action
+ * is to busy it and retry it after the controller state is recovered.  However,
+ * if the controller is deleting or if anything is marked for failfast or
+ * nvme multipath it is immediately failed.
+ *
+ * Note: commands used to initialize the controller will be marked for failfast.
+ * Note: nvme cli/ioctl commands are marked for failfast.
+ */
+blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
+		struct request *rq)
+{
+	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
+	    ctrl->state != NVME_CTRL_DEAD &&
+	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
+	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
+		return BLK_STS_RESOURCE;
+	return nvme_host_path_error(rq);
+}
+EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
+
+bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+		bool queue_live)
+{
+	struct nvme_request *req = nvme_req(rq);
+
+	/*
+	 * currently we have a problem sending passthru commands
+	 * on the admin_q if the controller is not LIVE because we can't
+	 * make sure that they are going out after the admin connect,
+	 * controller enable and/or other commands in the initialization
+	 * sequence. until the controller will be LIVE, fail with
+	 * BLK_STS_RESOURCE so that they will be rescheduled.
+	 */
+	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
+		return false;
+
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		/*
+		 * Only allow commands on a live queue, except for the connect
+		 * command, which is require to set the queue live in the
+		 * appropinquate states.
+		 */
+		switch (ctrl->state) {
+		case NVME_CTRL_CONNECTING:
+			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
+			    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
+				return true;
+			break;
+		default:
+			break;
+		case NVME_CTRL_DEAD:
+			return false;
+		}
+	}
+
+	return queue_live;
+}
+EXPORT_SYMBOL_GPL(__nvme_check_ready);
+
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
 	struct nvme_command c;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..9e1b195d8b03 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -535,63 +535,6 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 	return NULL;
 }
 
-/*
- * For something we're not in a state to send to the device the default action
- * is to busy it and retry it after the controller state is recovered.  However,
- * if the controller is deleting or if anything is marked for failfast or
- * nvme multipath it is immediately failed.
- *
- * Note: commands used to initialize the controller will be marked for failfast.
- * Note: nvme cli/ioctl commands are marked for failfast.
- */
-blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
-		struct request *rq)
-{
-	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
-	    ctrl->state != NVME_CTRL_DEAD &&
-	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
-	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
-		return BLK_STS_RESOURCE;
-	return nvme_host_path_error(rq);
-}
-EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
-
-bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
-		bool queue_live)
-{
-	struct nvme_request *req = nvme_req(rq);
-
-	/*
-	 * currently we have a problem sending passthru commands
-	 * on the admin_q if the controller is not LIVE because we can't
-	 * make sure that they are going out after the admin connect,
-	 * controller enable and/or other commands in the initialization
-	 * sequence. until the controller will be LIVE, fail with
-	 * BLK_STS_RESOURCE so that they will be rescheduled.
-	 */
-	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
-		return false;
-
-	/*
-	 * Only allow commands on a live queue, except for the connect command,
-	 * which is require to set the queue live in the appropinquate states.
-	 */
-	switch (ctrl->state) {
-	case NVME_CTRL_CONNECTING:
-		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
-			return true;
-		break;
-	default:
-		break;
-	case NVME_CTRL_DEAD:
-		return false;
-	}
-
-	return queue_live;
-}
-EXPORT_SYMBOL_GPL(__nvmf_check_ready);
-
 static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
 	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 733010d2eafd..e450d9a5d788 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -177,20 +177,7 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
-blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
-		struct request *rq);
-bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
-		bool queue_live);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
-static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
-		bool queue_live)
-{
-	if (likely(ctrl->state == NVME_CTRL_LIVE ||
-		   ctrl->state == NVME_CTRL_DELETING))
-		return true;
-	return __nvmf_check_ready(ctrl, rq, queue_live);
-}
-
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 921b3315c2f1..ea8804c1c96e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2766,8 +2766,8 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
-	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
-		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
+	    !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	ret = nvme_setup_cmd(ns, rq);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c6102ce83bb4..2b08e795bf54 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -632,6 +632,21 @@ struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
+blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
+		struct request *req);
+bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+		bool queue_live);
+
+static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+		bool queue_live)
+{
+	if (likely(ctrl->state == NVME_CTRL_LIVE))
+		return true;
+	if (ctrl->ops->flags & NVME_F_FABRICS &&
+	    ctrl->state == NVME_CTRL_DELETING)
+		return true;
+	return __nvme_check_ready(ctrl, rq, queue_live);
+}
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d6bc43e6c8a6..203b47a8ec92 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2047,8 +2047,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
-	if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
-		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
+	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	dev = queue->device->dev;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e55d8bc0c50..6bd5b281c818 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2328,8 +2328,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
-	if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
-		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
+	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b741854fc957..1b89a6bb819a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -138,8 +138,8 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_LOOP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
-	if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
-		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, req);
+	if (!nvme_check_ready(&queue->ctrl->ctrl, req, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, req);
 
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
-- 
2.30.1

