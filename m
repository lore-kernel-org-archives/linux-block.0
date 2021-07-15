Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF2C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8851611AB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhGOJwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbhGOJwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 05:52:47 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jul 2021 02:49:53 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D9C061760;
        Thu, 15 Jul 2021 02:49:53 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id BC8002E1700;
        Thu, 15 Jul 2021 12:48:44 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 74KuWyvOBd-mix8WY4w;
        Thu, 15 Jul 2021 12:48:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1626342524; bh=cjfhfx3Yno6tkEv/8GHdGDPNh7oLRWVFoA9ssU6mL2k=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=ADGlAR41DjSGz+p2Kd3uCOI6BN3IEePhYhTM+JML0jCr88iB7qrJVz4A/vE93GpCm
         /qDU6n0v+V/zmNiMi/2pATE9LcmzIE/wyPAMw5OveR7W+zH/9/EoRHXsKDhvOmhNrI
         +pT8IKzJeUSrQC9Q6BPgxCzZFO2yi5efT0On3Gao=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 77.88.0.204-spb.dhcp.yndx.net (77.88.0.204-spb.dhcp.yndx.net [77.88.0.204])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id JSE0wE09V8-mi2KCkLw;
        Thu, 15 Jul 2021 12:48:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Yury Kamenev <damtev@yandex-team.ru>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, hch@lst.de, cand@gmx.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Kamenev <damtev@yandex-team.ru>
Subject: [PATCH 1/1] virtio: disable partitions scanning for no partitions block
Date:   Thu, 15 Jul 2021 12:47:07 +0300
Message-Id: <20210715094707.19997-2-damtev@yandex-team.ru>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210715094707.19997-1-damtev@yandex-team.ru>
References: <20210715094707.19997-1-damtev@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yury Kamenev <damtev@yandex-team.ru>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/block/Kconfig                         |  7 +++++
 drivers/block/virtio_blk.c                    | 26 +++++++++++++++++++
 include/uapi/linux/virtio_blk.h               |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..941bdaf5c167 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6076,6 +6076,9 @@
 			brightness level.
 			default: 1

+	virtiopartscan
+		Enable virtio block device partition scanning omission based on VIRTIO_BLK_F_NO_PART_SCAN feature flag.
+
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 63056cfd4b62..69ecd3fd7037 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -399,6 +399,13 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.

+config VIRTIO_BLK_NO_PART_SCAN
+	bool "Disable partition scanning for devices with no partitions"
+	depends on VIRTIO_BLK
+	help
+	  Disable partition scanning for devices with no partitions.
+	  Can reduce the kernel start time for tiny systems like squashfs images.
+
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4b49df2dfd23..479711d3791c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -692,6 +692,19 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);

+#ifndef MODULE
+#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
+static int partitions_scanning_disable __read_mostly;
+
+static int __init partitions_scanning_setup(char *__unused)
+{
+	partitions_scanning_disable = 1;
+	return 1;
+}
+__setup("nopartscan", partitions_scanning_setup);
+#endif
+#endif
+
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -790,6 +803,13 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->disk->flags |= GENHD_FL_EXT_DEVT;
 	vblk->index = index;

+#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
+	if (unlikely(partitions_scanning_disable))
+		/* disable partitions scanning if it was stated in virtio features*/
+		if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PART_SCAN))
+			vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
+#endif
+
 	/* configure queue flush support */
 	virtblk_update_cache_mode(vdev);

@@ -966,6 +986,9 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
+	VIRTIO_BLK_F_NO_PART_SCAN,
+#endif
 }
 ;
 static unsigned int features[] = {
@@ -973,6 +996,9 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
+	VIRTIO_BLK_F_NO_PART_SCAN,
+#endif
 };

 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..9b381675342a 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_NO_PART_SCAN	16	/* Disable partition scanning */

 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
--
2.24.3 (Apple Git-128)

