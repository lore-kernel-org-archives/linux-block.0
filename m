Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B9C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jan 2022 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiACSP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 13:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiACSP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jan 2022 13:15:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE288C061761
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 10:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 871F6B8106E
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 18:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7BC36AEE;
        Mon,  3 Jan 2022 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641233755;
        bh=bM/tuR7/FVEybgFjgSQjrKbWH0+FJOOTrdnM4iMa1l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcCx+MjsJp+n0oPvV7EtafLNMB8fTDtN0/Ya3nylrvicO9JfybQN7VwSriOSX776J
         XI+nDeoISQBde3MxPhVieS2dpZO6dfnmTwH8BLEOMO1mk0IMDolYna7r2f0LH5m6wC
         KBuJEZxrG5P0o6aKFdApdvNSPkvzc9ruSf07shm/SX0ARogZgQguo13hlelWQFWF4d
         xMaXRWOm2hpJW6kaWGwe2LFq97g33Mv9t1ylX7GA6aCg/yU7/x3L0CNvTNiqLcPisn
         ofv3xDir4uHdbtIOEdcM+BgLsz9XpUfhRy2BM1m6+VU+XlaaFzgfLaWCbSBdllBJZ8
         38BHW+Dd/ko6A==
Date:   Mon, 3 Jan 2022 10:15:52 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 03, 2022 at 05:23:08PM +0200, Max Gurtovoy wrote:
> On 12/30/2021 5:30 PM, Keith Busch wrote:
> > I think it just may work if we export blk_mq_get_driver_tag().
> 
> do you have a suggestion for the NVMe/PCI driver ?

The following tests fine with my multi-namespace setups. I have real
hardware with namespace management capabilities, but qemu can also
easily emulate it too for anyone who doesn't have one.

---
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 5668e28be0b7..84f2e73d0c7c 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -41,12 +41,6 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 	return sbq_wait_ptr(bt, &hctx->wait_index);
 }
 
-enum {
-	BLK_MQ_NO_TAG		= -1U,
-	BLK_MQ_TAG_MIN		= 1,
-	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
-};
-
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d7c9d3e0329..b4540723077a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1589,6 +1589,7 @@ bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
+EXPORT_SYMBOL_GPL(__blk_mq_get_driver_tag);
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
@@ -2582,11 +2583,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * same queue, caller must ensure that's the case.
 		 *
 		 * Since we pass off the full list to the driver at this point,
-		 * we do not increment the active request count for the queue.
-		 * Bypass shared tags for now because of that.
+		 * we are counting on the driver to increment the active
+		 * request count for the queue.
 		 */
-		if (q->mq_ops->queue_rqs &&
-		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
 				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 948791ea2a3e..0f37ae906901 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -268,21 +268,6 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
-bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
-
-static inline bool blk_mq_get_driver_tag(struct request *rq)
-{
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	if (rq->tag != BLK_MQ_NO_TAG &&
-	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
-		hctx->tags->rqs[rq->tag] = rq;
-		return true;
-	}
-
-	return __blk_mq_get_driver_tag(hctx, rq);
-}
-
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..f50483475c12 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -992,8 +992,9 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 		return false;
 	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
 		return false;
+	if (!blk_mq_get_driver_tag(req))
+		return false;
 
-	req->mq_hctx->tags->rqs[req->tag] = req;
 	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 550996cf419c..8fb544a35330 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1072,6 +1072,27 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
 
+enum {
+	BLK_MQ_NO_TAG		= -1U,
+	BLK_MQ_TAG_MIN		= 1,
+	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
+};
+
+bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
+
+static inline bool blk_mq_get_driver_tag(struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (rq->tag != BLK_MQ_NO_TAG &&
+	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		hctx->tags->rqs[rq->tag] = rq;
+		return true;
+	}
+
+	return __blk_mq_get_driver_tag(hctx, rq);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int blk_rq_zone_no(struct request *rq)
 {
--
