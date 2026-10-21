Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550593;
	b=tdE8vW5Ap0ENm06ZOHRTsK0+sWTpSzSbJ/Jl3E7NltG3WYpgSSzT7Uf+ttoZ6lCLrAH3
	 wicwIfjhaZSgnQDUBPATXO876sW3zPeUU3s8yzDmyJ+UC9QUKp2EMo8sZo3tV2D2Sg4Qc
	 rZawU1/GqDDmoTr2cocMRT0smiexswSLAbz3uRIW8ksrvXlImEfcjrZsWcK0KCYI66VVl
	 Un6iYTaCGGjKy7P5sMeaPULRBCHxIoE//KwX912w4Z2DyLroxXCRfDUBAN2UFSdRTlb7s
	 hjJztLqiO/aGd0IOymCUa0Xgi7IYDnD98eBHUc9udVjdj/D4RPcWREjOVqWgJXCdScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GMUHUG9mI8djbWDXUeIrwPM5WKtb93fhgTyjDqvX1u0=;
	b=VadCwIRXoINUB4iX4qVvp3CVDu1QqUxutTu0gmJN+GCWad8YOh6eBa5JQ565CzerfnCl
	 6eKYhK3i6WaDZYM/ixNJpXfK/7d8Zk/DFGYVjJ0DB+nF03v1TkzE4nDEV+rGqegnx26nV
	 1eLX1vgTxx/3OWm8/WPM1NFQBVF6nbpnOKowKnAUPqwxMKTtoVynlCQSlJ8VW1NoGaQHN
	 W7Vtufa3FYpgAlg6b4udtyRfp0eHpBxYzsSy6vtGhD+StHMUzrkGvkyNLi2EGYt6WljqX
	 KxIRNgjDtMFmTp5ecQh+aPnhfxY6sVLIXlUgtIrWyqOAZm7NVrVcEU5ktA+8XZwT6sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c1OyjqNk;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9E60A2629
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29F9E60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c1OyjqNk
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so598101eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550592; x=1793155392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMUHUG9mI8djbWDXUeIrwPM5WKtb93fhgTyjDqvX1u0=;
        b=c1OyjqNko5TSOSTZ6RiXzGIVyNFj+lvYBKJ6Z2hxWEnWQe/2J0W/YpvETCLx1V12nO
         MtqCPLh9XSc/z4O3DBmYsOdNaXrFhrO2fQ1ZvuOhcUDhxUQ0XuVU4MlwO3ELDe5uuVrY
         Md4sEKTC90U+LNY9RFP9Sy2enwMDe20SvCKIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550592; x=1793155392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMUHUG9mI8djbWDXUeIrwPM5WKtb93fhgTyjDqvX1u0=;
        b=PNwTS3omLm8a0QLDYEPOvgvlpxrc1ghr9ZG95aYhbi80eCxGjYvbIVXOXUCSkszTc6
         Nn7oO3kHxMUY9oGcBx1cC9etX6JitnseONwBzkAYHm5HAW9ly+F1pYiNhkTdUXvJUSjF
         yo7MWhpFTeyVLfVumrVW6eqljVTptHyg3BS2G/x0IRCPM9KlOT5KXzYCYYVUGOWJaTr/
         RKRCOxK7NxRhW3V+WUlhh84/H1CTvDew2DWq42MmEK03SHWSA3CqhlJim41FJEF1vS29
         +ki0Pxzzhsv4FTkqnNClwNiCl8nuq5oYjK+96lm+e/t3NHRriGVRIeR3m+fRdg9kUIhH
         ViEw==
X-Forwarded-Encrypted: i=1; AKwUvBytluO3HHWQa7REPANB0tNIvr7btbRbvzjoKv9Y7vabUg1f8WsGH208eKZTu9VaoLLa8Z6HkuIiYZ31WA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+edN78ymQG4wBFYViyNKaM4p7OwLqV/EYqDi5RD7c7+bzSYDQ
	VcIxAIRgw1DSYtVvk6LwNrn99SFolty76akPXxrGzW1vKz9j4p8Ko6sDb47vCQbfyQ==
X-Gm-Gg: AYBFou0VSnjpXkAW/NUjs0SSnrEy2M0yIlafD4GDbXpD5TfXU+mkVZJf6MA/S/3nSp6
	lWb+lxhR9W6vSaFbI7UhtlUsp+V1ICeVlNyc1q3Q7Aal+vsQvS6C0lEzIAEh4qMbGHXgotMv6h6
	C4PFydq1PYS4iA8d06EQktq0/RmazQpyJRVoKwwPZ3O1FscS9Zbd5E9UTx2SmrTXirE7UXvZv7O
	UFLm8eLuNM4BnOqml4k+JPWJrSAraM5TS8tC5oDVGKgWceXGDws4HiDLFokkGfRalcbf4/6MHRV
	Dauf0QxYnUGV+W5/sTwQ/CAU4wGZ+HgTib7MpnIhp9Hz32+QwQkEJskBtQVar9SLpexMlt04/Hf
	gjOyXTIKimyOg/wP8mnSydWsQ28v1LswYHsHNXG102bZyG39pWs83Q7ey2OsBk8u7Qb5VMhDlPV
	pjvzSAJDKpg9XnsdML1MjjFfV1Wxl+1QWcd2Yq0/0//OQY2l5eXJMxeT5ycN6XifP7kIp/HbhxC
	WS4XyaMQRjPhmEVZ6+QxFbCIby27L3Cywj+x+MheDRk+0xSBRFceU9FGLtJuXVOj1gYQ08Fg9W5
	m28svYnEYbWEMbiuqsZu/nAdQ2ZF2oC4r0R1mqQ/T9npUg==
X-Received: by 2002:a05:701b:2051:20b0:16a:f5cd:365 with SMTP id a92af1059eb24-1909fd72082mr1003892c88.5.1792550592171;
        Tue, 20 Oct 2026 19:43:12 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:43:11 -0700 (PDT)
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
Subject: [PATCH v6 10/13] zram: introduce shared decompression streams
Date: Wed, 21 Oct 2026 11:42:20 +0900
Message-ID: <20261021024236.1787884-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
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

Currently, per-CPU decompression streams use a mutex, so there is
a chance for Reader vs Reader priority inversion - a low priority
Reader can get preempted by a higher priority Reader, which simply
will get blocked on the stream mutex.

Switch zcomp_dstrm to permit parallel usage.  However, things are not
completely straightforward.  Many backends have stateless decompression
and don't modify decompression context, so those can be used
concurrently.  But then there are backends that do modify decompression
context.  We also can have compressed object span across physical pages,
which zcomp linearises using stream's ->local_copy buffer before
decompression.  That buffer, clearly, cannot be used concurrently.

Give zcomp_dstrm two locks:
- ->lock (rw_semaphore) pins the stream against CPU hotplug teardown.
  Every decompression request takes it in read mode, and only
  zcomp_cpu_dead() takes it in write mode.
- ->excl_lock (mutex) serializes access to mutable stream state
  (->local_copy and ->ctx).

When the backend has no per-stream decompression context (stateless)
and zsmalloc object fits in a single page (zcomp_shared_decomp()),
the request touches neither ->local_copy nor ->ctx, so it only takes
->lock in read mode (ZCOMP_DSTRM_SHARED).  Otherwise, when ->local_copy
is needed or the backend has a decompression context (zstd, deflate),
additionally take ->excl_lock (ZCOMP_DSTRM_EXCLUSIVE) so exclusive
requests serialize only against each other without blocking shared
readers.

A quick synthetic fio test for Reader vs Reader inversion on 24 CPUs
(preempt=full, lz4, 48 low priority (nice 19) readers, 24 normal
priority (nice 0) CPU hogs and 24 high priority (nice -19) readers):

  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        857k               1,382k        (+61.3%)
  Read clat avg    14.40 us           4.07 us       (-3.5x)
  Read clat stdev  3,270.31 us        671.46 us     (-4.9x)
  Read clat p99.99 1,500 us           24.64 us      (-60.9x)
  Read clat max    2,430,200 us       1,022,758 us  (-2.4x)

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 56 ++++++++++++++++++++++++++++-------
 drivers/block/zram/zcomp.h    | 21 +++++++++++--
 drivers/block/zram/zram_drv.c | 12 +++++---
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1c9f6d5c8cd1..da122bf4dd15 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -165,7 +165,7 @@ struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
 		 * so then unlock and re-try on the current CPU.
 		 */
 		mutex_lock(&zstrm->lock);
-		if (likely(zstrm->buffer))
+		if (zstrm->buffer)
 			return zstrm;
 		mutex_unlock(&zstrm->lock);
 	}
@@ -176,21 +176,49 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
 	mutex_unlock(&zstrm->lock);
 }
 
-struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp)
+bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg)
+{
+	/*
+	 * Shared decompression is only safe when the backend has no
+	 * mutable per-stream decompression context and the object is
+	 * contained within a single page (no ->local_copy bounce needed).
+	 */
+	return !comp->ops->create_dctx && sg_is_last(sg);
+}
+
+struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
+				    enum zcomp_dstrm_mode mode)
 {
 	for (;;) {
 		struct zcomp_dstrm *zstrm = raw_cpu_ptr(comp->dstream);
 
-		mutex_lock(&zstrm->lock);
-		if (likely(zstrm->local_copy))
-			return zstrm;
-		mutex_unlock(&zstrm->lock);
+		/*
+		 * Pin the stream.  The write side of ->lock is only taken
+		 * by zcomp_cpu_dead(), so this never contends with other
+		 * decompression requests, regardless of their mode.
+		 */
+		down_read(&zstrm->lock);
+		if (!zstrm->local_copy) {
+			/* The stream has been destroyed, re-try */
+			up_read(&zstrm->lock);
+			continue;
+		}
+
+		/*
+		 * Exclusive requests additionally own ->local_copy and
+		 * ->ctx and hence can only wait for each other.
+		 */
+		if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+			mutex_lock(&zstrm->excl_lock);
+		return zstrm;
 	}
 }
 
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm)
+void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode)
 {
-	mutex_unlock(&zstrm->lock);
+	if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+		mutex_unlock(&zstrm->excl_lock);
+	up_read(&zstrm->lock);
 }
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
@@ -223,6 +251,9 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_held(&zstrm->lock);
+	if (!zcomp_shared_decomp(comp, sg))
+		lockdep_assert_held(&zstrm->excl_lock);
 
 	if (sg_is_last(sg)) {
 		/* the object is contained within one page, read it in-place */
@@ -277,9 +308,9 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	mutex_unlock(&cstrm->lock);
 
 	dstrm = per_cpu_ptr(comp->dstream, cpu);
-	mutex_lock(&dstrm->lock);
+	down_write(&dstrm->lock);
 	zcomp_dstrm_free(comp, dstrm);
-	mutex_unlock(&dstrm->lock);
+	up_write(&dstrm->lock);
 
 	return 0;
 }
@@ -306,8 +337,11 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	}
 
 	for_each_possible_cpu(cpu) {
+		struct zcomp_dstrm *zstrm = per_cpu_ptr(comp->dstream, cpu);
+
 		mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
-		mutex_init(&per_cpu_ptr(comp->dstream, cpu)->lock);
+		init_rwsem(&zstrm->lock);
+		mutex_init(&zstrm->excl_lock);
 	}
 
 	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 22be50dc51ba..bf41b27958c4 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -4,11 +4,17 @@
 #define _ZCOMP_H_
 
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 
 struct scatterlist;
 
 #define ZCOMP_PARAM_NOT_SET	INT_MIN
 
+enum zcomp_dstrm_mode {
+	ZCOMP_DSTRM_SHARED,
+	ZCOMP_DSTRM_EXCLUSIVE,
+};
+
 struct deflate_params {
 	s32 winbits;
 };
@@ -47,7 +53,14 @@ struct zcomp_cstrm {
 };
 
 struct zcomp_dstrm {
-	struct mutex lock;
+	/*
+	 * Pins the stream: held in read mode by every user, regardless
+	 * of the decompression mode, and in write mode only by
+	 * zcomp_cpu_dead().
+	 */
+	struct rw_semaphore lock;
+	/* Serializes users of the mutable stream state: ->local_copy, ->ctx */
+	struct mutex excl_lock;
 	/* local copy of handle memory */
 	void *local_copy;
 	struct zcomp_ctx ctx;
@@ -99,8 +112,10 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
 void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
 
-struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp);
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm);
+bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg);
+struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
+				    enum zcomp_dstrm_mode mode);
+void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 		   const void *src, unsigned int *dst_len);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index def5266679b0..a34859ff0461 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1373,7 +1373,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 	sg_init_table(sg, 1);
 	sg_set_page(sg, page, size, 0);
 
-	zstrm = zcomp_dstrm_get(zram->comps[prio]);
+	zstrm = zcomp_dstrm_get(zram->comps[prio], ZCOMP_DSTRM_EXCLUSIVE);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size,
 			       zstrm->local_copy);
 	if (!ret) {
@@ -1382,7 +1382,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 		copy_page(dst, zstrm->local_copy);
 		kunmap_local(dst);
 	}
-	zcomp_dstrm_put(zstrm);
+	zcomp_dstrm_put(zstrm, ZCOMP_DSTRM_EXCLUSIVE);
 	slot_unlock(zram, index);
 
 	return ret;
@@ -2115,6 +2115,7 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 static int read_compressed_page(struct zram *zram, struct page *page,
 				unsigned long index)
 {
+	enum zcomp_dstrm_mode mode = ZCOMP_DSTRM_EXCLUSIVE;
 	struct zcomp_dstrm *zstrm;
 	struct scatterlist sg[2];
 	unsigned long handle;
@@ -2126,13 +2127,16 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	size = get_slot_size(zram, index);
 	prio = get_slot_comp_priority(zram, index);
 
-	zstrm = zcomp_dstrm_get(zram->comps[prio]);
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
+	if (zcomp_shared_decomp(zram->comps[prio], sg))
+		mode = ZCOMP_DSTRM_SHARED;
+
+	zstrm = zcomp_dstrm_get(zram->comps[prio], mode);
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst);
 	kunmap_local(dst);
+	zcomp_dstrm_put(zstrm, mode);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
-	zcomp_dstrm_put(zstrm);
 
 	return ret;
 }
-- 
2.56.0.212.g129ede20d9-goog

