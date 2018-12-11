Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E611C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80672081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qW/EbUwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80672081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLKKu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:50:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeLKKu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LFkZyPvbqSYLLS6vBNRWZ3gVK017bJYsIXx6LHwoeTc=; b=qW/EbUwW6Ror9R6WTv6DffZ9f
        3ZaXvX8R8BxLBI8dp4p9CPB+XgPfcSKRfbvENuhYzzo7rmPxDobz3pXLa7J68YW+OphGJV7Ur2zxu
        xJ3HAn6qC4d80AIhn+VdNcBESgRP3ViJ6QvSCj2mCgmw5k1p0O8lZQdZqaSF3jK2Eeg9NUx5LH2Ah
        eF5m8oZ+4vPq0AhS2xKeu5wvuYSBGMiF2WW3ACPHudY57gl6+IpTCIfF8EsRK80l5ZJpi++cDAyCf
        TW25GYG9EwFzGSptIV18sg5355rXUL+8CbzcoRlzBjkqzJj2tojAd4mZFLPfUIWdisTrb0Pcw5suS
        WwqDJZsvg==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWfbe-0004p6-Au; Tue, 11 Dec 2018 10:49:38 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] nvme-rdma: support read/write queue separation
Date:   Tue, 11 Dec 2018 02:49:35 -0800
Message-Id: <20181211104936.25333-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5057d5ab5aaa..cfe823a491f2 100644
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
@@ -1750,8 +1753,37 @@ static void nvme_rdma_complete_rq(struct request *rq)
 static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+	struct blk_mq_queue_map *map;
+	int offset = 0;
+
+	if (ctrl->ctrl.opts->nr_write_queues) {
+		/* separate read/write queues */
+		map = &set->map[HCTX_TYPE_DEFAULT];
+		map->queue_offset = offset;
+		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+		offset += map->nr_queues;
+
+		map = &set->map[HCTX_TYPE_READ];
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		map->queue_offset = offset;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, offset);
+		offset += map->nr_queues;
 
-	return blk_mq_rdma_map_queues(&set->map[0], ctrl->device->dev, 0);
+	} else {
+		/* mixed read/write queues */
+		map = &set->map[HCTX_TYPE_DEFAULT];
+		map->queue_offset = 0;
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+
+		map = &set->map[HCTX_TYPE_READ];
+		map->queue_offset = 0;
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+	}
+
+	return 0;
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
@@ -1906,7 +1938,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -1957,7 +1989,8 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
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

