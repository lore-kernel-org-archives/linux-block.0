Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D81514DC
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121400; cv=none; b=egGGSXFpkWkcFe3C9PGoIDCDHZVEcGcQZPIw/vAeuZsI9kmbF2yvFq5hpS4OZtXd7okpAul3zbyBvi1yHPGIBRDpg2xhNt8nxAM/2PEfNrHyGXg9lzO4J6Kk4IX5jYWQBw55UiWJgtrMyVVi57VUOuI6oK4dBQEDgV67V04zVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121400; c=relaxed/simple;
	bh=TC+1dy04XXSHSKy2pYHcUFbRo1HknDnYg6m9PLGQoJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZFio0r9KTrBynSB2vFNY3lF9duNpYN4ZMHRkRd6uP1m0CSqw7o0d+AmfGkvaaUnZnGg7WVMCqYrwizNrqH0HVWAToBGb/k8ZNf7KCmySPi8i2njwmt5amhH66V2opU7qHGJtuHo4ouQOsFRYNwvitAyaaZXY3m3T1C7Pym5AGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C0prhYJw; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C0prhYJw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735121398; x=1766657398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TC+1dy04XXSHSKy2pYHcUFbRo1HknDnYg6m9PLGQoJM=;
  b=C0prhYJw9p1Cou9F/+YDbA9gq1OgUljclMsZ7nIJ1qdISLFoDlW9QhVl
   eNl6hi2ipOhNNXEC1+Pr/nGH0z04cxOERm3LxVL+q7twiQgOJkh8GSU8q
   Wi1Zsl2Y+FKKEQm8p8jSYvqBosN9bRw5qoQamg7iMuyQO4bV0bWhgeSmO
   HU6GBYvqW2twaHqW0qx1k9NXCD0GTIGt1ECwyIfQWpBzs83hENss+xSJX
   RSnbTfvSyzl8XVSHuaBmxcPVp2qVmOjNfqlH475nIrUMWkutxBCkZuRA2
   u1rxWros7cg7yFVjciB9PbdrGnes65O1dq2U09O5pe5iVeXZ8uc03bo62
   Q==;
X-CSE-ConnectionGUID: Xp5upOxiTF2fkELgJxxKSA==
X-CSE-MsgGUID: e3QQzCGLRRq3VMHhwNlszQ==
X-IronPort-AV: E=Sophos;i="6.12,263,1728921600"; 
   d="scan'208";a="35812595"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2024 18:09:51 +0800
IronPort-SDR: 676bcc7b_fT/swpSAN2hMNJcbXWO235DJeoAXjlokJlavxFq246LcALS
 jnxQngCGnBSsizLmiItUUFCTCQd7Ppa1NFPJ0aw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2024 01:12:28 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2024 02:09:50 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs features string
Date: Wed, 25 Dec 2024 19:09:46 +0900
Message-ID: <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The null_blk configfs file 'features' provides a string that lists
available null_blk features for userspace programs to reference.
The string is defined as a long constant in the code, which tends to be
forgotten for updates. It also causes checkpatch.pl to report
"WARNING: quoted string split across lines".

To avoid these drawbacks, generate the feature string on the fly. Refer
to the ca_name field of each element in the nullb_device_attrs table and
concatenate them in the given buffer. Also, modify order of the
nullb_device_attrs table to not change the list order of the generated
string.

Of note is that the feature "index" was missing before this commit.
This commit adds it to the generated string.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 93 ++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 178e62cd9a9f..f720707b7cfb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -591,42 +591,46 @@ static ssize_t nullb_device_zone_offline_store(struct config_item *item,
 }
 CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 
+/*
+ * Place the elements in alphabetical order to keep the confingfs
+ * 'features' string readable.
+ */
 static struct configfs_attribute *nullb_device_attrs[] = {
-	&nullb_device_attr_size,
-	&nullb_device_attr_completion_nsec,
-	&nullb_device_attr_submit_queues,
-	&nullb_device_attr_poll_queues,
-	&nullb_device_attr_home_node,
-	&nullb_device_attr_queue_mode,
+	&nullb_device_attr_badblocks,
+	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
-	&nullb_device_attr_max_sectors,
-	&nullb_device_attr_irqmode,
+	&nullb_device_attr_cache_size,
+	&nullb_device_attr_completion_nsec,
+	&nullb_device_attr_discard,
+	&nullb_device_attr_fua,
+	&nullb_device_attr_home_node,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
-	&nullb_device_attr_blocking,
-	&nullb_device_attr_use_per_node_hctx,
-	&nullb_device_attr_power,
-	&nullb_device_attr_memory_backed,
-	&nullb_device_attr_discard,
+	&nullb_device_attr_irqmode,
+	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_mbps,
-	&nullb_device_attr_cache_size,
-	&nullb_device_attr_badblocks,
-	&nullb_device_attr_zoned,
-	&nullb_device_attr_zone_size,
-	&nullb_device_attr_zone_capacity,
-	&nullb_device_attr_zone_nr_conv,
-	&nullb_device_attr_zone_max_open,
-	&nullb_device_attr_zone_max_active,
-	&nullb_device_attr_zone_append_max_sectors,
-	&nullb_device_attr_zone_readonly,
-	&nullb_device_attr_zone_offline,
-	&nullb_device_attr_zone_full,
-	&nullb_device_attr_virt_boundary,
+	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_no_sched,
-	&nullb_device_attr_shared_tags,
-	&nullb_device_attr_shared_tag_bitmap,
-	&nullb_device_attr_fua,
+	&nullb_device_attr_poll_queues,
+	&nullb_device_attr_power,
+	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_rotational,
+	&nullb_device_attr_shared_tag_bitmap,
+	&nullb_device_attr_shared_tags,
+	&nullb_device_attr_size,
+	&nullb_device_attr_submit_queues,
+	&nullb_device_attr_use_per_node_hctx,
+	&nullb_device_attr_virt_boundary,
+	&nullb_device_attr_zone_append_max_sectors,
+	&nullb_device_attr_zone_capacity,
+	&nullb_device_attr_zone_full,
+	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_max_open,
+	&nullb_device_attr_zone_nr_conv,
+	&nullb_device_attr_zone_offline,
+	&nullb_device_attr_zone_readonly,
+	&nullb_device_attr_zone_size,
+	&nullb_device_attr_zoned,
 	NULL,
 };
 
@@ -704,16 +708,27 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,fua,"
-			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
-			"poll_queues,power,queue_mode,shared_tag_bitmap,"
-			"shared_tags,size,submit_queues,use_per_node_hctx,"
-			"virt_boundary,zoned,zone_capacity,zone_max_active,"
-			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size,zone_append_max_sectors,zone_full,"
-			"rotational\n");
+
+	struct configfs_attribute **entry;
+	const char *fmt = "%s,";
+	size_t left = PAGE_SIZE;
+	size_t written = 0;
+	int ret;
+
+	for (entry = &nullb_device_attrs[0]; *entry && left > 0; entry++) {
+		if (!*(entry + 1))
+			fmt = "%s\n";
+		ret = snprintf(page + written, left, fmt, (*entry)->ca_name);
+		if (ret >= left) {
+			WARN_ONCE(1, "Too many null_blk features to print\n");
+			memzero_explicit(page, PAGE_SIZE);
+			return 0;
+		}
+		left -= ret;
+		written += ret;
+	}
+
+	return written;
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
-- 
2.47.0

