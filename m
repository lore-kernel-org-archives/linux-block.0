Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCOLPN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 07:15:13 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH] bcache: enable big endian support for IBM s390x
Date: Thu, 15 Mar 2018 19:15:00 +0800
Message-Id: <20180315111500.24865-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recently I receive bug report that bcache does not work on s390x machine.
A reason is from bcache-tools, the user space code does not do byte order
swapping before writing struct cache_sb to storage media.

Updating user space tools is not enough, the kernel code also has several
issues,
1) checksum is checked after some super block members swap their byte
   order by calling leXX_to_cpu(). On little endian machines, it changes
   nothing and works, but on big endian machines it will make checksum
   checking to be failed.
2) bcache code also updates super block in start/attach/detach time, but
   the kernel code does not call cpu_to_leXX() to all necessary structure
   members. On little endian machines no byte swapping happens so it is
   OK, but on big endian machines, that means next time when bcache reads
   super block in, the checksum check will failed.
3) current code checks checksum after some members of cache_sb are swapped,
   this is incorrect. The checksum calculation should be done when all
   structure members are explicitly in little endian.

This patch fixes the above issues and now bcache can be registered and
attach/detached on s390x machine.

Please note in this patch I add a new macro csum_set_le64(), it calculates
checksum of struct cache_sb when all multi-bytes members are explicitly in
little endian.

So far csum_set_le64() is only used in super block checksum calculation,
because bucket prio and journal entries checksums are still calculated by
CPU byte order. It won't be a problem if the backing device is not shared
among machines with different CPU endianness.

Ask for help:
My S390x vm only has 8GB storage, and I cannot find extra space for now.
When I run fio on bcache device I see allocator thread blocked on waiting
bucket allocating. I am not sure whether it is because I use a sparse file
as loop block device and the real space is too small. And the network
latency to ping this machine is 0.6 second, it is too slow for any
complicated operation...
So if any of you may provide me a faster S390 machine with large enough
storage devices for further testing, that will be very helpful.

Thanks in advance.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h |  10 ++++
 drivers/md/bcache/super.c  | 124 +++++++++++++++++++++++++++++----------------
 2 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 12e5197f186c..18e5aebd27c0 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -782,6 +782,16 @@ static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
 		  ((void *) bset_bkey_last(i)) -			\
 		  (((void *) (i)) + sizeof(uint64_t)))
 
+/*
+ * Same functionality as csum_set(), the difference is that all structure
+ * members are explicitly swapped to little endian byte order.
+ */
+#define csum_set_le64(i)						\
+	cpu_to_le64(bch_crc64(						\
+		(void *)(i) + sizeof(uint64_t),				\
+		(void *)((i)->d + le16_to_cpu((i)->keys)) -		\
+		((void *)(i) + sizeof(uint64_t))))			\
+
 /* Error handling macros */
 
 #define btree_bug(b, ...)						\
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4d1d8dfb2d2a..04c1a5b5f2a9 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -65,6 +65,70 @@ struct workqueue_struct *bcache_wq;
 
 /* Superblock */
 
+static void swap_cache_sb_from_cpu(struct cache_sb *sb,
+				   struct cache_sb *out)
+{
+	int i;
+
+	out->offset		= cpu_to_le64(sb->offset);
+	out->flags		= cpu_to_le64(sb->flags);
+	out->seq		= cpu_to_le64(sb->seq);
+
+	/* sb->version is in CPU endian now */
+	if (!SB_IS_BDEV(sb)) {
+		/* Cache devices */
+		out->nbuckets		= cpu_to_le64(sb->nbuckets);
+		out->bucket_size	= cpu_to_le16(sb->bucket_size);
+		out->nr_in_set		= cpu_to_le16(sb->nr_in_set);
+		out->nr_this_dev	= cpu_to_le16(sb->nr_this_dev);
+	} else {
+		/* Backing devices */
+		out->data_offset	= cpu_to_le16(sb->data_offset);
+	}
+	/* sb->version can be swapped now */
+	out->version		= cpu_to_le64(sb->version);
+
+	out->block_size		= cpu_to_le16(sb->block_size);
+	out->last_mount		= cpu_to_le32(sb->last_mount);
+	out->first_bucket	= cpu_to_le16(sb->first_bucket);
+
+	/* sb->keys is in CPU endian now */
+	for (i = 0; i < sb->keys; i++)
+		out->d[i] = cpu_to_le64(sb->d[i]);
+	/* sb->keys can be swapped now */
+	out->keys		= cpu_to_le16(sb->keys);
+}
+
+static void swap_cache_sb_to_cpu(struct cache_sb *sb,
+				 struct cache_sb *in)
+{
+	int i;
+
+	sb->offset		= le64_to_cpu(in->offset);
+	sb->flags		= le64_to_cpu(in->flags);
+	sb->seq			= le64_to_cpu(in->seq);
+	sb->block_size		= le16_to_cpu(in->block_size);
+	sb->last_mount		= le32_to_cpu(in->last_mount);
+	sb->first_bucket	= le16_to_cpu(in->first_bucket);
+	sb->keys		= le16_to_cpu(in->keys);
+
+	sb->version		= le64_to_cpu(in->version);
+	/* sb->version is in CPU endian now */
+	if (!SB_IS_BDEV(sb)) {
+		/* Cache devices */
+		sb->nbuckets	= le64_to_cpu(in->nbuckets);
+		sb->bucket_size	= le16_to_cpu(in->bucket_size);
+		sb->nr_in_set	= le16_to_cpu(in->nr_in_set);
+		sb->nr_this_dev	= le16_to_cpu(in->nr_this_dev);
+	} else {
+		/* Backing devices */
+		sb->data_offset = le64_to_cpu(in->data_offset);
+	}
+
+	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
+		sb->d[i] = le64_to_cpu(in->d[i]);
+}
+
 static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 			      struct page **res)
 {
@@ -78,23 +142,25 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 
 	s = (struct cache_sb *) bh->b_data;
 
-	sb->offset		= le64_to_cpu(s->offset);
-	sb->version		= le64_to_cpu(s->version);
+	err = "Bad magic";
+	if (memcmp(s->magic, bcache_magic, 16))
+		goto err;
+
+	/*
+	 * It is safe to compare equality of two numbers
+	 * both in little endian
+	 */
+	err = "Bad checksum";
+	if (s->csum != csum_set_le64(s))
+		goto err;
+
+	swap_cache_sb_to_cpu(sb, s);
 
 	memcpy(sb->magic,	s->magic, 16);
 	memcpy(sb->uuid,	s->uuid, 16);
 	memcpy(sb->set_uuid,	s->set_uuid, 16);
 	memcpy(sb->label,	s->label, SB_LABEL_SIZE);
 
-	sb->flags		= le64_to_cpu(s->flags);
-	sb->seq			= le64_to_cpu(s->seq);
-	sb->last_mount		= le32_to_cpu(s->last_mount);
-	sb->first_bucket	= le16_to_cpu(s->first_bucket);
-	sb->keys		= le16_to_cpu(s->keys);
-
-	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
-		sb->d[i] = le64_to_cpu(s->d[i]);
-
 	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u",
 		 sb->version, sb->flags, sb->seq, sb->keys);
 
@@ -102,34 +168,23 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	if (sb->offset != SB_SECTOR)
 		goto err;
 
-	if (memcmp(sb->magic, bcache_magic, 16))
-		goto err;
-
 	err = "Too many journal buckets";
 	if (sb->keys > SB_JOURNAL_BUCKETS)
 		goto err;
 
-	err = "Bad checksum";
-	if (s->csum != csum_set(s))
-		goto err;
-
 	err = "Bad UUID";
 	if (bch_is_zero(sb->uuid, 16))
 		goto err;
 
-	sb->block_size	= le16_to_cpu(s->block_size);
-
 	err = "Superblock block size smaller than device block size";
 	if (sb->block_size << 9 < bdev_logical_block_size(bdev))
 		goto err;
 
 	switch (sb->version) {
 	case BCACHE_SB_VERSION_BDEV:
-		sb->data_offset	= BDEV_DATA_START_DEFAULT;
+		sb->data_offset = BDEV_DATA_START_DEFAULT;
 		break;
 	case BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
-		sb->data_offset	= le64_to_cpu(s->data_offset);
-
 		err = "Bad data offset";
 		if (sb->data_offset < BDEV_DATA_START_DEFAULT)
 			goto err;
@@ -137,12 +192,6 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		break;
 	case BCACHE_SB_VERSION_CDEV:
 	case BCACHE_SB_VERSION_CDEV_WITH_UUID:
-		sb->nbuckets	= le64_to_cpu(s->nbuckets);
-		sb->bucket_size	= le16_to_cpu(s->bucket_size);
-
-		sb->nr_in_set	= le16_to_cpu(s->nr_in_set);
-		sb->nr_this_dev	= le16_to_cpu(s->nr_this_dev);
-
 		err = "Too many buckets";
 		if (sb->nbuckets > LONG_MAX)
 			goto err;
@@ -212,31 +261,18 @@ static void write_bdev_super_endio(struct bio *bio)
 static void __write_super(struct cache_sb *sb, struct bio *bio)
 {
 	struct cache_sb *out = page_address(bio_first_page_all(bio));
-	unsigned i;
 
 	bio->bi_iter.bi_sector	= SB_SECTOR;
 	bio->bi_iter.bi_size	= SB_SIZE;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
 	bch_bio_map(bio, NULL);
 
-	out->offset		= cpu_to_le64(sb->offset);
-	out->version		= cpu_to_le64(sb->version);
-
 	memcpy(out->uuid,	sb->uuid, 16);
 	memcpy(out->set_uuid,	sb->set_uuid, 16);
 	memcpy(out->label,	sb->label, SB_LABEL_SIZE);
 
-	out->flags		= cpu_to_le64(sb->flags);
-	out->seq		= cpu_to_le64(sb->seq);
-
-	out->last_mount		= cpu_to_le32(sb->last_mount);
-	out->first_bucket	= cpu_to_le16(sb->first_bucket);
-	out->keys		= cpu_to_le16(sb->keys);
-
-	for (i = 0; i < sb->keys; i++)
-		out->d[i] = cpu_to_le64(sb->d[i]);
-
-	out->csum = csum_set(out);
+	swap_cache_sb_from_cpu(sb, out);
+	out->csum = csum_set_le64(out);
 
 	pr_debug("ver %llu, flags %llu, seq %llu",
 		 sb->version, sb->flags, sb->seq);
-- 
2.16.2
