Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C6C43470
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D94E61468
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhDWWGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 18:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhDWWGl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6639F61467;
        Fri, 23 Apr 2021 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215565;
        bh=WC6okdkJnyksxo1ofAM6rL0O0NwmX0aGwFuZnSXTAUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdSfy/uIWAf1yIlih3WjihzORgyH4AwsLPzBK7QeJoK/uRkFwkygoWM/wgd9x+v3o
         7xwuE8VHwYQikH4hzbJ6Dxov8sOqa1QrwYzH8tjBrKdchDKUp0k7W7UmhhXG4OOB3G
         6zrnIF9qZG2viAmRd7u+mIWDZeHnRi5I0zhxlzpNlf2nyn4CEMfVnvu4GVR63RKY+4
         h/mAFMn1WwdnRblVKflA8oNqnVwqqpaWkpIAN3KGNMX7Oz2XZlp4JSoqhiRC1f8q3L
         +LBA5BRZuXd5Q/NZMrkcykUNEScGj8Bnro1/myHlT1nos92a2V/A/vJBkMD8WIbvqt
         pplYWL47nb/Kg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Date:   Fri, 23 Apr 2021 15:05:58 -0700
Message-Id: <20210423220558.40764-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer knows how to deal with polled requests. Let the NVMe
driver use the previously reserved user "flags" fields to define an
option to allocate the request from the polled hardware contexts. If
polling is not enabled, then the block layer will automatically fallback
to a non-polled request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c        | 10 ++++++----
 drivers/nvme/host/ioctl.c       | 32 ++++++++++++++++++--------------
 drivers/nvme/host/lightnvm.c    |  4 ++--
 drivers/nvme/host/nvme.h        |  3 ++-
 drivers/nvme/host/pci.c         |  4 ++--
 drivers/nvme/target/passthru.c  |  2 +-
 include/uapi/linux/nvme_ioctl.h |  4 ++++
 7 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62af5fe7a0ce..3af4d955405b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -610,11 +610,13 @@ static inline void nvme_init_request(struct request *req,
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags)
+		struct nvme_command *cmd, blk_mq_req_flags_t flags,
+		unsigned rq_flags)
 {
+	unsigned cmd_flags = nvme_req_op(cmd) | rq_flags;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	req = blk_mq_alloc_request(q, cmd_flags, flags);
 	if (!IS_ERR(req))
 		nvme_init_request(req, cmd);
 	return req;
@@ -957,7 +959,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	int ret;
 
 	if (qid == NVME_QID_ANY)
-		req = nvme_alloc_request(q, cmd, flags);
+		req = nvme_alloc_request(q, cmd, flags, 0);
 	else
 		req = nvme_alloc_request_qid(q, cmd, flags, qid);
 	if (IS_ERR(req))
@@ -1130,7 +1132,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 
 	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9cdd8bfebb80..79fc90f010b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -56,7 +56,7 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
+		u32 meta_seed, u64 *result, unsigned timeout, unsigned rq_flags)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -66,7 +66,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0);
+	req = nvme_alloc_request(q, cmd, 0, rq_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -116,11 +116,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_command c;
 	unsigned length, meta_len;
 	void __user *metadata;
+	unsigned rq_flags = 0;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	if (io.flags)
-		return -EINVAL;
+	if (io.flags & NVME_HIPRI)
+		rq_flags |= REQ_HIPRI;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -158,7 +159,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
+	c.rw.flags = 0;
 	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
@@ -170,7 +171,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
+			rq_flags);
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
@@ -178,6 +180,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
+	unsigned rq_flags = 0;
 	unsigned timeout = 0;
 	u64 result;
 	int status;
@@ -186,8 +189,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
+	if (cmd.flags & NVME_HIPRI)
+		rq_flags |= REQ_HIPRI;
 	if (ns && cmd.nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
 			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
@@ -197,7 +200,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
@@ -214,7 +217,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout);
+			0, &result, timeout, rq_flags);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -229,6 +232,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
+	unsigned rq_flags = 0;
 	unsigned timeout = 0;
 	int status;
 
@@ -236,8 +240,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
+	if (cmd.flags & NVME_HIPRI)
+		rq_flags |= REQ_HIPRI;
 	if (ns && cmd.nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
 			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
@@ -247,7 +251,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
@@ -264,7 +268,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, &cmd.result, timeout, rq_flags);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e9d9ad47f70f..a7fff633cdee 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0);
+	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, 0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -766,7 +766,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0);
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0, 0);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76a7ed0728b9..6005a61c7f4c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -629,7 +629,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+		struct nvme_command *cmd, blk_mq_req_flags_t flags,
+		unsigned rq_flags);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09d4c5f99fc3..0400ac53964f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1344,7 +1344,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2268,7 +2268,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index d9a649d9903b..be7c6d50d23a 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -244,7 +244,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0);
+	rq = nvme_alloc_request(q, req->cmd, 0, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..683d33c37a96 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -9,6 +9,10 @@
 
 #include <linux/types.h>
 
+enum nvme_io_flags {
+	NVME_HIPRI	= 1 << 0, /* use polling queue if available */
+};
+
 struct nvme_user_io {
 	__u8	opcode;
 	__u8	flags;
-- 
2.25.4

