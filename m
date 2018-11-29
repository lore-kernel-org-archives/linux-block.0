Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2593CC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A82146D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rCcEk9dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67A82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbeK3HHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:07:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50630 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3HHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:07:03 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so5640289iti.0
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BzZk9Q3hagcgnDUeBxirYaHe35+wdzlVzvVclJXcdF8=;
        b=rCcEk9dw89Oi0VanY6rr3u5i46Tp7RBSYoYj9igkX8bxkJOu4WLvlmRCS3SQRGQiKe
         0Om9YEDvj5GhHRa8vfP7hVggVifVvK7VnGfqprMO9MS6u6GnEogDDuItakSyf4efHnFt
         DXpUJyoenl6f98qg+NjRWSCI6d18U9WbRnwz5rBjrRocifgoWOA1O8xPhSfvhqW4f0Ua
         RQXxWl9ZZ2IBFV/W8e7K890ccTIlUskptKL7BKhmrkZVq3i0acymlXdLeVK8iPAOrm8U
         2NWdjxfyrDxiELtpPBGzt16CfF76Py0YkQGzIavLVHX36idfg3AkcwRn2Ppra++p08so
         BSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BzZk9Q3hagcgnDUeBxirYaHe35+wdzlVzvVclJXcdF8=;
        b=ZwPsHQ01JdMt8mM7cmfHIDYNdnnS2D1uIh12Bkjn26jddxgAv96xKsg7DJKQraq5JX
         umtRQzJL9+8BHy5bmYuVot2yBj3Dv5Fldy1urP4jwfxVbv5wnnfd9e59I5xuv3I5wmW4
         uU2CTGH3PKgNByXhRlDchr0dR9twLIDpaRS9gb5xjX6YuuUHGm7ZiNaQDXhZ3CV6d9ps
         p4fGyH8DIRPE/ZGNKCA7rtvSNz1veSRaXa0d4N+7HNwwvEgAOq99Z8dspxOH8ims7ba8
         8lATydYfBtlhpmiqYhV45z34DPGWm3dQ76ZN6MmRLxMHS3UAsQYMJaWlBQxeSi8bNa2X
         pNvA==
X-Gm-Message-State: AA+aEWZPADP+XZdr55F2/YnET0fLBV4QZkU18woOzjCX6/nGPsMbIq3B
        RfpgaYoos1erIxuE/ZpyWt0gHPMGuWQ=
X-Google-Smtp-Source: AFSGD/VGDheOx8HcErEORH8f8+z2IRqpwQu//rR/gFHXa7CKDuZJNnwDzjI0CL5e9mjypuRE3h2wQw==
X-Received: by 2002:a02:4511:: with SMTP id y17mr2525399jaa.56.1543521627652;
        Thu, 29 Nov 2018 12:00:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q76sm1205393iod.35.2018.11.29.12.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 12:00:26 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sbitmap: ammortize cost of clearing bits
Message-ID: <91b96e21-45c9-63ca-334a-6f597b34123e@kernel.dk>
Date:   Thu, 29 Nov 2018 13:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
for 2 cmpxchg(). On top of that, we do those sequentially, hopefully
making that a bit cheaper as well.

In a threaded poll test case, half the overhead of getting and clearing
tags is removed with this change. On another poll test case with a
single thread, performance is unchanged.
    
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This patch is on top of the round robin fix for sbitmap just posted.

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
index 45cab6bbc1c7..3007b89f3e33 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -111,6 +111,51 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
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
@@ -129,9 +174,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
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
@@ -514,7 +558,8 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
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
Jens Axboe

