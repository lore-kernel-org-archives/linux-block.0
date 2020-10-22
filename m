Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00769C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19B62245D
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="mvuKTc/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441028AbgJVBC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:02:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28406 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603329071; x=1634865071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+mA7oBvbm2Iqh+FaZrW3l1Udy7Fnvf4SGqRIEGDfP4=;
  b=mvuKTc/cSxd8J89T5KoOCWoZcohTu4jvxEQ+fRb/KHc/Wx2daC8Im83s
   AVxkKwCh1NgG9svKqVDJH0MchMPQ6rTUCuD8v4VAbixt6MYtB7/Mb5elX
   XURX4082G3xN4IUmkfB2gkZPwKxym0jadFCeukw3qN2k4IO6ib4N4OMTv
   Y9jTHscfJrj3zWZMLlTpf0YmtuSyYV3XMwa/Po9kF0pzFuURL94Y75Cot
   Mpy0+VxhEd3CDljM1lHCYvfrgSIUhI+gDYrmqwqxpmnDCV6eR8Z27oUPw
   px6bY3Ee29SEzpHWmbKWvA3525rQzy2M54RxDhdUby7YGdg13vQBDwa/W
   g==;
IronPort-SDR: Qrs5+4K5sLTfJ4Py0cnLxy3keEEupIlTZFoBrYHifqTa0EBJT3NrrwdvLgN8PeLFVPD0IBz22j
 +YZRJHhT6LKDPY4vSBPu5IRiKAFonIbNmliY0AYnOmFmg5tvBNDTq66puEKBbvym+hlWHzTYPh
 rrD8WdbF6upvTfY2jfPRlSXwUzDVDOQcTN3w+CzfgYFkaW1PW0sy5BhHPzeuWsiYtIED3N9ORx
 XQQBVBFnlhyXwByqYcA5v/58yuAQWR9YoWga2ImT3lBodGgVDByg3dd0g2SK2pFRbBcjkTU4Ru
 Tl0=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="254069096"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:11:11 +0800
IronPort-SDR: fHi8p2RosO0NMgdYK7KiEUCF89ZZgSFb7yjutLXVcpYmXMMmDEp3L+ihP1+claPQIVr5c//2VP
 4HlFpwggkBKz8LynKmkemvQgRKfeod/CtTkXizPXw0ipY9eZaYM3W5M6x9/jp4vaVomfeFs5mM
 V8x7ERV3qfJdNwxs2rVKG9mya8Rkzhj67cC1KBMCxeB3nbHMOiSzsUEFfVHHifs2b3hwsT6rc0
 MWH8tmRYbM1x8zLzlkPlXeX+Saio1fMRMfjW/kYg7oodF+ZsGvQn0967Y00+rNCp0pLLUYElDb
 pk+Mg6qyZWgqJQLurniTJVAM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:48:27 -0700
IronPort-SDR: JhUkZAQSF0AWZ+4qgrou+1gIV6RT0YXFRNNhlOfVtsKjkUjINKWmWwJcWBoDkbQPCXVx6aOtFk
 2i+L3PWEgZDleh+wlgDrjwzauCH9I7GzoKi+5aC/UEeF+Stu4PoDXu7DZD+vclilWFrNh5unap
 nPh1LkRqlslwYMfUi28Q43NPi8asB0LezEaa4V33tskKP7GxjS2aU7k24vAH3KLgY/sFJlc0+y
 91tMKg5rAJ8/fUZhdQP2kVhYVrPbjja0dX/BXtS51lK+6EqY8GUgJm7piaakdjP/i7cdLUu4K7
 2c8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:02:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Date:   Wed, 21 Oct 2020 18:02:30 -0700
Message-Id: <20201022010234.8304-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
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
additional branch check and the code in fast path.

Split the nvme_alloc_request() into nvme_alloc_request_qid_any() and
nvme_alloc_request_qid().

Replace each call of the nvme_alloc_request() with NVME_QID_ANY param
with a call to newly added nvme_alloc_request_qid_any().

Replace a call to nvme_alloc_request() with QID param with a call to
newly added nvme_alloc_request_qid_any() and nvme_alloc_request_qid()
based on the qid value set in the __nvme_submit_sync_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 44 +++++++++++++++++++++++-----------
 drivers/nvme/host/lightnvm.c   |  5 ++--
 drivers/nvme/host/nvme.h       |  4 ++--
 drivers/nvme/host/pci.c        |  6 ++---
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5bc52594fe63..87e56ef48f5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -522,26 +522,38 @@ static inline void nvme_init_req_from_cmd(struct request *req,
 	nvme_req(req)->cmd = cmd;
 }
 
-struct request *nvme_alloc_request(struct request_queue *q,
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
+struct request *nvme_alloc_request_qid_any(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags)
+{
+	struct request *req;
+
+	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	if (unlikely(IS_ERR(req)))
+		return req;
+
+	nvme_init_req_from_cmd(req, cmd);
+	return req;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_request_qid_any);
+
+static struct request *nvme_alloc_request_qid(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
-	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
 
-	if (qid == NVME_QID_ANY) {
-		req = blk_mq_alloc_request(q, op, flags);
-	} else {
-		req = blk_mq_alloc_request_hctx(q, op, flags,
-				qid ? qid - 1 : 0);
-	}
+	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+			qid ? qid - 1 : 0);
 	if (IS_ERR(req))
 		return req;
 
 	nvme_init_req_from_cmd(req, cmd);
-
 	return req;
 }
-EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
@@ -899,7 +911,11 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	if (qid == NVME_QID_ANY)
+		req = nvme_alloc_request_qid_any(q, cmd, flags);
+	else
+		req = nvme_alloc_request_qid(q, cmd, flags, qid);
+
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1069,7 +1085,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	req = nvme_alloc_request_qid_any(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1143,8 +1159,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request_qid_any(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..b1ee1a0310f6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request_qid_any(q, (struct nvme_command *)cmd, 0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -767,8 +767,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request_qid_any(q, (struct nvme_command *)vcmd, 0);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..f39a0a387a51 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -608,8 +608,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
-struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
+struct request *nvme_alloc_request_qid_any(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df8f3612107f..94f329b5f980 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1289,8 +1289,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		"I/O %d QID %d timeout, aborting\n",
 		 req->tag, nvmeq->qid);
 
-	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	abort_req = nvme_alloc_request_qid_any(dev->ctrl.admin_q, &cmd,
+			BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2204,7 +2204,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	req = nvme_alloc_request_qid_any(q, &cmd, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 56c571052216..76affbc3bd9a 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -236,7 +236,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		q = ns->queue;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	rq = nvme_alloc_request_qid_any(q, req->cmd, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1

