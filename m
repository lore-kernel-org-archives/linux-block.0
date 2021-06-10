Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43AFC48BD1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915D561410
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFJVqw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhFJVqw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 17:46:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DADA361421;
        Thu, 10 Jun 2021 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623361495;
        bh=65lHkVM9pO4Mm3GE+Y0x4B9DmcZVAocGeR0mSXe2xaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/dYamzeNZtusk83vlu+jcbUcDLLQvmZTbKrqQdaVlveg4+3A6EALuKw4Vh734vVM
         pev2ulkiMU5mOQS8dtpTglwchG9ixKMMvSel5kKQlP9TPYs0MbnmcpGbjEp6abpCFj
         mxEWjJwUOLXYpsjPoeCKKN8uUjRfMO1THVqsokHY1Ed/LNBUPOoqqST42DKIC27i9f
         jsMeDjdLUrvzbwLJhMpnmgf+32C1c80TxWXACKIDGXrRDb1CniQiXqYN4XVUnC6JBq
         begQS9noNufHd8N68KhD6efrpkuXVns7x2gChcvN5UlSSHZ+U105plusbrYoAbA0W7
         4Zbr4fO/0xoag==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 4/4] nvme: use return value from blk_execute_rq()
Date:   Thu, 10 Jun 2021 14:44:37 -0700
Message-Id: <20210610214437.641245-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210610214437.641245-1-kbusch@kernel.org>
References: <20210610214437.641245-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't have an nvme status to report if the driver's .queue_rq()
returns an error without dispatching the requested nvme command. Check
the return value from blk_execute_rq() for all passthrough commands so
the caller may know their command was not successful.

If the command is from the target passthrough interface and fails to
dispatch, synthesize the response back to the host as a internal target
error.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Combined request dispatch with the status decoding into single
  function

 drivers/nvme/host/core.c       | 35 ++++++++++++++++++++++++++--------
 drivers/nvme/host/ioctl.c      |  6 +-----
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c |  8 ++++----
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b9deaffa4e1..f4a690808010 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -609,6 +609,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
+	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -1034,6 +1035,25 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
+/*
+ * Return values:
+ * 0:  success
+ * >0: nvme controller's cqe status response
+ * <0: kernel error in lieu of controller response
+ */
+static int nvme_execute_rq(struct gendisk *disk, struct request *rq,
+		bool at_head)
+{
+	blk_status_t status;
+
+	status = blk_execute_rq(disk, rq, at_head);
+	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+		return -EINTR;
+	if (nvme_req(rq)->status)
+		return nvme_req(rq)->status;
+	return blk_status_to_errno(status);
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -1062,13 +1082,9 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(NULL, req, at_head);
-	if (result)
+	ret = nvme_execute_rq(NULL, req, at_head);
+	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -1156,18 +1172,21 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-void nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
 	u32 effects;
+	int  ret;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(disk, rq, 0);
+	ret = nvme_execute_rq(disk, rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
 		nvme_passthru_end(ctrl, effects);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 2e7780ea0354..85cfad3dd692 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -93,11 +93,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}
 
-	nvme_execute_passthru_rq(req);
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
+	ret = nvme_execute_passthru_rq(req);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (meta && !ret && !write) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 499681bc0286..7557f3404615 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -871,7 +871,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-void nvme_execute_passthru_rq(struct request *rq);
+int nvme_execute_passthru_rq(struct request *rq);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 39b1473f7204..ba28ce42cb55 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -153,11 +153,10 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
-	u16 status;
+	int status;
 
-	nvme_execute_passthru_rq(rq);
+	status = nvme_execute_passthru_rq(rq);
 
-	status = nvme_req(rq)->status;
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
@@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 			nvmet_passthru_override_id_ns(req);
 			break;
 		}
-	}
+	} else if (status < 0)
+		status = NVME_SC_INTERNAL;
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
-- 
2.25.4

