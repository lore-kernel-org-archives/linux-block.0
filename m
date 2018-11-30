Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70ADC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B402086B
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aOSWlfdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B402086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeK3NQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:16:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 08:16:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1985651pld.6
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJnY8LWPoB2wQw+JA8hgTEdEY0S1dyCmTNhU6YBjunk=;
        b=aOSWlfdJKfFsR+b3IUj7mLhhbOjgTeY9aQ2t1+ouuaSciU7MT6RhpI4TtHpF5viYgf
         FtZKIrjO4sfRqjrtTYqK5hNFKfL6bDNe6wqAtkmmkAfCh1BUbncal9zNxAeggi/fPK8P
         3NvPTfY4GndWkZp0Q72W4KS2lCrB5JRUkJDlLwxx6GMfJrbT6ZxM6BQZzAShvGQ1GHRO
         YetBkjw/Sy41bHja936LfdctRlr57RMBhU/TwZqrhF3xy43e5vjO0u8AoB0fKh4geezf
         0yYNBZTGwan5Mfg3uOKTMGvG85ith0pRHiL8EvkVbFa//Lkwijx3yZvxtmHwOraTsThs
         Idew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJnY8LWPoB2wQw+JA8hgTEdEY0S1dyCmTNhU6YBjunk=;
        b=NSaFjE9QcZMM7GGaLOtom1iU+XSZLgqFSDXmHyjw/k4h1tLIdE10SorG/f9BiAEnRo
         k2Z0NI8sEo82zVQKv2mlitFGbjSsGD7Q4zifK9x3SfTemeOjBrnMgpVcUVaM2DCxJ/Rk
         sH9uZvIZz8TSkf38kvH+Mkwz5dsRa2NgxBsiQAw73NQ6UsPr3Lii48pcmQPkm4WvbVCw
         IfACKv6Sk6b6XkRdB+jZ3pQ026e7Y9TZmzNTfDkmJ28ExkWzNx/XUsJ3xWLJuLq77JEr
         vbvx1sK1MLkHiumapggsJRj1bkV0KRpB1EbI0+x16t/yGJlSbhB5DeUFP0PWJyU1EJ/S
         RlQg==
X-Gm-Message-State: AA+aEWZZQslYwJsBrjRGMvFvvvt7ez/oABL2kCGr6QBEpZ7r3lForW+f
        1bczljqrUgl8+7VRpktc+x7ZONmQoZ8=
X-Google-Smtp-Source: AFSGD/UZXNnrNoPAyudZO0e+Yhxlg4YHn1aKr4Hf0JVRYpt/DXp3/zrzwFKQ348PI6ijGymfl3MnFA==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr3859225plb.217.1543543754302;
        Thu, 29 Nov 2018 18:09:14 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d16sm3711612pgj.21.2018.11.29.18.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:09:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sbitmap: ammortize cost of clearing bits
Date:   Thu, 29 Nov 2018 19:09:07 -0700
Message-Id: <20181130020908.7325-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130020908.7325-1-axboe@kernel.dk>
References: <20181130020908.7325-1-axboe@kernel.dk>
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
index 804a50983ec5..cec685b89998 100644
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
@@ -310,6 +315,19 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
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
index 45cab6bbc1c7..2316f53f3e1d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -111,6 +111,58 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
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
@@ -514,7 +565,8 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
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

