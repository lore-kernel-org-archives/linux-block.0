Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE34C433FE
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AE561076
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJLRRa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLRRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 13:17:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AEAC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w10so22381949ilc.13
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=la0n6IiKCgAydy4cCn3F9FUVlR8bkOsw5X6TatQ5VVo=;
        b=y9a/gu34FYfO14hM1eZHWPWexOwwkMtpGsv2o2z/M9Hqwz8aZ3Lti9MXBFJZPm5cqn
         xVoKgwracAEU0IVct4AC+91EVl0/Rn9KkNsd5mPIsXBMsDocZuQ9nqcYSgcuAdXbn3sj
         kSCIbKJtDSb/VonjD1ZytaAzN2BIhRtayo69lWpOzJpntyI+ZmjAxIphCDQpCVibhGni
         OYMA3DC6W9U74hvXVWfaofGMLiYsGkruAGP1CXXxkJwmucwX2T+9qmVXH6oeqOvGnY21
         kNdZ/WYIhbI9U3ptytrwgSU4GPZ5Is+i98AsagEP9P1twAj3dvAZXxSrwGVtKZYPvikc
         GlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la0n6IiKCgAydy4cCn3F9FUVlR8bkOsw5X6TatQ5VVo=;
        b=bKuyAH4k8Gk+8Y1KgTBu9/TVJS5MEX6IKEdrDvoyDAAwaQQ65yRMbwJsAfNpwPHzLU
         Ai1+C7fpDbAj4/QFNHnOCMlJea9mbsAvS5MfU510nIHFHuVQccQTh8GVikAmGhhz+x8x
         mnZ7bJy7ePhhHeRM+sZq1VxArb/g449HYjTvJ54wHi+zm9G7LgyUUSd3HYL3vZSPjuGp
         wrqZaPUSGWIbQAqBdKlKoiL/RpV7gTqJdhz90zLZ3ke2ZwpfpMSwr+Vickwd5dNa09m1
         kQFvk37FEt+CtQTQFkksulzZnwYZ3LPprbatoDHEJSvkofQm769BNeO9w36YlULPPZIL
         rq4g==
X-Gm-Message-State: AOAM532lIFHKJCPwvJA2o+/l5p7E1qtsPyzSUm0+jNJtkyZo0HTUItzs
        Ss0pDAAJSFyOQmuVZlETKBt3NPiB1/iKFA==
X-Google-Smtp-Source: ABdhPJx+FpZM7Y3yLvafkR9eq0RGjXIwUfsEvLqJhUiCDvr7l7icoW2NOAtGnFLBmAHtd5LwqfpEqg==
X-Received: by 2002:a05:6e02:154a:: with SMTP id j10mr8604929ilu.267.1634058927415;
        Tue, 12 Oct 2021 10:15:27 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w15sm4577824ill.23.2021.10.12.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 10:15:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sbitmap: add __sbitmap_queue_get_batch()
Date:   Tue, 12 Oct 2021 11:15:24 -0600
Message-Id: <20211012171525.665644-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012171525.665644-1-axboe@kernel.dk>
References: <20211012171525.665644-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer tag allocation batching still calls into sbitmap to get
each tag, but we can improve on that. Add __sbitmap_queue_get_batch(),
which returns a mask of tags all at once, along with an offset for
those tags.

An example return would be 0xff, where bits 0..7 are set, with
tag_offset == 128. The valid tags in this case would be 128..135.

A batch is specific to an individual sbitmap_map, hence it cannot be
larger than that. The requested number of tags is automatically reduced
to the max that can be satisfied with a single map.

On failure, 0 is returned. Caller should fall back to single tag
allocation at that point/

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 13 +++++++++++
 lib/sbitmap.c           | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 2713e689ad66..e30b56023ead 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -426,6 +426,19 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
  */
 int __sbitmap_queue_get(struct sbitmap_queue *sbq);
 
+/**
+ * __sbitmap_queue_get_batch() - Try to allocate a batch of free bits
+ * @sbq: Bitmap queue to allocate from.
+ * @nr_tags: number of tags requested
+ * @offset: offset to add to returned bits
+ *
+ * Return: Mask of allocated tags, 0 if none are found. Each tag allocated is
+ * a bit in the mask returned, and the caller must add @offset to the value to
+ * get the absolute tag value.
+ */
+unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
+					unsigned int *offset);
+
 /**
  * __sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
  * sbitmap_queue, limiting the depth used from each word, with preemption
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b25db9be938a..f398e0ae548e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -489,6 +489,57 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get);
 
+unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
+					unsigned int *offset)
+{
+	struct sbitmap *sb = &sbq->sb;
+	unsigned int hint, depth;
+	unsigned long index, nr;
+	int i;
+
+	if (unlikely(sb->round_robin))
+		return 0;
+
+	depth = READ_ONCE(sb->depth);
+	hint = update_alloc_hint_before_get(sb, depth);
+
+	index = SB_NR_TO_INDEX(sb, hint);
+
+	for (i = 0; i < sb->map_nr; i++) {
+		struct sbitmap_word *map = &sb->map[index];
+		unsigned long get_mask;
+
+		sbitmap_deferred_clear(map);
+		if (map->word == (1UL << (map->depth - 1)) - 1)
+			continue;
+
+		nr = find_first_zero_bit(&map->word, map->depth);
+		if (nr + nr_tags <= map->depth) {
+			atomic_long_t *ptr = (atomic_long_t *) &map->word;
+			int map_tags = min_t(int, nr_tags, map->depth);
+			unsigned long val, ret;
+
+			get_mask = ((1UL << map_tags) - 1) << nr;
+			do {
+				val = READ_ONCE(map->word);
+				ret = atomic_long_cmpxchg(ptr, val, get_mask | val);
+			} while (ret != val);
+			get_mask = (get_mask & ~ret) >> nr;
+			if (get_mask) {
+				*offset = nr + (index << sb->shift);
+				update_alloc_hint_after_get(sb, depth, hint,
+							*offset + map_tags - 1);
+				return get_mask;
+			}
+		}
+		/* Jump to next index. */
+		if (++index >= sb->map_nr)
+			index = 0;
+	}
+
+	return 0;
+}
+
 int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 				unsigned int shallow_depth)
 {
-- 
2.33.0

