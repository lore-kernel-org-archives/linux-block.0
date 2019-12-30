Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF22C2D0C2
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F81220722
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G70D0aou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfL3SPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:15:17 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34130 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfL3SPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 13:15:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so14402662ywc.1
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPorQbNkP1bf95wsY52FC/L7timFxE0VwX0FyytlDUU=;
        b=G70D0aou+wOFtMT6j1UZuhky31phf4N+//mWV4SErw3DmO9rBwLvHWnFJXQwBzHU4O
         bAMr+RiUtCJLTVpsqiZ1eHZ47+kxW3y00J0Fk8Sq8jMIDwARkGVpucwfB11X1bEKqyEj
         Iipsge6DMq+g5C3f6OZjEvXR7sudtUB5HoN6q3IYvA+OLLaHm7++DPLmbIxRSlZ4YwJT
         N+t7T0aZtFVMYcQsQf/kfyCSnM7HVWrMjPerhhlMnR9lmnfvoyJQpujGEOfH1VuKCD7f
         /cWQp5IYd6Z9TIldv1ftrMTaJId/E2vzpufR9/TOUPgb4GLFuurRt3vhRfYx6QNok10U
         u4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPorQbNkP1bf95wsY52FC/L7timFxE0VwX0FyytlDUU=;
        b=gIigOcNGxkSNphGCjfzj07JZIWto4PlTrFcJAxmE46fx9vgqG3UgloP/MLj6BlTY17
         6zF9F7AEoKZTmfLtb1bUiqAE+HghnVeH7IaeDxubzEidrxdo5Uj5KNLbWtdUWK8W7jCU
         b1Zk7dDvpArkN6rRSxgLWDr92JT99WHHaS3OG3HnTWiRk4TU+cGmMRzGhV6tJqulMl3G
         6iSK4rw00bsqsxSXvQeseg8Q8habZFZkt8Xgc8s84M1o6Uv4r/3tW9PHVoSfpJRj5f4F
         dlaNYPUK5lKOQvJCkYEmViak1OQIExpF3g3g83LfMIpR5ZdUGkLNwk/l+YJwN213oYXX
         flVA==
X-Gm-Message-State: APjAAAU8nxBhTbDJXWVBVsQ1wxBUwG4PCKytnKPtZYaeD2fDGUL6euwZ
        8kMiWuuUZawwPARdzhlzobqurcil/F0=
X-Google-Smtp-Source: APXvYqzd3w8wO6QsZsmK5EskSeKzraWI5sxWOPBrUbGx7ENmyuTDMVcdtnnxps+YeDYW6270sNNhug==
X-Received: by 2002:a0d:c404:: with SMTP id g4mr48272299ywd.403.1577729714306;
        Mon, 30 Dec 2019 10:15:14 -0800 (PST)
Received: from x1.localdomain ([8.46.73.113])
        by smtp.gmail.com with ESMTPSA id u136sm17879910ywf.101.2019.12.30.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:15:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] sbitmap: add batch tag retrieval
Date:   Mon, 30 Dec 2019 11:14:42 -0700
Message-Id: <20191230181442.4460-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230181442.4460-1-axboe@kernel.dk>
References: <20191230181442.4460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows retrieving a batch of tags by the caller, instead of getting
them one at the time.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 23 ++++++++++
 lib/sbitmap.c           | 97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 7cdd82e0e0dd..d7560f57cd6f 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -366,6 +366,29 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
  */
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
 
+/**
+ * __sbitmap_queue_get_batch() - Try to allocate a batch of free tags from a
+ * &struct sbitmap_queue with preemption already disabled.
+ * @sbq: Bitmap queue to allocate from.
+ * @offset: tag offset
+ * @mask: mask of free tags
+ *
+ * Return: Zero if successful, -1 otherwise.
+ */
+int __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, unsigned int *offset,
+			      unsigned long *mask);
+
+/**
+ * __sbitmap_queue_clear_batch() - Free a batch a tags
+ * @sbq: Bitmap queue to allocate from.
+ * @offset: tag offset
+ * @mask: mask of free tags
+ *
+ * Return: Zero if successful, -1 otherwise.
+ */
+void __sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, unsigned int offset,
+				 unsigned long mask);
+
 /**
  * __sbitmap_queue_get() - Try to allocate a free bit from a &struct
  * sbitmap_queue with preemption already disabled.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index a6c6c104b063..62cfc7761e4b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -143,6 +143,42 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 }
 EXPORT_SYMBOL_GPL(sbitmap_get);
 
+static int __sbitmap_get_batch(struct sbitmap *sb, unsigned int index,
+			       unsigned long *ret)
+{
+	do {
+		unsigned long val = sb->map[index].word;
+		unsigned long new_val;
+
+		*ret = ~val;
+		if (!(*ret))
+			return -1;
+
+		new_val = val | *ret;
+		if (cmpxchg(&sb->map[index].word, val, new_val) == val)
+			break;
+	} while (1);
+
+	return 0;
+}
+
+int sbitmap_get_batch(struct sbitmap *sb, unsigned int *index,
+		      unsigned long *ret)
+{
+	int i;
+
+	for (i = 0; i < sb->map_nr; i++) {
+		if (!__sbitmap_get_batch(sb, *index, ret))
+			return 0;
+
+		/* Jump to next index. */
+		if (++(*index) >= sb->map_nr)
+			*index = 0;
+	}
+
+	return -1;
+}
+
 int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 			unsigned long shallow_depth)
 {
@@ -354,6 +390,67 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
 
+void __sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, unsigned int index,
+				 unsigned long mask)
+{
+	index >>= sbq->sb.shift;
+	do {
+		unsigned long val = sbq->sb.map[index].word;
+		unsigned long new_val = val & ~mask;
+
+		if (cmpxchg(&sbq->sb.map[index].word, val, new_val) == val)
+			break;
+	} while (1);
+
+	/*
+	 * Pairs with the memory barrier in set_current_state() to ensure the
+	 * proper ordering of clear_bit_unlock()/waitqueue_active() in the waker
+	 * and test_and_set_bit_lock()/prepare_to_wait()/finish_wait() in the
+	 * waiter. See the comment on waitqueue_active().
+	 */
+	smp_mb__after_atomic();
+	sbitmap_queue_wake_up(sbq);
+}
+
+int __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, unsigned int *offset,
+			      unsigned long *mask)
+{
+	unsigned int hint, depth;
+	int nr;
+
+	/* don't do batches for round-robin or very sparse maps */
+	if (sbq->round_robin || sbq->sb.shift < 5)
+		return -1;
+
+	hint = this_cpu_read(*sbq->alloc_hint);
+	depth = READ_ONCE(sbq->sb.depth);
+	if (unlikely(hint >= depth))
+		hint = depth ? prandom_u32() % depth : 0;
+
+	*offset = SB_NR_TO_INDEX(&sbq->sb, hint);
+
+	nr = sbitmap_get_batch(&sbq->sb, offset, mask);
+
+	if (nr == -1) {
+		/* If the map is full, a hint won't do us much good. */
+		this_cpu_write(*sbq->alloc_hint, 0);
+		return -1;
+	}
+
+	/*
+	 * Only update the hint if we used it. We might not have gotten a
+	 * full 'count' worth of bits, but pretend we did. Even if we didn't,
+	 * we want to advance to the next index since we failed to get a full
+	 * batch in this one.
+	 */
+	hint = ((*offset) + 1) << sbq->sb.shift;
+	if (hint >= depth - 1)
+		hint = 0;
+	this_cpu_write(*sbq->alloc_hint, hint);
+	*offset <<= sbq->sb.shift;
+	return 0;
+}
+
 int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 {
 	unsigned int hint, depth;
-- 
2.24.1

