Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A4C2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E81206F1
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="adElzKZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKJCYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31575 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgKJCYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975754; x=1636511754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=htBo/T+51yFNf/aP20lfx/LKM07TCey+64vVFBRYtC8=;
  b=adElzKZZRXIlIzCsiO5B1eytO04pv8lRmog+E5FJY2YaJWd8MfB0liP3
   fLYkHvgYIEt4ljnWNUwgprPVQQWjC+yhaqOFCCPhfgYZQ+gOx5Gy0yYrM
   HTVwEshU7xt2YvbAiEKVXyuvWxZzr2Nu43N/tkFOz+50WFWEkrABbW1hB
   xAoSOnM+upv/wJ8sM6Q4EXDmOmzUIaqkv9mQY7prtdknzIbo/NEmEGL++
   f3JaklZVHB+XAbBIFqgybjWKWxBPJOIp8YETJ+7govmGLvlxUT3ymwuCB
   bbLRCobT8Qr816aAKD+R1JyKJ3CnKzYQUUM3HWYBZ0zQ0KiXLE1KqvNhn
   Q==;
IronPort-SDR: OjoQvpHzyppyG8S0rcm8TOsYGxCmOyaRN3dSPM8tDVFcAUNliZ807rJY8dSkCVEydchHlZqEjQ
 I7IbewGh+/EJJe+w7INkBRniVBpHAL6FVnrIrRg3m3fKE/JZXwz0gaIcDCznGdnF2qtBclbzba
 O0KU20fGBj+FfWaC8gC1a/Kukvmvq9aXRYDYoCPfmA+6VmdIBnHgBpZUMvFoVskZA2UBR2Bd9e
 6asLSmrEOSpRTlAakRKS9diHJFt3Ngv9icDMJAcQ3p4OPpbPRTCzmrQbfIZaNiQ9oKt6X/moEb
 hNM=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="255796332"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:35:54 +0800
IronPort-SDR: ZdODBHgrE+4IU/mcI+R6BpPyfJvRzP/nIA6j8fIiCV0Rn7C//y0xjq6Z5VLjJ0flbJTpayTigb
 X3KIAQM84zZcK0OUu2qCoh3TjdeqlA/OpqDZ4a4fX8kaeChPNyYzGZsXFhkuB6f78LfiTijVu8
 FZ1VdrnGGAdO1xtwIeSVFT1GCAaJnpfdAgG+XiqLvC4diGU7QfZU8/lUAP3x8Ljk+ba0Ey4NLb
 UKNfJSktbS71T/KGRxSHS9LTBT0lmby0XOTloYj3bYlOcEK4Lgwed9mYfFQb2OyzQzSpMWMVmP
 8gccmJqFX1AwwvjxJAd4tr8f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:10:23 -0800
IronPort-SDR: Sea2stDnWVAs+NRyLpMU5L3sNHddbbkuizv7ct1Um9A3BVH4y+GtdxDK2eddQmkCZwvh8qYDR7
 3fmS+MV0oOCvyUte7yupPIxUorIib9h95snnuAgS9HpIg9eGup2NOTR7lg/5sGddHlQkh9MiPG
 4QygbVHDF+37WgUfLRNzwPlbu3WU1BGGXAzI3zR4Wcy2QGh3ZGsAIdicjUS6B4/GcTWRhpJfyJ
 2I5lP4/o7m5SKQQPx5cbyZT95RA0eeZ8F26F/89SBZb+dxX8zL+Azmnv3SPag3FbbHPCUNqbop
 dxI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:21 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 2/6] nvme-core: split nvme_alloc_request()
Date:   Mon,  9 Nov 2020 18:24:01 -0800
Message-Id: <20201110022405.6707-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now nvme_alloc_request() allocates a request from block layer
based on the value of the qid. When qid set to NVME_QID_ANY it used
blk_mq_alloc_request() else blk_mq_alloc_request_hctx().

The function nvme_alloc_request() is called from different context, The
only place where it uses non NVME_QID_ANY value is for fabrics connect
commands :-

nvme_submit_sync_cmd()		NVME_QID_ANY
nvme_features()			NVME_QID_ANY
nvme_sec_submit()		NVME_QID_ANY
nvmf_reg_read32()		NVME_QID_ANY
nvmf_reg_read64()		NVME_QID_ANY
nvmf_reg_write32()		NVME_QID_ANY
nvmf_connect_admin_queue()	NVME_QID_ANY
nvme_submit_user_cmd()		NVME_QID_ANY
	nvme_alloc_request()
nvme_keep_alive()		NVME_QID_ANY
	nvme_alloc_request()
nvme_timeout()			NVME_QID_ANY
	nvme_alloc_request()
nvme_delete_queue()		NVME_QID_ANY
	nvme_alloc_request()
nvmet_passthru_execute_cmd()	NVME_QID_ANY
	nvme_alloc_request()
nvmf_connect_io_queue() 	QID
	__nvme_submit_sync_cmd()
		nvme_alloc_request()

With passthru nvme_alloc_request() now falls into the I/O fast path such
that blk_mq_alloc_request_hctx() is never gets called and that adds
additional branch check in fast path.

Split the nvme_alloc_request() into nvme_alloc_request() and
nvme_alloc_request_qid().

Replace each call of the nvme_alloc_request() with NVME_QID_ANY param
with a call to newly added nvme_alloc_request() without NVME_QID_ANY.

Replace a call to nvme_alloc_request() with QID param with a call to
newly added nvme_alloc_request() and nvme_alloc_request_qid()
based on the qid value set in the __nvme_submit_sync_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c       | 56 +++++++++++++++++++++-------------
 drivers/nvme/host/lightnvm.c   |  5 ++-
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/pci.c        |  4 +--
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 315ea958d1b7..99aa0863502f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -526,12 +526,7 @@ static inline void nvme_init_req_from_cmd(struct request *req,
 	nvme_req(req)->cmd = cmd;
 }
 
-static inline unsigned int nvme_req_op(struct nvme_command *cmd)
-{
-	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
-}
-
-static inline void nvme_init_req_default_timeout(struct request *req)
+static inline void nvme_init_req_timeout(struct request *req)
 {
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
@@ -539,28 +534,42 @@ static inline void nvme_init_req_default_timeout(struct request *req)
 		req->timeout = NVME_ADMIN_TIMEOUT;
 }
 
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+		struct nvme_command *cmd, blk_mq_req_flags_t flags)
 {
-	unsigned op = nvme_req_op(cmd);
 	struct request *req;
 
-	if (qid == NVME_QID_ANY) {
-		req = blk_mq_alloc_request(q, op, flags);
-	} else {
-		req = blk_mq_alloc_request_hctx(q, op, flags,
-				qid ? qid - 1 : 0);
+	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	if (!IS_ERR(req)) {
+		nvme_init_req_timeout(req);
+		nvme_init_req_from_cmd(req, cmd);
 	}
-	if (IS_ERR(req))
-		return req;
-
-	nvme_init_req_timeout(req);
-	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
+struct request *nvme_alloc_request_qid(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+{
+	struct request *req;
+
+	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+			qid ? qid - 1 : 0);
+	if (!IS_ERR(req)) {
+		nvme_init_req_timeout(req);
+		nvme_init_req_from_cmd(req, cmd);
+	}
+
+	return req;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_request_qid);
+
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
 	struct nvme_command c;
@@ -917,7 +926,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	if (qid == NVME_QID_ANY)
+		req = nvme_alloc_request(q, cmd, flags);
+	else
+		req = nvme_alloc_request_qid(q, cmd, flags, qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1088,7 +1100,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1163,8 +1175,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 88a7c8eac455..470cef3abec3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -767,8 +767,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 53783358d62b..d2ccd3473b20 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -610,6 +610,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+struct request *nvme_alloc_request_qid(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6123040ff872..5e6365dd0c8e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1304,7 +1304,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+			BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2218,7 +2218,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a062398305a7..be8ae59dcb71 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -248,7 +248,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, req->cmd, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1

