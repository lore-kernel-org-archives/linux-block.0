Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385682E645
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608614; cv=none; b=ZocSfjrrVGHt6IfHiGc3IO/D8ihm98fx1fUM6pGA2WENejo4KXN10jh5x6Hd4nrQDFKCMGpJKRK/ncensaxqsUCXkm5yH6yhUOX/z9TDGdXi1iCGpFskCfF/juTOVAqSm0/tI97dkjpvn7oSNa91Tx7J56NdRQZOqgpqD7uO7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608614; c=relaxed/simple;
	bh=B/UrElRiVI8Mb5TQ78FsiverZrM1ogHyQ4vJ53qsSZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ex1eNVR/1nIvCSsism4hjVlgvKyivprUme7VDQepGjwU5nwGln1Qp3HM/boCCTiyRKkuFyOSZMvSKQ2a50WocD31RaWdoaS+O22EBGi2e4sp7lm/c1Jbo5Dy6s32qIsZGzofFhu4ZUoKG0h7ttvWEPvsYpEm8WT69OYRpv+q0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIRARhS3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIRARhS3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba92341f83so562852b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763608612; x=1764213412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70NFH61GTnJkjmmi5AlGpz40lJiQnlEUOy4am33b1D0=;
        b=KIRARhS3J1pyyTjDLx0jux/rpiqzbCYVsgY0N2WWwl4cnIFSSzDkVSl9lnflWkQA9Z
         DcpNDAYbI9TlJ87MuGeDb+Gt20slvLvtdJhrBFWq+fdvX1a+dC2cadgNac1dDEAx9eKH
         ClUi1tuBeuIGNQRkgcIKS7xTJ/L+3b63U7QP/RifU0nwJLOUkuswjgq0pgEca2ZKbTMk
         b9bO/6SS6AqQQLyQuoyJV30kFqwRpErC8smY4W037BD9Hv613J7rw689iZ0wg6zJHxgx
         pCnA5yz5cbpt86+IYJ2PxBiG+/jGYMtPXUKd/nJOWKG7ePru08JwKjJIJ5eq9RgNl2Vz
         6GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763608612; x=1764213412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70NFH61GTnJkjmmi5AlGpz40lJiQnlEUOy4am33b1D0=;
        b=gX9qBr2U28hlcVKQx6eWectwCnFQQndAoVonRysXdpYScijkv38vo8ukBOy3zeLsfP
         tTC+8KGRTEQaIQO+Mj/SxzEcN7nU1uaI+x+m3l0ZMz8JkBrSUjvzuaXyJ+AgsAyRZ0P1
         DZC7HtyoNPEMAskIJNfSisnjCfvWM9VI5kqk/e5TZKnfUYJ8rQAtehDRuL6Fd/iX9c4H
         /FQFRCdQXFjOZYq5Vb2V/vlDHA3y7CB5LLXgbKJUKCVlKSXQ26g+n4u6NnaHjleH3IzG
         yybmXg6WljsL3ILFs459aQVmB7a0PO8kO7GIdWNTHQbfs8aUOiEe3UfWRNOpGD6PE0ob
         AOlA==
X-Forwarded-Encrypted: i=1; AJvYcCXfJ2SZ+r5elvFtl+5+Sc5ma7bOpW/6QsGTFjYNN7jQTolyMzvBWH2qtBNszjTR8L2aScMSCj5vNpiSzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wWodc69pPG7wju3FAWdF+TzjSDwXovKz1au052twSw9+o3Pa
	CpAmlfTkWDaSNYKRJB+N5/ngz89+wFomc94TrF9tnSTIHqRQKe9kzBuiuXilkrUXNNM=
X-Gm-Gg: ASbGncsIfLhQ0isfiBSj7V8WMiQVw3DrLLxazJshaa2Agoch+XcZp12ClPFVNzeliLo
	kWCOg8Hfqtz1egqbY2kT9iefP7HB7LtIqP+XpuFEz6wCzCepsIdpQbVLTjTYptLVdcUdGAjpGMa
	gjh3WuPgZx2H4Vvmrg5v6gVjVWe1JfXMQl3CDXgqSd8bqV7nBbY4O/Fhuhnjtk8nZXOdSVsKgJA
	eBIkk42gt7fIaKQ0yyR1RHDj1vp011hhRBDj6Dl9KdO3f3LR6CvF/xiOWyUF0j78l1Lrb/9XZ1s
	BVX6qO+j+m66/sPqSQqRPmrZFH1cHbyuXnXjmQ356QG1a+QR0bposaCRHBjsyKXF/z4Eb7rkbTj
	UzvpWxKYvAN8RAH10qnyT71UWovOCAqlfTMOkZ8OfRuBGVsbfLqHMrkCOIRRQKrXclo38fHGEfR
	lUdSvJGuYcd0I3Ez5ZnrolYa7OmWvPJB7nzSAEHJEc5s/hsJXS
X-Google-Smtp-Source: AGHT+IHH3oD7g8BD9bufjR1EV9E2xtk0m7O2f1DTVeLcgkr9fZ7S+bgBnA7abDuLKGFXqTbdULySPw==
X-Received: by 2002:a05:6a00:3ccc:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-7c3f0d5eebamr1742936b3a.27.1763608611658;
        Wed, 19 Nov 2025 19:16:51 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7c29asm879890b3a.9.2025.11.19.19.16.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 19:16:50 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Date: Thu, 20 Nov 2025 11:16:26 +0800
Message-Id: <20251120031626.92425-3-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251120031626.92425-1-fengnanchang@gmail.com>
References: <20251120031626.92425-1-fengnanchang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

This is just apply Kuai's patch in [1].

blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
submit_queues through configfs for null_blk), while it might still be
used from other context(e.g. switch elevator to none):

t1					t2
elevator_switch
 blk_mq_unquiesce_queue
  blk_mq_run_hw_queues
   queue_for_each_hw_ctx
    // assembly code for hctx = (q)->queue_hw_ctx[i]
    mov    0x48(%rbp),%rdx -> read old queue_hw_ctx

					__blk_mq_update_nr_hw_queues
					 blk_mq_realloc_hw_ctxs
					  hctxs = q->queue_hw_ctx
					  q->queue_hw_ctx = new_hctxs
					  kfree(hctxs)
    movslq %ebx,%rax
    mov    (%rdx,%rax,8),%rdi ->uaf

This problem was found by code review, and I comfirmed that the concurrent
scenario do exist(specifically 'q->queue_hw_ctx' can be changed during
blk_mq_run_hw_queues()), however, the uaf problem hasn't been repoduced yet
without hacking the kernel.

Sicne the queue is freezed in __blk_mq_update_nr_hw_queues(), fix the
problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
without grabbing 'q_usage_counter'.

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-mq.c         |  7 ++++++-
 block/blk-mq.h         | 11 +++++++++++
 include/linux/blk-mq.h |  2 +-
 include/linux/blkdev.h |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eed12fab3484..82195f22befd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (hctxs)
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
-		q->queue_hw_ctx = new_hctxs;
+		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
+		/*
+		 * Make sure reading the old queue_hw_ctx from other
+		 * context concurrently won't trigger uaf.
+		 */
+		synchronize_rcu();
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 80a3f0c2bce7..ccd8c08524a4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	rcu_read_lock();
+	hctx = *(rcu_dereference(q->queue_hw_ctx) + id);
+	rcu_read_unlock();
+
+	return hctx;
+}
+
 static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0795f29dd65d..484baf91fd91 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1001,7 +1001,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56328080ca09..f50f2d5eeb55 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -493,7 +493,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct blk_mq_hw_ctx __rcu	**queue_hw_ctx;
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.39.5 (Apple Git-154)

