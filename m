Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089E2F9C2D
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320023; cv=none; b=mrHRUncURzGlqb9rU/fgCbsMhTRNvIPOZhmFKGVlL70QenFmuWzWQpS61Y+xGpEz12cL2SAcRHnfwibibtqsbZS08Jl6AGCMbB2qF0eNKN2j1u1LzDiFaGp3osS1oZf4eveWKFtjniTvusYv7YDOmvwGwM9ZHhYQ1wKyqzxlFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320023; c=relaxed/simple;
	bh=Uq3G6AfeJBCntsVTHgNjfKQaXr8IfgtEMiubo4G0O2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrej8j5QPz9Ud0KCLQL5ec5lplcpSZyy/gVQBLv9wC/DPX1uNOM7JH05fwD8b8Tim1Ojh571wnnMwxJCOcL6hXJ/i67Zzg5sKUmK3FFPKm4xC4wAXFdaArmrbMKe6nufr7BvtnD420o1IZ9hFIAqnIgp7vv1E1vCpkaGkrh+Jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqDtDjdg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqDtDjdg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso2427312b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764320021; x=1764924821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pGd8R+PirfibqyB7sCwuWGXaKknkaXw21qWcmiRUYI=;
        b=FqDtDjdgSH5cpPkg/r6cP0WKYYjGx9rYItOmfyfH0DKs1bXr3uT6XKp3KjKmXLzddy
         rGsl+RwAh9C1KYiK6PNyCZAtoi5k6CdB93u2g9Kzes5+6xJ0MY5Xk+guis+eNGXqpK5n
         pD/wlSzCaYMe8AGUAvEVZhhbC3zBQ8uibaVgjT6ZBBWg+9VhXaulw3wt6nIwMYda+pKj
         QefaO3rPCgkfQxi8eHSAriW4vF8xKu2aVx6ec0r5s4fcEYghgBZuXi1Qcbc+AFxhbMrn
         zIc3gv/7cFC1JuFZ5cXczY2Ozodt5bVXV9C4CweCZ+Zj8Xq0pqd/3e+Q8GcOwNQfvhND
         s4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320021; x=1764924821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pGd8R+PirfibqyB7sCwuWGXaKknkaXw21qWcmiRUYI=;
        b=tGtxV2IGdzAn6ySsPNn4INf5vTVJuZrwSPvokd3rGAR/Mmo7hPjpww+aiB30So82Xx
         m0KghuHu6DBMwa16Whp7KDSojclQ5YPxiZUA/THQceBNYLOal/B1nVwuuQ1ooKBKXq9p
         lWl2mFFcTiwOWgyWSD4VbqlJ/zuIuOiUAfyXrfSxexGnRNJCMfd10JbRxSHBhcezBRhf
         5mjd8gObfwue/eYvOLwsAT5p90yc7k66B1lxph5/L1Ljgbt3/fdZFYAUTSa18vexoS21
         sT9NOLLHdIxc6J18xhuYQPg0aNZxeiTaKrTF12eoKOTWS3WAt99NqxJeBDTqm8G6W88C
         OfVA==
X-Forwarded-Encrypted: i=1; AJvYcCUn/kutdjWPMmuhAMnosBOTVgyoUWAluUQbNfuQSh17AUjkUPI48Pnb92nvHekXQ1gGct/Os+/P9EQa/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7mwUNHQNYetJmMHuVMFMI7v1v1sd3k5d/1vZAG43xIQz4uQo
	yHasL8Z92SB85PZ9kyIm4C+GFAJiAxPtzPhkThaf227w1yUfIBRbZqq6
X-Gm-Gg: ASbGncsPSTvD7AVVEOBoT0UJ6eOHt85j6xdABje5dbNuTSh1AI9FLPLw9X0l+fG6xLw
	oqOV7h0G42Pjjf3FN0gzSSKGNzMhNXkLXmg/X9cHNZXQ2hnKBdTPETGFrAkPOAVE3rmp8GItk1y
	ZrDWk2mkAnngnmPvG12OABs/RJ05xhTJcg92L0IfwrdHuKa8rylg2rJa+elF4+REYhU25ODAhzv
	nnVcE1nfm1m7TE9AScDNDN5qZyDX7uNEcDKB1y9CsWn5NKSRjEo6LmTlheZj2BTMA1ZgLzvEma8
	h2NH8DUIRb02F7KHjc985leTp+0nY0Y+6kFQyOiya3lQ5xmXTF5muN28zmt+FlNozQCiloM1+VO
	QWdT5n8ae7/3lvYgSdimXzwKXwafu9ToTHrBVKLS/NXx/OW5KNYTnRQyaC6v6BdXpIUBAeKQJ8s
	5UvKrnRpNFLW6yeZ1nKhKg13Z6IOes21KZ21/NegxW5aE=
X-Google-Smtp-Source: AGHT+IHdxdSCz3w+Z+9oydhoVgQ3u1zaobI3e5ErrQWsEOXIqoEKlAnlIkDr82x6rPAOP/02NKY2pA==
X-Received: by 2002:a05:6a20:914a:b0:334:a523:abe7 with SMTP id adf61e73a8af0-3637db8683emr16042654637.27.1764320020806;
        Fri, 28 Nov 2025 00:53:40 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-be5093b5b79sm3999943a12.25.2025.11.28.00.53.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Nov 2025 00:53:40 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v3 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Date: Fri, 28 Nov 2025 16:53:14 +0800
Message-Id: <20251128085314.8991-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251128085314.8991-1-changfengnan@bytedance.com>
References: <20251128085314.8991-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just apply Kuai's patch in [1] with mirror changes.

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
 include/linux/blk-mq.h | 13 ++++++++++++-
 include/linux/blkdev.h |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eed12fab3484..0b8b72194003 100644
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
+		synchronize_rcu_expedited();
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0795f29dd65d..c16875b35521 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -999,9 +999,20 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
+static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	rcu_read_lock();
+	hctx = rcu_dereference(q->queue_hw_ctx)[id];
+	rcu_read_unlock();
+
+	return hctx;
+}
+
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56328080ca09..e25d9802e08b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -493,7 +493,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct blk_mq_hw_ctx * __rcu *queue_hw_ctx;
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.39.5 (Apple Git-154)

