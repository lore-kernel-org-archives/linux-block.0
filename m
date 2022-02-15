Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3446C43217
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiBOJpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:45:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiBOJpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:45:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB821E61E8;
        Tue, 15 Feb 2022 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9GwSkxFbAAcxg10ZpVTsZzHKPI4VoEWLYjJIK1zScJg=; b=Ay91D2S3n80JCKQKYiFR535ia4
        XH9lTKIQLPYk9wr/KzAwAPVeut0862az9cfIXhw6zP8ontWaT4V71rXUGclOCC6dFTDmfE9kBeZC7
        cHqAWQvX2J4HJzynMS8BSH8LF+D3rn7YSf1hMKhFr63Ypbb1A2ut+ljQmAy/0BDGomYVbLDaJRbte
        w9Coq4645CDXe5048nqrktKJL+kTGlWfBLMLwfe/hV4oR/QRr0BGfC1CPx38MFqoBJrBUGTU3uXWH
        EevtCvUpvlC2JZQYId3zxiGsTGbCf6MlqBPvNb/CKPLaeVOLm2tvK/YvxZSvu5ic91mUXLGwp/cpI
        p17PU5qA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuOp-00267N-39; Tue, 15 Feb 2022 09:45:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 5/5] virtio_blk: simplify refcounting
Date:   Tue, 15 Feb 2022 10:45:14 +0100
Message-Id: <20220215094514.3828912-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement the ->free_disk method to free the virtio_blk structure only
once the last gendisk reference goes away instead of keeping a local
refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 66 ++++++++------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b4..5c636ca7f1a7f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -69,13 +69,6 @@ struct virtio_blk {
 	/* Process context for config space updates */
 	struct work_struct config_work;
 
-	/*
-	 * Tracks references from block_device_operations open/release and
-	 * virtio_driver probe/remove so this object can be freed once no
-	 * longer in use.
-	 */
-	refcount_t refs;
-
 	/* What host tells us, plus 2 for header & tailer. */
 	unsigned int sg_elems;
 
@@ -391,43 +384,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
-static void virtblk_get(struct virtio_blk *vblk)
-{
-	refcount_inc(&vblk->refs);
-}
-
-static void virtblk_put(struct virtio_blk *vblk)
-{
-	if (refcount_dec_and_test(&vblk->refs)) {
-		ida_simple_remove(&vd_index_ida, vblk->index);
-		mutex_destroy(&vblk->vdev_mutex);
-		kfree(vblk);
-	}
-}
-
-static int virtblk_open(struct block_device *bd, fmode_t mode)
-{
-	struct virtio_blk *vblk = bd->bd_disk->private_data;
-	int ret = 0;
-
-	mutex_lock(&vblk->vdev_mutex);
-
-	if (vblk->vdev)
-		virtblk_get(vblk);
-	else
-		ret = -ENXIO;
-
-	mutex_unlock(&vblk->vdev_mutex);
-	return ret;
-}
-
-static void virtblk_release(struct gendisk *disk, fmode_t mode)
-{
-	struct virtio_blk *vblk = disk->private_data;
-
-	virtblk_put(vblk);
-}
-
 /* We provide getgeo only to please some old bootloader/partitioning tools */
 static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
@@ -460,11 +416,19 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return ret;
 }
 
+static void virtblk_free_disk(struct gendisk *disk)
+{
+	struct virtio_blk *vblk = disk->private_data;
+
+	ida_simple_remove(&vd_index_ida, vblk->index);
+	mutex_destroy(&vblk->vdev_mutex);
+	kfree(vblk);
+}
+
 static const struct block_device_operations virtblk_fops = {
-	.owner  = THIS_MODULE,
-	.open = virtblk_open,
-	.release = virtblk_release,
-	.getgeo = virtblk_getgeo,
+	.owner  	= THIS_MODULE,
+	.getgeo		= virtblk_getgeo,
+	.free_disk	= virtblk_free_disk,
 };
 
 static int index_to_minor(int index)
@@ -791,8 +755,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out_free_index;
 	}
 
-	/* This reference is dropped in virtblk_remove(). */
-	refcount_set(&vblk->refs, 1);
 	mutex_init(&vblk->vdev_mutex);
 
 	vblk->vdev = vdev;
@@ -970,7 +932,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	flush_work(&vblk->config_work);
 
 	del_gendisk(vblk->disk);
-	blk_cleanup_disk(vblk->disk);
+	blk_cleanup_queue(vblk->disk->queue);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
 	mutex_lock(&vblk->vdev_mutex);
@@ -986,7 +948,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 
 	mutex_unlock(&vblk->vdev_mutex);
 
-	virtblk_put(vblk);
+	put_disk(vblk->disk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2

