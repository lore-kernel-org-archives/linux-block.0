Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EF37704
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706588504; cv=none; b=iRrG42c0wVf8VKgiGG6cX1qq/KUUH7InHlN53cwlNeuHpzfAR+yeHICnSehFZy4v6se2hMrtcCV1wnVuQq0uWci8UfDdRQG4765TT/BOuARNQduZOB6SwIDQGlXp6pdiDlREPcsMqmelP2YyW2/qTPcrkn9HHt5n0c/uV9A3xMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706588504; c=relaxed/simple;
	bh=XL0yLKPcLZfYzwxKHMm5T8KPZZEeMdkZu8MYjRsdbns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hf5cgQUVGAkFwVHRQmDTaoVdxLOb43FbGmgB+27w1Jx41LPuPcT9/eRMlPpB2jle+iKGJ4mBSlmNpBqIi5/CvnZnj4ClseMKrJWe34ckLF2ZE6ufixDKlpXCYeUUu2C8WlHEy4K5hsTi9+qKfkAQiwCF6Q7t/dnoxGq1a62hLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nxhtAmo5; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nxhtAmo5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706588502; x=1738124502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XL0yLKPcLZfYzwxKHMm5T8KPZZEeMdkZu8MYjRsdbns=;
  b=nxhtAmo5A5hHMpPPcVaGRNbIhyS9sXbLayJuFzDWoAc49Fd5i+fbtwcO
   KAb/RPcw8euDiigZ3ewPTK18Cg5YBrctfyx0X14xo7+pokQaiel/mbxFB
   uJeMAb0kpP0vx0lSzWaTmUypmyACh0s4Q0Au0HSVNc9oy6aYoU6u7aFom
   KikNaCxMsMn5yJGvxmMc2vZ6qpCNMtVOc9c/yVUTBaQYd/SPDW+CX6pp1
   aa5U1KRiiOpxuM4/rnaYlEHI6Tfz1fb6KMP70IB6ao3TBCqDfCv3w96oQ
   TNNvFHzhY7iL6+itxwiMzam5yZ2F7ZikaaFhSbJtWVMvJwUcozKdUO1Xu
   w==;
X-CSE-ConnectionGUID: WtdmG60JTfKgBBoi11np1w==
X-CSE-MsgGUID: yD5fX8L5Q6SyIMKgfQYIuA==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="8102354"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 12:21:35 +0800
IronPort-SDR: QxZdbpfXm8Vaf2vYDDy1Osd/5ZTM7YmbWtIFGiNNeq6ov/55sXL7VqXcHd2pO3GxoKW2g3q549
 rGQ7gX7iulcg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 19:31:30 -0800
IronPort-SDR: OLK5y4xUffi0RdFXBZW0iDBuiTXQKkE9gBfaUFlcHwrBOtxkVh/95iNMcMhpDIMLdlz6EqCSev
 1XeuBfBMy6cw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2024 20:21:33 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v3] null_blk: add configfs variable shared_tags
Date: Tue, 30 Jan 2024 13:21:34 +0900
Message-ID: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow setting shared_tags through configfs, which could only be set as a
module parameter. For that purpose, delay tag_set initialization from
null_init() to null_add_dev(). Refer tag_set.ops as the flag to check if
tag_set is initialized or not.

The following parameters can not be set through configfs yet:

    timeout
    requeue
    init_hctx

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch will allow running the blktests test cases block/010 and block/022
using the built-in null_blk driver. Corresponding blktests side changes are
drafted here [1].

[1] https://github.com/kawasaki/blktests/tree/shared_tags

Changes from v2:
* Used tag_set.ops instead of tag_set_initialized

Changes from v1:
* Removed unnecessary global variable initializer

 drivers/block/null_blk/main.c     | 38 ++++++++++++++++---------------
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 36755f263e8e..4281371c81fe 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -165,8 +165,8 @@ static bool g_blocking;
 module_param_named(blocking, g_blocking, bool, 0444);
 MODULE_PARM_DESC(blocking, "Register as a blocking blk-mq driver device");
 
-static bool shared_tags;
-module_param(shared_tags, bool, 0444);
+static bool g_shared_tags;
+module_param_named(shared_tags, g_shared_tags, bool, 0444);
 MODULE_PARM_DESC(shared_tags, "Share tag set between devices for blk-mq");
 
 static bool g_shared_tag_bitmap;
@@ -426,6 +426,7 @@ NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
+NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
@@ -571,6 +572,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_offline,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
+	&nullb_device_attr_shared_tags,
 	&nullb_device_attr_shared_tag_bitmap,
 	NULL,
 };
@@ -653,10 +655,11 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"badblocks,blocking,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
-			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
-			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
-			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
+			"poll_queues,power,queue_mode,shared_tag_bitmap,"
+			"shared_tags,size,submit_queues,use_per_node_hctx,"
+			"virt_boundary,zoned,zone_capacity,zone_max_active,"
+			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
+			"zone_size\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -738,6 +741,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_max_active = g_zone_max_active;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
+	dev->shared_tags = g_shared_tags;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
 	return dev;
 }
@@ -2124,7 +2128,14 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out_free_nullb;
 
 	if (dev->queue_mode == NULL_Q_MQ) {
-		if (shared_tags) {
+		if (dev->shared_tags) {
+			if (!tag_set.ops) {
+				rv = null_init_tag_set(NULL, &tag_set);
+				if (rv) {
+					tag_set.ops = NULL;
+					goto out_cleanup_queues;
+				}
+			}
 			nullb->tag_set = &tag_set;
 			rv = 0;
 		} else {
@@ -2311,18 +2322,12 @@ static int __init null_init(void)
 		g_submit_queues = 1;
 	}
 
-	if (g_queue_mode == NULL_Q_MQ && shared_tags) {
-		ret = null_init_tag_set(NULL, &tag_set);
-		if (ret)
-			return ret;
-	}
-
 	config_group_init(&nullb_subsys.su_group);
 	mutex_init(&nullb_subsys.su_mutex);
 
 	ret = configfs_register_subsystem(&nullb_subsys);
 	if (ret)
-		goto err_tagset;
+		return ret;
 
 	mutex_init(&lock);
 
@@ -2349,9 +2354,6 @@ static int __init null_init(void)
 	unregister_blkdev(null_major, "nullb");
 err_conf:
 	configfs_unregister_subsystem(&nullb_subsys);
-err_tagset:
-	if (g_queue_mode == NULL_Q_MQ && shared_tags)
-		blk_mq_free_tag_set(&tag_set);
 	return ret;
 }
 
@@ -2370,7 +2372,7 @@ static void __exit null_exit(void)
 	}
 	mutex_unlock(&lock);
 
-	if (g_queue_mode == NULL_Q_MQ && shared_tags)
+	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 }
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..7bcfc0922ae8 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -119,6 +119,7 @@ struct nullb_device {
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
+	bool shared_tags; /* share tag set between devices for blk-mq */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
 };
 
-- 
2.43.0

