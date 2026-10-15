Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BA27A462
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028470; cv=none; b=TWHY2rRVAPwU7VaJE2jtBA28SZx0NrhtxhQpwDOIMRuXd18SaC616K5zGxpekFom85Hwtms1Ft+cE/vVzX77x5M+xZEkYZyUTmRQ/n+/+z0w/vzNb9P+KrWm9ji2CGAN8ogn6klwXbb/RGQBWKi/TWaRnq/W2lqu/BQCetruzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028470; c=relaxed/simple;
	bh=/PyZD06xWmvGd/p8LwqxwkTt9hyKgcZxLnnoZSz488o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3q9ltEU4Hy9D/s23q+12ebUMqQ14ardmpFA40GeJo9dMi8wASrIs0VxlplbdqCkpTWxHqi3HoTC1sZbOrvtL24QumZI17jIpQTf4xFZLt0DbplTOFPuesS1J6LRlgZ1YrNg3PoaV2V5O5eglMd36QZcJop963LyOVY3Md93wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUNdQQLE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUNdQQLE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e831e86ebfso8929395ad.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792028467; x=1792633267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Rn/uJVhfyYtA3tBXf0jKeMnRRwU6eZkuv2ioiXCGGw=;
        b=gUNdQQLE6cy0XPAn1mfHY5C0dH8lGaClBCPSNPJCBQywoe4WdLtWR7jjDTkYji458n
         fzUz4/oprB5YsxuE/haRZ/uVBBoFE6b3IZMyzroV3kY21uYP0foNmsD6Bc0AuEJA5TYu
         cHpE2iTYwWWcEBrJxbGAFiXsw5G+7dvF0mBQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028467; x=1792633267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Rn/uJVhfyYtA3tBXf0jKeMnRRwU6eZkuv2ioiXCGGw=;
        b=hs/YM+9dVQNMCwtLcz6cvz6jEWrR1HfG6rrcw+jH+8NAFJt3jMEUroxnHf84eQsnIr
         rexfm8mG2o6iW4X2unJ6jEst5kdyRm8L+ismJYzMatRB6fG6yYmQTuRjYCll3M1um1aX
         qWeekM4kcUWO6zU9bhvMcuMbFu5mugOQx11PQFMXdUL5SZQL47cYsfRbTORDQbFcCq38
         +ZsO8f6ev39iTOacqQJT3YmafqyE1GAcpKMk2rjt22mQETjCj3Wkr9xcxkCisP5z3uMU
         CGnM7zlk1Suc8yfkkBCXjAxrcObIYw52xSElojL0SIZivTh6TB2ywCQIwOH853e8Aby2
         vvSg==
X-Forwarded-Encrypted: i=1; AKwUvBw9NlG8KKDDJwsUTthqdFwwGEdyd6ilMRkdBCOyanPqmEtufjJq5tuDaa0pV4AZxiTHJATTBcC1e4Pa4Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKL6k0ccxRm3XVo0bibU4dBcRB0aCe4Hvv9imZITyZUiNEIUOjb
	t/rO/jkffwCBAFUqYjwH7ZFZJZW2Dyj74qAfLqGlImdJXkVcqYUxFhuFwLnlYT3vpaJ4KAl3Qzg
	grhg=
X-Gm-Gg: AYBFou0w+nXOElAOg+nQXtbfyj+zyrnc/yqn34MCIhmzNKKK4US8oBI3sENXWsfvlpR
	1P3SFNG8FJKkFtpsZ+1ljPzJrt3veBWPPifxSLLQh4R9ko8uxJ2+9bmfVrRFkk29+f7JdoQgT9g
	+JP9+GT7mbtzGPm2WW6SNTITrZfXZn5Jhc+LuNV3+U0KdafP7NjxhZUj2XpxWUZnBB0OEpYMQ7B
	t/MiF6g8/57j/ECGooLwvK2MA12ioi75k/yH+y1rbgBF5kZ1lnv0TIIZ8jeCI2S3hoZCWGQtHoq
	Ql/a5t3m5+ITwOmPiSwA2NZPsHqNNsKA8K+CvjSTf+Fcq9oiAE0SjiunUeru0tQhKd8OoADJCJZ
	DQCJLgkOZGHI/bMVWh6Iao2IKZq4r/BtLVYlHc5nVkrsOCqzf/OcAEEb8oqXaUtpShMJzXhisYa
	oPu33VE9R7eG6zu/Kxusp+otlyDTS0lGTLowfpldc2FrgCNdCgYFJDtWGrKGa4LXSou0kv/uqUm
	FSDPOfdQi7VxDrDeHSy7fySIaSggbI4GEgH9TgPcnzIJreCYA==
X-Received: by 2002:a17:903:19e8:b0:2e8:79d:15ec with SMTP id d9443c01a7336-2e84280afc4mr161603165ad.6.1792028467036;
        Wed, 14 Oct 2026 18:41:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e94ba30f6asm9486375ad.57.2026.10.14.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:41:05 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:41:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, baohua@kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atAj9o5IgrAeiGiW@google.com>
References: <20261013035201.2809924-11-senozhatsky@chromium.org>
 <20261014153603.1365617-1-zhangbo56@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014153603.1365617-1-zhangbo56@xiaomi.com>

On (26/10/14 23:36), Bo Zhang wrote:
> Following up on the RFC thread [1]: Sergey pointed me at this series as
> the reworked version of the by-direction split I had tested, so I applied
> patches 9 and 10 and re-ran the same A/B. Big improvement.

Thanks!

> I use decompress acquire count (swapped-in pages) as the comparability anchor
> instead of swap volume, which stays within ~20% across builds.
> 
>                       baseline   preempt-disable   9 + 10
>   read contended      24,749     406               1,959
>   read wait_ns total  239.8 s    3.78 s            ~12 s
>   read wait_ns max    757 ms     51.7 ms           72-96 ms
>   read acquire        3,948,150  4,305,078         3,510,610

So... these numbers don't disappoint.  Combined with memory
savings (and zcomp redesign) this series looks like a decent
start.

> Decompression on 9+10 splits into:
>   shared (stateless backend, single-page): 76.7% -> down_read never
>       blocked (dpin_contended = 0)
>   exclusive (cross-page object): 23.3% -> excl_lock, ~1,959 contended

23.3% is a slightly high bounce reads number, basically almost 1/4 of
reads are exclusive.  I wonder if we can do better.  Technically, the
number of bounce reads depends on the data.  Data that are not compressed
good enough can results in much higher numbers.  E.g. if most of the
objects compress to say 2500 bytes then every second object in the size
class becomes a spanning object.

I have a quick and dirty patch that turns ->local_copy into a fallback
slowpath and uses vm_map_ram() for fast path.

A synthetic fio test in VM (reader vs reader inversion test).

BASE (local_copy + excl_lock for spanning objects):
 Run #0: 1,434k IOPS, avg 3.74 us, stdev 443.11 us, p99.99 23.94 us, max 741,374 us (741 ms)
 Run #1: 1,465k IOPS, avg 3.36 us, stdev 99.88 us, p99.99 26.50 us, max 187,415 us (187 ms)
 Run #2: 1,454k IOPS, avg 3.51 us, stdev 171.87 us, p99.99 24.45 us, max 257,715 us (258 ms)
PATCHED (vm_map_ram() for spanning objects):
 Run #0: 1,471k IOPS, avg 3.33 us, stdev 14.69 us, p99.99 28.29 us, max 2,844 us (2.8 ms)
 Run #1: 1,463k IOPS, avg 3.32 us, stdev 15.93 us, p99.99 24.96 us, max 5,182 us (5.2 ms)
 Run #2: 1,458k IOPS, avg 3.34 us, stdev 14.70 us, p99.99 24.96 us, max 5,619 us (5.6 ms)

Just as an idea.

---

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 39d1f9384939..0a9bfa36f5ce 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/cpuhotplug.h>
 #include <linux/highmem.h>
 #include <linux/scatterlist.h>
@@ -181,14 +182,13 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
 	mutex_unlock(&zstrm->lock);
 }
 
-bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg)
+bool zcomp_shared_decomp(struct zcomp *comp)
 {
 	/*
 	 * Shared decompression is only safe when the backend has no
-	 * mutable per-stream decompression context and the object is
-	 * contained within a single page (no ->local_copy bounce needed).
+	 * mutable per-stream decompression context.
 	 */
-	return !comp->ops->create_dctx && sg_is_last(sg);
+	return !comp->ops->create_dctx;
 }
 
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
@@ -257,22 +257,44 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 
 	might_sleep();
 	lockdep_assert_held(&zstrm->lock);
-	if (!zcomp_shared_decomp(comp, sg))
+	if (!zcomp_shared_decomp(comp))
 		lockdep_assert_held(&zstrm->excl_lock);
 
 	if (sg_is_last(sg)) {
 		/* the object is contained within one page, read it in-place */
 		src = kmap_local_page(sg_page(sg));
 		req.src = src + sg->offset;
-	} else {
-		/* the object spans two pages, linearize it into local copy */
-		sg_copy_to_buffer(sg, 2, zstrm->local_copy, src_len);
-		req.src = zstrm->local_copy;
+		ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
+		kunmap_local(src);
+		return ret;
 	}
 
+	if (zcomp_shared_decomp(comp)) {
+		struct page *pages[2];
+		unsigned int flags;
+
+		pages[0] = sg_page(sg);
+		pages[1] = sg_page(sg_next(sg));
+
+		flags = memalloc_noreclaim_save();
+		src = vm_map_ram(pages, 2, NUMA_NO_NODE);
+		memalloc_noreclaim_restore(flags);
+		if (src) {
+			req.src = src + sg->offset;
+			ret = comp->ops->decompress(comp->params, &zstrm->ctx,
+						    &req);
+			vm_unmap_ram(src, 2);
+			return ret;
+		}
+		mutex_lock(&zstrm->excl_lock);
+	}
+
+	/* the object spans two pages, linearize it into local copy */
+	sg_copy_to_buffer(sg, 2, zstrm->local_copy, src_len);
+	req.src = zstrm->local_copy;
 	ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
-	if (src)
-		kunmap_local(src);
+	if (zcomp_shared_decomp(comp))
+		mutex_unlock(&zstrm->excl_lock);
 	return ret;
 }
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 924c4185abe9..6764818d2a9f 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -115,7 +115,7 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
 void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
 
-bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg);
+bool zcomp_shared_decomp(struct zcomp *comp);
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode);
 void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ad244624d4a5..e608769bfad5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2128,7 +2128,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	prio = get_slot_comp_priority(zram, index);
 
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
-	if (zcomp_shared_decomp(zram->comps[prio], sg))
+	if (zcomp_shared_decomp(zram->comps[prio]))
 		mode = ZCOMP_DSTRM_SHARED;
 
 	zstrm = zcomp_dstrm_get(zram->comps[prio], mode);
