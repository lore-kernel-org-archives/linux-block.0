Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeCOPIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:31 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 16/16] bcache: Fix endianness annotations
Date: Thu, 15 Mar 2018 08:08:14 -0700
Message-Id: <20180315150814.9412-17-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch avoids that sparse complains about using integer types
incorrectly (u32, __le32, __be32, ...) by splitting struct cache_sb
into two different structures:
- struct cache_sb in which all integer members except csum have
  CPU endianness.
- struct cache_sb_le in which all integer members except csum are
  declared as little endian.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/super.c   |  10 ++--
 include/uapi/linux/bcache.h | 118 +++++++++++++++++++++++---------------------
 2 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 31d700aecd56..ef659c7d72f9 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -63,20 +63,22 @@ struct workqueue_struct *bcache_wq;
 /* limitation of bcache devices number on single system */
 #define BCACHE_DEVICE_IDX_MAX	((1U << MINORBITS)/BCACHE_MINORS)
 
+struct cache_sb_le STRUCT_CACHE_SB(le);
+
 /* Superblock */
 
 static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 			      struct page **res)
 {
 	const char *err;
-	struct cache_sb *s;
+	struct cache_sb_le *s;
 	struct buffer_head *bh = __bread(bdev, 1, SB_SIZE);
 	unsigned i;
 
 	if (!bh)
 		return "IO error";
 
-	s = (struct cache_sb *) bh->b_data;
+	s = (struct cache_sb_le *) bh->b_data;
 
 	sb->offset		= le64_to_cpu(s->offset);
 	sb->version		= le64_to_cpu(s->version);
@@ -211,7 +213,7 @@ static void write_bdev_super_endio(struct bio *bio)
 
 static void __write_super(struct cache_sb *sb, struct bio *bio)
 {
-	struct cache_sb *out = page_address(bio_first_page_all(bio));
+	struct cache_sb_le *out = page_address(bio_first_page_all(bio));
 	unsigned i;
 
 	bio->bi_iter.bi_sector	= SB_SECTOR;
@@ -959,7 +961,7 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 			  uint8_t *set_uuid)
 {
-	uint32_t rtime = cpu_to_le32(get_seconds());
+	__le32 rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
 	char buf[BDEVNAME_SIZE];
 
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 821f71a2e48f..772787c47772 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -154,57 +154,63 @@ static inline struct bkey *bkey_idx(const struct bkey *k, unsigned nr_keys)
 
 #define BDEV_DATA_START_DEFAULT		16	/* sectors */
 
-struct cache_sb {
-	__u64			csum;
-	__u64			offset;	/* sector where this sb was written */
-	__u64			version;
-
-	__u8			magic[16];
-
-	__u8			uuid[16];
-	union {
-		__u8		set_uuid[16];
-		__u64		set_magic;
-	};
-	__u8			label[SB_LABEL_SIZE];
-
-	__u64			flags;
-	__u64			seq;
-	__u64			pad[8];
-
-	union {
-	struct {
-		/* Cache devices */
-		__u64		nbuckets;	/* device size */
-
-		__u16		block_size;	/* sectors */
-		__u16		bucket_size;	/* sectors */
-
-		__u16		nr_in_set;
-		__u16		nr_this_dev;
-	};
-	struct {
-		/* Backing devices */
-		__u64		data_offset;
-
-		/*
-		 * block_size from the cache device section is still used by
-		 * backing devices, so don't add anything here until we fix
-		 * things to not need it for backing devices anymore
-		 */
-	};
-	};
-
-	__u32			last_mount;	/* time_t */
-
-	__u16			first_bucket;
-	union {
-		__u16		njournal_buckets;
-		__u16		keys;
-	};
-	__u64			d[SB_JOURNAL_BUCKETS];	/* journal buckets */
+#define STRUCT_CACHE_SB(e)						\
+{									\
+	__u64			csum;					\
+	/* sector where this sb was written */				\
+	__##e##64		offset;					\
+	__##e##64		version;				\
+									\
+	__u8			magic[16];				\
+									\
+	__u8			uuid[16];				\
+	union {								\
+		__u8		set_uuid[16];				\
+		__##e##64	set_magic;				\
+	};								\
+	__u8			label[SB_LABEL_SIZE];			\
+									\
+	__##e##64		flags;					\
+	__##e##64		seq;					\
+	__##e##64		pad[8];					\
+									\
+	union {								\
+	struct {							\
+		/* Cache devices */					\
+		__##e##64	nbuckets;	/* device size */	\
+									\
+		__##e##16	block_size;	/* sectors */		\
+		__##e##16	bucket_size;	/* sectors */		\
+									\
+		__##e##16	nr_in_set;				\
+		__##e##16	nr_this_dev;				\
+	};								\
+	struct {							\
+		/* Backing devices */					\
+		__##e##64	data_offset;				\
+									\
+		/*							\
+		 * block_size from the cache device section is still	\
+		 * used by backing devices, so don't add anything here	\
+		 * until we fix things to not need it for backing	\
+		 * devices anymore					\
+		 */							\
+	};								\
+	};								\
+									\
+	__##e##32		last_mount;	/* time_t */		\
+									\
+	__##e##16		first_bucket;				\
+	union {								\
+		__##e##16	njournal_buckets;			\
+		__##e##16	keys;					\
+	};								\
+	/* journal buckets */						\
+	__##e##64		d[SB_JOURNAL_BUCKETS];			\
 };
 
+struct cache_sb STRUCT_CACHE_SB(u);
+
 static inline _Bool SB_IS_BDEV(const struct cache_sb *sb)
 {
 	return sb->version == BCACHE_SB_VERSION_BDEV
@@ -306,7 +312,7 @@ struct prio_set {
 	__u64			next_bucket;
 
 	struct bucket_disk {
-		__u16		prio;
+		__le16		prio;
 		__u8		gen;
 	} __attribute((packed)) data[];
 };
@@ -318,9 +324,9 @@ struct uuid_entry {
 		struct {
 			__u8	uuid[16];
 			__u8	label[32];
-			__u32	first_reg;
-			__u32	last_reg;
-			__u32	invalidated;
+			__le32	first_reg;
+			__le32	last_reg;
+			__le32	invalidated;
 
 			__u32	flags;
 			/* Size of flash only volumes */
@@ -366,9 +372,9 @@ struct bset {
 struct uuid_entry_v0 {
 	__u8		uuid[16];
 	__u8		label[32];
-	__u32		first_reg;
-	__u32		last_reg;
-	__u32		invalidated;
+	__le32		first_reg;
+	__le32		last_reg;
+	__le32		invalidated;
 	__u32		pad;
 };
 
-- 
2.16.2
