Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F7C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiGUFRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiGUFRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE779ECE
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jm0roFuUacizElAlpwI3+r1F+KLQVTFqM3e7Zs/Y4IA=; b=xbVN1kNsdgZsW3ZrvIvQ9mL8sd
        hZhaP3zTJc/5RryOJiSpzZRePWx545UT8L9g8jv/+EufwZlDe9w16hJfvHw+aRXGR6AePDmwxV8Tq
        N2xHGHnPAbm+jCdEaV1tnvQJoai825iLi8LzcftwezrH8LocbhBG/shmn4Uk3KfW8A1bP+gRRHKMX
        wdNeFR4HgKv0mNnfqyse1P3Z2rE+qtWDoKGNjmHV4fb2Pm/4N7UchcsWXwuG883vIHa2VOSZNnPmJ
        VhRsjBOPbCfp9HjvdncJDgVOyM0xh7kLEte/BUAUpG4fohEqlm0xS1MB08pQa+qIpaLaEgk8hFbO+
        eUmeO75Q==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYX-00HDnR-2x; Thu, 21 Jul 2022 05:17:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/8] ublk: rewrite ublk_ctrl_get_queue_affinity to not rely on hctx->cpumask
Date:   Thu, 21 Jul 2022 07:16:31 +0200
Message-Id: <20220721051632.1676890-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looking at the hctxs and cpumap is not safe without at very last a RCU
reference.  It also requires the queue to be set up before starting the
device, which leads to rather awkware life time rules.

Instead rewrite ublk_ctrl_get_queue_affinity to call blk_mq_map_queues
on an on-stack blk_mq_queue_map and build the cpumask from that.

Note: given that ublk has not made it into a released kernel it might
make sense to change the ABI for this command to instead copy the
qmap.mq_map array (a nr_cpu_ids sized array of unsigned integer
values  where the CPU index directly points to the queue) to userspace.

That way all the information could be transported to userspace in a
single command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 63 ++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7d57cbecfc8a0..67c6c46b8e07e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1245,26 +1245,16 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
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
+	struct blk_mq_queue_map	qmap = {};
+	cpumask_var_t cpumask;
 	struct ublk_device *ub;
 	unsigned long queue;
 	unsigned int retlen;
+	unsigned int i;
 	int ret = -EINVAL;
 	
 	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
@@ -1276,30 +1266,41 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 
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
+
+	qmap.mq_map = kcalloc(nr_cpu_ids, sizeof(qmap.mq_map), GFP_KERNEL);
+	if (!qmap.mq_map)
+		goto out_put_device;
+	qmap.nr_queues = ub->dev_info.nr_hw_queues;
+	blk_mq_map_queues(&qmap);
+
+	ret = -ENOMEM;
+	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
+		goto out_free_qmap;
+
+	for_each_possible_cpu(i)
+		if (qmap.mq_map[i] == queue)
+			cpumask_set_cpu(i, cpumask);
 
+	ret = -EFAULT;
 	retlen = min_t(unsigned short, header->len, cpumask_size());
-	if (copy_to_user(argp, hctx->cpumask, retlen)) {
-		ret = -EFAULT;
-		goto out;
-	}
-	if (retlen != header->len) {
-		if (clear_user(argp + retlen, header->len - retlen)) {
-			ret = -EFAULT;
-			goto out;
-		}
-	}
+	if (copy_to_user(argp, cpumask, retlen))
+		goto out_put_device;
+
+	if (retlen != header->len &&
+	    clear_user(argp + retlen, header->len - retlen))
+		goto out_put_device;
+
 	ret = 0;
- out:
-	if (ub)
-		ublk_put_device(ub);
+	free_cpumask_var(cpumask);
+out_free_qmap:
+	kfree(qmap.mq_map);
+out_put_device:
+	ublk_put_device(ub);
 	return ret;
 }
 
-- 
2.30.2

