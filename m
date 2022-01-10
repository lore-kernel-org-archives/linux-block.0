Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC7C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 07:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiAJHcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 02:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239389AbiAJHaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 02:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641799803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zOK/KkDBl1nr0DwI+1IiNBTX9HoPMvosxqDjOyhSLXE=;
        b=SR+LCseFuEUn1UKP047uPq4DK9fLPIqQMtIlvrWJo8Zn5CGdJDYd7x5Y993Td2/RMxFDlG
        FDLjBv6FBECrzCpWXa8mjyWOEcbYJX3IAmSDrhwJz1S5yGWmgQ3my2touSn2Hzb8EP7y8G
        XZebvc9QePOy7vYWVx2DdAUTuLKztuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-XeAp7Uv0Pcm7sDkauI71RQ-1; Mon, 10 Jan 2022 02:29:59 -0500
X-MC-Unique: XeAp7Uv0Pcm7sDkauI71RQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 335451898290;
        Mon, 10 Jan 2022 07:29:58 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858917A227;
        Mon, 10 Jan 2022 07:29:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Martin Wilck <martin.wilck@suse.com>
Subject: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
Date:   Mon, 10 Jan 2022 15:29:45 +0800
Message-Id: <20220110072945.347535-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only the last sbitmap_word can have different depth, and all the others
must have same depth of 1U << sb->shift, so not necessary to store it in
sbitmap_word, and it can be retrieved easily and efficiently by adding
one internal helper of __map_depth(sb, index).

Remove 'depth' field from sbitmap_word, then the annotation of
____cacheline_aligned_in_smp for 'word' isn't needed any more.

Not see performance effect when running high parallel IOPS test on
null_blk.

This way saves us one cacheline(usually 64 words) per each sbitmap_word.

Cc: Martin Wilck <martin.wilck@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove the annotation of ____cacheline_aligned_in_smp for 'word'
	as suggested by Jens

 include/linux/sbitmap.h | 17 ++++++++++-------
 lib/sbitmap.c           | 34 ++++++++++++++--------------------
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index fc0357a6e19b..3754dc45f890 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -27,15 +27,10 @@ struct seq_file;
  * struct sbitmap_word - Word in a &struct sbitmap.
  */
 struct sbitmap_word {
-	/**
-	 * @depth: Number of bits being used in @word/@cleared
-	 */
-	unsigned long depth;
-
 	/**
 	 * @word: word holding free bits
 	 */
-	unsigned long word ____cacheline_aligned_in_smp;
+	unsigned long word;
 
 	/**
 	 * @cleared: word holding cleared bits
@@ -164,6 +159,14 @@ struct sbitmap_queue {
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node, bool round_robin, bool alloc_hint);
 
+/* sbitmap internal helper */
+static inline unsigned int __map_depth(const struct sbitmap *sb, int index)
+{
+	if (index == sb->map_nr - 1)
+		return sb->depth - (index << sb->shift);
+	return 1U << sb->shift;
+}
+
 /**
  * sbitmap_free() - Free memory used by a &struct sbitmap.
  * @sb: Bitmap to free.
@@ -251,7 +254,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 	while (scanned < sb->depth) {
 		unsigned long word;
 		unsigned int depth = min_t(unsigned int,
-					   sb->map[index].depth - nr,
+					   __map_depth(sb, index) - nr,
 					   sb->depth - scanned);
 
 		scanned += depth;
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2709ab825499..e9a51337a2a3 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -85,7 +85,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
-	unsigned int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -117,10 +116,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < sb->map_nr; i++) {
-		sb->map[i].depth = min(depth, bits_per_word);
-		depth -= sb->map[i].depth;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -135,11 +130,6 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
-
-	for (i = 0; i < sb->map_nr; i++) {
-		sb->map[i].depth = min(depth, bits_per_word);
-		depth -= sb->map[i].depth;
-	}
 }
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
@@ -184,8 +174,8 @@ static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&map->word, map->depth, alloc_hint,
-					!sb->round_robin);
+		nr = __sbitmap_get_word(&map->word, __map_depth(sb, index),
+					alloc_hint, !sb->round_robin);
 		if (nr != -1)
 			break;
 		if (!sbitmap_deferred_clear(map))
@@ -257,7 +247,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	for (i = 0; i < sb->map_nr; i++) {
 again:
 		nr = __sbitmap_get_word(&sb->map[index].word,
-					min(sb->map[index].depth, shallow_depth),
+					min_t(unsigned int,
+					      __map_depth(sb, index),
+					      shallow_depth),
 					SB_NR_TO_BIT(sb, alloc_hint), true);
 		if (nr != -1) {
 			nr += index << sb->shift;
@@ -315,11 +307,12 @@ static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 
 	for (i = 0; i < sb->map_nr; i++) {
 		const struct sbitmap_word *word = &sb->map[i];
+		unsigned int word_depth = __map_depth(sb, i);
 
 		if (set)
-			weight += bitmap_weight(&word->word, word->depth);
+			weight += bitmap_weight(&word->word, word_depth);
 		else
-			weight += bitmap_weight(&word->cleared, word->depth);
+			weight += bitmap_weight(&word->cleared, word_depth);
 	}
 	return weight;
 }
@@ -367,7 +360,7 @@ void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
 	for (i = 0; i < sb->map_nr; i++) {
 		unsigned long word = READ_ONCE(sb->map[i].word);
 		unsigned long cleared = READ_ONCE(sb->map[i].cleared);
-		unsigned int word_bits = READ_ONCE(sb->map[i].depth);
+		unsigned int word_bits = __map_depth(sb, i);
 
 		word &= ~cleared;
 
@@ -508,15 +501,16 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 	for (i = 0; i < sb->map_nr; i++) {
 		struct sbitmap_word *map = &sb->map[index];
 		unsigned long get_mask;
+		unsigned int map_depth = __map_depth(sb, index);
 
 		sbitmap_deferred_clear(map);
-		if (map->word == (1UL << (map->depth - 1)) - 1)
+		if (map->word == (1UL << (map_depth - 1)) - 1)
 			continue;
 
-		nr = find_first_zero_bit(&map->word, map->depth);
-		if (nr + nr_tags <= map->depth) {
+		nr = find_first_zero_bit(&map->word, map_depth);
+		if (nr + nr_tags <= map_depth) {
 			atomic_long_t *ptr = (atomic_long_t *) &map->word;
-			int map_tags = min_t(int, nr_tags, map->depth);
+			int map_tags = min_t(int, nr_tags, map_depth);
 			unsigned long val, ret;
 
 			get_mask = ((1UL << map_tags) - 1) << nr;
-- 
2.31.1

