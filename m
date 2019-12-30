Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB1C2D0C2
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC48120722
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CQUZnq+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfL3SPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:15:13 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42206 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfL3SPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 13:15:13 -0500
Received: by mail-yb1-f195.google.com with SMTP id z10so7058838ybr.9
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aj9Wl4IISw4J8mjSPZKjI/zZD8uz/erzW9iHCZZM2f4=;
        b=CQUZnq+/TBdNKnoD0YhAhV9Ip0OpijxXo94HwLbKiRW472HSfIMX2u9R7ZXwV+l5G5
         uSOGSeZaU1vnDT+CVqXoWHbLs8BKDeSXXU6FLip/yn0TJX/ueaXCynBMk3fvFkPZ9n/n
         bT3QnCwZwzsCGU+fv6+g29/uBiV7I77YdP+IeWUys6koWKDnO1wcGwqgp9H7FRTZkHff
         fGihKrKp8gI6Wz/t2CAYl0OdvN/vigJLxNmEsQdBG5k9oGR/O0gTSzh2v7L7yVnMSU+J
         tFd4tV53g3gjAIT3k2Qhj9jbiEpF+KrsZ13XV0Hj44Bjj5XrRMfsFN4vPH3yPL4HtVLN
         IySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aj9Wl4IISw4J8mjSPZKjI/zZD8uz/erzW9iHCZZM2f4=;
        b=DX2xaJvWx4Fd/T8iTG3f6yjfS28gA/3jtfa5ecC5TPlJDx5szhluE2RWbwEtEolsqZ
         8CYcMK8wpOEf8Q2L3tDcnhPP/DxXCzIhB8iOsmrwc56Q4lLbh9PG3o6HDPmbGw/4nWHL
         FQP+AHf/DLNbv2NcBzxaS1Iow5D8JTUgFRaCgCbiTasthMYplbVDSEeGmvSBVWk+g345
         ObN3eE3w/pBy5Uf5lc18ZQnK/16qbmAP/714gkYW3sNE0Aq364eUGBrJk4QeIT6D0gPA
         71y9EYMFtjtE0u4157ha7A/YUVcP0blJglCr543JlKIPv4xxPEdI/gHPxQS3jBFAwq8D
         bviA==
X-Gm-Message-State: APjAAAWZ7FITUSJdlicLMd9pCMTtn9W4t+M5L5ZhVdQ2MRJmOQzVsVha
        ZOxwDwQZxsjMxPZqiGPfDzfpoQxehK4=
X-Google-Smtp-Source: APXvYqww/DgfGXCeIJpPnm1rKBPshAH7PiPZqNY2BuHBDhqGNLQHZnVGZ0Cm7K0fXmydpYEyJUpwuw==
X-Received: by 2002:a5b:bc2:: with SMTP id c2mr22758665ybr.372.1577729710179;
        Mon, 30 Dec 2019 10:15:10 -0800 (PST)
Received: from x1.localdomain ([8.46.73.113])
        by smtp.gmail.com with ESMTPSA id u136sm17879910ywf.101.2019.12.30.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:15:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] sbitmap: remove cleared bitmask
Date:   Mon, 30 Dec 2019 11:14:40 -0700
Message-Id: <20191230181442.4460-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230181442.4460-1-axboe@kernel.dk>
References: <20191230181442.4460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for doing something better, which doesn't need
us to maintain two sets of bitmaps.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 25 +-----------
 lib/sbitmap.c           | 88 +++++------------------------------------
 2 files changed, 10 insertions(+), 103 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e40d019c3d9d..7cdd82e0e0dd 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -27,16 +27,6 @@ struct sbitmap_word {
 	 * @word: word holding free bits
 	 */
 	unsigned long word ____cacheline_aligned_in_smp;
-
-	/**
-	 * @cleared: word holding cleared bits
-	 */
-	unsigned long cleared ____cacheline_aligned_in_smp;
-
-	/**
-	 * @swap_lock: Held while swapping word <-> cleared
-	 */
-	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
@@ -251,7 +241,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 					   sb->depth - scanned);
 
 		scanned += depth;
-		word = sb->map[index].word & ~sb->map[index].cleared;
+		word = sb->map[index].word;
 		if (!word)
 			goto next;
 
@@ -307,19 +297,6 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
 	clear_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
 }
 
-/*
- * This one is special, since it doesn't actually clear the bit, rather it
- * sets the corresponding bit in the ->cleared mask instead. Paired with
- * the caller doing sbitmap_deferred_clear() if a given index is full, which
- * will clear the previously freed entries in the corresponding ->word.
- */
-static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
-{
-	unsigned long *addr = &sb->map[SB_NR_TO_INDEX(sb, bitnr)].cleared;
-
-	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
-}
-
 static inline void sbitmap_clear_bit_unlock(struct sbitmap *sb,
 					    unsigned int bitnr)
 {
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af88d1346dd7..c13a9623e9b5 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -9,38 +9,6 @@
 #include <linux/sbitmap.h>
 #include <linux/seq_file.h>
 
-/*
- * See if we have deferred clears that we can batch move
- */
-static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
-{
-	unsigned long mask, val;
-	bool ret = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sb->map[index].swap_lock, flags);
-
-	if (!sb->map[index].cleared)
-		goto out_unlock;
-
-	/*
-	 * First get a stable cleared mask, setting the old mask to 0.
-	 */
-	mask = xchg(&sb->map[index].cleared, 0);
-
-	/*
-	 * Now clear the masked bits in our free word
-	 */
-	do {
-		val = sb->map[index].word;
-	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
-
-	ret = true;
-out_unlock:
-	spin_unlock_irqrestore(&sb->map[index].swap_lock, flags);
-	return ret;
-}
-
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node)
 {
@@ -80,7 +48,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
 		depth -= sb->map[i].depth;
-		spin_lock_init(&sb->map[i].swap_lock);
 	}
 	return 0;
 }
@@ -91,9 +58,6 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int bits_per_word = 1U << sb->shift;
 	unsigned int i;
 
-	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(sb, i);
-
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
 
@@ -136,24 +100,6 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	return nr;
 }
 
-static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
-				     unsigned int alloc_hint, bool round_robin)
-{
-	int nr;
-
-	do {
-		nr = __sbitmap_get_word(&sb->map[index].word,
-					sb->map[index].depth, alloc_hint,
-					!round_robin);
-		if (nr != -1)
-			break;
-		if (!sbitmap_deferred_clear(sb, index))
-			break;
-	} while (1);
-
-	return nr;
-}
-
 int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 {
 	unsigned int i, index;
@@ -172,8 +118,10 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 		alloc_hint = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint,
-						round_robin);
+		nr = __sbitmap_get_word(&sb->map[index].word,
+					sb->map[index].depth, alloc_hint,
+					!round_robin);
+
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -198,7 +146,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
-again:
 		nr = __sbitmap_get_word(&sb->map[index].word,
 					min(sb->map[index].depth, shallow_depth),
 					SB_NR_TO_BIT(sb, alloc_hint), true);
@@ -207,9 +154,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 			break;
 		}
 
-		if (sbitmap_deferred_clear(sb, index))
-			goto again;
-
 		/* Jump to next index. */
 		index++;
 		alloc_hint = index << sb->shift;
@@ -229,43 +173,29 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		if (sb->map[i].word & ~sb->map[i].cleared)
+		if (sb->map[i].word)
 			return true;
 	}
 	return false;
 }
 EXPORT_SYMBOL_GPL(sbitmap_any_bit_set);
 
-static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
+static unsigned int sbitmap_weight(const struct sbitmap *sb)
 {
 	unsigned int i, weight = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
 		const struct sbitmap_word *word = &sb->map[i];
 
-		if (set)
-			weight += bitmap_weight(&word->word, word->depth);
-		else
-			weight += bitmap_weight(&word->cleared, word->depth);
+		weight += bitmap_weight(&word->word, word->depth);
 	}
 	return weight;
 }
 
-static unsigned int sbitmap_weight(const struct sbitmap *sb)
-{
-	return __sbitmap_weight(sb, true);
-}
-
-static unsigned int sbitmap_cleared(const struct sbitmap *sb)
-{
-	return __sbitmap_weight(sb, false);
-}
-
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
 {
 	seq_printf(m, "depth=%u\n", sb->depth);
-	seq_printf(m, "busy=%u\n", sbitmap_weight(sb) - sbitmap_cleared(sb));
-	seq_printf(m, "cleared=%u\n", sbitmap_cleared(sb));
+	seq_printf(m, "busy=%u\n", sbitmap_weight(sb));
 	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
 	seq_printf(m, "map_nr=%u\n", sb->map_nr);
 }
@@ -570,7 +500,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 	 * is in use.
 	 */
 	smp_mb__before_atomic();
-	sbitmap_deferred_clear_bit(&sbq->sb, nr);
+	sbitmap_clear_bit_unlock(&sbq->sb, nr);
 
 	/*
 	 * Pairs with the memory barrier in set_current_state() to ensure the
-- 
2.24.1

