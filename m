Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC69C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE52086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bw/Nt92N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEE52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zdZRGxe6+K9R1S+q8YhU7Mhn7jmgSU5GwE3WESFPoWc=; b=Bw/Nt92NrWIZS9bBVc8HYirhL
        VzyelQWf9yr43K0e3sa7wtzsLgTOjWs87cn8NxclMpEJacKX/7ZeKZOJlVTY6KXiY9onLajwgt3yV
        W9mikNFyZisPoZAtTbmPzjTdlz4UlUtLz6DgtDhFyrtsUM6E5dT1ptxxg0o3EzW3Pqu0PEifFTJoM
        0JMhnMiEPvf05pigi1N2M01jZi0SBjKDQVycLmf9d+uwV+bY4sGNP7Slk5kpR9IPD2HSbi5j7th01
        Gwq7fstkmeUsC3cb9nB/Nb5Qg4CBkIxhn1uLKvZJ2aYJbQt+O+L/c/HBOayxjOibkJ4JdzdVtS1fH
        GiYaHWRWA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYh-0002L4-VA; Tue, 11 Dec 2018 23:35:24 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 5/5] nvme-rdma: support separate queue maps for read and write
Date:   Tue, 11 Dec 2018 15:35:18 -0800
Message-Id: <20181211233519.9350-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow NVMF_OPT_NR_WRITE_QUEUES and allocate nvme queues for
write additionally. In addition, implement .map_queues that
will apply 2 queue maps for read and write queue sets.

Note that with the separate queue map, HCTX_TYPE_READ will always
use nr_io_queues and HCTX_TYPE_DEFAULT will use nr_write_queues.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5057d5ab5aaa..6a7c546b4e74 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -645,6 +645,8 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	nr_io_queues = min_t(unsigned int, nr_io_queues,
 				ibdev->num_comp_vectors);
 
+	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
+
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -714,6 +716,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
+		set->nr_maps = 2 /* default + read */;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1751,7 +1754,25 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 
-	return blk_mq_rdma_map_queues(&set->map[0], ctrl->device->dev, 0);
+	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+	set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
+	if (ctrl->ctrl.opts->nr_write_queues) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_write_queues;
+		set->map[HCTX_TYPE_READ].queue_offset =
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		/* mixed read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_READ].queue_offset = 0;
+	}
+	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+			ctrl->device->dev, 0);
+	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
+			ctrl->device->dev, 0);
+	return 0;
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
@@ -1906,7 +1927,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -1957,7 +1978,8 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
-			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_NR_IO_QUEUES,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
2.17.1

