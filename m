Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AA56052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJMQ40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhJMQ4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60BC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r134so426479iod.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahqldeCtg66uzCKobXV+3ZUDAi97hwCQoUdjJg1AbOs=;
        b=VwyWvr7wdYOL9keMvXL/QDfI4sEWrwF/oRAC5cY/WZcR+VdeTnb7a5DnWPvWg7Freo
         O4S7GaL6xuhltdgGs6p2n1jNukmALmWE+/Q+QtL5UUdcExqax2i38AqBIggPDidVIzPd
         FyBOraM8sOT5bSFbiaqC9RY+Pi8PrUr8peK0F7JuCy8H9l9U9OtRBArl/+HfDtWsOLBv
         XdZkg/MBC8eUx/9dDpBChsmJx8lq2bhYIsL1mLxkyUGXINNw0JwCYtHQwig2+xizOsEr
         yDzGsj0h3mdf21tR8PKFZAFoM9lunBLTGD1RlwywclHPoqwlGukbSffMWHM0rx6lTaI1
         Wuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahqldeCtg66uzCKobXV+3ZUDAi97hwCQoUdjJg1AbOs=;
        b=tDJfy7snpdsdGxhBLIJym+HVQvY4DA33zlM711mJ0wc12q2YAxfrSU/1PiGtNIOWDj
         4fnh1K5f9qFvZbnMSki3qCWx5YLGmUczydTcfrnyGssR706wzhKjediogPvC0x93qonQ
         Zmiqt026z4WeBMlWQCYvw9S/Wc2onI4o8jhq+gsJo4XuMG7Sz0sXpWGwzjGB9CXcNVnC
         vLkN0w3d3RoGlF+ReysGIiV1P9Fi05VPzsF3g44AlIhM4rd/wgMf1ISGxPuuRcTeZBxr
         rDhRjT1OvOAPnaJeDDqJceH8VJLmf+88dVn/LlyAZyQRMd2ZEXqXxVcG2BBSDp37ohVG
         aaug==
X-Gm-Message-State: AOAM533mfs4NlIkjSuVBFWRl5eSezwWSHt1I6jSlrORvi/yQkI32tfT8
        8ya8mBHKwYI2sESowoDVhMk1fTgxyk4=
X-Google-Smtp-Source: ABdhPJz88CJrC6mMo/Pl/ZmskF0eZpMfTcw1jcn3B4HJHPADH2RgtDR+21imLn1NJfl0hOpxlEVYaQ==
X-Received: by 2002:a05:6602:2ac3:: with SMTP id m3mr306844iov.138.1634144061391;
        Wed, 13 Oct 2021 09:54:21 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/9] sbitmap: add helper to clear a batch of tags
Date:   Wed, 13 Oct 2021 10:54:10 -0600
Message-Id: <20211013165416.985696-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap currently only supports clearing tags one-by-one, add a helper
that allows the caller to pass in an array of tags to clear.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 11 +++++++++++
 lib/sbitmap.c           | 44 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e30b56023ead..4a6ff274335a 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -528,6 +528,17 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
 void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 			 unsigned int cpu);
 
+/**
+ * sbitmap_queue_clear_batch() - Free a batch of allocated bits
+ * &struct sbitmap_queue.
+ * @sbq: Bitmap to free from.
+ * @offset: offset for each tag in array
+ * @tags: array of tags
+ * @nr_tags: number of tags in array
+ */
+void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
+				int *tags, int nr_tags);
+
 static inline int sbq_index_inc(int index)
 {
 	return (index + 1) & (SBQ_WAIT_QUEUES - 1);
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index f398e0ae548e..c6e2f1f2c4d2 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -628,6 +628,46 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 
+static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
+{
+	if (likely(!sb->round_robin && tag < sb->depth))
+		*per_cpu_ptr(sb->alloc_hint, cpu) = tag;
+}
+
+void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
+				int *tags, int nr_tags)
+{
+	struct sbitmap *sb = &sbq->sb;
+	unsigned long *addr = NULL;
+	unsigned long mask = 0;
+	int i;
+
+	smp_mb__before_atomic();
+	for (i = 0; i < nr_tags; i++) {
+		const int tag = tags[i] - offset;
+		unsigned long *this_addr;
+
+		/* since we're clearing a batch, skip the deferred map */
+		this_addr = &sb->map[SB_NR_TO_INDEX(sb, tag)].word;
+		if (!addr) {
+			addr = this_addr;
+		} else if (addr != this_addr) {
+			atomic_long_andnot(mask, (atomic_long_t *) addr);
+			mask = 0;
+			addr = this_addr;
+		}
+		mask |= (1UL << SB_NR_TO_BIT(sb, tag));
+	}
+
+	if (mask)
+		atomic_long_andnot(mask, (atomic_long_t *) addr);
+
+	smp_mb__after_atomic();
+	sbitmap_queue_wake_up(sbq);
+	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
+					tags[nr_tags - 1] - offset);
+}
+
 void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 			 unsigned int cpu)
 {
@@ -652,9 +692,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 	 */
 	smp_mb__after_atomic();
 	sbitmap_queue_wake_up(sbq);
-
-	if (likely(!sbq->sb.round_robin && nr < sbq->sb.depth))
-		*per_cpu_ptr(sbq->sb.alloc_hint, cpu) = nr;
+	sbitmap_update_cpu_hint(&sbq->sb, cpu, nr);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
 
-- 
2.33.0

