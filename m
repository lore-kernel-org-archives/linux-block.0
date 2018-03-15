Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54845 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbeCOKnN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 06:43:13 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 4/4] bcache-tools: add CPU endianness support
Date: Thu, 15 Mar 2018 18:42:40 +0800
Message-Id: <20180315104240.24647-5-colyli@suse.de>
In-Reply-To: <20180315104240.24647-1-colyli@suse.de>
References: <20180315104240.24647-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Current code assumes CPU arch is little endian, so the created bcache
devices cannot be recognized by big endian machine (e.g. S390).

This patch adds CPU endianness support, does same as Linux kernel code
does, to make kernel code swap byte order of super block members correctly.

Signed-off-by: Coly Li <colyli@suse.de>
---
 bcache-super-show.c | 29 ++++++++++--------
 bcache.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++
 bcache.h            | 19 +++++++++---
 byteorder.h         | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 make-bcache.c       |  3 +-
 5 files changed, 192 insertions(+), 19 deletions(-)
 create mode 100644 byteorder.h

diff --git a/bcache-super-show.c b/bcache-super-show.c
index 2d46cac..4f8ccd8 100644
--- a/bcache-super-show.c
+++ b/bcache-super-show.c
@@ -63,7 +63,7 @@ int main(int argc, char **argv)
 	extern char *optarg;
 	struct cache_sb sb;
 	char uuid[40];
-	uint64_t expected_csum;
+	uint64_t expected_csum_le64;
 
 	while ((o = getopt(argc, argv, "f")) != EOF)
 		switch (o) {
@@ -104,27 +104,30 @@ int main(int argc, char **argv)
 		exit(2);
 	}
 
-	printf("sb.first_sector\t\t%" PRIu64, sb.offset);
-	if (sb.offset == SB_SECTOR) {
-		printf(" [match]\n");
-	} else {
-		printf(" [expected %ds]\n", SB_SECTOR);
-		fprintf(stderr, "Invalid superblock (bad sector)\n");
-		exit(2);
-	}
-
 	printf("sb.csum\t\t\t%" PRIX64, sb.csum);
-	expected_csum = csum_set(&sb);
-	if (sb.csum == expected_csum) {
+	expected_csum_le64 = csum_set_le64(&sb);
+	/* compare two little endian numbers is safe */
+	if (sb.csum == expected_csum_le64) {
 		printf(" [match]\n");
 	} else {
-		printf(" [expected %" PRIX64 "]\n", expected_csum);
+		printf(" [expected %" PRIX64 "]\n", le64_to_cpu(expected_csum_le64));
 		if (!force_csum) {
 			fprintf(stderr, "Corrupt superblock (bad csum)\n");
 			exit(2);
 		}
 	}
 
+	swap_sb_to_cpu(&sb);
+
+	printf("sb.first_sector\t\t%" PRIu64, sb.offset);
+	if (sb.offset == SB_SECTOR) {
+		printf(" [match]\n");
+	} else {
+		printf(" [expected %ds]\n", SB_SECTOR);
+		fprintf(stderr, "Invalid superblock (bad sector)\n");
+		exit(2);
+	}
+
 	printf("sb.version\t\t%" PRIu64, sb.version);
 	switch (sb.version) {
 		// These are handled the same by the kernel
diff --git a/bcache.c b/bcache.c
index 8b4b986..4457bce 100644
--- a/bcache.c
+++ b/bcache.c
@@ -4,7 +4,10 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <stdbool.h>
 
+#include "bcache.h"
+#include "byteorder.h"
 /*
  * Portions Copyright (c) 1996-2001, PostgreSQL Global Development Group (Any
  * use permitted, subject to terms of PostgreSQL license; see.)
@@ -127,3 +130,73 @@ uint64_t crc64(const void *_data, size_t len)
 
 	return crc ^ 0xFFFFFFFFFFFFFFFFULL;
 }
+
+/*
+ * Convert some super block members into little endian before
+ * writing to storage media as bcache kernel code does
+ */
+void swap_sb_from_cpu(struct cache_sb *sb)
+{
+	int i;
+
+	if (cpu_is_little_endian)
+		return;
+
+	sb->offset = cpu_to_le64(sb->offset);
+	sb->flags = cpu_to_le64(sb->flags);
+	sb->seq = cpu_to_le64(sb->seq);
+
+	/* sb->version is still in CPU endianness now */
+	if (!SB_IS_BDEV(sb)) {
+		/* Cache device */
+		sb->nbuckets = cpu_to_le64(sb->nbuckets);
+		sb->bucket_size = cpu_to_le16(sb->bucket_size);
+		sb->nr_in_set = cpu_to_le16(sb->nr_in_set);
+		sb->nr_this_dev = cpu_to_le16(sb->nr_this_dev);
+	} else {
+		/* Backing device */
+		sb->data_offset = cpu_to_le64(sb->data_offset);
+	}
+	sb->version = cpu_to_le64(sb->version);
+
+	sb->block_size = cpu_to_le16(sb->block_size);
+	sb->last_mount = cpu_to_le32(sb->last_mount);
+	sb->first_bucket = cpu_to_le16(sb->first_bucket);
+	sb->keys = cpu_to_le16(sb->keys);
+
+	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
+		sb->d[i] = cpu_to_le64(sb->d[i]);
+}
+
+void swap_sb_to_cpu(struct cache_sb *sb)
+{
+	int i;
+
+	if (cpu_is_little_endian)
+		return;
+
+	sb->offset = le64_to_cpu(sb->offset);
+	sb->flags = le64_to_cpu(sb->flags);
+	sb->seq = le64_to_cpu(sb->seq);
+
+	sb->version = le64_to_cpu(sb->version);
+	/* sb->version is in CPU endianness */
+	if (!SB_IS_BDEV(sb)) {
+		/* Cache device */
+		sb->nbuckets = le64_to_cpu(sb->nbuckets);
+		sb->bucket_size = le16_to_cpu(sb->bucket_size);
+		sb->nr_in_set = le16_to_cpu(sb->nr_in_set);
+		sb->nr_this_dev = le16_to_cpu(sb->nr_this_dev);
+	} else {
+		/* Backing device */
+		sb->data_offset = le64_to_cpu(sb->data_offset);
+	}
+
+	sb->block_size = le16_to_cpu(sb->block_size);
+	sb->last_mount = le32_to_cpu(sb->last_mount);
+	sb->first_bucket = le16_to_cpu(sb->first_bucket);
+	sb->keys = le16_to_cpu(sb->keys);
+
+	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
+		sb->d[i] = le64_to_cpu(sb->d[i]);
+}
diff --git a/bcache.h b/bcache.h
index 61e4252..eb72c6f 100644
--- a/bcache.h
+++ b/bcache.h
@@ -7,6 +7,8 @@
 #ifndef _BCACHE_H
 #define _BCACHE_H
 
+#include "byteorder.h"
+
 #define BITMASK(name, type, field, offset, size)		\
 static inline uint64_t name(const type *k)			\
 { return (k->field >> offset) & ~(((uint64_t) ~0) << size); }	\
@@ -115,12 +117,19 @@ BITMASK(BDEV_STATE,		struct cache_sb, flags, 61, 2);
 #define BDEV_STATE_DIRTY	2U
 #define BDEV_STATE_STALE	3U
 
+void swap_sb_from_cpu(struct cache_sb *sb);
+void swap_sb_to_cpu(struct cache_sb *sb);
 uint64_t crc64(const void *_data, size_t len);
 
-#define node(i, j)		((void *) ((i)->d + (j)))
-#define end(i)			node(i, (i)->keys)
-
-#define csum_set(i)							\
-	crc64(((void *) (i)) + 8, ((void *) end(i)) - (((void *) (i)) + 8))
+/* members in calculation are all in little endian */
+static inline uint64_t csum_set_le64(struct cache_sb *sb)
+{
+	uint64_t csum;
+	uint16_t keys = le16_to_cpu(sb->keys);
+	void *start = (void *)(sb) + sizeof(sb->csum);
+	void *end = (void *)(sb->d + keys);
 
+	csum = crc64(start, end - start);
+	return cpu_to_le64(csum);
+}
 #endif
diff --git a/byteorder.h b/byteorder.h
new file mode 100644
index 0000000..3b62e1b
--- /dev/null
+++ b/byteorder.h
@@ -0,0 +1,87 @@
+/* -*- mode: c; c-basic-offset: 8; -*-
+ * vim: noexpandtab sw=8 ts=8 sts=0:
+ *
+ * byteorder.h
+ *
+ * Byteswapping!
+ *
+ * Copyright (C) 2004 Oracle.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License, version 2,  as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ *
+ * Authors: Joel Becker
+ *
+ * Copied from ocfs2-tools, and modify for bcache-tool by Coly Li.
+ */
+
+#ifndef _BYTEORDER_H
+#define _BYTEORDER_H
+
+
+#include <endian.h>
+#include <byteswap.h>
+#include <stdint.h>
+
+/*
+ * bcache super block values are in little endian.
+ */
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_is_little_endian	1
+# ifndef cpu_to_le16
+#  define cpu_to_le16(x) ((uint16_t)(x))
+# endif
+# ifndef le16_to_cpu
+#  define le16_to_cpu(x) ((uint16_t)(x))
+# endif
+# ifndef cpu_to_le32
+#  define cpu_to_le32(x) ((uint32_t)(x))
+# endif
+# ifndef le32_to_cpu
+#  define le32_to_cpu(x) ((uint32_t)(x))
+# endif
+# ifndef cpu_to_le64
+#  define cpu_to_le64(x) ((uint64_t)(x))
+# endif
+# ifndef le64_to_cpu
+#  define le64_to_cpu(x) ((uint64_t)(x))
+# endif
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define cpu_is_little_endian	0
+# ifndef cpu_to_le16
+#  define cpu_to_le16(x) ((uint16_t)bswap_16(x))
+# endif
+# ifndef le16_to_cpu
+#  define le16_to_cpu(x) ((uint16_t)bswap_16(x))
+# endif
+# ifndef cpu_to_le32
+#  define cpu_to_le32(x) ((uint32_t)bswap_32(x))
+# endif
+# ifndef le32_to_cpu
+#  define le32_to_cpu(x) ((uint32_t)bswap_32(x))
+# endif
+# ifndef cpu_to_le64
+#  define cpu_to_le64(x) ((uint64_t)bswap_64(x))
+# endif
+# ifndef le64_to_cpu
+#  define le64_to_cpu(x) ((uint64_t)bswap_64(x))
+# endif
+#else
+# error Invalid byte order __BYTE_ORDER
+#endif  /* __BYTE_ORDER */
+
+#define cpu_is_big_endian	(!cpu_is_little_endian)
+
+#endif  /* _BYTEORDER_H */
diff --git a/make-bcache.c b/make-bcache.c
index 14c605d..144433f 100644
--- a/make-bcache.c
+++ b/make-bcache.c
@@ -274,7 +274,8 @@ static void write_sb(char *dev, unsigned block_size, unsigned bucket_size,
 		       sb.first_bucket);
 	}
 
-	sb.csum = csum_set(&sb);
+	swap_sb_from_cpu(&sb);
+	sb.csum = csum_set_le64(&sb);
 
 	/* Zero start of disk */
 	if (pwrite(fd, zeroes, SB_START, 0) != SB_START) {
-- 
2.16.2
