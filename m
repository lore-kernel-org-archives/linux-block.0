Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D01C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499220849
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PSpWpIWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C499220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeLMGiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UQ+NdH5QrJ5ErilWLCAIdaecQaBREsdXmXjJWQOs6Zo=; b=PSpWpIWVAPk2jv3NqQsrzFAbx
        H3oupWHDJfIiiunUxcoyw1snKDGZ0wjQgRCskSKu3jNP0oyK3w/SI8YFlpGn9XECyF6QakaOT8+s6
        2f1CkftN9IlsUJvfQx54pd0w8Ol8jn4THmHN48Vc7VA0wpJPNMwKVmsEDNt+xV/KFM9dfvWt/R+ba
        gGLsMmIhN4PQNGvKt/G6A6lWw5Ys3eh2xHTV1SGtXV2rIt1coTRLsjXmGCdhycF8glAOsrV4ZmSHt
        py9w282wXhVyuy76vQeJNO+gQvkgwLQvjDt1dTRfgH796yznbiZuQEAU4uboQGeNwCheKT2KzWBae
        PTYq1N4Dg==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKdZ-0006LR-9Q; Thu, 13 Dec 2018 06:38:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/6] nvme-core: allow __nvme_submit_sync_cmd to poll
Date:   Wed, 12 Dec 2018 22:38:14 -0800
Message-Id: <20181213063819.13614-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass poll bool to indicate that we need it to poll. This prepares us for
polling support in nvmf since connect is an I/O that will be queued
and has to be polled in order to complete.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c    | 13 ++++++++-----
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f90576862736..eb1c10b0eaf0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -713,7 +713,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags)
+		blk_mq_req_flags_t flags, bool poll)
 {
 	struct request *req;
 	int ret;
@@ -730,7 +730,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(req->q, NULL, req, at_head);
+	if (poll)
+		blk_execute_rq_polled(req->q, NULL, req, at_head);
+	else
+		blk_execute_rq(req->q, NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -747,7 +750,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1058,7 +1061,7 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
+			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -1703,7 +1706,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10[1] = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
+				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 19ff0eae4582..d93a169f6403 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -159,7 +159,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -206,7 +206,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -252,7 +252,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -406,7 +406,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -468,7 +468,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e0ec365ce8d..75ed640a5ef0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -444,7 +444,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		blk_mq_req_flags_t flags, bool flag);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.17.1

