Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB82C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 03:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8C224BD
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 03:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbhARD7t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:59:49 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24842 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732002AbhARD7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Jan 2021 22:59:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UM0aJVD_1610942338;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UM0aJVD_1610942338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jan 2021 11:58:58 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH RFC] virtio-blk: support per-device queue depth
Date:   Mon, 18 Jan 2021 11:58:58 +0800
Message-Id: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

module parameter 'virtblk_queue_depth' was firstly introduced for
testing/benchmarking purposes described in commit fc4324b4597c
("virtio-blk: base queue-depth on virtqueue ringsize or module param").
Since we have different virtio-blk devices which have different
capabilities, it requires that we support per-device queue depth instead
of per-module. So defaultly use vq free elements if module parameter
'virtblk_queue_depth' is not set.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 drivers/block/virtio_blk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 145606d..f83a417 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -705,6 +705,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
+	unsigned int queue_depth;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -755,17 +756,18 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out_free_vq;
 	}
 
-	/* Default queue sizing is to fill the ring. */
-	if (!virtblk_queue_depth) {
-		virtblk_queue_depth = vblk->vqs[0].vq->num_free;
+	if (likely(!virtblk_queue_depth)) {
+		queue_depth = vblk->vqs[0].vq->num_free;
 		/* ... but without indirect descs, we use 2 descs per req */
 		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
-			virtblk_queue_depth /= 2;
+			queue_depth /= 2;
+	} else {
+		queue_depth = virtblk_queue_depth;
 	}
 
 	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
 	vblk->tag_set.ops = &virtio_mq_ops;
-	vblk->tag_set.queue_depth = virtblk_queue_depth;
+	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
 	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	vblk->tag_set.cmd_size =
-- 
1.8.3.1

