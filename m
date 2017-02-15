Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] sbitmap: boundary checks for resized bitmap
Date: Wed, 15 Feb 2017 12:10:42 +0100
Message-Id: <1487157042-5621-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

If the sbitmap gets resized we need to ensure not to overflow
the original allocation. And we should limit the search in
sbitmap_any_bit_set() to the available depth to avoid looking
into unused space.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 12 +++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d4e0a20..5ed3815 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -61,6 +61,11 @@ struct sbitmap {
 	unsigned int map_nr;
 
 	/**
+	 * @map_nr: Number of words (cachelines) allocated for the bitmap.
+	 */
+	unsigned int max_map_nr;
+
+	/**
 	 * @map: Allocated bitmap.
 	 */
 	struct sbitmap_word *map;
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 55e11c4..f6f18b7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -44,7 +44,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 
 	sb->shift = shift;
 	sb->depth = depth;
-	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
+	sb->map_nr = sb->max_map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
 
 	if (depth == 0) {
 		sb->map = NULL;
@@ -70,7 +70,8 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
-
+	if (sb->map_nr > sb->max_map_nr)
+		sb->map_nr = sb->max_map_nr;
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
 		depth -= sb->map[i].depth;
@@ -145,7 +146,11 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		if (sb->map[i].word)
+		const struct sbitmap_word *word = &sb->map[i];
+		unsigned long ret;
+
+		ret = find_first_bit(&word->word, word->depth);
+		if (ret < word->depth)
 			return true;
 	}
 	return false;
@@ -187,6 +192,7 @@ void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
 	seq_printf(m, "busy=%u\n", sbitmap_weight(sb));
 	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
 	seq_printf(m, "map_nr=%u\n", sb->map_nr);
+	seq_printf(m, "max_map_nr=%u\n", sb->max_map_nr);
 }
 EXPORT_SYMBOL_GPL(sbitmap_show);
 
-- 
1.8.5.6
