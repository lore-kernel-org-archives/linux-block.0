Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CACC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiGUNKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiGUNJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA060FE
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iBjVmLcUg5hrQfGPBAtR949PIrfj0z/kG43BbCei9oc=; b=PxtvsJiUl0hoE5UN6pSuAOAyRN
        Z02hIMNMS2xTxQkXDxiZ20jYwEY9u4cNSEnL9uIiG/on0EYALSx+47//gVkskwHz/DqH+pR3O64uN
        VBcoPQvQoA+UK7jWGkIOPDgoHkzbCzK8El1EVxhnq0Q48YJ3gq38C8lHYRqC6xSTL1+2NJ/89iVNX
        HSwUnBXYLf5bHBe+aAWnL8B7dkHlxKJ93jnbIYrnj563vxSrmkbueZHTjrmDY0ZVoYnLU6O93Md30
        x1G1AF5f9VpUBOUkCsJIjyQXD1fztBvwHawxXFTYg0UJxWwuA5Y8DBds4y5QO8x4o6lAoTS8zQOah
        +dRVFgyQ==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvu-006n0x-0S; Thu, 21 Jul 2022 13:09:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/8] ublk: rewrite ublk_ctrl_get_queue_affinity to not rely on hctx->cpumask
Date:   Thu, 21 Jul 2022 15:09:15 +0200
Message-Id: <20220721130916.1869719-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looking at the hctxs and cpumap is not safe without at very last a RCU
reference.  It also requires the queue to be set up before starting the
device, which leads to rather awkward life time rules.

Instead rewrite ublk_ctrl_get_queue_affinity to just build the cpumask
directly from the mq_map in the tag set, similar to hctx->cpumask is
built.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 55 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b8ac7b508029e..748247c0435be 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1245,26 +1245,15 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	return ret;
 }
 
-static struct blk_mq_hw_ctx *ublk_get_hw_queue(struct ublk_device *ub,
-		unsigned int index)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	queue_for_each_hw_ctx(ub->ub_queue, hctx, i)
-		if (hctx->queue_num == index)
-			return hctx;
-	return NULL;
-}
-
 static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct blk_mq_hw_ctx *hctx;
 	struct ublk_device *ub;
+	cpumask_var_t cpumask;
 	unsigned long queue;
 	unsigned int retlen;
+	unsigned int i;
 	int ret = -EINVAL;
 	
 	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
@@ -1276,30 +1265,34 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
-		goto out;
+		return -EINVAL;
 
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
-		goto out;
-	hctx = ublk_get_hw_queue(ub, queue);
-	if (!hctx)
-		goto out;
+		goto out_put_device;
 
-	retlen = min_t(unsigned short, header->len, cpumask_size());
-	if (copy_to_user(argp, hctx->cpumask, retlen)) {
-		ret = -EFAULT;
-		goto out;
-	}
-	if (retlen != header->len) {
-		if (clear_user(argp + retlen, header->len - retlen)) {
-			ret = -EFAULT;
-			goto out;
-		}
+	ret = -ENOMEM;
+	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
+		goto out_put_device;
+
+	for_each_possible_cpu(i) {
+		if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[i] == queue)
+			cpumask_set_cpu(i, cpumask);
 	}
+
+	ret = -EFAULT;
+	retlen = min_t(unsigned short, header->len, cpumask_size());
+	if (copy_to_user(argp, cpumask, retlen))
+		goto out_free_cpumask;
+	if (retlen != header->len &&
+	    clear_user(argp + retlen, header->len - retlen))
+		goto out_free_cpumask;
+
 	ret = 0;
- out:
-	if (ub)
-		ublk_put_device(ub);
+out_free_cpumask:
+	free_cpumask_var(cpumask);
+out_put_device:
+	ublk_put_device(ub);
 	return ret;
 }
 
-- 
2.30.2

