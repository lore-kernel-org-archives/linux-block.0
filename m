Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34081 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdAYQH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id e4so59022878pfg.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:25 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 05/10] sbitmap: add helpers for dumping to a seq_file
Date: Wed, 25 Jan 2017 08:06:44 -0800
Message-Id: <adfbb141405c3c0697af61bc686d8ec7d9aa2b8d.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is useful debugging information that will be used in the blk-mq
debugfs directory.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/sbitmap.h | 28 +++++++++++++++++++
 lib/sbitmap.c           | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index f017fd6e69c4..4a7998355f2b 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -259,6 +259,25 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 unsigned int sbitmap_weight(const struct sbitmap *sb);
 
 /**
+ * sbitmap_show() - Dump bitmap information to a struct seq_file.
+ * @sb: Bitmap to show.
+ * @m: struct seq_file to write to.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
+
+/**
+ * sbitmap_bitmap_show() - Dump the raw bitmap to a struct seq_file.
+ * @sb: Bitmap to show.
+ * @m: struct seq_file to write to.
+ *
+ * This is intended for debugging. The output isn't guaranteed to be internally
+ * consistent.
+ */
+void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m);
+
+/**
  * sbitmap_queue_init_node() - Initialize a &struct sbitmap_queue on a specific
  * memory node.
  * @sbq: Bitmap queue to initialize.
@@ -370,4 +389,13 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
  */
 void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
 
+/**
+ * sbitmap_queue_show() - Dump bitmap queue information to a struct seq_file.
+ * @sbq: Bitmap queue to show.
+ * @m: struct seq_file to write to.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 8f5c3b268c77..48cb6b5a8e7e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -17,6 +17,7 @@
 
 #include <linux/random.h>
 #include <linux/sbitmap.h>
+#include <linux/seq_file.h>
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node)
@@ -180,6 +181,45 @@ unsigned int sbitmap_weight(const struct sbitmap *sb)
 }
 EXPORT_SYMBOL_GPL(sbitmap_weight);
 
+void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
+{
+	seq_printf(m, "depth=%u\n", sb->depth);
+	seq_printf(m, "weight=%u\n", sbitmap_weight(sb));
+	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
+	seq_printf(m, "map_nr=%u\n", sb->map_nr);
+}
+EXPORT_SYMBOL_GPL(sbitmap_show);
+
+void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
+{
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
+}
+EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
+
 static unsigned int sbq_calc_wake_batch(unsigned int depth)
 {
 	unsigned int wake_batch;
@@ -377,3 +417,37 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	}
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_all);
+
+void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
+{
+	bool first;
+	int i;
+
+	sbitmap_show(&sbq->sb, m);
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
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_show);
-- 
2.11.0

