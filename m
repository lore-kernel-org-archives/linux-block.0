Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbeCOPIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:30 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 15/16] bcache: Fix an endianness bug
Date: Thu, 15 Mar 2018 08:08:13 -0700
Message-Id: <20180315150814.9412-16-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ensure that byte swapping occurs on big endian architectures when
reading or writing the superblock.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/bcache.h | 12 ++++++++++++
 drivers/md/bcache/super.c  |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 72b1ea4576d9..50ddc78596bf 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -784,6 +784,18 @@ static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
 	bch_crc64(p, q - p);					\
 })
 
+/*
+ * Variant of csum_set() for data structures in which (i)->keys has type
+ * __le16.
+ */
+#define csum_set_le(i) ({						\
+	const void *p = (void *)(i) + sizeof(uint64_t);			\
+	const void *q = bkey_idx((struct bkey *)(i)->d,			\
+				 le16_to_cpu((i)->keys));		\
+									\
+	bch_crc64(p, q - p);						\
+})
+
 /* Error handling macros */
 
 #define btree_bug(b, ...)						\
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 39bec137f636..31d700aecd56 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -110,7 +110,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		goto err;
 
 	err = "Bad checksum";
-	if (s->csum != csum_set(s))
+	if (s->csum != csum_set_le(s))
 		goto err;
 
 	err = "Bad UUID";
@@ -236,7 +236,7 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
 	for (i = 0; i < sb->keys; i++)
 		out->d[i] = cpu_to_le64(sb->d[i]);
 
-	out->csum = csum_set(out);
+	out->csum = csum_set_le(out);
 
 	pr_debug("ver %llu, flags %llu, seq %llu",
 		 sb->version, sb->flags, sb->seq);
-- 
2.16.2
