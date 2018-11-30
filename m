Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBCC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D6E2146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wLg3hmBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D6E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLADLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:11:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38162 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLADLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:11:11 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so4929356ioj.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+whhgdpIratdkSx0z4AHkfhAKdCtDeyAw027pnHaqZE=;
        b=wLg3hmBeh94SSMKtozhVYQ3oqwoPMGxMfcVKAs+4iS4CNW87JRjBFU4cGN0qQyVV4d
         HuD6+axckLR9tV6cSu67sKbFN+j3AXQExOTXkdZxAgZ7yg4jauI4M/WdToubnxDo5cu7
         H3Yr4NRcANGR7db7fPTwkrnc8NVP72uCpoHEl82JE0uJ0U+jjeL+qPLZJVTUnEthrauA
         IsrNcyVnOHMSpJIFZbQXviOWFrk42jQwtQHsAQ5M7nT5MH684IetAfK70UyMHHoHwVkY
         LoZXJY07H+BDJ8bs6ipG02z+uajEYztgm3pkTRbeAZeEGALmnQWFuDPwgmGZZxIj0L+y
         QgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+whhgdpIratdkSx0z4AHkfhAKdCtDeyAw027pnHaqZE=;
        b=Zhc5lG8mxVeCiQofPEv4xCrvGTDx+/RD1yUIybhR3V3D1+rnkF7ow3QDrJJhJNOEk6
         gcN8RUQf3fGO4ORmdr167dvC81wTT+/yO1weZkG1fxRdCV1xaS4zq1syB1dK7lZn+lM1
         JfhXbcKbqYrkfVieqrKkS3DxdnQX91WePQVrFLnK1dXg/Dm0XoFrTrjITHew0dlm7m2b
         vlCTKY9T3OazmVnmr1/DzJU2VXMnvyh6HySt1q7Ufz3wMfxsN8S4ValdEURs+alpZf/6
         CeN/4WepNxK7k/T00EXJs6rMVTHzHcroH+EwSb6l+9kRX8hoknziy+ScB/wIlt3gju6v
         6IiA==
X-Gm-Message-State: AA+aEWaOOVawQ51etTrd2XDieLyqSC2eOTU+l45ykuldGFhntOMSkYEY
        hHxiraSH2eiwdffzQoCoSU8oF4GZqXo=
X-Google-Smtp-Source: AFSGD/XVOJmHKcxPhBPKInjH4FQqc5uzBVg1nxzIgp7+1iXy5hunPUitQqrQ8+ffAa/Ua7E4+MX4PA==
X-Received: by 2002:a6b:2a05:: with SMTP id q5mr5360053ioq.188.1543593682947;
        Fri, 30 Nov 2018 08:01:22 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m11sm2906784itb.24.2018.11.30.08.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:01:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sbitmap: ammortize cost of clearing bits
Date:   Fri, 30 Nov 2018 09:01:17 -0700
Message-Id: <20181130160118.24683-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130160118.24683-1-axboe@kernel.dk>
References: <20181130160118.24683-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap maintains a set of words that we use to set and clear bits, with
each bit representing a tag for blk-mq. Even though we spread the bits
out and maintain a hint cache, one particular bit allocated will end up
being cleared in the exact same spot.

This introduces batched clearing of bits. Instead of clearing a given
bit, the same bit is set in a cleared/free mask instead. If we fail
allocating a bit from a given word, then we check the free mask, and
batch move those cleared bits at that time. This trades 64 atomic bitops
for 2 cmpxchg().

In a threaded poll test case, half the overhead of getting and clearing
tags is removed with this change. On another poll test case with a
single thread, performance is unchanged.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 31 +++++++++++++---
 lib/sbitmap.c           | 80 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 804a50983ec5..07f117ee19dc 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -30,14 +30,24 @@ struct seq_file;
  */
 struct sbitmap_word {
 	/**
-	 * @word: The bitmap word itself.
+	 * @depth: Number of bits being used in @word/@cleared
 	 */
-	unsigned long word;
+	unsigned long depth;
 
 	/**
-	 * @depth: Number of bits being used in @word.
+	 * @word: word holding free bits
 	 */
-	unsigned long depth;
+	unsigned long word ____cacheline_aligned_in_smp;
+
+	/**
+	 * @cleared: word holding cleared bits
+	 */
+	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_lock: Held while swapping word <-> cleared
+	 */
+	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
@@ -310,6 +320,19 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
 	clear_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
 }
 
+/*
+ * This one is special, since it doesn't actually clear the bit, rather it
+ * sets the corresponding bit in the ->cleared mask instead. Paired with
+ * the caller doing sbitmap_batch_clear() if a given index is full, which
+ * will clear the previously freed entries in the corresponding ->word.
+ */
+static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
+{
+	unsigned long *addr = &sb->map[SB_NR_TO_INDEX(sb, bitnr)].cleared;
+
+	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
+}
+
 static inline void sbitmap_clear_bit_unlock(struct sbitmap *sb,
 					    unsigned int bitnr)
 {
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 45cab6bbc1c7..f6a9553617bd 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -59,6 +59,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
 		depth -= sb->map[i].depth;
+		spin_lock_init(&sb->map[i].swap_lock);
 	}
 	return 0;
 }
@@ -111,6 +112,57 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	return nr;
 }
 
+/*
+ * See if we have deferred clears that we can batch move
+ */
+static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
+{
+	unsigned long mask, val;
+	bool ret = false;
+
+	spin_lock(&sb->map[index].swap_lock);
+
+	if (!sb->map[index].cleared)
+		goto out_unlock;
+
+	/*
+	 * First get a stable cleared mask, setting the old mask to 0.
+	 */
+	do {
+		mask = sb->map[index].cleared;
+	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
+
+	/*
+	 * Now clear the masked bits in our free word
+	 */
+	do {
+		val = sb->map[index].word;
+	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
+
+	ret = true;
+out_unlock:
+	spin_unlock(&sb->map[index].swap_lock);
+	return ret;
+}
+
+static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
+				     unsigned int alloc_hint, bool round_robin)
+{
+	int nr;
+
+	do {
+		nr = __sbitmap_get_word(&sb->map[index].word,
+					sb->map[index].depth, alloc_hint,
+					!round_robin);
+		if (nr != -1)
+			break;
+		if (!sbitmap_deferred_clear(sb, index))
+			break;
+	} while (1);
+
+	return nr;
+}
+
 int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 {
 	unsigned int i, index;
@@ -129,9 +181,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 		alloc_hint = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = __sbitmap_get_word(&sb->map[index].word,
-					sb->map[index].depth, alloc_hint,
-					!round_robin);
+		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint,
+						round_robin);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -206,23 +257,37 @@ bool sbitmap_any_bit_clear(const struct sbitmap *sb)
 }
 EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
 
-unsigned int sbitmap_weight(const struct sbitmap *sb)
+static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 {
 	unsigned int i, weight = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
 		const struct sbitmap_word *word = &sb->map[i];
 
-		weight += bitmap_weight(&word->word, word->depth);
+		if (set)
+			weight += bitmap_weight(&word->word, word->depth);
+		else
+			weight += bitmap_weight(&word->cleared, word->depth);
 	}
 	return weight;
 }
+
+unsigned int sbitmap_weight(const struct sbitmap *sb)
+{
+	return __sbitmap_weight(sb, true);
+}
 EXPORT_SYMBOL_GPL(sbitmap_weight);
 
+static unsigned int sbitmap_cleared(const struct sbitmap *sb)
+{
+	return __sbitmap_weight(sb, false);
+}
+
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
 {
 	seq_printf(m, "depth=%u\n", sb->depth);
-	seq_printf(m, "busy=%u\n", sbitmap_weight(sb));
+	seq_printf(m, "busy=%u\n", sbitmap_weight(sb) - sbitmap_cleared(sb));
+	seq_printf(m, "cleared=%u\n", sbitmap_cleared(sb));
 	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
 	seq_printf(m, "map_nr=%u\n", sb->map_nr);
 }
@@ -514,7 +579,8 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 			 unsigned int cpu)
 {
-	sbitmap_clear_bit_unlock(&sbq->sb, nr);
+	sbitmap_deferred_clear_bit(&sbq->sb, nr);
+
 	/*
 	 * Pairs with the memory barrier in set_current_state() to ensure the
 	 * proper ordering of clear_bit_unlock()/waitqueue_active() in the waker
-- 
2.17.1

