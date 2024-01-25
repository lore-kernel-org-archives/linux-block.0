Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF141CA81
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177676; cv=none; b=X7uhdFZFeHlgSWeFC/9kPyKWq7BeKHqlihVKgFbPBsDr8OFM5OJlIH//foYt46AfgJpNskoIa3dQback9yJ+3PqwVGKezbWGYC9/ZpjZ//5J4EZTr4pRscCvqQWfDqtUXvuwp5sWdP1o2rhyOtaaypjzZNziGQCCtsZQQCL07xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177676; c=relaxed/simple;
	bh=qtecy34DLD5a1HWtOeAD2t0mx1jlKputlV6RHNPGPs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8nFP9lAqisG31Jgwqpuo7V7o2o+i8kKUQ4TsMqca+t82TvA75cIo5QaTrxutC+Nav6ojjyNc4HL/Yj934S9yWH65dl76w5oGseRUqvP3RYWIfVwf/jxKWHS0TX1ohQkeKeEFYfIWl3XzCEoHUzph9Nz7btI6b3CezNN3+ixIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rrF92/xa; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rrF92/xa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706177674; x=1737713674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qtecy34DLD5a1HWtOeAD2t0mx1jlKputlV6RHNPGPs4=;
  b=rrF92/xaFTtdwO8YpA3bT9DBePufk9MUkWKLDhUlhMcMYTRf2P+t+C74
   J7aCM35i3Gsx4fGDwxzILvbnBrBjKPl6um7wYVOlfOxPNtFf8jAy+6dFs
   FcXqMGVEYJJLlW4g/6jH8XPLuorZirBOwsGdd1e1KLVc2MlW40KoifQV4
   JgZ04bMuBSRsEMw8l90JXPQjoEWAsw77p5wxU+NICimiRqwhs+HDOitWs
   sd5wmOi8nlOTsOtuxmHb72EWOy55jcPF0VNePBeFzkuZd65fPa+Zc0ipz
   Pr14Lsgw14J+eufw3Yx7/UgBfutaQaDk7m1LiaKZQxDX+mGezn3kXjxdv
   w==;
X-CSE-ConnectionGUID: hVuMybSIT42RdhY0wCkzug==
X-CSE-MsgGUID: cor4FdiPTM6jLlEw5OTqTw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7939581"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2024 18:14:27 +0800
IronPort-SDR: A5EbiPE6+IauMpvzXASanUAo4c7O726/EBktKjuLUZ+TcGa32zRxuSO8adGaMyRRfCnXKfwE63
 tBKULN3o55IQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 01:24:27 -0800
IronPort-SDR: Q+GvlDwM7MgwIFFtTXzUcqEhcRWjqF0WsRMm9R2VMfgqkdzHUaid+VnVGh3DvI01bMqtpYj2LH
 VzWB5eJGV0/g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 02:14:27 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v2] null_blk: add configfs variable shared_tags
Date: Thu, 25 Jan 2024 19:14:25 +0900
Message-ID: <20240125101425.2054263-1-shinichiro.kawasaki@wdc.com>
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
null_init() to null_add_dev(). Introduce the flag tag_set_initialized to
manage the initialization status of tag_set.

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

Changes from v1:
* Removed unnecessary global variable initializer

 drivers/block/null_blk/main.c     | 38 ++++++++++++++++---------------
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 36755f263e8e..1407d4e3452a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -69,6 +69,7 @@ static LIST_HEAD(nullb_list);
 static struct mutex lock;
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
+static bool tag_set_initialized;
 static struct blk_mq_tag_set tag_set;
 
 enum {
@@ -165,8 +166,8 @@ static bool g_blocking;
 module_param_named(blocking, g_blocking, bool, 0444);
 MODULE_PARM_DESC(blocking, "Register as a blocking blk-mq driver device");
 
-static bool shared_tags;
-module_param(shared_tags, bool, 0444);
+static bool g_shared_tags;
+module_param_named(shared_tags, g_shared_tags, bool, 0444);
 MODULE_PARM_DESC(shared_tags, "Share tag set between devices for blk-mq");
 
 static bool g_shared_tag_bitmap;
@@ -426,6 +427,7 @@ NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
+NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
@@ -571,6 +573,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_offline,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
+	&nullb_device_attr_shared_tags,
 	&nullb_device_attr_shared_tag_bitmap,
 	NULL,
 };
@@ -653,10 +656,11 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
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
@@ -738,6 +742,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_max_active = g_zone_max_active;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
+	dev->shared_tags = g_shared_tags;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
 	return dev;
 }
@@ -2124,7 +2129,13 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out_free_nullb;
 
 	if (dev->queue_mode == NULL_Q_MQ) {
-		if (shared_tags) {
+		if (dev->shared_tags) {
+			if (!tag_set_initialized) {
+				rv = null_init_tag_set(NULL, &tag_set);
+				if (rv)
+					goto out_cleanup_queues;
+				tag_set_initialized = true;
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
+	if (tag_set_initialized)
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

