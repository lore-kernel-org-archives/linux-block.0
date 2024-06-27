Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F113146D7D
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486867; cv=none; b=Zfh6wJp9aEAOVELZxYl67g2ARARGFoo2v4BbEHdfAGywGV7zHqwifxRT3l0/wi2k6DeMBe2AMFxRY7VhHjdMUulNB82p87ZtF6qWD4ySYl2aDPA3EzFRoz7o0RyaI/JFx/2NPuH0kdsdHwznf9Q4em5ZmaHcLYf7LhRYjjUNWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486867; c=relaxed/simple;
	bh=8cYbWpRO7g9m4YM1/Us7gNXXMoJxtx7I7h+tc0kcxNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BalUKCkZNFtqYFKVKTKoRYq+2Uvy+cwfD2km4FZaGz9Ka2PJbVwkYUhNrsnoloKFS9m9kkGN+sCmb2zsEYRzE25EAfg26wi9AkzFRF26zBSpYaswF8SaAaXBj9zEBqP18xY1Bhc1T9t/T14ifiLekNjkJWN0LJxYJQNNO/J5eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrHgPiAg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrHgPiAg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UIpfQb5RizFdAKCUcR5e8BpyYFI5CHTXF32/ZBoSxNE=; b=FrHgPiAgkjpcSzmn5ONERLwP8P
	BuIJEGB3CO7svJmnzMw8v+JgUT/4YJYydjhQA6SQgc3ZOXjD4W+12/4T/AGTXBnbOWH9YvgPHMeNJ
	3fQtBvmu43zA7V9xlaW9vxzBYI3LPHTZc8Ozgv2p0mk1dspw6bR+UoAcTPXw88XYEcyeq+5knzfqF
	38CaO6ESSfsf0LYn6Fsy+Grjl6Xph/jCooc2P2CsPkiVKAYjCRjSZLeRYEkh+xOUL1hZHSm2bLXfG
	osZSloS1xOsXhBekPChoC7n2nlNJUyUcAOJlc+9cOaMMvLpKI+UnTo1Cpwz6fotyOM/F+5ghZN8HV
	ByOjNmYw==;
Received: from [2001:4bb8:2dc:6d4c:6789:3c0c:a17:a2fe] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMn56-0000000A7Jb-0isd;
	Thu, 27 Jun 2024 11:14:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: add helper macros to de-duplicate the queue sysfs attributes
Date: Thu, 27 Jun 2024 13:14:02 +0200
Message-ID: <20240627111407.476276-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627111407.476276-1-hch@lst.de>
References: <20240627111407.476276-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

A lof the code to implement the queue sysfs attributes is repetitive.
Add a few macros to generate the common cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 255 +++++++++++++++-------------------------------
 1 file changed, 82 insertions(+), 173 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 2e6d9b918127fe..a769fb441b58da 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -100,103 +100,65 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
-{
-	int max_sectors_kb = queue_max_sectors(q) >> 1;
-
-	return queue_var_show(max_sectors_kb, page);
-}
-
-static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_max_segments(q), page);
-}
-
-static ssize_t queue_max_discard_segments_show(struct request_queue *q,
-		char *page)
-{
-	return queue_var_show(queue_max_discard_segments(q), page);
-}
-
-static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
-						char *page)
-{
-	return queue_var_show(queue_atomic_write_max_bytes(q), page);
-}
-
-static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
-						char *page)
-{
-	return queue_var_show(queue_atomic_write_boundary_bytes(q), page);
-}
-
-static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
-						char *page)
-{
-	return queue_var_show(queue_atomic_write_unit_min_bytes(q), page);
-}
-
-static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
-						char *page)
-{
-	return queue_var_show(queue_atomic_write_unit_max_bytes(q), page);
-}
-
-static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(q->limits.max_integrity_segments, page);
-}
-
-static ssize_t queue_max_segment_size_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_max_segment_size(q), page);
-}
-
-static ssize_t queue_logical_block_size_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_logical_block_size(q), page);
-}
-
-static ssize_t queue_physical_block_size_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_physical_block_size(q), page);
-}
-
-static ssize_t queue_chunk_sectors_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(q->limits.chunk_sectors, page);
-}
-
-static ssize_t queue_io_min_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_io_min(q), page);
-}
-
-static ssize_t queue_io_opt_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_io_opt(q), page);
-}
-
-static ssize_t queue_discard_granularity_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(q->limits.discard_granularity, page);
+#define QUEUE_SYSFS_LIMIT_SHOW(_field)					\
+static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+{									\
+	return queue_var_show(q->limits._field, page);			\
+}
+
+QUEUE_SYSFS_LIMIT_SHOW(max_segments)
+QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
+QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
+QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
+QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
+QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
+QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
+QUEUE_SYSFS_LIMIT_SHOW(io_min)
+QUEUE_SYSFS_LIMIT_SHOW(io_opt)
+QUEUE_SYSFS_LIMIT_SHOW(discard_granularity)
+QUEUE_SYSFS_LIMIT_SHOW(zone_write_granularity)
+QUEUE_SYSFS_LIMIT_SHOW(virt_boundary_mask)
+QUEUE_SYSFS_LIMIT_SHOW(dma_alignment)
+QUEUE_SYSFS_LIMIT_SHOW(max_open_zones)
+QUEUE_SYSFS_LIMIT_SHOW(max_active_zones)
+QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_min)
+QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_max)
+
+#define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(_field)			\
+static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+{									\
+	return sprintf(page, "%llu\n",					\
+		(unsigned long long)q->limits._field << SECTOR_SHIFT);	\
+}
+
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_discard_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_discard_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_write_zeroes_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
+
+#define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(_field)			\
+static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+{									\
+	return queue_var_show(q->limits._field >> 1, page);		\
+}
+
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
+
+#define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
+static ssize_t queue_##_name##_show(struct request_queue *q, char *page) \
+{									\
+	return sprintf(page, "%d\n", _val);				\
 }
 
-static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
-{
-
-	return sprintf(page, "%llu\n",
-		(unsigned long long)q->limits.max_hw_discard_sectors << 9);
-}
+/* deprecated fields */
+QUEUE_SYSFS_SHOW_CONST(discard_zeroes_data, 0)
+QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
+QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
 
-static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
-{
-	return sprintf(page, "%llu\n",
-		       (unsigned long long)q->limits.max_discard_sectors << 9);
-}
-
-static ssize_t queue_discard_max_store(struct request_queue *q,
-				       const char *page, size_t count)
+static ssize_t queue_max_discard_sectors_store(struct request_queue *q,
+		const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
 	struct queue_limits lim;
@@ -221,28 +183,11 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	return ret;
 }
 
-static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(0, page);
-}
-
-static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(0, page);
-}
-
-static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
-{
-	return sprintf(page, "%llu\n",
-		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
-}
-
-static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
-						 char *page)
-{
-	return queue_var_show(queue_zone_write_granularity(q), page);
-}
-
+/*
+ * For zone append queue_max_zone_append_sectors does not just return the
+ * underlying queue limits, but actually contains a calculation.  Because of
+ * that we can't simply use QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES here.
+ */
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = queue_max_zone_append_sectors(q);
@@ -270,23 +215,6 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
-{
-	int max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1;
-
-	return queue_var_show(max_hw_sectors_kb, page);
-}
-
-static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(q->limits.virt_boundary_mask, page);
-}
-
-static ssize_t queue_dma_alignment_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(queue_dma_alignment(q), page);
-}
-
 static ssize_t queue_feature_store(struct request_queue *q, const char *page,
 		size_t count, blk_features_t feature)
 {
@@ -325,6 +253,16 @@ QUEUE_SYSFS_FEATURE(add_random, BLK_FEAT_ADD_RANDOM)
 QUEUE_SYSFS_FEATURE(iostats, BLK_FEAT_IO_STAT)
 QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
 
+#define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			 \
+static ssize_t queue_##_name##_show(struct request_queue *q, char *page) \
+{									 \
+	return sprintf(page, "%u\n", !!(q->limits.features & _feature)); \
+}
+
+QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
+QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
+QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
+
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
 {
 	if (blk_queue_is_zoned(q))
@@ -337,16 +275,6 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
 	return queue_var_show(disk_nr_zones(q->disk), page);
 }
 
-static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
-}
-
-static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(bdev_max_active_zones(q->disk->part0), page);
-}
-
 static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(q) << 1) |
@@ -405,22 +333,12 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
-{
-	return sprintf(page, "%d\n", -1);
-}
-
 static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 				size_t count)
 {
 	return count;
 }
 
-static ssize_t queue_poll_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(!!(q->limits.features & BLK_FEAT_POLL), page);
-}
-
 static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 				size_t count)
 {
@@ -485,16 +403,6 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_fua_show(struct request_queue *q, char *page)
-{
-	return sprintf(page, "%u\n", !!(q->limits.features & BLK_FEAT_FUA));
-}
-
-static ssize_t queue_dax_show(struct request_queue *q, char *page)
-{
-	return queue_var_show(!!blk_queue_dax(q), page);
-}
-
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr	= { .name = _name, .mode = 0444 },	\
@@ -525,17 +433,18 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
-QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
-QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
+QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
+QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
-QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
+		"atomic_write_boundary_bytes");
 QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
 QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
-QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
+QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -652,15 +561,15 @@ static struct attribute *queue_attrs[] = {
 	&queue_io_min_entry.attr,
 	&queue_io_opt_entry.attr,
 	&queue_discard_granularity_entry.attr,
-	&queue_discard_max_entry.attr,
-	&queue_discard_max_hw_entry.attr,
+	&queue_max_discard_sectors_entry.attr,
+	&queue_max_hw_discard_sectors_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
-	&queue_atomic_write_max_bytes_entry.attr,
-	&queue_atomic_write_boundary_entry.attr,
+	&queue_atomic_write_max_sectors_entry.attr,
+	&queue_atomic_write_boundary_sectors_entry.attr,
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
-	&queue_write_zeroes_max_entry.attr,
+	&queue_max_write_zeroes_sectors_entry.attr,
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
-- 
2.43.0

