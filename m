Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31147C33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31182146E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iE9fLIYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgAGQam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33422 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQam (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:42 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so53226927ioh.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ierO3fX9pg4Gi2HSO0ZNBZgupNQhVcF7l9T7m010bY=;
        b=iE9fLIYWLVue+QCNBgZ6WAUnlF92DkJScpWRYmQaSlYn9rzu1QQXqVLcw68oZpIVDx
         3bYHqVtTC9opOxilNMQUkRRT4GtHlt/s/6LmyM0QBZNkG7cJ31C0BVkB94loVCBCLPyJ
         Qe3xzBcvB0cWfKLJcP3sohPDwydLJDNHJ5XRySU4UnrTuVlumXX54jVEWmqFA5O67vpM
         +PhUEQ53a/k4zgdeF6pfIszzNLwnCyvV98bWs5Zl944vCkciHO1CIfHvR7JKi7ugFzQi
         3g/ISmWWxgPtzUSA22YhGMrfwGZCkFPrlvqzQNAa3DwfKcsnt3y1eQN/gI2PCoDad1dG
         Ubdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ierO3fX9pg4Gi2HSO0ZNBZgupNQhVcF7l9T7m010bY=;
        b=F8zQyKFQwXY8bDEx+hTPVhgZVs7MEYJybRrnQz7ZKs4smIgMIz5liR1RPA+0RZQsFd
         Vx4jNhsWZrkJfLii9kKADGI9BKr8MTiVW9lJVxqh9ovXXcnLrCO5dTCS1wkfGZ5JdEEe
         QJHloObzoCOggw81XYbBWDa7GpkYXyLybHUn3lVu0QepQ+LG936qfxePmg4zrGvMipOd
         PIqWiIBv6o+1UbGyB637uIp66zY7J7tQVCTf8LRIfwRGLxpK1QzojfukRrgyBPFFc/Hf
         UAo/LHuQf9mITPbZYfwnOnCGJH0VucV86BAE6rPnC1rIl1C1nAD2hUG0Hzusb6Ss+7ZZ
         3Q7A==
X-Gm-Message-State: APjAAAV6UOqCoxaW6ZlcLxK+nmlaskHo5lWpdv1tg5jK/93RdDbbOoq+
        A0lrcF6SnkXA5G7eY05SekTF3EkaA7Q=
X-Google-Smtp-Source: APXvYqxWBCuBKvtMEKGJi1yaLbWsCdNL7cl0E8EYXTg+aimtg9IWXePmqKvEsG2h4XtXK3gZhIjtKw==
X-Received: by 2002:a02:c942:: with SMTP id u2mr306377jao.49.1578414640862;
        Tue, 07 Jan 2020 08:30:40 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] sbitmap: remove cleared bitmask
Date:   Tue,  7 Jan 2020 09:30:32 -0700
Message-Id: <20200107163037.31745-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
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
index 33feec8989f1..af6d6578809f 100644
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

