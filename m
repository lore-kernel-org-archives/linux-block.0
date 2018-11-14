Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3EC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933AF22419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yn90PSz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933AF22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbeKOCGx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbeKOCGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RfxkUeP8DZ/T3akTnH5HwqFg7NNrwhBVgMm0JYo0K+0=; b=Yn90PSz2ToPdsfTUTZiHxf0Jt5
        Z2IFqU7XuFNB0OM5mZXozjUI9zPJjhO4mS5heICOaoGIrIX5+FNv3IfknUI1aqNjOINStVTxqBhSZ
        89PbX5SXGj5/XA+mTrm/IfkDretpm4t8UH+s7LKTxhhLE4KywM8bdBMDMwk43ReDqFWpeza7FMNzn
        hAFZOITIjr/ES/9duj2y1j9gfbalihZqPXrlEfC3ZPYba6UGtkZhjItg0o/d/ntyINfw2dnQV/YF+
        8vnpTI3CL92YVNs7uI8G5WonlYx4Zp58ZEBTm53LUJVDLyBCgGYsx72IPBTdEFPwUMaZAFfruraIx
        BqqH7LdQ==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxd9-0006Su-Cu; Wed, 14 Nov 2018 16:03:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 15/16] block: remove the lock argument to blk_alloc_queue_node
Date:   Wed, 14 Nov 2018 17:02:18 +0100
Message-Id: <20181114160219.28328-16-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the legacy request path gone there is no real need to override the
queue_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c               | 16 +++-------------
 block/blk-mq.c                 |  2 +-
 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/block/null_blk_main.c  |  3 +--
 drivers/block/umem.c           |  2 +-
 drivers/lightnvm/core.c        |  2 +-
 drivers/md/dm.c                |  2 +-
 drivers/nvdimm/pmem.c          |  2 +-
 drivers/nvme/host/multipath.c  |  2 +-
 include/linux/blkdev.h         |  3 +--
 10 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5c8e66a09d82..3f94c9de0252 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -393,7 +393,7 @@ EXPORT_SYMBOL(blk_cleanup_queue);
 
 struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 {
-	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE, NULL);
+	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
@@ -473,17 +473,8 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
  * blk_alloc_queue_node - allocate a request queue
  * @gfp_mask: memory allocation flags
  * @node_id: NUMA node to allocate memory from
- * @lock: For legacy queues, pointer to a spinlock that will be used to e.g.
- *        serialize calls to the legacy .request_fn() callback. Ignored for
- *	  blk-mq request queues.
- *
- * Note: pass the queue lock as the third argument to this function instead of
- * setting the queue lock pointer explicitly to avoid triggering a sporadic
- * crash in the blkcg code. This function namely calls blkcg_init_queue() and
- * the queue lock pointer must be set before blkcg_init_queue() is called.
  */
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
-					   spinlock_t *lock)
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
 	int ret;
@@ -534,8 +525,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 #endif
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
-
-	q->queue_lock = lock ? : &q->__queue_lock;
+	q->queue_lock = &q->__queue_lock;
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3f057fdd045..3b823891b3ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2548,7 +2548,7 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
 	struct request_queue *uninit_q, *q;
 
-	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node, NULL);
+	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node);
 	if (!uninit_q)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b66c59ce6260..f973a2a845c8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2792,7 +2792,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 63c23fcfc4df..62c9654b9ce8 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1659,8 +1659,7 @@ static int null_add_dev(struct nullb_device *dev)
 		}
 		null_init_queues(nullb);
 	} else if (dev->queue_mode == NULL_Q_BIO) {
-		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node,
-						NULL);
+		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node);
 		if (!nullb->q) {
 			rv = -ENOMEM;
 			goto out_cleanup_queues;
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 8a27b5adc2b3..aa035cf8a51d 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,7 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!card->queue)
 		goto failed_alloc;
 
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..60ab11fcc81c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -389,7 +389,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_dev;
 	}
 
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node, NULL);
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue) {
 		ret = -ENOMEM;
 		goto err_disk;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c510179a7f84..a733e4c920af 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1896,7 +1896,7 @@ static struct mapped_device *alloc_dev(int minor)
 	INIT_LIST_HEAD(&md->table_devices);
 	spin_lock_init(&md->uevent_lock);
 
-	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id, NULL);
+	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id);
 	if (!md->queue)
 		goto bad;
 	md->queue->queuedata = md;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 0e39e3d1846f..f7019294740c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -393,7 +393,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
-	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev), NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..b82b0d3ca39a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -276,7 +276,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
 		return 0;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!q)
 		goto out;
 	q->queuedata = head;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b887e24837e..666c73b97b0d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1125,8 +1125,7 @@ extern long nr_blockdev_pages(void);
 
 bool __must_check blk_get_queue(struct request_queue *);
 struct request_queue *blk_alloc_queue(gfp_t);
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
-					   spinlock_t *lock);
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
-- 
2.19.1

