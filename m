Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36620 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdAYWda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 17:33:30 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so9181121pgj.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 14:33:19 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 05/10] sbitmap: add helpers for dumping to a seq_file
Date: Wed, 25 Jan 2017 14:32:13 -0800
Message-Id: <20a158eb0622e89cd16d1c112952908561f6b0e3.1485382647.git.osandov@fb.com>
In-Reply-To: <adfbb141405c3c0697af61bc686d8ec7d9aa2b8d.1485360145.git.osandov@fb.com>
References: <adfbb141405c3c0697af61bc686d8ec7d9aa2b8d.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is useful debugging information that will be used in the blk-mq
debugfs directory.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Jens took offense to me making the bitmap dumps binary, so this turns them into
nicely formatted hex dumps, like this one:

# cat /sys/kernel/debug/block/nvme0n1/mq/0/tags_bitmap
00000000: 0000 0000 0000 0000 0000 0000 0000 0000
00000010: 0000 2000 0000 0000 0000 0000 0000 0000
00000020: 0000 0000 0000 0000 0000 0000 0000 0000
00000030: 0000 0000 0000 0000 0000 0000 0000 0000
00000040: 0000 0000 0000 0000 0000 0000 0000 0000
00000050: 0000 0000 0000 0000 0000 0000 0000 0000
00000060: 0000 0000 0000 0000 0000 0000 0000 0000
00000070: 0000 0000 0000 0000 0000 0000 0000 0000

I decided to go with this format because 1) it's consistent with
print_hex_dump() already in the kernel, and 2) it's much easier to read
than a string of bits or hex values. In the example above, it's easy to
see that byte 0x12 is set to 0x20 (and do some arithmetic from there to
figure out that the stuck bit is 149).

 include/linux/sbitmap.h | 30 ++++++++++++++++
 lib/sbitmap.c           | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index f017fd6e69c4..d4e0a204c118 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -259,6 +259,26 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 unsigned int sbitmap_weight(const struct sbitmap *sb);
 
 /**
+ * sbitmap_show() - Dump &struct sbitmap information to a &struct seq_file.
+ * @sb: Bitmap to show.
+ * @m: struct seq_file to write to.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
+
+/**
+ * sbitmap_bitmap_show() - Write a hex dump of a &struct sbitmap to a &struct
+ * seq_file.
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
@@ -370,4 +390,14 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
  */
 void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
 
+/**
+ * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &struct
+ * seq_file.
+ * @sbq: Bitmap queue to show.
+ * @m: struct seq_file to write to.
+ *
+ * This is intended for debugging. The format may change at any time.
+ */
+void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 8f5c3b268c77..014913b5407a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -17,6 +17,7 @@
 
 #include <linux/random.h>
 #include <linux/sbitmap.h>
+#include <linux/seq_file.h>
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node)
@@ -180,6 +181,62 @@ unsigned int sbitmap_weight(const struct sbitmap *sb)
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
+static inline void emit_byte(struct seq_file *m, unsigned int offset, u8 byte)
+{
+	if ((offset & 0xf) == 0) {
+		if (offset != 0)
+			seq_putc(m, '\n');
+		seq_printf(m, "%08x:", offset);
+	}
+	if ((offset & 0x1) == 0)
+		seq_putc(m, ' ');
+	seq_printf(m, "%02x", byte);
+}
+
+void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
+{
+	u8 byte = 0;
+	unsigned int byte_bits = 0;
+	unsigned int offset = 0;
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
+				emit_byte(m, offset, byte);
+				byte = 0;
+				byte_bits = 0;
+				offset++;
+			}
+			word >>= bits;
+			word_bits -= bits;
+		}
+	}
+	if (byte_bits) {
+		emit_byte(m, offset, byte);
+		offset++;
+	}
+	if (offset)
+		seq_putc(m, '\n');
+}
+EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
+
 static unsigned int sbq_calc_wake_batch(unsigned int depth)
 {
 	unsigned int wake_batch;
@@ -377,3 +434,37 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
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

