Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D7161
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579811; cv=none; b=NqZtlkg4RCuUom8Ikt/z/2f0BUWoEuVu2mpHwV5zQWe94o5xlkTIVjyjLyaHg4YPzXH65IYdvIDRxG5bZ2BRNnNZoCSeo57t7O/6osJQBg5c8LDTQekSKmHwfAL3PXFkvLx6ZW/PLeuxuNBf3H7IWJwodFNSqV5wwssv8o2AgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579811; c=relaxed/simple;
	bh=C99p26Y6QTsIsLOSy793KVh8/ldNsZdy9uvaXrlJidY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1jdNGrqfq6nBL6YQbDJPQnaL7abpGtHYiwYy8FVn4aVSuLMInJMymVSTUIfATxTTRhD8BPpejjI8Vwz6dNpV6oV5UnRsrT1+8dyAzsIHBHcxAUuaiSCeEudF9g82QTc7DAfoNHLOfX8hVRgljSE5GCMbr+kncciQ6tqHdEIMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0eyLbHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0eyLbHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C405C4CECE;
	Tue, 26 Nov 2024 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732579811;
	bh=C99p26Y6QTsIsLOSy793KVh8/ldNsZdy9uvaXrlJidY=;
	h=From:To:Cc:Subject:Date:From;
	b=B0eyLbHgxf2ufqS3LXAgj6C3d29WQItFqkrdYoKKJaSa7r1aQLwtceMVv/s9JMA8A
	 rSeiA8EIPX0sbuXZ0yr/sSAwUZELZiDCXf6i7ILo2jEtz/CeIp1lPwHgT6C0I88cE+
	 u+gNmrhXXEIjoIBm+Ekm6tY0aoVR8oI3xyeCUSmOry3+L42ug+abvgaqdTSJ9CHPLO
	 DodSZtsKxGMGSKu++MlUrw6vnN51ogaN9+60RsVSgEsOYjf51XmpojFIlo7qB/eX7W
	 SXuR1LqcS04VdO5/FSiUvnFQ9TghHynzMfWVQhKla89I1N505qybXtlEdbypwAIX2D
	 7lx0Wdc+H8cBg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] null_blk: Add rotational feature support
Date: Tue, 26 Nov 2024 09:09:56 +0900
Message-ID: <20241126000956.95983-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate testing of kernel functions related to the rotational
feature (BLK_FEAT_ROTATIONAL) of a block device (e.g. NVMe rotational
bit support), add the rotational boolean configfs attribute and module
parameter to the null_blk driver. If set, a null block device will
report being a rotational device through it queue limits features with
the BLK_FEAT_ROTATIONAL flag.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c     | 13 ++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3c3d8d200abb..32bd232cceef 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -266,6 +266,10 @@ static bool g_zone_full;
 module_param_named(zone_full, g_zone_full, bool, S_IRUGO);
 MODULE_PARM_DESC(zone_full, "Initialize the sequential write required zones of a zoned device to be full. Default: false");
 
+static bool g_rotational;
+module_param_named(rotational, g_rotational, bool, S_IRUGO);
+MODULE_PARM_DESC(rotational, "Set the rotational feature for the device. Default: false");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -468,6 +472,7 @@ NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
+NULLB_DEVICE_ATTR(rotational, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -621,6 +626,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_shared_tags,
 	&nullb_device_attr_shared_tag_bitmap,
 	&nullb_device_attr_fua,
+	&nullb_device_attr_rotational,
 	NULL,
 };
 
@@ -706,7 +712,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"shared_tags,size,submit_queues,use_per_node_hctx,"
 			"virt_boundary,zoned,zone_capacity,zone_max_active,"
 			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size,zone_append_max_sectors,zone_full\n");
+			"zone_size,zone_append_max_sectors,zone_full,"
+			"rotational\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -793,6 +800,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->shared_tags = g_shared_tags;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
 	dev->fua = g_fua;
+	dev->rotational = g_rotational;
 
 	return dev;
 }
@@ -1938,6 +1946,9 @@ static int null_add_dev(struct nullb_device *dev)
 			lim.features |= BLK_FEAT_FUA;
 	}
 
+	if (dev->rotational)
+		lim.features |= BLK_FEAT_ROTATIONAL;
+
 	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, &lim, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index a7bb32f73ec3..6f9fe6171087 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -107,6 +107,7 @@ struct nullb_device {
 	bool shared_tags; /* share tag set between devices for blk-mq */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
 	bool fua; /* Support FUA */
+	bool rotational; /* Fake rotational device */
 };
 
 struct nullb {
-- 
2.47.0

