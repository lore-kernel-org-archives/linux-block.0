Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdHEG51 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Aug 2017 02:57:27 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Date: Sat,  5 Aug 2017 14:56:47 +0800
Message-Id: <20170805065705.12989-3-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-1-ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We need to iterate ctx starting from one offset in way
of round robin, so introduce this helper.

Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 54 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index a1904aadbc45..ace08016f54a 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -211,10 +211,14 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb);
  */
 bool sbitmap_any_bit_clear(const struct sbitmap *sb);
 
+#define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
+#define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
+
 typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
 
 /**
  * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
+ * @off: Offset to iterate from
  * @sb: Bitmap to iterate over.
  * @fn: Callback. Should return true to continue or false to break early.
  * @data: Pointer to pass to callback.
@@ -222,35 +226,57 @@ typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
  * This is inline even though it's non-trivial so that the function calls to the
  * callback will hopefully get optimized away.
  */
-static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
-					void *data)
+static inline void __sbitmap_for_each_set(struct sbitmap *sb,
+					  unsigned int off,
+					  sb_for_each_fn fn, void *data)
 {
-	unsigned int i;
+	unsigned int index = SB_NR_TO_INDEX(sb, off);
+	unsigned int nr = SB_NR_TO_BIT(sb, off);
+	unsigned int scanned = 0;
 
-	for (i = 0; i < sb->map_nr; i++) {
-		struct sbitmap_word *word = &sb->map[i];
-		unsigned int off, nr;
+	while (1) {
+		struct sbitmap_word *word = &sb->map[index];
+		unsigned int start = nr;
+		unsigned int depth = min_t(unsigned int, word->depth - start,
+					   sb->depth - scanned);
 
 		if (!word->word)
-			continue;
+			goto next;
 
-		nr = 0;
-		off = i << sb->shift;
+		off = index << sb->shift;
 		while (1) {
-			nr = find_next_bit(&word->word, word->depth, nr);
-			if (nr >= word->depth)
+			nr = find_next_bit(&word->word, start + depth, nr);
+			if (nr >= start + depth)
 				break;
-
 			if (!fn(sb, off + nr, data))
 				return;
 
 			nr++;
 		}
+ next:
+		scanned += depth;
+		if (scanned >= sb->depth)
+			break;
+		nr = 0;
+		if (++index >= sb->map_nr)
+			index = 0;
 	}
 }
 
-#define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
-#define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
+/**
+ * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
+ * @sb: Bitmap to iterate over.
+ * @fn: Callback. Should return true to continue or false to break early.
+ * @data: Pointer to pass to callback.
+ *
+ * This is inline even though it's non-trivial so that the function calls to the
+ * callback will hopefully get optimized away.
+ */
+static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
+					void *data)
+{
+	__sbitmap_for_each_set(sb, 0, fn, data);
+}
 
 static inline unsigned long *__sbitmap_word(struct sbitmap *sb,
 					    unsigned int bitnr)
-- 
2.9.4
