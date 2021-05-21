Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE5C4707F
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937F46138C
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhEUUXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhEUUXO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:23:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E5BF6135A;
        Fri, 21 May 2021 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621628510;
        bh=6m2eCmCZZnbOPSgGeuvIFaNXuTsftPSL5d8vIqd9YiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDa/po8x5pobjA1iL52KQAO3x6AJjhUuomy2MzuBYns0S446ShOGs6o0K1Irhbmmq
         EraBQKEYmpKgswEKNcy3f8OMppHVshuwoKMWnyYgmDs3t5RcFr6EPY0HegYrutbgIg
         Hkw7404JKKNq4f4WQ6y6TBsXfI9CxiDWTfut+MWxTg/ihBgoBDq4nLsNIqc3inn8+j
         xED5kgbWIxzL4RGT6hvViUwKywzTmnwnliUC1VP378Ucfete/wgEB/0gbltDu3qgTQ
         T5+SxP3+Mt6TrTiU8mDfjk7n9NL80PEeXJcwDcYOmpMhVNijC4qZHJvBd9FUmuYQPB
         W7ORlwPTo/Acw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Date:   Fri, 21 May 2021 13:21:45 -0700
Message-Id: <20210521202145.3674904-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
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

  Initialize nvme status to 0

  Add helper function for blk_status_t to nvme passthrough return code

 drivers/nvme/host/core.c       | 33 +++++++++++++++++++++++++--------
 drivers/nvme/host/ioctl.c      |  6 +-----
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c |  8 ++++----
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a73eed61eee..99e10476f377 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -589,6 +589,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
+	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -1012,6 +1013,21 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
+/*
+ * Return values:
+ * 0:  success
+ * >0: nvme controller's cqe status response
+ * <0: kernel error in lieu of controller response
+ */
+static int nvme_passthrough_status(struct request *rq, blk_status_t status)
+{
+	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+		return -EINTR;
+	else if (nvme_req(rq)->status)
+		return nvme_req(rq)->status;
+	return blk_status_to_errno(status);
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -1022,6 +1038,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		blk_mq_req_flags_t flags)
 {
 	struct request *req;
+	blk_status_t status;
 	int ret;
 
 	if (qid == NVME_QID_ANY)
@@ -1040,13 +1057,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(NULL, req, at_head);
-	if (result)
+	status = blk_execute_rq(NULL, req, at_head);
+	ret = nvme_passthrough_status(req, status);
+	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -1134,18 +1148,21 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-void nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	blk_status_t status;
 	u32 effects;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(disk, rq, 0);
+	status = blk_execute_rq(disk, rq, 0);
 	if (effects) /* nothing to be done for zero cmd effects */
 		nvme_passthru_end(ctrl, effects);
+
+	return nvme_passthrough_status(rq, status);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9557ead02de1..4e6bcc3c1c0d 100644
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
index 84bff995a308..9ea827871d67 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -877,7 +877,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
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

