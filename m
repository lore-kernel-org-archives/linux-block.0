Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30480C6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 02:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjC1CbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjC1CbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 22:31:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4100270E
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679970659; x=1711506659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D6JKw5tCyaER/4VMuo5XW+FsPn0mXLeUZcXFODltzSQ=;
  b=a4Gv53cDDPDxKaCRxFUAQ0HemWg21co/CYxxDF6Y+74aS7vTFveVXp7l
   qbzOh0mj9O4aw4veraF+92G6VYLpLrJNtKMonL0FiIFqeIlJcFXv5wQsw
   mVgJ1FmVsd0iH2JPZGsCI+FBDE0D//GS+WCP4hF53k+iwa1LNbIM9004/
   rijgzNHFplAXFlBV0muo2dpoqNtCY41z3zkigd7iu5jFICB7L/xFAmdI/
   NN/fed4EhhtnzpUDT2hRsWnw6Pu5grhmFiEYs39qIFP34GWFu68TQIPgM
   ok+dGjPs/ZoxIX3iCtRQ9zXtbFKJenOcy6+UuQVakrOSwTz8khURgxswj
   g==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="226460241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 10:29:36 +0800
IronPort-SDR: 0MMgnuhMKZiwlXMVG/B+7HjRxIEVbksXCwrupwD/VP/Kjh8N+4dcS33Dc20gfInmyez+osPAiQ
 KDJoCbrwI4Q1K0/l13hrrQx1V5gG4DVYXfTQbgdBOOY73KBkehy5U/wV7bdmP7YwblkUtM7sTS
 +YHRuwdHp/Iv//PoUpWcc3KlVg0FmkcsaJbD4XMF/LV0gtS+7VRXgAWBr/KTXarphkr3jfRCUu
 YW50MdQWmiTsdOiXV9dM5+FdF9DmENIhBh78q//fHtnpYrLaLtT5DeCZqmML4P9fBSYvVXtUyT
 QRI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 18:45:47 -0700
IronPort-SDR: 0/0GEX6ngGBREaUzdfSBf8lYe2pQ3uS29PJdD1JWhlRzyTmjYNYXreUtYy2S4LksHPnpkpT4ox
 DGA0y7IYpeBui8TvXkEU/vohl4NTbGlmUJ3rY1W3u5YPGGubmDts7dKz24AWT+3AzwBGh78UCj
 GrUzhUcV3jV7pNKY2AxXBm+6ktj4EYpX+492RUptqyKaHbEFDkI7Szkp2HmOdR/1i9DPuOZUaS
 C3//8gljkO1bgab95eTq6D3yLIVlWfVFaiBixK1izdawHda/Dnfjg2dcfCN6NpFh1vt1kzyJsc
 I4k=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2023 19:29:35 -0700
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
Subject: [PATCH 2/2] virtio-blk: fix ZBD probe in kernels without ZBD support
Date:   Mon, 27 Mar 2023 22:29:28 -0400
Message-Id: <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
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
---
 drivers/block/virtio_blk.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0b49fd2bd3bf..6d2674aa0551 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -867,16 +867,12 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
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
+ * Host-managed zoned devices can't be supported, but others are good
+ * to go as regular block devices.
  */
 #define virtblk_report_zones       NULL
 static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
@@ -885,11 +881,16 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	return -EOPNOTSUPP;
-}
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return false;
+	u8 model;
+
+	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
+	if (model == VIRTIO_BLK_Z_HM) {
+		dev_err(&vdev->dev,
+			"zoned devices are not supported by the kernel");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1575,7 +1576,11 @@ static int virtblk_probe(struct virtio_device *vdev)
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
@@ -1681,10 +1686,7 @@ static unsigned int features[] = {
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

