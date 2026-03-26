Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F439A7F6
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557514; cv=none; b=R5E4gB3t9dPYTqRO8rJgl3OubpHKBxe4tVk+axwtLX2U8Lif2sinTOn1Vc0luFeLrdbF7BWQOM2yEHp93v7ojw8EC77d1sM0Ouggo2S+g94BbTvWPlAV6wNLFYEAN27KhYKZ+k2C09TuuNLP3XnLlKIn6gecWrrsNPcjHyKl2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557514; c=relaxed/simple;
	bh=Rz7xNSJdryFFh0PBCrn3nH8lMAC1chxZW8AEQ00QK74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbtCQhFw0/iVTD64PdUw+JldhFeMiE7T2IANA5SnEPjh0tdKd6F3EQ+7b0Gpzd/Xt+636AHBfwCHBSagqLaeezzwXVXcy7jD8YgYRyyBu8p4fKcp8NFXKOsIU38z1YLpK0CYfPfQQ1IBmaW5sprdJTxzWumqiwXhAVssD6hvYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIpjoCs4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIpjoCs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7361C116C6;
	Thu, 26 Mar 2026 20:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774557514;
	bh=Rz7xNSJdryFFh0PBCrn3nH8lMAC1chxZW8AEQ00QK74=;
	h=From:To:Cc:Subject:Date:From;
	b=cIpjoCs4pdby3Dv7l/zaNzCTJJeoU9BDk7mMGYytvdZw42MSNMNpWG9MWCZEB0MuG
	 acWMDMgyiNzSqNoDhyPX7fuC4h00A/+5DuvDkNNBg8JovGJVuUNZ/XhzxRkMaGlOJp
	 BdjaX5MhklcsZJo6sNd/Dyr4BLXlvFSHR30ewzt5E0WfkstyxPswGwDNAvGBjyBUdw
	 MT50ECMW8YB8AnkAbxLpuOURq3P3o7lD15DovRWR+iXG3XdszXsmBZjrcuIML3EUmn
	 PLczod4qV5Hd88RRhlMiKAP8jelLUVhFJI+qakwwUuS8Aypi0xivKFV7uldYonZooE
	 DQ7Vx0Fyh814Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] zloop: add max_open_zones option
Date: Fri, 27 Mar 2026 05:32:45 +0900
Message-ID: <20260326203245.946830-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the new max_open_zones option to allow specifying a limit on
the maximum number of open zones of a zloop device. This change allows
creating a zloop device that can more closely mimick the characteristics
of a physical SMR drive.

When set to a non zero value, only up to max_open_zones zones can be in
the implicit open (BLK_ZONE_COND_IMP_OPEN) and explicit open
(BLK_ZONE_COND_EXP_OPEN) conditions at any time. The transition to the
implicit open condition of a zone on a write operation can result in an
implicit close of an already implicitly open zone. This is handled in
the function zloop_do_open_zone(). This function also handles
transitions to the explicit open condition. Implicit close transitions
are handled using an LRU ordered list of open zones which is managed
using the helper functions zloop_lru_rotate_open_zone() and
zloop_lru_remove_open_zone().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../admin-guide/blockdev/zoned_loop.rst       |   5 +-
 drivers/block/zloop.c                         | 180 ++++++++++++++++--
 2 files changed, 168 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index a01f857b36ad..f4f1f3121bf9 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -62,7 +62,7 @@ The options available for the add command can be listed by reading the
 /dev/zloop-control device::
 
 	$ cat /dev/zloop-control
-        add id=%d,capacity_mb=%u,zone_size_mb=%u,zone_capacity_mb=%u,conv_zones=%u,base_dir=%s,nr_queues=%u,queue_depth=%u,buffered_io
+        add id=%d,capacity_mb=%u,zone_size_mb=%u,zone_capacity_mb=%u,conv_zones=%u,max_open_zones=%u,base_dir=%s,nr_queues=%u,queue_depth=%u,buffered_io,zone_append=%u,ordered_zone_append,discard_write_cache
         remove id=%d
 
 In more details, the options that can be used with the "add" command are as
@@ -80,6 +80,9 @@ zone_capacity_mb      Device zone capacity (must always be equal to or lower
 conv_zones            Total number of conventioanl zones starting from
                       sector 0
                       Default: 8
+max_open_zones        Maximum number of open sequential write required zones
+                      (0 for no limit).
+                      Default: 0
 base_dir              Path to the base directory where to create the directory
                       containing the zone files of the device.
                       Default=/var/local/zloop.
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 86a1324c27b3..8baf642037fd 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -36,6 +36,7 @@ enum {
 	ZLOOP_OPT_ZONE_APPEND		= (1 << 9),
 	ZLOOP_OPT_ORDERED_ZONE_APPEND	= (1 << 10),
 	ZLOOP_OPT_DISCARD_WRITE_CACHE	= (1 << 11),
+	ZLOOP_OPT_MAX_OPEN_ZONES	= (1 << 12),
 };
 
 static const match_table_t zloop_opt_tokens = {
@@ -51,6 +52,7 @@ static const match_table_t zloop_opt_tokens = {
 	{ ZLOOP_OPT_ZONE_APPEND,	"zone_append=%u"	},
 	{ ZLOOP_OPT_ORDERED_ZONE_APPEND, "ordered_zone_append"	},
 	{ ZLOOP_OPT_DISCARD_WRITE_CACHE, "discard_write_cache" },
+	{ ZLOOP_OPT_MAX_OPEN_ZONES,	"max_open_zones=%u"	},
 	{ ZLOOP_OPT_ERR,		NULL			}
 };
 
@@ -59,6 +61,7 @@ static const match_table_t zloop_opt_tokens = {
 #define ZLOOP_DEF_ZONE_SIZE		((256ULL * SZ_1M) >> SECTOR_SHIFT)
 #define ZLOOP_DEF_NR_ZONES		64
 #define ZLOOP_DEF_NR_CONV_ZONES		8
+#define ZLOOP_DEF_MAX_OPEN_ZONES	0
 #define ZLOOP_DEF_BASE_DIR		"/var/local/zloop"
 #define ZLOOP_DEF_NR_QUEUES		1
 #define ZLOOP_DEF_QUEUE_DEPTH		128
@@ -76,6 +79,7 @@ struct zloop_options {
 	sector_t		zone_size;
 	sector_t		zone_capacity;
 	unsigned int		nr_conv_zones;
+	unsigned int		max_open_zones;
 	char			*base_dir;
 	unsigned int		nr_queues;
 	unsigned int		queue_depth;
@@ -99,7 +103,12 @@ enum zloop_zone_flags {
 	ZLOOP_ZONE_SEQ_ERROR,
 };
 
+/*
+ * Zone descriptor.
+ * Locking order: z.lock -> z.wp_lock -> zlo.open_zones_lock
+ */
 struct zloop_zone {
+	struct list_head	open_zone_entry;
 	struct file		*file;
 
 	unsigned long		flags;
@@ -133,8 +142,13 @@ struct zloop_device {
 	sector_t		zone_capacity;
 	unsigned int		nr_zones;
 	unsigned int		nr_conv_zones;
+	unsigned int		max_open_zones;
 	unsigned int		block_size;
 
+	spinlock_t		open_zones_lock;
+	struct list_head	open_zones_lru_list;
+	unsigned int		nr_open_zones;
+
 	struct zloop_zone	zones[] __counted_by(nr_zones);
 };
 
@@ -158,6 +172,122 @@ static unsigned int rq_zone_no(struct request *rq)
 	return blk_rq_pos(rq) >> zlo->zone_shift;
 }
 
+/*
+ * Open an already open zone. This is mostly a no-op, except for the imp open ->
+ * exp open condition change that may happen. We also move a zone at the tail of
+ * the list of open zones so that if we need to
+ * implicitly close one open zone, we can do so in LRU order.
+ */
+static inline void zloop_lru_rotate_open_zone(struct zloop_device *zlo,
+					      struct zloop_zone *zone)
+{
+	if (zlo->max_open_zones) {
+		spin_lock(&zlo->open_zones_lock);
+		list_move_tail(&zone->open_zone_entry,
+			       &zlo->open_zones_lru_list);
+		spin_unlock(&zlo->open_zones_lock);
+	}
+}
+
+static inline void zloop_lru_remove_open_zone(struct zloop_device *zlo,
+					      struct zloop_zone *zone)
+{
+	if (zone->cond == BLK_ZONE_COND_IMP_OPEN ||
+	    zone->cond == BLK_ZONE_COND_EXP_OPEN) {
+		spin_lock(&zlo->open_zones_lock);
+		list_del_init(&zone->open_zone_entry);
+		zlo->nr_open_zones--;
+		spin_unlock(&zlo->open_zones_lock);
+	}
+}
+
+static inline bool zloop_can_open_zone(struct zloop_device *zlo)
+{
+	return !zlo->max_open_zones || zlo->nr_open_zones < zlo->max_open_zones;
+}
+
+/*
+ * If we have reached the maximum open zones limit, attempt to close an
+ * implicitly open zone (if we have any) so that we can implicitly open another
+ * zone without exceeding the maximum number of open zones.
+ */
+static bool zloop_close_imp_open_zone(struct zloop_device *zlo)
+{
+	struct zloop_zone *zone;
+
+	lockdep_assert_held(&zlo->open_zones_lock);
+
+	if (zloop_can_open_zone(zlo))
+		return true;
+
+	list_for_each_entry(zone, &zlo->open_zones_lru_list, open_zone_entry) {
+		if (zone->cond == BLK_ZONE_COND_IMP_OPEN) {
+			zone->cond = BLK_ZONE_COND_CLOSED;
+			list_del_init(&zone->open_zone_entry);
+			zlo->nr_open_zones--;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool zloop_open_closed_or_empty_zone(struct zloop_device *zlo,
+					    struct zloop_zone *zone,
+					    bool explicit)
+{
+	spin_lock(&zlo->open_zones_lock);
+
+	if (explicit) {
+		/*
+		 * Explicit open: we cannot allow this if we have reached the
+		 * maximum open zones limit.
+		 */
+		if (!zloop_can_open_zone(zlo))
+			goto fail;
+		zone->cond = BLK_ZONE_COND_EXP_OPEN;
+	} else {
+		/*
+		 * Implicit open case: if we have reached the maximum open zones
+		 * limit, try to close an implicitly open zone first.
+		 */
+		if (!zloop_close_imp_open_zone(zlo))
+			goto fail;
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	}
+
+	zlo->nr_open_zones++;
+	list_add_tail(&zone->open_zone_entry,
+		      &zlo->open_zones_lru_list);
+
+	spin_unlock(&zlo->open_zones_lock);
+
+	return true;
+
+fail:
+	spin_unlock(&zlo->open_zones_lock);
+
+	return false;
+}
+
+static bool zloop_do_open_zone(struct zloop_device *zlo,
+			       struct zloop_zone *zone, bool explicit)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+		if (explicit)
+			zone->cond = BLK_ZONE_COND_EXP_OPEN;
+		zloop_lru_rotate_open_zone(zlo, zone);
+		return true;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_CLOSED:
+		return zloop_open_closed_or_empty_zone(zlo, zone, explicit);
+	default:
+		return false;
+	}
+}
+
 static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
@@ -191,13 +321,17 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
 	if (!file_sectors) {
+		zloop_lru_remove_open_zone(zlo, zone);
 		zone->cond = BLK_ZONE_COND_EMPTY;
 		zone->wp = zone->start;
 	} else if (file_sectors == zlo->zone_capacity) {
+		zloop_lru_remove_open_zone(zlo, zone);
 		zone->cond = BLK_ZONE_COND_FULL;
 		zone->wp = ULLONG_MAX;
 	} else {
-		zone->cond = BLK_ZONE_COND_CLOSED;
+		if (zone->cond != BLK_ZONE_COND_IMP_OPEN &&
+		    zone->cond != BLK_ZONE_COND_EXP_OPEN)
+			zone->cond = BLK_ZONE_COND_CLOSED;
 		zone->wp = zone->start + file_sectors;
 	}
 	spin_unlock_irqrestore(&zone->wp_lock, flags);
@@ -221,19 +355,8 @@ static int zloop_open_zone(struct zloop_device *zlo, unsigned int zone_no)
 			goto unlock;
 	}
 
-	switch (zone->cond) {
-	case BLK_ZONE_COND_EXP_OPEN:
-		break;
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_CLOSED:
-	case BLK_ZONE_COND_IMP_OPEN:
-		zone->cond = BLK_ZONE_COND_EXP_OPEN;
-		break;
-	case BLK_ZONE_COND_FULL:
-	default:
+	if (!zloop_do_open_zone(zlo, zone, true))
 		ret = -EIO;
-		break;
-	}
 
 unlock:
 	mutex_unlock(&zone->lock);
@@ -264,6 +387,7 @@ static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 		spin_lock_irqsave(&zone->wp_lock, flags);
+		zloop_lru_remove_open_zone(zlo, zone);
 		if (zone->wp == zone->start)
 			zone->cond = BLK_ZONE_COND_EMPTY;
 		else
@@ -305,6 +429,7 @@ static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
+	zloop_lru_remove_open_zone(zlo, zone);
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
@@ -352,6 +477,7 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
+	zloop_lru_remove_open_zone(zlo, zone);
 	zone->cond = BLK_ZONE_COND_FULL;
 	zone->wp = ULLONG_MAX;
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
@@ -478,9 +604,10 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 	}
 
 	/* Implicitly open the target zone. */
-	if (zone->cond == BLK_ZONE_COND_CLOSED ||
-	    zone->cond == BLK_ZONE_COND_EMPTY)
-		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	if (!zloop_do_open_zone(zlo, zone, false)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	/*
 	 * Advance the write pointer, unless ordered zone append is in use. If
@@ -490,6 +617,7 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 	if (!is_append || !zlo->ordered_zone_append) {
 		zone->wp += nr_sectors;
 		if (zone->wp == zone_end) {
+			zloop_lru_remove_open_zone(zlo, zone);
 			zone->cond = BLK_ZONE_COND_FULL;
 			zone->wp = ULLONG_MAX;
 		}
@@ -746,6 +874,7 @@ static bool zloop_set_zone_append_sector(struct request *rq)
 	rq->__sector = zone->wp;
 	zone->wp += blk_rq_sectors(rq);
 	if (zone->wp >= zone_end) {
+		zloop_lru_remove_open_zone(zlo, zone);
 		zone->cond = BLK_ZONE_COND_FULL;
 		zone->wp = ULLONG_MAX;
 	}
@@ -943,6 +1072,7 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 	int ret;
 
 	mutex_init(&zone->lock);
+	INIT_LIST_HEAD(&zone->open_zone_entry);
 	spin_lock_init(&zone->wp_lock);
 	zone->start = (sector_t)zone_no << zlo->zone_shift;
 
@@ -1063,12 +1193,20 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		goto out;
 	}
 
+	if (opts->max_open_zones > nr_zones - opts->nr_conv_zones) {
+		pr_err("Invalid maximum number of open zones %u\n",
+		       opts->max_open_zones);
+		goto out;
+	}
+
 	zlo = kvzalloc_flex(*zlo, zones, nr_zones);
 	if (!zlo) {
 		ret = -ENOMEM;
 		goto out;
 	}
 	WRITE_ONCE(zlo->state, Zlo_creating);
+	spin_lock_init(&zlo->open_zones_lock);
+	INIT_LIST_HEAD(&zlo->open_zones_lru_list);
 
 	ret = mutex_lock_killable(&zloop_ctl_mutex);
 	if (ret)
@@ -1096,6 +1234,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		zlo->zone_capacity = zlo->zone_size;
 	zlo->nr_zones = nr_zones;
 	zlo->nr_conv_zones = opts->nr_conv_zones;
+	zlo->max_open_zones = opts->max_open_zones;
 	zlo->buffered_io = opts->buffered_io;
 	zlo->zone_append = opts->zone_append;
 	if (zlo->zone_append)
@@ -1143,6 +1282,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	lim.logical_block_size = zlo->block_size;
 	if (zlo->zone_append)
 		lim.max_hw_zone_append_sectors = lim.max_hw_sectors;
+	lim.max_open_zones = zlo->max_open_zones;
 
 	zlo->tag_set.ops = &zloop_mq_ops;
 	zlo->tag_set.nr_hw_queues = opts->nr_queues;
@@ -1326,6 +1466,7 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 	opts->capacity = ZLOOP_DEF_ZONE_SIZE * ZLOOP_DEF_NR_ZONES;
 	opts->zone_size = ZLOOP_DEF_ZONE_SIZE;
 	opts->nr_conv_zones = ZLOOP_DEF_NR_CONV_ZONES;
+	opts->max_open_zones = ZLOOP_DEF_MAX_OPEN_ZONES;
 	opts->nr_queues = ZLOOP_DEF_NR_QUEUES;
 	opts->queue_depth = ZLOOP_DEF_QUEUE_DEPTH;
 	opts->buffered_io = ZLOOP_DEF_BUFFERED_IO;
@@ -1404,6 +1545,13 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 			}
 			opts->nr_conv_zones = token;
 			break;
+		case ZLOOP_OPT_MAX_OPEN_ZONES:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->max_open_zones = token;
+			break;
 		case ZLOOP_OPT_BASE_DIR:
 			p = match_strdup(args);
 			if (!p) {
-- 
2.53.0

