Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698EC6783C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0620851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nw0lPOSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB0620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qOJo1FY0ts4w5VWtvpXt1ZEWHNVVYuKP5ntb1O2VaYM=; b=nw0lPOSYc58rq7Chfn/GjpMBn
        S8+il1f/QSJ6KQQAFLknqu3R9eXNLutv8k+lnePSMRSKsfnwl5ywuUE8eSVmOj4ahOqd8zaoxy+F6
        t8SvJdLZaDHghsvhdbpnytWIuF8Q4G8WqlSls9oYbFVVxK2/JK3KXz7fo9UF+pZ8GZpqFptOu822G
        9Gkt95H6P28Z0px8QYINA/fovj70a3YdNpyozpFj3Gjyjtr49TXzlFmf3xmUDEW8nXkUMOoxGv/BO
        ATS7Wn+Zi7/sOjtgrgRjU2DM86Z5/eX9bBBbBbU1h80tpOaPheK7ZXp2LRjp/0hba7FOuACR57BM4
        lUtF9E7/w==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYh-0002L4-3U; Tue, 11 Dec 2018 23:35:23 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 1/5] blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
Date:   Tue, 11 Dec 2018 15:35:14 -0800
Message-Id: <20181211233519.9350-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

will be used by nvme-rdma for queue map separation support.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-rdma.c         | 8 ++++----
 drivers/nvme/host/rdma.c    | 2 +-
 include/linux/blk-mq-rdma.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index a71576aff3a5..45030a81a1ed 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -29,24 +29,24 @@
  * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
  * vector, we fallback to the naive mapping.
  */
-int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
+int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec)
 {
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
-	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+	for (queue = 0; queue < map->nr_queues; queue++) {
 		mask = ib_get_vector_affinity(dev, first_vec + queue);
 		if (!mask)
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			set->map[0].mq_map[cpu] = queue;
+			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
 	return 0;
 
 fallback:
-	return blk_mq_map_queues(&set->map[0]);
+	return blk_mq_map_queues(map);
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f2db848f6985..5057d5ab5aaa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1751,7 +1751,7 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 
-	return blk_mq_rdma_map_queues(set, ctrl->device->dev, 0);
+	return blk_mq_rdma_map_queues(&set->map[0], ctrl->device->dev, 0);
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
index b4ade198007d..7b6ecf9ac4c3 100644
--- a/include/linux/blk-mq-rdma.h
+++ b/include/linux/blk-mq-rdma.h
@@ -4,7 +4,7 @@
 struct blk_mq_tag_set;
 struct ib_device;
 
-int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
+int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec);
 
 #endif /* _LINUX_BLK_MQ_RDMA_H */
-- 
2.17.1

