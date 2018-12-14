Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A5C43614
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870242080F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WyndJnv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeLNTGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:06:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbeLNTGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QPQTcFQSwsdDx3QAqFAaR3iAumv+5FC0WJ95UC3nJCY=; b=WyndJnv4Alw5UZImS0Vqj1JqY
        NxJ5iD5WHK1BcaFAop5kPh47JfuZjagCHDPoUxknE6WNNxhYP5WQxOk7hSEn2OiUmc/EOfNLafiQm
        H2V8F12kpaQ4Lv6Ox+7fbHzN6FhZ5QEOlqYRWCBd2OG7lE4BSFb4QXWENAryAPY+MiGfPWr7oah/+
        BhBmOX3pfrvGi7gvCBNUQCblb+SA4BeC0YhwqwAr/dGBjZ/M6at1WWdk3SKz2fbRjlwIISOttikhj
        LYPhTf9ZO6eT2Mc/6U81C1cyuyaB4q3yADXMrDONcn3a11VYvCGofKGFvwu+gtGbLvXJI4GpC59fS
        Mwe9XR/CQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXsmr-0002PK-5A; Fri, 14 Dec 2018 19:06:13 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 4/6] nvme-fabrics: allow nvmf_connect_io_queue to poll
Date:   Fri, 14 Dec 2018 11:06:08 -0800
Message-Id: <20181214190610.20086-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214190610.20086-1-sagi@grimberg.me>
References: <20181214190610.20086-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Preparation for polling support for fabrics. Polling support
means that our completion queues are not generating any interrupts
which means we need to poll for the nvmf io queue connect as well.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed by Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/fabrics.h | 2 +-
 drivers/nvme/host/fc.c      | 2 +-
 drivers/nvme/host/rdma.c    | 2 +-
 drivers/nvme/host/tcp.c     | 2 +-
 drivers/nvme/target/loop.c  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d93a169f6403..5ff14f46a8d9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -441,7 +441,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 {
 	struct nvme_command cmd;
 	struct nvmf_connect_data *data;
@@ -468,7 +468,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 81b8fd1c0c5d..cad70a9f976a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -168,7 +168,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b79e41938513..89accc76d71c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1975,7 +1975,7 @@ nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 					(qsize / 5));
 		if (ret)
 			break;
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
 		if (ret)
 			break;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ed726da77b5b..b907ed43814f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -598,7 +598,7 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, false);
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 51826479a41e..762a676403ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1393,7 +1393,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx);
+		ret = nvmf_connect_io_queue(nctrl, idx, false);
 	else
 		ret = nvmf_connect_admin_queue(nctrl);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..4aac1b4a8112 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -345,7 +345,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
 		if (ret)
 			return ret;
 		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
-- 
2.17.1

