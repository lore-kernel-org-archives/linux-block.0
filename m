Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28444C4332F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C17760F8F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhJQCIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhJQCIh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D3C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s3so11373780ild.0
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0QV96xx561bA3GdpG3X6EbF6DpqdsjQW9dcNKICRdY=;
        b=cbCi3x8VLh/x3hBteWQUYZbgZmLtbraeSBTDyQqxRZ+cqIunytmfMFVbm2P3b6RJc0
         8JJ4kf+GXfN/rOu90jFtS/27O6to7eJo6dciEw537GXDmXA9NBIvz7LiNWXAnRGhBg5Q
         ibNrt4HW3PaN4RIM4RIgDeaQBYVLb4Ks+gjxchhWSf7QmJv3Jn0NfIj2aAs/Gcn2Vw5m
         7VdXP1+3mx2ZR3BOHzmOdyA+zZ5koCQpK3kDj18pRqCWtktSLwFMor2Qtja7Sl2E32Qs
         T+w9z0fP4Te++fw7gD4YH4uUePk+QGZIP5H2SweAT/vIR8YS/Qumx9ovF2cLevMNnPW2
         mwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0QV96xx561bA3GdpG3X6EbF6DpqdsjQW9dcNKICRdY=;
        b=IROqvuPIekMyC8Y8n9N/nDnkG7yaVOiQxvG9kx7MJSSIPP6rNIZ5SI6cCwQZp4/A+c
         wFdffohfdNhd3Z11J2HuI/S2HTwONqs/amfw+2qpvHFgvgvR50LW430ZkGrqrtehK6uz
         F+upm84Ao6v64OhlrjAW+Qkz9ljgDN6huH7r4/R2qf6QkVYc34OqE4UNIXeEysTUByMS
         sfUwn7rdH/5DHoMSG2q9JLaWo8jnBitsqZ8eCiG1beqqpscrDO4DNNgwUldBNT+WZWBg
         GOrvalcLL/ziUKsOxwIK5xirmWPkWyrvTAX8Xftv5c0y/rVexb+CBLu/hRWgv5GCHNNV
         9Q7Q==
X-Gm-Message-State: AOAM530EiWLHulvj+Vgcbi4kIzNhbnxRz0jvegPlKiZiqcmP1Ad3WBQ2
        9TeTMXmxsITyRa6kMpcCvA6mPgWDp/FIFQ==
X-Google-Smtp-Source: ABdhPJzL5jSDTV+s/cHUtp3GTAffDeTbVD9BG9n3ia59IJBe0OGCVzXLC7G2703gFjoLjk059Ut6KA==
X-Received: by 2002:a05:6e02:190a:: with SMTP id w10mr9199135ilu.243.1634436387621;
        Sat, 16 Oct 2021 19:06:27 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] sbitmap: add helper to clear a batch of tags
Date:   Sat, 16 Oct 2021 20:06:19 -0600
Message-Id: <20211017020623.77815-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017020623.77815-1-axboe@kernel.dk>
References: <20211017020623.77815-1-axboe@kernel.dk>
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
2.33.1

