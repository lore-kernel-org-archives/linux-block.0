Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34399 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWTAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:23 -0500
Received: by mail-pg0-f50.google.com with SMTP id 14so47093675pgg.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:23 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 05/10] sbitmap: add helpers for dumping to a seq_file
Date: Mon, 23 Jan 2017 10:59:42 -0800
Message-Id: <6b27fe00b778210934d798880357ffc4dfea2086.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is useful debugging information that will be used in the blk-mq
debugfs directory.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/sbitmap.h | 34 ++++++++++++++++++++
 lib/sbitmap.c           | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index f017fd6e69c4..97758d1cf79a 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -259,6 +259,29 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 unsigned int sbitmap_weight(const struct sbitmap *sb);
 
 /**
+ * sbitmap_show() - Dump bitmap information to a struct seq_file.
+ * @m: struct seq_file to write to.
+ * @v: Bitmap to show.
+ *
+ * Return: Zero.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+int sbitmap_show(struct seq_file *m, void *v);
+
+/**
+ * sbitmap_bitmap_show() - Dump the raw bitmap to a struct seq_file.
+ * @m: struct seq_file to write to.
+ * @v: Bitmap to show.
+ *
+ * Return: Zero.
+ *
+ * This is intended for debugging. The output isn't guaranteed to be internally
+ * consistent.
+ */
+int sbitmap_bitmap_show(struct seq_file *m, void *v);
+
+/**
  * sbitmap_queue_init_node() - Initialize a &struct sbitmap_queue on a specific
  * memory node.
  * @sbq: Bitmap queue to initialize.
@@ -370,4 +393,15 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
  */
 void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
 
+/**
+ * sbitmap_queue_show() - Dump bitmap queue information to a struct seq_file.
+ * @m: struct seq_file to write to.
+ * @v: Bitmap queue to show.
+ *
+ * Return: Zero.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+int sbitmap_queue_show(struct seq_file *m, void *v);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 8f5c3b268c77..f2b1ca9dfc36 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -17,6 +17,7 @@
 
 #include <linux/random.h>
 #include <linux/sbitmap.h>
+#include <linux/seq_file.h>
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node)
@@ -180,6 +181,51 @@ unsigned int sbitmap_weight(const struct sbitmap *sb)
 }
 EXPORT_SYMBOL_GPL(sbitmap_weight);
 
+int sbitmap_show(struct seq_file *m, void *v)
+{
+	struct sbitmap *sb = v;
+
+	seq_printf(m, "depth=%u\n", sb->depth);
+	seq_printf(m, "weight=%u\n", sbitmap_weight(sb));
+	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
+	seq_printf(m, "map_nr=%u\n", sb->map_nr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sbitmap_show);
+
+int sbitmap_bitmap_show(struct seq_file *m, void *v)
+{
+	struct sbitmap *sb = v;
+	u8 byte = 0;
+	unsigned int byte_bits = 0;
+	int i;
+
+	for (i = 0; i < sb->map_nr; i++) {
+		unsigned long word = READ_ONCE(sb->map[i].word);
+		unsigned int word_bits = READ_ONCE(sb->map[i].depth);
+
+		while (word_bits > 0) {
+			unsigned int bits = min(8 - byte_bits, word_bits);
+
+			byte |= (word & (BIT(bits) - 1)) << byte_bits;
+			byte_bits += bits;
+			if (byte_bits == 8) {
+				seq_write(m, &byte, sizeof(byte));
+				byte = 0;
+				byte_bits = 0;
+			}
+			word >>= bits;
+			word_bits -= bits;
+		}
+	}
+
+	if (byte_bits)
+		seq_write(m, &byte, sizeof(byte));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
+
 static unsigned int sbq_calc_wake_batch(unsigned int depth)
 {
 	unsigned int wake_batch;
@@ -377,3 +423,40 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	}
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_all);
+
+int sbitmap_queue_show(struct seq_file *m, void *v)
+{
+	struct sbitmap_queue *sbq = v;
+	bool first;
+	int i;
+
+	sbitmap_show(m, &sbq->sb);
+
+	seq_puts(m, "alloc_hint={");
+	first = true;
+	for_each_possible_cpu(i) {
+		if (!first)
+			seq_puts(m, ", ");
+		first = false;
+		seq_printf(m, "%u", *per_cpu_ptr(sbq->alloc_hint, i));
+	}
+	seq_puts(m, "}\n");
+
+	seq_printf(m, "wake_batch=%u\n", sbq->wake_batch);
+	seq_printf(m, "wake_index=%d\n", atomic_read(&sbq->wake_index));
+
+	seq_puts(m, "ws={\n");
+	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
+		struct sbq_wait_state *ws = &sbq->ws[i];
+
+		seq_printf(m, "\t{.wait_cnt=%d, .wait=%s},\n",
+			   atomic_read(&ws->wait_cnt),
+			   waitqueue_active(&ws->wait) ? "active" : "inactive");
+	}
+	seq_puts(m, "}\n");
+
+	seq_printf(m, "round_robin=%d\n", sbq->round_robin);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_show);
-- 
2.11.0

