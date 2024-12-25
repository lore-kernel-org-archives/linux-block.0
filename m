Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913218E764
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121402; cv=none; b=W2O9vcw4rkaVP7/qIg6GmkzNZMUog3bBadVTgfUDNiT8n20OrIvPU2/pvXAB52BcPlOrwPb50fxAQmNyIvhPLPTF0uSnoGtwI/uorz4spPgFEWcL6BLK9jEM1I0yNlZLAeUgEguQ0vo83siNm/lDgSyfP/pfSfkhqHRC1pORG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121402; c=relaxed/simple;
	bh=/NBE5XRhOlU64CSGQQs1kStu2qmn8wfA60ckE/L1tJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5sYABg1kdHPhEHF75NESZKC7DJZIRkDmaGN0yidfSnF8assr5my38u1J76H9S/tAElEE2jnEuQ9jKHSUebSktsXeJ80cNpOv+rgvII+zTFF74bKp/rYT3Tu7yTrkSw2yPlJIAkKlXvKZQiDVw28nGqOXz3Ky6PyDjhn3txXBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DgWwbDkJ; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DgWwbDkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735121400; x=1766657400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/NBE5XRhOlU64CSGQQs1kStu2qmn8wfA60ckE/L1tJs=;
  b=DgWwbDkJyDIDz2EfD4xzTbkidB+2ZeDgpQVTeMEjxt0vj3+XUJrHRyOq
   ui1NXCnf6WRT6dNkmJmZrQNhYN3XvuwW8NIuEKxhx1xPgrwpOa9NBDiya
   56qyL9vmBIgFo5164c3tV5kFLQlKmt6NgrVZR0jl3y+yzUxsV/imidUn0
   fuFHSJ1BvE5swdqtgs927lVGhdMBM13l/xxSdeDzKqmunUzj0iQ9KQ6Lp
   E3h25Ur1eJkKV0b0XtDWJ4YHfEruBvH5eoKSuqpOtgeETJxKV8kCfXX+s
   Viuieen10RmSYLNsGp9WLQl1rkOwnF2/M1pEvSjsNU6hTWGynUGgJVdKA
   w==;
X-CSE-ConnectionGUID: qo+L0r3RQnmLFACq6ef5FA==
X-CSE-MsgGUID: gi4jY7mwRFOXJXOfDEv1Qw==
X-IronPort-AV: E=Sophos;i="6.12,263,1728921600"; 
   d="scan'208";a="35812600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2024 18:09:54 +0800
IronPort-SDR: 676bcc7e_3HwHs/Ii50aJFqfZyrrc/A9EVLKOaRMv9KPF7kJfFnVsPIY
 B9bQe6MC6gt5cBdoaBub6vyJ4NV/k5NOc3yI+ug==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2024 01:12:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2024 02:09:53 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v2 4/4] null_blk: introduce badblocks_once parameter
Date: Wed, 25 Dec 2024 19:09:49 +0900
Message-ID: <20241225100949.930897-5-shinichiro.kawasaki@wdc.com>
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

When IO errors happen on real storage devices, the IOs repeated to the
same target range can success by virtue of recovery features by devices,
such as reserved block assignment. To simulate such IO errors and
recoveries, introduce the new parameter badblocks_once parameter. When
this parameter is set to 1, the specified badblocks are cleared after
the first IO error, so that the next IO to the blocks succeed.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 4 ++++
 drivers/block/null_blk/null_blk.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1675dec0b0e6..09d85b71b7f9 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -473,6 +473,7 @@ NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
 NULLB_DEVICE_ATTR(rotational, bool, NULL);
+NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -597,6 +598,7 @@ CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
  */
 static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
+	&nullb_device_attr_badblocks_once,
 	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_cache_size,
@@ -1342,6 +1344,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	int bad_sectors;
 
 	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors)) {
+		if (cmd->nq->dev->badblocks_once)
+			badblocks_clear(bb, first_bad, bad_sectors);
 		if (!IS_ALIGNED(first_bad, block_sectors))
 			first_bad = ALIGN_DOWN(first_bad, block_sectors);
 		if (dev->memory_backed && sector < first_bad) {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index c6ceede691ba..b9cd85542498 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -63,6 +63,7 @@ struct nullb_device {
 	unsigned long flags; /* device flags */
 	unsigned int curr_cache;
 	struct badblocks badblocks;
+	bool badblocks_once;
 
 	unsigned int nr_zones;
 	unsigned int nr_zones_imp_open;
-- 
2.47.0

