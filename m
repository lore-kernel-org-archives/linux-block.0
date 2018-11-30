Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914FC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742702082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L4lKV+HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742702082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3MUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:20:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeK3MUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:20:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1913673plb.10
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FL64amkHfziKUXg291XJEzD6bPujZYHM+eAGmoCvs38=;
        b=L4lKV+HDaFtMwQ7sBWg1gSpfTnQwtqhHeJITHqMJ4OJrjalYqS8fLYy2n+fu7OoRNj
         Im6AO9J7dCiYjlRmHXwVM+qdTMa+06+109SrKoqRuYYNiNiQEOX7y5tPxS4or8mStuw0
         QjwCB9Okx1FnFUcRRR62YjNW+MUmFp8Ri4HSnvZmCT9kHIUzbygUceAA2azxDR8ZGfC1
         aXzaMrh1ro0blqXlMxuGEi6nG3NwQc8RFFPUaLIV/erdduqfQctYCmTrcXWk/JpqBV6m
         UxxhGd0d8KtJ15zDn61awAVaWKjb5XaXFQqU4jpkwaxsbFjh7r26ToRAEt/9iF7C/oW5
         emSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FL64amkHfziKUXg291XJEzD6bPujZYHM+eAGmoCvs38=;
        b=s7mnUyfCrkMgQ8DTIWpo4YEHcAAcaW82gMIRfJXwLZ1wiuj4HPfCGStMsqmz/PZbMA
         +HoKZQ05x/1ULiiASDH6ltjyDO5UcgP5sinXP3dy7+UtugFclDkF8OZbqX9OMmMVSrgO
         jo+KrX1jranpmPKnXhixNGSqtmlyFuH/W4n84wIR4elRUUllOw5TODzmR2dTB91LlHz9
         VhwK83MUUiGKUKLty0K38XTyqu5OKzUAUzF6gEcqlVi2UZnb5PDcR7rQzJTglGspkvXg
         WcoGdGrgghHMf/NNPAcbHc01SzruD9gqjt/bXwQR1a8zkM8L0GgvwjbTM3OllIhfOi4p
         SLww==
X-Gm-Message-State: AA+aEWYLlhSfZbdPbBJZSyqiO7bSOZfdE9QiM+mwumx+5LHrRqYZk96v
        YVAZXX+d+mkaGnpeVQFh/jCkulzws5g=
X-Google-Smtp-Source: AFSGD/UoalAz4uVrZgM3REBPPeMOZUtAYXW/QAAmc9y/URUcn0TfBHaZAUdDwGt7QJfnoYEnfO95+Q==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr3615008plb.113.1543540362737;
        Thu, 29 Nov 2018 17:12:42 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm4841749pfn.94.2018.11.29.17.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:12:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] sbitmap: ammortize cost of clearing bits
Date:   Thu, 29 Nov 2018 18:12:33 -0700
Message-Id: <20181130011234.32674-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130011234.32674-1-axboe@kernel.dk>
References: <20181130011234.32674-1-axboe@kernel.dk>
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
 include/linux/sbitmap.h | 26 +++++++++++++++---
 lib/sbitmap.c           | 60 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 5cb1755d32da..13eb8973bd10 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -30,14 +30,19 @@ struct seq_file;
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
 } ____cacheline_aligned_in_smp;
 
 /**
@@ -315,6 +320,19 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
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
index 21e776e3128d..04db31f4dfda 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -114,6 +114,58 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	return nr;
 }
 
+/*
+ * See if we have deferred clears that we can batch move
+ */
+static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
+{
+	unsigned long mask, val;
+
+	if (!sb->map[index].cleared)
+		return false;
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
+	/*
+	 * If someone found ->cleared == 0 before we wrote ->word, then
+	 * they could have failed when they should not have. Check for
+	 * waiters.
+	 */
+	smp_mb__after_atomic();
+	sbitmap_queue_wake_up(container_of(sb, struct sbitmap_queue, sb));
+	return true;
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
@@ -132,9 +184,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
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
@@ -517,7 +568,8 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
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

