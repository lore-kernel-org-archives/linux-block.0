Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D466C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5487660C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJLSUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhJLSUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:20:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC8C061749
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b10so9789723iof.12
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahqldeCtg66uzCKobXV+3ZUDAi97hwCQoUdjJg1AbOs=;
        b=nV5vIikQm+H4RZwWKi3Z+DLzGzotqecUYJEbpBc2v4REqCwenQ5EbXDg7tI5ag1Az8
         xFD200VZEDHSbCne2eNOQXLVfGmJw1paPs2odHNDyKk4jqxPzCmtCpWhN6gnPUnrpH5v
         XX80d5aCqJe78Nzoiuv+1iL0VIxeuWMHwjZommG+recFeP98y3X6aBpzLbOlMBXOIVkF
         JIdO10XlyBSXx87WiiV4nbtP4CTMzCp2bdyt4B8o+WUQuV0tje6F/0ncU1mAUNsyuivV
         yUdwjoCKG0OntE5SsN5tHowAUAJ1ffxHuTkXhgZQs5WXlpXZ6Fvki8zPx4TqAUTReRrp
         dZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahqldeCtg66uzCKobXV+3ZUDAi97hwCQoUdjJg1AbOs=;
        b=he6E2cgaO/VI5k/u8ktELHESUM6ypdZt4XFASLGp/HJQxK1McQKS5oFXFwHDz7cGdh
         GK6L+YQIpc0wKFToQvv6J/mDfBIZ4/AIVA0g5j4fUYIPQ4y1WFvf643F/sDZUeGFHzSr
         bpFhIoehnrytvEo1dWPuTC2JfHj+d3IBG32t2hcmEQ2M/1aiaju6EKYlV+O76WQee7rQ
         LO+rE8LUUYawBikocHH6rp2ob0sqIQu38lOLJNOQnegHlS6aXZkm8Te/fdWhr/rX+duF
         yqjlMVi+aux560zr5mZyScdkqo5w2ZwgRB3Bbv8saqB/cDd0djkIAACIMUeKTDh2k63U
         pcrg==
X-Gm-Message-State: AOAM532j3IyYl1JJvmyMkXOxRHMYDy0t5bbftfTGZ6Q+Ly31oqoJebSg
        ei7OWhdEpgzdEFrMSmjPIK3pMHLATEbEyA==
X-Google-Smtp-Source: ABdhPJzFcnCmtQkpoS9jgNpz1KuCDVvIaJMsIp64VeP66Nk7r7BhI22s3tZ+XvauVR5uQdqpgxbN+Q==
X-Received: by 2002:a6b:2b17:: with SMTP id r23mr20718473ior.13.1634062666404;
        Tue, 12 Oct 2021 11:17:46 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] sbitmap: add helper to clear a batch of tags
Date:   Tue, 12 Oct 2021 12:17:35 -0600
Message-Id: <20211012181742.672391-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
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

