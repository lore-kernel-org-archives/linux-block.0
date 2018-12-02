Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F5C64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D7E20851
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtO9K+5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D7E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbeLBQsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:48:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLBQsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 11:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5o/YJTkEvhLiI+nbqAwgYA7vxzO2DAmTbHCoWD59D5U=; b=XtO9K+5hhxCzXKuAgwH2Ici2zO
        lsVIrmuESgzSl+MZMjI33Dc/y+uGJxGXA1fu/Elgbkr9aOIh77i1slygk1u4nZySZBNP9XzMflx4Z
        n11B7uduCqRawbp0RvGuYRe97jz9ApQps71Y2TOxVT+OdQ5MSalwy167UE4i5NnlQq/AiYQq/ahg4
        ZtmaZpCy7dWIu5cZnYbSyJigBJ0JgyFfJu4LpZLjALW+B5IlXCD+POD0kao7uvQe3LKD2HqBhXrM3
        bZDpWmqIHP5TpSWX+sNn9QgO5C25PArZtLflJvtYwYcbxxu4Lk9pRMheYdeN6qzeEhvbAZak5B28d
        1Rwb4xyA==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTUud-0002av-EM; Sun, 02 Dec 2018 16:48:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 10/13] nvme-mpath: remove I/O polling support
Date:   Sun,  2 Dec 2018 17:46:25 +0100
Message-Id: <20181202164628.1116-11-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ->poll_fn has been stale for a while, as a lot of places check for mq
ops.  But there is no real point in it anyway, as we don't even use
the multipath code for subsystems without multiple ports, which is usually
what we do high performance I/O to.  If it really becomes an issue we
should rework the nvme code to also skip the multipath code for any
private namespace, even if that could mean some trouble when rescanning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ffebdd0ae34b..ec310b1b9267 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,21 +220,6 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	return ret;
 }
 
-static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc, bool spin)
-{
-	struct nvme_ns_head *head = q->queuedata;
-	struct nvme_ns *ns;
-	int found = 0;
-	int srcu_idx;
-
-	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = srcu_dereference(head->current_path[numa_node_id()], &head->srcu);
-	if (likely(ns && nvme_path_is_optimized(ns)))
-		found = ns->queue->poll_fn(q, qc, spin);
-	srcu_read_unlock(&head->srcu, srcu_idx);
-	return found;
-}
-
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
@@ -281,7 +266,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		goto out;
 	q->queuedata = head;
 	blk_queue_make_request(q, nvme_ns_head_make_request);
-	q->poll_fn = nvme_ns_head_poll;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
-- 
2.19.1

