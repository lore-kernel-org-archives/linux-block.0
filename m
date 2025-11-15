Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54365299AB3
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209202; cv=none; b=cEVYbHKwHK9KtiwNB0VS+BagtoRQppDaAfbkVjomTLELY1JIdnilnBDxvMYE4Xyu687v76yeEkByCKNtxlPieYp8Ef9XNf+whBkPWNsCTAcvPZ8Yy5DsOyPxOGAyMMJqkkBOEKIcEkYF1+jkKd8F/ldERdkRWU6ot2i+BifjRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209202; c=relaxed/simple;
	bh=13eUXwP6sC0Fgg6g6FPw/HvMCzuUFBlm3LWon3syfj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRkIcdovvBJWi8O2QYkhXPj7HVyGGVHj78BKS5X6WcnLlvc6PcVKrfh0Hm9k7q+X++ARKBVYo494h8ZncBp4Qixgmd7N0GHra+NdGW6MteGQnm9EVWI05/KpQddyQgMnKxAXMb2T2IWkJNYHGAmaFIKp2FxiPDL56ZCHU3xxo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAyEbR+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAyEbR+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F61C4CEF8;
	Sat, 15 Nov 2025 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209202;
	bh=13eUXwP6sC0Fgg6g6FPw/HvMCzuUFBlm3LWon3syfj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAyEbR+uOWZEVu/KXms+iFhZPsIfKR9lHaAY+Ztddc/Sz4bAcAnq0oiJfb81ihthE
	 uSkdPFKdmf2ZzZoNOkig7+hOMn/pry12RlDrWrxpXQdS4eAjIP7HLaz5eQmyQec0/C
	 syr8537YFcGCeO3kNxt9evez0kpmHziqtLw2D00a06wzuwsNnF0sbJWZkbHlH/oSdT
	 kjIzvusoGS6UdaSUDqaVqVyTgaAMALaVvfimhSxSHap7J/Gg7G2cfVaineEN0ZUrDm
	 mQjEtx678bBAG5r8e/Nnhb7rojF9PwsOxrcOF/YqqPb7FFHfhvXOwqvXDy2Wp4UVl/
	 nkxzw83s3IoYg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] zloop: introduce the zone_append configuration parameter
Date: Sat, 15 Nov 2025 21:15:54 +0900
Message-ID: <20251115121556.196104-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zloop zoned block device declares to the block layer that it supports
zone append operations. That is, a zloop device ressembles an NVMe ZNS
devices supporting zone append.

This native support is fine but it does not allow exercising the block
layer zone write plugging emulation of zone append, as is done with SCSI
or ATA SMR HDDs.

Introduce the zone_append configuration parameter to allow creating a
zloop device without native support for zone append, thus relying on the
block layer zone append emulation. If not specified, zone append support
is enabled by default. Otherwise, a value of 0 disables native zone
append and a value of 1 enables it.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 0526277f6cd1..cf9be42ca3e1 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -32,6 +32,7 @@ enum {
 	ZLOOP_OPT_NR_QUEUES		= (1 << 6),
 	ZLOOP_OPT_QUEUE_DEPTH		= (1 << 7),
 	ZLOOP_OPT_BUFFERED_IO		= (1 << 8),
+	ZLOOP_OPT_ZONE_APPEND		= (1 << 9),
 };
 
 static const match_table_t zloop_opt_tokens = {
@@ -44,6 +45,7 @@ static const match_table_t zloop_opt_tokens = {
 	{ ZLOOP_OPT_NR_QUEUES,		"nr_queues=%u"		},
 	{ ZLOOP_OPT_QUEUE_DEPTH,	"queue_depth=%u"	},
 	{ ZLOOP_OPT_BUFFERED_IO,	"buffered_io"		},
+	{ ZLOOP_OPT_ZONE_APPEND,	"zone_append=%u"	},
 	{ ZLOOP_OPT_ERR,		NULL			}
 };
 
@@ -56,6 +58,7 @@ static const match_table_t zloop_opt_tokens = {
 #define ZLOOP_DEF_NR_QUEUES		1
 #define ZLOOP_DEF_QUEUE_DEPTH		128
 #define ZLOOP_DEF_BUFFERED_IO		false
+#define ZLOOP_DEF_ZONE_APPEND		true
 
 /* Arbitrary limit on the zone size (16GB). */
 #define ZLOOP_MAX_ZONE_SIZE_MB		16384
@@ -71,6 +74,7 @@ struct zloop_options {
 	unsigned int		nr_queues;
 	unsigned int		queue_depth;
 	bool			buffered_io;
+	bool			zone_append;
 };
 
 /*
@@ -108,6 +112,7 @@ struct zloop_device {
 
 	struct workqueue_struct *workqueue;
 	bool			buffered_io;
+	bool			zone_append;
 
 	const char		*base_dir;
 	struct file		*data_dir;
@@ -378,6 +383,11 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	cmd->nr_sectors = nr_sectors;
 	cmd->ret = 0;
 
+	if (WARN_ON_ONCE(is_append && !zlo->zone_append)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	/* We should never get an I/O beyond the device capacity. */
 	if (WARN_ON_ONCE(zone_no >= zlo->nr_zones)) {
 		ret = -EIO;
@@ -889,7 +899,6 @@ static int zloop_ctl_add(struct zloop_options *opts)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= SZ_1M >> SECTOR_SHIFT,
-		.max_hw_zone_append_sectors = SZ_1M >> SECTOR_SHIFT,
 		.chunk_sectors		= opts->zone_size,
 		.features		= BLK_FEAT_ZONED,
 	};
@@ -941,6 +950,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	zlo->nr_zones = nr_zones;
 	zlo->nr_conv_zones = opts->nr_conv_zones;
 	zlo->buffered_io = opts->buffered_io;
+	zlo->zone_append = opts->zone_append;
 
 	zlo->workqueue = alloc_workqueue("zloop%d", WQ_UNBOUND | WQ_FREEZABLE,
 				opts->nr_queues * opts->queue_depth, zlo->id);
@@ -981,6 +991,8 @@ static int zloop_ctl_add(struct zloop_options *opts)
 
 	lim.physical_block_size = zlo->block_size;
 	lim.logical_block_size = zlo->block_size;
+	if (zlo->zone_append)
+		lim.max_hw_zone_append_sectors = lim.max_hw_sectors;
 
 	zlo->tag_set.ops = &zloop_mq_ops;
 	zlo->tag_set.nr_hw_queues = opts->nr_queues;
@@ -1021,10 +1033,13 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	zlo->state = Zlo_live;
 	mutex_unlock(&zloop_ctl_mutex);
 
-	pr_info("Added device %d: %u zones of %llu MB, %u B block size\n",
+	pr_info("zloop: device %d, %u zones of %llu MiB, %u B block size\n",
 		zlo->id, zlo->nr_zones,
 		((sector_t)zlo->zone_size << SECTOR_SHIFT) >> 20,
 		zlo->block_size);
+	pr_info("zloop%d: using %s zone append\n",
+		zlo->id,
+		zlo->zone_append ? "native" : "emulated");
 
 	return 0;
 
@@ -1111,6 +1126,7 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 	opts->nr_queues = ZLOOP_DEF_NR_QUEUES;
 	opts->queue_depth = ZLOOP_DEF_QUEUE_DEPTH;
 	opts->buffered_io = ZLOOP_DEF_BUFFERED_IO;
+	opts->zone_append = ZLOOP_DEF_ZONE_APPEND;
 
 	if (!buf)
 		return 0;
@@ -1220,6 +1236,18 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 		case ZLOOP_OPT_BUFFERED_IO:
 			opts->buffered_io = true;
 			break;
+		case ZLOOP_OPT_ZONE_APPEND:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token != 0 && token != 1) {
+				pr_err("Invalid zone_append value\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->zone_append = token;
+			break;
 		case ZLOOP_OPT_ERR:
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
-- 
2.51.1

