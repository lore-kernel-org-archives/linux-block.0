Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09829D27E
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209203; cv=none; b=fIY21/wjbs/1EauU+hJ+Rla6r2yi6xuD424F2m7ngL85cHKMuArhsyxA9+Zgs4xHan5Dhy7VxY4b2bizaKkVBId+zVtK1F3b2L2tfR6BJPxqRYml+IjJiPgp958PMcMN7QurCY12gbUs5BUp3BqznNW2OC2jxu0KaMAOgvd+pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209203; c=relaxed/simple;
	bh=/oI84foZC+gUeGGiRfvMhHchlm3hKQgKu7eueySYgtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a00e0VKFyUw7gpnYciNGTjL9GzX/IEMIlliKac4TMfazW0/LVbjmjpM/SojEBiG3v98cENPh7XjCWLX3ctI5VpJT1cM3RY9p5o7sTtUTB4kqZJ8CmTMFIy+Rtr+PBB2t/H33KMCpXfOH3nuKbGpjjv+4FSrc5paj0AqZEge6YUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Fs6DGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Fs6DGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAEEC116D0;
	Sat, 15 Nov 2025 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209203;
	bh=/oI84foZC+gUeGGiRfvMhHchlm3hKQgKu7eueySYgtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4Fs6DGMTf6gM28mMXdddNhMj771IAjqEKUlBLRlikSjQwC4VQaD8grf6IaJpDEH2
	 8FKNXzrDPptflrld2Up9TNIPa8xMUWUDuO1grNxbtWdAZ2vxcf63XBuO1KsMttW59U
	 z7Z6OLIHS/4XlrQDx0s7fz3TS1AJ41wJMOHXagCBUGltfmwIARVXPvf7mmSJMSlhKl
	 g58dD5RdD+sC9JrdinsqQIV3HVeLUPUZYY2vJG3vx3UjJRjiWj0dTJfFQaw0mD7O/4
	 DZok6rXGbTeFje57SqjvTw1avQ7fG3XxlvbtZx5X4pv1aHwOqwlO8uSTmrgOjyL1Ex
	 OwmWaBLaFdX8g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] zloop: introduce the ordered_zone_append configuration parameter
Date: Sat, 15 Nov 2025 21:15:55 +0900
Message-ID: <20251115121556.196104-6-dlemoal@kernel.org>
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

The zone append operation processing for zloop devices is similar to any
other command, that is, the operation is processed as a command work
item, without any special serialization between the work items (beside
the zone mutex for mutually exclusive code sections).

This processing is fine and gives excellent performance. However, it has
a side effect: zone append operation are very often reordered and
processed in a sequence that is very different from their issuing order
by the user. This effect is very visible using an XFS file system on top
of a zloop device. A simple file write leads to many file extents as the
data writes using zone append are reordered and so result in the
physical order being different than the file logical order.
E.g. executing:

$ dd if=/dev/zero of=/mnt/test bs=1M count=10 && sync
$ xfs_bmap /mnt/test
/mnt/test:
	0: [0..4095]: 2162688..2166783
	1: [4096..6143]: 2168832..2170879
	2: [6144..8191]: 2166784..2168831
	3: [8192..10239]: 2170880..2172927
	4: [10240..12287]: 2174976..2177023
	5: [12288..14335]: 2172928..2174975
	6: [14336..20479]: 2177024..2183167

For 10 IOs, 6 extents are created.

This is fine and actually allows to exercise XFS zone garbage collection
very well. However, this also makes debugging/working on XFS data
placement harder as the underlying device will most of the time reorder
IOs, resulting in many file extents.

Allow a user to mitigate this with the new ordered_zone_append
configuration parameter. For a zloop device created with this parameter
specified, the sector of a zone append command is set early, when the
command is submitted by the block layer with the zloop_queue_rq()
function, instead of in the zloop_rw() function which is exectued later
in the command work item context. This change ensures that more often
than not, zone append operations data end up being written in the same
order as the command submission by the user.

In the case of XFS, this leads to far less file data extents. E.g., for
the previous example, we get a single file data extent for the written
file.

$ dd if=/dev/zero of=/mnt/test bs=1M count=10 && sync
$ xfs_bmap /mnt/test
/mnt/test:
	0: [0..20479]: 2162688..2183167

Since we cannot use a mutex in the context of the zloop_queue_rq()
function to atomically set a zone append operation sector to the target
zone write pointer location and increment that the write pointer, a new
per-zone spinlock is introduced to protect a zone write pointer access
and modifications. To check a zone write pointer location and set a zone
append operation target sector to that value, the function
zloop_set_zone_append_sector() is introduced and called from
zloop_queue_rq().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 108 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index cf9be42ca3e1..c4da3116f7a9 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -33,6 +33,7 @@ enum {
 	ZLOOP_OPT_QUEUE_DEPTH		= (1 << 7),
 	ZLOOP_OPT_BUFFERED_IO		= (1 << 8),
 	ZLOOP_OPT_ZONE_APPEND		= (1 << 9),
+	ZLOOP_OPT_ORDERED_ZONE_APPEND	= (1 << 10),
 };
 
 static const match_table_t zloop_opt_tokens = {
@@ -46,6 +47,7 @@ static const match_table_t zloop_opt_tokens = {
 	{ ZLOOP_OPT_QUEUE_DEPTH,	"queue_depth=%u"	},
 	{ ZLOOP_OPT_BUFFERED_IO,	"buffered_io"		},
 	{ ZLOOP_OPT_ZONE_APPEND,	"zone_append=%u"	},
+	{ ZLOOP_OPT_ORDERED_ZONE_APPEND, "ordered_zone_append"	},
 	{ ZLOOP_OPT_ERR,		NULL			}
 };
 
@@ -59,6 +61,7 @@ static const match_table_t zloop_opt_tokens = {
 #define ZLOOP_DEF_QUEUE_DEPTH		128
 #define ZLOOP_DEF_BUFFERED_IO		false
 #define ZLOOP_DEF_ZONE_APPEND		true
+#define ZLOOP_DEF_ORDERED_ZONE_APPEND	false
 
 /* Arbitrary limit on the zone size (16GB). */
 #define ZLOOP_MAX_ZONE_SIZE_MB		16384
@@ -75,6 +78,7 @@ struct zloop_options {
 	unsigned int		queue_depth;
 	bool			buffered_io;
 	bool			zone_append;
+	bool			ordered_zone_append;
 };
 
 /*
@@ -96,6 +100,7 @@ struct zloop_zone {
 
 	unsigned long		flags;
 	struct mutex		lock;
+	spinlock_t		wp_lock;
 	enum blk_zone_cond	cond;
 	sector_t		start;
 	sector_t		wp;
@@ -113,6 +118,7 @@ struct zloop_device {
 	struct workqueue_struct *workqueue;
 	bool			buffered_io;
 	bool			zone_append;
+	bool			ordered_zone_append;
 
 	const char		*base_dir;
 	struct file		*data_dir;
@@ -152,6 +158,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 	struct zloop_zone *zone = &zlo->zones[zone_no];
 	struct kstat stat;
 	sector_t file_sectors;
+	unsigned long flags;
 	int ret;
 
 	lockdep_assert_held(&zone->lock);
@@ -177,6 +184,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 		return -EINVAL;
 	}
 
+	spin_lock_irqsave(&zone->wp_lock, flags);
 	if (!file_sectors) {
 		zone->cond = BLK_ZONE_COND_EMPTY;
 		zone->wp = zone->start;
@@ -187,6 +195,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 		zone->cond = BLK_ZONE_COND_CLOSED;
 		zone->wp = zone->start + file_sectors;
 	}
+	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
 	return 0;
 }
@@ -230,6 +239,7 @@ static int zloop_open_zone(struct zloop_device *zlo, unsigned int zone_no)
 static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
+	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -248,10 +258,12 @@ static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
+		spin_lock_irqsave(&zone->wp_lock, flags);
 		if (zone->wp == zone->start)
 			zone->cond = BLK_ZONE_COND_EMPTY;
 		else
 			zone->cond = BLK_ZONE_COND_CLOSED;
+		spin_unlock_irqrestore(&zone->wp_lock, flags);
 		break;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_FULL:
@@ -269,6 +281,7 @@ static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
+	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -286,9 +299,11 @@ static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 		goto unlock;
 	}
 
+	spin_lock_irqsave(&zone->wp_lock, flags);
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
+	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
 unlock:
 	mutex_unlock(&zone->lock);
@@ -313,6 +328,7 @@ static int zloop_reset_all_zones(struct zloop_device *zlo)
 static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
+	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -330,9 +346,11 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 		goto unlock;
 	}
 
+	spin_lock_irqsave(&zone->wp_lock, flags);
 	zone->cond = BLK_ZONE_COND_FULL;
 	zone->wp = ULLONG_MAX;
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
+	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
  unlock:
 	mutex_unlock(&zone->lock);
@@ -374,6 +392,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	struct zloop_zone *zone;
 	struct iov_iter iter;
 	struct bio_vec tmp;
+	unsigned long flags;
 	sector_t zone_end;
 	int nr_bvec = 0;
 	int ret;
@@ -416,19 +435,30 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	if (!test_bit(ZLOOP_ZONE_CONV, &zone->flags) && is_write) {
 		mutex_lock(&zone->lock);
 
+		spin_lock_irqsave(&zone->wp_lock, flags);
+
 		/*
 		 * Zone append operations always go at the current write
 		 * pointer, but regular write operations must already be
 		 * aligned to the write pointer when submitted.
 		 */
 		if (is_append) {
-			if (zone->cond == BLK_ZONE_COND_FULL) {
-				ret = -EIO;
-				goto unlock;
+			/*
+			 * If ordered zone append is in use, we already checked
+			 * and set the target sector in zloop_queue_rq().
+			 */
+			if (!zlo->ordered_zone_append) {
+				if (zone->cond == BLK_ZONE_COND_FULL) {
+					spin_unlock_irqrestore(&zone->wp_lock,
+							       flags);
+					ret = -EIO;
+					goto unlock;
+				}
+				sector = zone->wp;
 			}
-			sector = zone->wp;
 			cmd->sector = sector;
 		} else if (sector != zone->wp) {
+			spin_unlock_irqrestore(&zone->wp_lock, flags);
 			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
 			       zone_no, sector, zone->wp);
 			ret = -EIO;
@@ -441,15 +471,19 @@ static void zloop_rw(struct zloop_cmd *cmd)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
 		/*
-		 * Advance the write pointer. If the write fails, the write
-		 * pointer position will be corrected when the next I/O starts
-		 * execution.
+		 * Advance the write pointer, unless ordered zone append is in
+		 * use. If the write fails, the write pointer position will be
+		 * corrected when the next I/O starts execution.
 		 */
-		zone->wp += nr_sectors;
-		if (zone->wp == zone_end) {
-			zone->cond = BLK_ZONE_COND_FULL;
-			zone->wp = ULLONG_MAX;
+		if (!is_append || !zlo->ordered_zone_append) {
+			zone->wp += nr_sectors;
+			if (zone->wp == zone_end) {
+				zone->cond = BLK_ZONE_COND_FULL;
+				zone->wp = ULLONG_MAX;
+			}
 		}
+
+		spin_unlock_irqrestore(&zone->wp_lock, flags);
 	}
 
 	rq_for_each_bvec(tmp, rq, rq_iter)
@@ -623,6 +657,35 @@ static void zloop_complete_rq(struct request *rq)
 	blk_mq_end_request(rq, sts);
 }
 
+static bool zloop_set_zone_append_sector(struct request *rq)
+{
+	struct zloop_device *zlo = rq->q->queuedata;
+	unsigned int zone_no = rq_zone_no(rq);
+	struct zloop_zone *zone = &zlo->zones[zone_no];
+	sector_t zone_end = zone->start + zlo->zone_capacity;
+	sector_t nr_sectors = blk_rq_sectors(rq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&zone->wp_lock, flags);
+
+	if (zone->cond == BLK_ZONE_COND_FULL ||
+	    zone->wp + nr_sectors > zone_end) {
+		spin_unlock_irqrestore(&zone->wp_lock, flags);
+		return false;
+	}
+
+	rq->__sector = zone->wp;
+	zone->wp += blk_rq_sectors(rq);
+	if (zone->wp >= zone_end) {
+		zone->cond = BLK_ZONE_COND_FULL;
+		zone->wp = ULLONG_MAX;
+	}
+
+	spin_unlock_irqrestore(&zone->wp_lock, flags);
+
+	return true;
+}
+
 static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				   const struct blk_mq_queue_data *bd)
 {
@@ -633,6 +696,16 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (zlo->state == Zlo_deleting)
 		return BLK_STS_IOERR;
 
+	/*
+	 * If we need to strongly order zone append operations, set the request
+	 * sector to the zone write pointer location now instead of when the
+	 * command work runs.
+	 */
+	if (zlo->ordered_zone_append && req_op(rq) == REQ_OP_ZONE_APPEND) {
+		if (!zloop_set_zone_append_sector(rq))
+			return BLK_STS_IOERR;
+	}
+
 	blk_mq_start_request(rq);
 
 	INIT_WORK(&cmd->work, zloop_cmd_workfn);
@@ -667,6 +740,7 @@ static int zloop_report_zones(struct gendisk *disk, sector_t sector,
 	struct zloop_device *zlo = disk->private_data;
 	struct blk_zone blkz = {};
 	unsigned int first, i;
+	unsigned long flags;
 	int ret;
 
 	first = disk_zone_no(disk, sector);
@@ -690,7 +764,9 @@ static int zloop_report_zones(struct gendisk *disk, sector_t sector,
 
 		blkz.start = zone->start;
 		blkz.len = zlo->zone_size;
+		spin_lock_irqsave(&zone->wp_lock, flags);
 		blkz.wp = zone->wp;
+		spin_unlock_irqrestore(&zone->wp_lock, flags);
 		blkz.cond = zone->cond;
 		if (test_bit(ZLOOP_ZONE_CONV, &zone->flags)) {
 			blkz.type = BLK_ZONE_TYPE_CONVENTIONAL;
@@ -798,6 +874,7 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 	int ret;
 
 	mutex_init(&zone->lock);
+	spin_lock_init(&zone->wp_lock);
 	zone->start = (sector_t)zone_no << zlo->zone_shift;
 
 	if (!restore)
@@ -951,6 +1028,8 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	zlo->nr_conv_zones = opts->nr_conv_zones;
 	zlo->buffered_io = opts->buffered_io;
 	zlo->zone_append = opts->zone_append;
+	if (zlo->zone_append)
+		zlo->ordered_zone_append = opts->ordered_zone_append;
 
 	zlo->workqueue = alloc_workqueue("zloop%d", WQ_UNBOUND | WQ_FREEZABLE,
 				opts->nr_queues * opts->queue_depth, zlo->id);
@@ -1037,8 +1116,9 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		zlo->id, zlo->nr_zones,
 		((sector_t)zlo->zone_size << SECTOR_SHIFT) >> 20,
 		zlo->block_size);
-	pr_info("zloop%d: using %s zone append\n",
+	pr_info("zloop%d: using %s%s zone append\n",
 		zlo->id,
+		zlo->ordered_zone_append ? "ordered " : "",
 		zlo->zone_append ? "native" : "emulated");
 
 	return 0;
@@ -1127,6 +1207,7 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 	opts->queue_depth = ZLOOP_DEF_QUEUE_DEPTH;
 	opts->buffered_io = ZLOOP_DEF_BUFFERED_IO;
 	opts->zone_append = ZLOOP_DEF_ZONE_APPEND;
+	opts->ordered_zone_append = ZLOOP_DEF_ORDERED_ZONE_APPEND;
 
 	if (!buf)
 		return 0;
@@ -1248,6 +1329,9 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 			}
 			opts->zone_append = token;
 			break;
+		case ZLOOP_OPT_ORDERED_ZONE_APPEND:
+			opts->ordered_zone_append = true;
+			break;
 		case ZLOOP_OPT_ERR:
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
-- 
2.51.1

