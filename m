Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33637 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdCQWK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 18:10:29 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so49426032pga.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 15:10:28 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [RFC PATCH 1/4] sbitmap: add sbitmap_get_shallow() operation
Date: Fri, 17 Mar 2017 15:03:30 -0700
Message-Id: <369fe5d06ca42bcdbda58f436ca752bc5538cdc9.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This operation supports the use case of limiting the number of bits that
can be allocated for a given operation. Rather than setting aside some
bits at the end of the bitmap, we can set aside bits in each word of the
bitmap. This means we can keep the allocation hints spread out and
support sbitmap_resize() nicely at the cost of lower granularity for the
allowed depth.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/sbitmap.h | 55 ++++++++++++++++++++++++++++++++++++
 lib/sbitmap.c           | 75 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d4e0a204c118..a1904aadbc45 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -176,6 +176,25 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
 int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin);
 
 /**
+ * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
+ * limiting the depth used from each word.
+ * @sb: Bitmap to allocate from.
+ * @alloc_hint: Hint for where to start searching for a free bit.
+ * @shallow_depth: The maximum number of bits to allocate from a single word.
+ *
+ * This rather specific operation allows for having multiple users with
+ * different allocation limits. E.g., there can be a high-priority class that
+ * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
+ * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
+ * class can only allocate half of the total bits in the bitmap, preventing it
+ * from starving out the high-priority class.
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
+			unsigned long shallow_depth);
+
+/**
  * sbitmap_any_bit_set() - Check for a set bit in a &struct sbitmap.
  * @sb: Bitmap to check.
  *
@@ -326,6 +345,19 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
 int __sbitmap_queue_get(struct sbitmap_queue *sbq);
 
 /**
+ * __sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
+ * sbitmap_queue, limiting the depth used from each word, with preemption
+ * already disabled.
+ * @sbq: Bitmap queue to allocate from.
+ * @shallow_depth: The maximum number of bits to allocate from a single word.
+ * See sbitmap_get_shallow().
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
+				unsigned int shallow_depth);
+
+/**
  * sbitmap_queue_get() - Try to allocate a free bit from a &struct
  * sbitmap_queue.
  * @sbq: Bitmap queue to allocate from.
@@ -346,6 +378,29 @@ static inline int sbitmap_queue_get(struct sbitmap_queue *sbq,
 }
 
 /**
+ * sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
+ * sbitmap_queue, limiting the depth used from each word.
+ * @sbq: Bitmap queue to allocate from.
+ * @cpu: Output parameter; will contain the CPU we ran on (e.g., to be passed to
+ *       sbitmap_queue_clear()).
+ * @shallow_depth: The maximum number of bits to allocate from a single word.
+ * See sbitmap_get_shallow().
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+static inline int sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
+					    unsigned int *cpu,
+					    unsigned int shallow_depth)
+{
+	int nr;
+
+	*cpu = get_cpu();
+	nr = __sbitmap_queue_get_shallow(sbq, shallow_depth);
+	put_cpu();
+	return nr;
+}
+
+/**
  * sbitmap_queue_clear() - Free an allocated bit and wake up waiters on a
  * &struct sbitmap_queue.
  * @sbq: Bitmap to free from.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 60e800e0b5a0..80aa8d5463fa 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -79,15 +79,15 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
-static int __sbitmap_get_word(struct sbitmap_word *word, unsigned int hint,
-			      bool wrap)
+static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
+			      unsigned int hint, bool wrap)
 {
 	unsigned int orig_hint = hint;
 	int nr;
 
 	while (1) {
-		nr = find_next_zero_bit(&word->word, word->depth, hint);
-		if (unlikely(nr >= word->depth)) {
+		nr = find_next_zero_bit(word, depth, hint);
+		if (unlikely(nr >= depth)) {
 			/*
 			 * We started with an offset, and we didn't reset the
 			 * offset to 0 in a failure case, so start from 0 to
@@ -100,11 +100,11 @@ static int __sbitmap_get_word(struct sbitmap_word *word, unsigned int hint,
 			return -1;
 		}
 
-		if (!test_and_set_bit(nr, &word->word))
+		if (!test_and_set_bit(nr, word))
 			break;
 
 		hint = nr + 1;
-		if (hint >= word->depth - 1)
+		if (hint >= depth - 1)
 			hint = 0;
 	}
 
@@ -119,7 +119,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = __sbitmap_get_word(&sb->map[index],
+		nr = __sbitmap_get_word(&sb->map[index].word,
+					sb->map[index].depth,
 					SB_NR_TO_BIT(sb, alloc_hint),
 					!round_robin);
 		if (nr != -1) {
@@ -141,6 +142,37 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 }
 EXPORT_SYMBOL_GPL(sbitmap_get);
 
+int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
+			unsigned long shallow_depth)
+{
+	unsigned int i, index;
+	int nr = -1;
+
+	index = SB_NR_TO_INDEX(sb, alloc_hint);
+
+	for (i = 0; i < sb->map_nr; i++) {
+		nr = __sbitmap_get_word(&sb->map[index].word,
+					min(sb->map[index].depth, shallow_depth),
+					SB_NR_TO_BIT(sb, alloc_hint), true);
+		if (nr != -1) {
+			nr += index << sb->shift;
+			break;
+		}
+
+		/* Jump to next index. */
+		index++;
+		alloc_hint = index << sb->shift;
+
+		if (index >= sb->map_nr) {
+			index = 0;
+			alloc_hint = 0;
+		}
+	}
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(sbitmap_get_shallow);
+
 bool sbitmap_any_bit_set(const struct sbitmap *sb)
 {
 	unsigned int i;
@@ -342,6 +374,35 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get);
 
+int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
+				unsigned int shallow_depth)
+{
+	unsigned int hint, depth;
+	int nr;
+
+	hint = this_cpu_read(*sbq->alloc_hint);
+	depth = READ_ONCE(sbq->sb.depth);
+	if (unlikely(hint >= depth)) {
+		hint = depth ? prandom_u32() % depth : 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
+	nr = sbitmap_get_shallow(&sbq->sb, hint, shallow_depth);
+
+	if (nr == -1) {
+		/* If the map is full, a hint won't do us much good. */
+		this_cpu_write(*sbq->alloc_hint, 0);
+	} else if (nr == hint || unlikely(sbq->round_robin)) {
+		/* Only update the hint if we used it. */
+		hint = nr + 1;
+		if (hint >= depth - 1)
+			hint = 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
+
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
-- 
2.12.0
