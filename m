Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894759;
	b=WOqMrkOeJDVy6tSqlxHMeh2l6T6r2RYhU64h75N9uaO+HQVHAqAcgX87All31STtIDk8
	 DY5UjoGG9Cmg0YqjA03eQi6MH/MEyYNMU3UR0aE++gAB/xkWE+Z6SM/Lpy/F5ledO2d+u
	 WalMgFPznraPt+OX+iOQeAsdLRXIy9xRzN0Xk5fm3i8CD7i5Q24nbdT+vk/TnHYvV4+l2
	 kFXDcLub7j8bG9a3IYkVfgPZenYAnbNvtbzZjpHJ0vCdpyvg23OFmHS2N1MqLB+GYc7gU
	 V91+rFROR9kfHl9R7U+BgYWjBCi05ywRf4xmT321ctsx61vQYosQoSiXdZe8yZFJnBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G53yd6495YZjDK2uTViEdAV52YMWKJCQhSrCD2FaT6k=;
	b=1g2OAtGYCCtEkjXy3MWdvF35KtUEiu41dU5eT7sO7Oh0L78oum8bODedCj/suDD6U9u4
	 Qkvoz+hSnTPVNM2vEjmpM+hvPXQHvqDjPYmSoMP62oE1evWfn2THuNMVF7OIqBdvX0UJd
	 Yetbqzm3xQWqJxHl3zKQMIyqhUaA9eAgpOFJRsw5ielzn92h+0ELR6T4n3klfOTdcgom6
	 cXJh6yuGC6wUz3z2bYjMxc8qaH1xuOTQcnXYc6WF/yy88M6R++HbPG2VdhtCgI1AswsMz
	 Ii97jb4ESJJ2ZVjotOIugzLfkjz2mQyLZ7rc7nArL88bO2Vm0BaHxARFhXm9EKOKzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=N48zsfFF;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6360A3802
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E6360A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=N48zsfFF
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-156cbe59524so1123099c88.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894758; x=1793499558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G53yd6495YZjDK2uTViEdAV52YMWKJCQhSrCD2FaT6k=;
        b=N48zsfFF3q3JwdjaXTXGHFZzA7XpE/qud4JlcjhpkWyXqLYfCSQlJP6sul9tU6bn9s
         FU/0S8I2J2itPIiFiKXgL3Cr/N2YrbZEOHA2P+fere7LPR35Vtotls/EQbogK6aVN1hL
         5rC/q4rVEmNJ8XqpGoGhpo61y43xzJGA7FMg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894758; x=1793499558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G53yd6495YZjDK2uTViEdAV52YMWKJCQhSrCD2FaT6k=;
        b=mVrW8+BLBts9tVAph7Ng8Q8DoPwrranDzF0n2DeMrd1VuYmxJU25p9rODXoEY4PY7H
         iX9Kv3xucEFmBvEo4zfucl2dT75G3mcZH6OfKsZxU2z1KGjbC9yUgQEwvGIlbwRFFOuB
         Oz/dk0K+3WWvQE2H+fTxr0fbDVBmGnzv6ZBoETlLrtwIRFaVy6J3ri4fr9eJxi5Lo9EO
         VTi6q66P/PEjV5gjujVJdEgu+4woaed/q7sRt0PPoQzMzDwM/6ulsICuMtuDoMQOZkNY
         jWQAli63YXdHq5ZAey413vZjZL8uLS+XOg05qW0s3fOsBwITOX2D1fvbCRHfHhha4WpQ
         7lpA==
X-Forwarded-Encrypted: i=1; AKwUvBwmF42hoz5i32qDei0WsZ4Jgw8yI7hG+mgfiJO6fTdMFzZT16J6emSJrqoQdh5yVtvBG2KTYZe3bJvyuw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPXO/yk7fZ2AWH4m52JzjVUNx8nY5y7pPLsnf3+m2QTPJqa30H
	aIAeN1BYcNwX8k9RnVDWSodlOIHP4IVhfCQ3rpZwMSq6rCzqBtebeQ2DtOakPrXW7A==
X-Gm-Gg: AYBFou201OduBpmxJQzdPc5XRUuFznl98e2IrnpxEfmnIrR+T2Cnspo/zkPCWUNqW+x
	DRoZJhF3a31VZOw7I3ey85Ekfc793pUG6lDwxe+BPaHO+wAwk8AXWLRHcfqr7xfNvDNT+ULSPwh
	+qbVl/kVsT/b7id5rO4/YxGIF/vLrqozTb/vqgLNdUhJa31yaH5tVQVnhsoOt5jcpl36KcM2AyJ
	nu2kpJyOmAe/xoajTC2SZNAJkNwHq+Bvy1ne8kzkxBMbEmqyFcesBMEvr8CBHv4YK35E14vL+8G
	Mmnv1AKzBDeJcJac9ygcLWKX9xkGTYrIOM4jXWnqBLm5XwkU9VY93dEVJZ0aCEYlDB758wo7ccP
	KR0w+ygWnwa1+Z7we6foDhx+D5EBrGx7BprEK7VWMTPgAbcgKCGr3C8yXQ6butI+GF3f5kVwB96
	eegwiK4okoJ7pon60XL4mjPemHV7hA8TySUVKaJC0BfWvm3P6xpSBeNY1p6OEr99axeO9okiNnV
	PdmhEk1PtC4DaCUYpp/dwAL7v1+OyaQhVocQ2mc/unVD3RyH4Y6u69TOpzS8mjyo1jv3yz+q+X7
	g+tTunsUIKRpDq7XlMFQVho1x90D2l7rxb5kWUShuoKR
X-Received: by 2002:a05:7022:6283:b0:14c:96a4:b631 with SMTP id a92af1059eb24-1993702493bmr6104831c88.30.1792894757489;
        Sat, 24 Oct 2026 19:19:17 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:19:17 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 14/15] zram: borrow idle decompression streams in exclusive mode
Date: Sun, 25 Oct 2026 11:18:30 +0900
Message-ID: <20261025021839.1542805-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shared decompression streams eliminate Reader vs Reader priority
inversion for backends with stateless decompression.  However,
backends with stateful decompression contexts (zstd, deflate)
still require exclusive access to the stream [1].

Instead of unconditionally blocking on the local CPU's ->excl_lock,
we can scan online CPUs starting from the current one and try to
borrow the first free stream.  Only when all online streams are
busy, sleep on a per-zcomp waitqueue until any CPU releases an
exclusive stream, which significantly drops contention and wait
time, per Bo Zhang's measurements [2]:

  Metric              Base      cross-CPU borrow
  ----------------------------------------------
  dexcl_contended     15,919    1,447
  dexcl_wait_ns_total 109.6 s   3.66 s
  dexcl_wait_ns_max   145 ms    26.6 ms
  dexcl_avg_wait      6.88 ms   2.53 ms
  dexcl_acquire       2.21M     2.94M

A quick synthetic fio test for Reader vs Reader inversion on 24 CPUs
(preempt=full, zstd, 48 low priority (nice 19) bg readers, 24 normal
priority (nice 0) CPU hogs and 24 high priority (nice -19) fg readers),
fg reader results (average of 3 runs):

  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        396k               1,064k        (+2.7x)
  Read clat avg    48.32 us           9.66 us       (-5.0x)
  Read clat p50    7.58 us            8.85 us       (+17%)
  Read clat p99    14.27 us           31.02 us      (+2.2x)
  Read clat stdev  7,571 us           31.92 us      (-237x)
  Read clat max    3,555,300 us       6,288 us      (-565x)

Reader vs Reader with CONFIG_SCHED_PROXY_EXEC=y in both kernels,
21 runs each:

                          Base                    Patched
  ------------------------------------------------------------------
  zstd-3   Read IOPS      1,055k (+-160k)         1,045k (+-50k)
           Read clat max  113 ms - 2.35 s         2.8 - 6.3 ms
  zstd-12  Read IOPS      973k (+-175k)           1,045k (+-17k)
           Read clat max  135 ms - 2.34 s         2.9 - 7.5 ms

  Welch's t-test on IOPS, 21 runs each (patched vs base):
                          diff        95% CI              p
  ------------------------------------------------------------------
  zstd-3                  -1.0%       [-76k, +63k]        0.78
  zstd-12                 +7.4%       [+2k, +149k]        0.073

  Runs with max read latency over 100 ms / over 1 s:
                          Base                    Patched
  ------------------------------------------------------------------
  zstd-3                  21 of 21 / 9 of 21      0 / 0
  zstd-12                 21 of 21 / 14 of 21     0 / 0

With proxy execution base is about as fast as patched at both levels
(no significant difference, p = 0.78 and p = 0.073).  Base is noisy
though, and its worst case is still 0.1-2.3 s in every run.

[1] https://lore.kernel.org/linux-kernel/20261015112440.1491168-1-zhangbo56@xiaomi.com
[2] https://lore.kernel.org/linux-kernel/20261016134847.1620103-1-zhangbo0325@gmail.com

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 77 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  5 ++-
 drivers/block/zram/zram_drv.c |  4 +-
 3 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 4fda13aac896..72683f91313f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -185,38 +185,67 @@ bool zcomp_shared_decomp(struct zcomp *comp)
 	return !comp->ops->create_dctx;
 }
 
+static bool zcomp_dstrm_excl_trylock(struct zcomp_dstrm *zstrm)
+{
+	/* Cheap pre-check: don't touch a busy stream's cachelines */
+	if (mutex_is_locked(&zstrm->excl_lock))
+		return false;
+	/*
+	 * Pin the stream.  The write side of ->lock is only taken by
+	 * zcomp_cpu_dead(), which also sets ->local_copy to NULL.
+	 */
+	if (!down_read_trylock(&zstrm->lock))
+		return false;
+	if (zstrm->local_copy && mutex_trylock(&zstrm->excl_lock))
+		return true;
+	up_read(&zstrm->lock);
+	return false;
+}
+
+static struct zcomp_dstrm *zcomp_dstrm_excl_tryget(struct zcomp *comp)
+{
+	unsigned int cpu, start = raw_smp_processor_id();
+	struct zcomp_dstrm *zstrm;
+
+	/* Best-effort start CPU hint; migration during the scan is fine */
+	for_each_online_cpu_wrap(cpu, start) {
+		zstrm = per_cpu_ptr(comp->dstream, cpu);
+		if (zcomp_dstrm_excl_trylock(zstrm))
+			return zstrm;
+	}
+	return NULL;
+}
+
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode)
 {
-	for (;;) {
-		struct zcomp_dstrm *zstrm = raw_cpu_ptr(comp->dstream);
-
-		/*
-		 * Pin the stream.  The write side of ->lock is only taken
-		 * by zcomp_cpu_dead(), so this never contends with other
-		 * decompression requests, regardless of their mode.
-		 */
-		down_read(&zstrm->lock);
-		if (!zstrm->local_copy) {
-			/* The stream has been destroyed, re-try */
+	struct zcomp_dstrm *zstrm;
+
+	if (mode == ZCOMP_DSTRM_SHARED) {
+		for (;;) {
+			zstrm = raw_cpu_ptr(comp->dstream);
+			down_read(&zstrm->lock);
+			if (zstrm->local_copy)
+				return zstrm;
 			up_read(&zstrm->lock);
-			continue;
 		}
-
-		/*
-		 * Exclusive requests additionally own ->local_copy and
-		 * ->ctx and hence can only wait for each other.
-		 */
-		if (mode == ZCOMP_DSTRM_EXCLUSIVE)
-			mutex_lock(&zstrm->excl_lock);
-		return zstrm;
 	}
+
+	/* Checks zcomp_dstrm_excl_tryget() before touching the waitq */
+	wait_event(comp->dstrm_waitq, (zstrm = zcomp_dstrm_excl_tryget(comp)));
+	return zstrm;
 }
 
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode)
+void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
+		     enum zcomp_dstrm_mode mode)
 {
-	if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+	if (mode == ZCOMP_DSTRM_EXCLUSIVE) {
 		mutex_unlock(&zstrm->excl_lock);
+		up_read(&zstrm->lock);
+		if (wq_has_sleeper(&comp->dstrm_waitq))
+			wake_up(&comp->dstrm_waitq);
+		return;
+	}
 	up_read(&zstrm->lock);
 }
 
@@ -289,6 +318,8 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 	mutex_lock(&zstrm->excl_lock);
 	ret = zcomp_decompress_buf(comp, zstrm, sg, zstrm->local_copy, &req);
 	mutex_unlock(&zstrm->excl_lock);
+	if (wq_has_sleeper(&comp->dstrm_waitq))
+		wake_up(&comp->dstrm_waitq);
 	return ret;
 }
 
@@ -357,6 +388,8 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 		goto cleanup;
 	}
 
+	init_waitqueue_head(&comp->dstrm_waitq);
+
 	for_each_possible_cpu(cpu) {
 		struct zcomp_dstrm *zstrm = per_cpu_ptr(comp->dstream, cpu);
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 362a6da014aa..ca1ebc70ad0a 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,6 +5,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
+#include <linux/wait.h>
 
 struct scatterlist;
 
@@ -96,6 +97,7 @@ struct zcomp_ops {
 struct zcomp {
 	struct zcomp_cstrm __percpu *cstream;
 	struct zcomp_dstrm __percpu *dstream;
+	wait_queue_head_t dstrm_waitq;
 	const struct zcomp_ops *ops;
 	struct zcomp_params *params;
 	struct hlist_node node;
@@ -115,7 +117,8 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
 bool zcomp_shared_decomp(struct zcomp *comp);
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode);
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode);
+void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
+		     enum zcomp_dstrm_mode mode);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 		   const void *src, unsigned int *dst_len);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8c0fe34b7a28..8d55b1104b76 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1382,7 +1382,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 		copy_page(dst, zstrm->local_copy);
 		kunmap_local(dst);
 	}
-	zcomp_dstrm_put(zstrm, ZCOMP_DSTRM_EXCLUSIVE);
+	zcomp_dstrm_put(zram->comps[prio], zstrm, ZCOMP_DSTRM_EXCLUSIVE);
 	slot_unlock(zram, index);
 
 	return ret;
@@ -2135,7 +2135,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst);
 	kunmap_local(dst);
-	zcomp_dstrm_put(zstrm, mode);
+	zcomp_dstrm_put(zram->comps[prio], zstrm, mode);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
 
 	return ret;
-- 
2.56.0.257.gf7497c7d27-goog

