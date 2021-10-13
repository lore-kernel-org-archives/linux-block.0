Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C995C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F42A60D07
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJMMsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhJMMsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 08:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pio+Rp9lSXqTgcX0jd1ToQMieUTpIAr4Wm8ggp456+o=;
        b=fDi80G8h49m015tHrzDRZ4dnqOQz0tumxczgdg4RqrZK9kUk+sxseASBtqJwMu98wFSVv+
        S26k9vkQSgyDok8hhvjNtlVGQc+sWGXq9I+FCQzYrISs42izR6FhOYKkrFLxywRPClTBkd
        yMxLe2DuDR0GAMUuJa0Ll+tDy/ZZCjw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-XTE1s7i2M7KGi33xSKesxQ-1; Wed, 13 Oct 2021 08:46:13 -0400
X-MC-Unique: XTE1s7i2M7KGi33xSKesxQ-1
Received: by mail-wr1-f71.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso1865592wri.17
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pio+Rp9lSXqTgcX0jd1ToQMieUTpIAr4Wm8ggp456+o=;
        b=4Qux6w+6ixC9dh1UnKzQXPSFZb7OqAgJu4PngkVPErOXY8MXTRwz3gN6s1nBKW3B4p
         pMWvTTTdoiMn6jpHuyr8p8jpGF7CA6E3h85uZjbdpFUR5TyrR0Kxy70fj4OgEMDLWa2Z
         NsPZmLQvXJtDBdRLAOhCB4bGEK6mJH4lVu6vrHBoYrzH8Gq7QUSYZf3z7ns82Lfs5hXX
         pRfa2+HVL3LpoNjkVpOPsk8W/k7Iaow/4SWzr3u2IcndI9M7r2h3G7ZHWZym4zKp9sbk
         HeY2+HkNfhKy7/iSkrTamEnbWb81/RwHEEXZeMgR/BMbMaGrhxqjsTVGlFNnjo39/ePt
         X+HA==
X-Gm-Message-State: AOAM531ecOJfJ3hSinvZHNKKD/UlPSKsXoYJgTsoJPtxyWgygrwQPBGN
        xXLIIEYMY9EbIO7i4Tye+NLSkrqgszknV2exDtB9ulpH1JWBFb2fHCSaWDcv7XOxvEAJd3ff9iT
        R5I9Y7xRAAGyUvS0xQsveiRI=
X-Received: by 2002:a1c:3586:: with SMTP id c128mr12804926wma.78.1634129172062;
        Wed, 13 Oct 2021 05:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWON28WQcyoAHS7/UuoGSQN5DfnmTJuEAcV0OBwnEccLiKLDK1QD4fr9pYUdKD+eXE6vI3mA==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr12804894wma.78.1634129171809;
        Wed, 13 Oct 2021 05:46:11 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id s1sm5015348wmc.47.2021.10.13.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:46:11 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:46:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] Revert "virtio-blk: Add validation for block size in config
 space"
Message-ID: <20211013124553.23803-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It turns out that access to config space before completing the feature
negotiation is broken for big endian guests at least with QEMU hosts up
to 6.1 inclusive.  This affects any device that accesses config space in
the validate callback: at the moment that is virtio-net with
VIRTIO_NET_F_MTU but since 82e89ea077b9 ("virtio-blk: Add validation for
block size in config space") that also started affecting virtio-blk with
VIRTIO_BLK_F_BLK_SIZE. Further, unlike VIRTIO_NET_F_MTU which is off by
default on QEMU, VIRTIO_BLK_F_BLK_SIZE is on by default, which resulted
in lots of people not being able to boot VMs on BE.

The spec is very clear that what we are doing is legal so QEMU needs to
be fixed, but given it's been broken for so many years and no one
noticed, we need to give QEMU a bit more time before applying this.

Further, this patch is incomplete (does not check blk size is a power
of two) and it duplicates the logic from nbd.

Revert for now, and we'll reapply a cleaner logic in the next release.

Cc: stable@vger.kernel.org
Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
Cc: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3bd083b411..303caf2d17d0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,28 +689,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
-static int virtblk_validate(struct virtio_device *vdev)
-{
-	u32 blk_size;
-
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
-		return 0;
-
-	blk_size = virtio_cread32(vdev,
-			offsetof(struct virtio_blk_config, blk_size));
-
-	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
-		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
-
-	return 0;
-}
-
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -722,6 +700,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
 
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
 			     GFP_KERNEL);
 	if (err < 0)
@@ -836,14 +820,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	else
 		blk_size = queue_logical_block_size(q);
 
-	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE) {
-		dev_err(&vdev->dev,
-			"block size is changed unexpectedly, now is %u\n",
-			blk_size);
-		err = -EINVAL;
-		goto out_cleanup_disk;
-	}
-
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
@@ -1009,7 +985,6 @@ static struct virtio_driver virtio_blk = {
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
-	.validate			= virtblk_validate,
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
-- 
MST

