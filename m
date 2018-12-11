Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50781C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122872084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAekHtNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122872084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKXg7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:36:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKXg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I4L4IN089RqfWMWAwDyCS6XI87ETgggO9pASeHabJFM=; b=dAekHtNCMJdsV2PmZ2Cdwc4Ky
        5x4U+tda6gsF87y9nXMB9ymoA/gNJLZlq4uY1whMHjGU5levnI/E+0jEWzyH5M0h9p71xP6TlLbGk
        xuc7OW4YiRVeenvxWxF3B1BTG5p58idQOun6ny/JftYbRUzLdSghr/eyjE2K1HZJlb03bDASrDIfP
        dRqImLDoYTpuNEM9POGXagtTr0f+k4Xvik3HB43tRKZcFYnoESMc8KS8bvIi9AQw+YIvUcTqvzpib
        w+IX0/rEVCIfiwKmgEV6T74rVT6s+fuCS9fB0w9t0zwgVi6oE4kBj1olXsUBxsWkkDz7P/eIJhRGF
        v5MPYm0aQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraD-0003uQ-Tj; Tue, 11 Dec 2018 23:36:57 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC 3/4] nvme-rdma: implement polling queue map
Date:   Tue, 11 Dec 2018 15:36:50 -0800
Message-Id: <20181211233652.9705-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every nvmf queue starts with a connect message that is the slow path
at setup time, and there is no need for polling (it is actually
hurtful). Instead, allocate the polling queue cq with IB_POLL_SOFTIRQ
and switch it to IB_POLL_DIRECT where it makes sense.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6a7c546b4e74..590d006d0187 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -607,6 +607,11 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	else
 		dev_info(ctrl->ctrl.device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
+
+	if (idx > ctrl->ctrl.opts->nr_io_queues +
+	    ctrl->ctrl.opts->nr_write_queues)
+		ib_change_cq_ctx(ctrl->queues[idx].ib_cq, IB_POLL_DIRECT);
+
 	return ret;
 }
 
@@ -646,6 +651,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 				ibdev->num_comp_vectors);
 
 	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
+	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
@@ -716,7 +722,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
-		set->nr_maps = 2 /* default + read */;
+		set->nr_maps = HCTX_MAX_TYPES;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1742,6 +1748,14 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_rdma_queue *queue = hctx->driver_data;
+	struct ib_cq *cq = queue->ib_cq;
+
+	return ib_process_cq_direct(cq, 16);
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1772,6 +1786,21 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->device->dev, 0);
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
 			ctrl->device->dev, 0);
+
+	if (ctrl->ctrl.opts->nr_poll_queues) {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_poll_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset =
+				ctrl->ctrl.opts->nr_io_queues;
+		if (ctrl->ctrl.opts->nr_write_queues)
+			set->map[HCTX_TYPE_POLL].queue_offset +=
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	return 0;
 }
 
@@ -1783,6 +1812,7 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_hctx	= nvme_rdma_init_hctx,
 	.timeout	= nvme_rdma_timeout,
 	.map_queues	= nvme_rdma_map_queues,
+	.poll		= nvme_rdma_poll,
 };
 
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
@@ -1927,7 +1957,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
+				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-- 
2.17.1

