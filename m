Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35453 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761793AbdAIToj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 14:44:39 -0500
Received: by mail-pg0-f50.google.com with SMTP id 194so16680980pgd.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2017 11:44:39 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] virtio_blk: fix panic in initialization error path
Date: Mon,  9 Jan 2017 11:44:12 -0800
Message-Id: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If blk_mq_init_queue() returns an error, it gets assigned to
vblk->disk->queue. Then, when we call put_disk(), we end up calling
blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
only assigning to vblk->disk->queue on success.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5545a679abd8..8587361e5356 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -628,11 +628,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_put_disk;
 
-	q = vblk->disk->queue = blk_mq_init_queue(&vblk->tag_set);
+	q = blk_mq_init_queue(&vblk->tag_set);
 	if (IS_ERR(q)) {
 		err = -ENOMEM;
 		goto out_free_tags;
 	}
+	vblk->disk->queue = q;
 
 	q->queuedata = vblk;
 
-- 
2.11.0

