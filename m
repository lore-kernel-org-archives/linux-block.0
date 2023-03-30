Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9385BC761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC3VuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjC3VuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:50:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD731C173
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680212999; x=1711748999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYblPRkRhwhAWF1bO7/SwUc4kG1uyGLgsuO6Org0QAw=;
  b=UhcsIC1lCnNxbIitYuZyUP8qRxQ6fzSfCGSIz6GkB0YAxVzRDXnVESRS
   8RKAUnnljLiqNGElxCJ2Id/nfWvrWk+ZmtZKwJ7hITw44ANkag11wh9O3
   0oNpMnaLlNiBuIxv2D10upIEIzBHIXTFfWEFkFkM5mjS7ez86rdB7YVUs
   WHGZh0UeAkp1xvSmm4cqCGwzYpE6erwAnRxHSh3U7n5pVsRijf3lB8ZMS
   ATOKELcgPFsIhtyWZ9Gor4vzx6NAh6kGhN2/vnxgktNcKKecvB6CZchtm
   Hl2eyQyO0+nM80H3dRIb9G5LQQm7sW8g3B0+FDlDend/SCyE31CGncKdk
   A==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="331371075"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 05:49:59 +0800
IronPort-SDR: aSqANSephZG8QL0t/uWwXbd7vrTcO7IKoUZNUK/JxzdofHbUR4aamGL7jVejaTExaIBw/3hr6L
 NODkZSAnVS5Pd0PAtCw8em0Ui0CNu06I1OENXP+Uj4RZgR97YZ98jxB7EnJq6CDNJBTpMY7BPp
 M5+rZqo8w0C/E1JcRj+XuUKqfAcrYoepTpD4QYOU/Wr5UKVwsH4zgZxbTnOK3ckq1wwC6pBHVH
 eT3pFv4LZyFeUxLYo1dfATJRl3YzMNmiV6ZRud2Lykyg96YRXV0vla2dIaX0rgh3+NPsIPcFbx
 TCo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 14:06:07 -0700
IronPort-SDR: DNvGBiq89+ZAQJlWk3BqyqkYzKCO/2v/F1gd7R/I6LgvpyUPRbBjFHdso6rFzxziCulUKYkrh/
 tENgRzamSf6jpHM+NOCreBYdFJVcBX9QsnKAIBa988xqK400Usuq+hoVuuOFzQGfaDGN2UX0OO
 PurFpJYjJx5dwVrMdWsLK8umP2+eGv3udnZQiBNFLT2Q84pdA2BkzNOSNue6gULJE16W7trw1w
 9x3lT0PX6oIsH1MrrPeArXLbV2JW56fvpK4FEUx32X/usacniiyGW1H4x+GyiDWqDyasKPvSHJ
 0Hg=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Mar 2023 14:49:58 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 2/2] virtio-blk: fix ZBD probe in kernels without ZBD support
Date:   Thu, 30 Mar 2023 17:49:53 -0400
Message-Id: <20230330214953.1088216-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the kernel is built without support for zoned block devices,
virtio-blk probe needs to error out any host-managed device scans
to prevent such devices from appearing in the system as non-zoned.
The current virtio-blk code simply bypasses all ZBD checks if
CONFIG_BLK_DEV_ZONED is not defined and this leads to host-managed
block devices being presented as non-zoned in the OS. This is one of
the main problems this patch series is aimed to fix.

In this patch, make VIRTIO_BLK_F_ZONED feature defined even when
CONFIG_BLK_DEV_ZONED is not. This change makes the code compliant with
the voted revision of virtio-blk ZBD spec. Modify the probe code to
look at the situation when VIRTIO_BLK_F_ZONED is negotiated in a kernel
that is built without ZBD support. In this case, the code checks
the zoned model of the device and fails the probe is the device
is host-managed.

The patch also adds the comment to clarify that the call to perform
the zoned device probe is correctly placed after virtio_device ready().

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/virtio_blk.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4f0dbbb3d4a5..2b918e28acaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -866,16 +866,12 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
-}
-
 #else
 
 /*
  * Zoned block device support is not configured in this kernel.
- * We only need to define a few symbols to avoid compilation errors.
+ * Host-managed zoned devices can't be supported, but others are
+ * good to go as regular block devices.
  */
 #define virtblk_report_zones       NULL
 
@@ -886,12 +882,16 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	return -EOPNOTSUPP;
-}
+	u8 model;
 
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return false;
+	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
+	if (model == VIRTIO_BLK_Z_HM) {
+		dev_err(&vdev->dev,
+			"virtio_blk: zoned devices are not supported");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1577,7 +1577,11 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtblk_has_zoned_feature(vdev)) {
+	/*
+	 * All steps that follow use the VQs therefore they need to be
+	 * placed after the virtio_device_ready() call above.
+	 */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
@@ -1683,10 +1687,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
-#ifdef CONFIG_BLK_DEV_ZONED
-	VIRTIO_BLK_F_ZONED,
-#endif /* CONFIG_BLK_DEV_ZONED */
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
 };
 
 static struct virtio_driver virtio_blk = {
-- 
2.34.1

