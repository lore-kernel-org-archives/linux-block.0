Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4282BC33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F6E2146E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q8UUJEHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgAGQan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33422 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQan (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:43 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so53226980ioh.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCLM2cnBgeTta+e+ayFzNbSJeH6itn7C1lQKp+lkSFA=;
        b=q8UUJEHtZYF0qgFGs337yV6/4NWvNbL7/ycbWwlnTu+pLf0plhHuEMtn0jlIPKuwgZ
         dAwPlia8YBgR/c8wM20PrL84a/N/QvcGEokYvlGY0LKHXJk3oAEdQX17gA7yCjaAx1OC
         iqb56MV93CIoswntSPYrfy6kVOEfNJ16/T1HdDlaiOAGyOuba9N6xxUIJqsT1u35+Y7K
         FgT0mz6fnaWxp56zAdMbHPjNh0yOU6HDFCr64ilb76C+PVM5iLtEIXyw2uLgrG1/vaYI
         e3Z8gYQ27PCVsBfKxLN+JsjPstqkvT72yd4u5gAMz7qO0SfZOyRnyzC9FUHCiSiIntFH
         sphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCLM2cnBgeTta+e+ayFzNbSJeH6itn7C1lQKp+lkSFA=;
        b=b5b/Ha+m0PbR7K7pLchBxzTmTubz3oWjC5JiymCH0dLbEVCF53Vbr5x9N2zJbyYGFg
         fHJuQIXdonlVGFWswY5pe+tY4SsqrU430IY0i+l0sZVEleomBAyR+7/VKqzs2dghNmbX
         BVfzDjOt7AZKJc9esKEVeEt/UGtTpCXQa6yJkMKlWiq/GOhddpeWMvZUHuc0PPuhyLDI
         CnqLy9ljXAaSQ2vyQwksf3MqjkQxPB+6jMvgYVdjbVFB/fcjBxjz36M5zE4kFX19mN7E
         p/vNDV/19BChOA17WeHrFcQ1XH9ghBo67xNZZig69f+p3E32IrG1WNOr6TtQeRVdC9C7
         LVLg==
X-Gm-Message-State: APjAAAXGGmf1Hg4N6iHxrEyjtY1T5M3mMmwQb1uCd/zNWCoLytiglyf2
        6HlEIOe/ym6cC53voPfOPqD1EDLW0+g=
X-Google-Smtp-Source: APXvYqwnREfcIgFdh8UiAnhkchDkkSKJ6+5pYnIyDhSPC9JFFFZyb+MV0NJwZJyJrJNR1quj08b/6Q==
X-Received: by 2002:a5d:8483:: with SMTP id t3mr54338027iom.127.1578414641784;
        Tue, 07 Jan 2020 08:30:41 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] sbitmap: add batch tag retrieval
Date:   Tue,  7 Jan 2020 09:30:33 -0700
Message-Id: <20200107163037.31745-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
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
 include/linux/sbitmap.h | 21 +++++++++
 lib/sbitmap.c           | 97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 7cdd82e0e0dd..0d686b64a4b8 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -366,6 +366,27 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
  */
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
 
+/**
+ * __sbitmap_queue_get_batch() - Try to allocate a batch of free tags from a
+ * &struct sbitmap_queue with preemption already disabled.
+ * @sbq: Bitmap queue to allocate from.
+ * @offset: tag offset
+ * @mask: mask of free tags
+ *
+ * Return: Zero if successful, non-zero if not
+ */
+int __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, unsigned int *offset,
+			      unsigned long *mask);
+
+/**
+ * __sbitmap_queue_clear_batch() - Free a batch a tags
+ * @sbq: Bitmap queue to allocate from.
+ * @offset: tag offset
+ * @mask: mask of free tags
+ */
+void __sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, unsigned int offset,
+				 unsigned long mask);
+
 /**
  * __sbitmap_queue_get() - Try to allocate a free bit from a &struct
  * sbitmap_queue with preemption already disabled.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af6d6578809f..530d1a1e15c6 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -137,6 +137,45 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 }
 EXPORT_SYMBOL_GPL(sbitmap_get);
 
+static int __sbitmap_get_batch(struct sbitmap *sb, unsigned int index,
+			       unsigned long *ret)
+{
+	unsigned long val, new_val;
+
+	do {
+		val = sb->map[index].word;
+
+		*ret = ~val;
+		if (sb->map[index].depth != BITS_PER_LONG)
+			*ret &= (1UL << sb->map[index].depth) - 1;
+		if (!*ret)
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
+static unsigned int sbitmap_get_batch(struct sbitmap *sb, unsigned int index,
+				      unsigned long *ret)
+{
+	int i;
+
+	for (i = 0; i < sb->map_nr; i++) {
+		if (!__sbitmap_get_batch(sb, index, ret))
+			return index;
+
+		/* Jump to next index. */
+		if (++index >= sb->map_nr)
+			index = 0;
+	}
+
+	return -1U;
+}
+
 int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 			unsigned long shallow_depth)
 {
@@ -348,6 +387,64 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
 
+void __sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, unsigned int index,
+				 unsigned long mask)
+{
+	index >>= sbq->sb.shift;
+	do {
+		unsigned long val = sbq->sb.map[index].word;
+		unsigned long new_val = ~(val & mask);
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
+	struct sbitmap *sb = &sbq->sb;
+	unsigned long __mask = 0;
+	unsigned int hint, depth;
+	unsigned int index;
+
+	hint = this_cpu_read(*sbq->alloc_hint);
+	depth = READ_ONCE(sb->depth);
+	if (unlikely(hint >= depth))
+		hint = depth ? prandom_u32() % depth : 0;
+
+	index = sbitmap_get_batch(&sbq->sb, SB_NR_TO_INDEX(sb, hint), &__mask);
+
+	if (index == -1U) {
+		/* If the map is full, a hint won't do us much good. */
+		this_cpu_write(*sbq->alloc_hint, 0);
+		return 1;
+	}
+
+	/*
+	 * Only update the hint if we used it. We might not have gotten a
+	 * full 'count' worth of bits, but pretend we did. Even if we didn't,
+	 * we want to advance to the next index since we failed to get a full
+	 * batch in this one.
+	 */
+	hint = (index + 1) << sb->shift;
+	if (hint >= depth - 1)
+		hint = 0;
+	this_cpu_write(*sbq->alloc_hint, hint);
+	*offset = index << sb->shift;
+	*mask = __mask;
+	return 0;
+}
+
 int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 {
 	unsigned int hint, depth;
-- 
2.24.1

