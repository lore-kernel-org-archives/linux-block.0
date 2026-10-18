Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DC3D903E
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295538; cv=none; b=UIpLtcyIO1rMbHbI6axVqbH4Bn6TDr3Iq971Li2Yfvk9cazlQRUk0302AjJg3CNJJTitOXR6BpovNKi4MS/NybEWvdZo131jJVCVZAl+1F7ICkXQ4H0BDnUOZHKTWXW6T+5HT5PyUItiMLk3Q9DnS691xhY3SGsRNYbHrY31loI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295538; c=relaxed/simple;
	bh=WQWooKAiGQ3+7rC+vPzm2+FA/Q1PNaF1fgBbbpJTyF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjuY02dMyIftJiZtTB8nEHijiPxqIlG1XrMG5NAthMPAefMMAWTbaKR3RK6NsLLZYbOlVgBhlh6XyFQyMuE2HWtqE+es3n2GluCxZp7O4EQGBhwZTjHPGbZXW2ELLtzLhANzzbRSKQTYkFmvy4kj5GSXXJfn1emHSSBY8UBDHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+nea7Jm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+nea7Jm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso661139a12.2
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295537; x=1792900337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBsgGrwxjk4mKkzegIUyY57FWFNYlpp8ckkkXl62oGc=;
        b=i+nea7JmJ+vFdU5u1sweTnqRC3koR/FMmXDbW5dkUqwmvqrKZCDtQsJe3k4d9l6vlV
         htiNLyo3KjAt26UQt3prC8g/tR0xmMgd9VMBGXiqlY+GSyexpN8Z70YBT9+oAVCNIM3c
         KA0kmeWUsaIDqgc3VFL7YYCt1S4hQfzFgwRlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295537; x=1792900337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBsgGrwxjk4mKkzegIUyY57FWFNYlpp8ckkkXl62oGc=;
        b=SbkWMmF7gcMqSE5TQ45+OK9KxwiqvsMVx+hZbejigNL+keEugZzRZ+owLQ6hWRbrmv
         LnTMm2CPWnBYFV84hgeipXR5GIztKVXkbV2S58IZwuYCjSDt8JvxKT/P6P8tiA4RzpVr
         VHHBpYIFHz+HiTdSKq3Q6TnlAGW+EO6JzSb8u+w6rKqi4dvxKlx+I+PZlOxkKB3lxN3B
         pZpbQCYM7IlerASdOFZUFdYk5iKRV0QEfyFXkhRzRfTx1E6MZIM5Lq1SEkPf43caR1a3
         idoocpq8yemFNK1EWW35q+ArvFGc+ce5CjpLNply/Kb4YROXhL2iy89pYdik85o0nl5D
         V02w==
X-Forwarded-Encrypted: i=1; AKwUvBxyF+fEaNEIADTw5IbuewlBxxnRZQLLHIJZws+0gfGguZcddFeNzBYPlECvYmHCRGIbPiN0jYAOyqVDOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYInzA4+MK16CacpnJOJ0DZm5PwLLu6vPzaVEy6JzFgwQNKhbDpT
	ot5agGiA32z9fDM2uhYGVtWEC41soE8KNvOC0Y6vGuc1s9bi11KIGGI+KpGs3WGE9w==
X-Gm-Gg: AYBFou0y6J9Y56TrfBHctN/IuwaLxmVk31rEGi8oiuLu/Rj1ncjCEvJAW+AIYgMgZyB
	A/URecrhn0UjdWezkw16fxJVFQuQ40moN7viW3Uu1z1VkjOafB8FEPBr9HoAHd38WjY7UMOyVQF
	7FD5YqgZaQocYhnK1QEi3R5xTXLPmtOQKeILY/MdvC1+8oa1yiz6h3J+hDlHElztzgWBgHmnixP
	eATu1mEjwySQUhLqyFw3gs90iKTbUXU8K2DuVwezPZYbsEPQKPPf2xBWd2Kb3rfGd79WbIEe5R9
	UovivesXkXR4dAMAwl+UOAzhZaTQ43jFLX5amU0FH1OkpWIU6IRNtG8nAoCLAQKszO8Nqvha2H8
	R13mvL/sxGALWE1B0IJxsjrWK30u08S2a+7YA7qvNZHwAN9QeGgbZ1o8qK4DE2DJSPrgFd9abab
	CR2CXTjDiLbCwrQ4Q74i9j5OQNy7sdQzgwPIGGo8DeB11u3eXDrnLdSOONAYySvTkUYTq+WWyD1
	88/wadA4ZCPd1jixBNM0BTw8bb4JcujPszczbIC+jE084Xfyvq/B7nkWMlF61FFs692tINootoc
	kHhfK0W5WJZeGsTFQb1pn3tg4Tm1tb8FiWZpwG10ZH8H2CkZUPwt16jYh2HSzy2Vqg==
X-Received: by 2002:a17:90b:5112:b0:3ac:450a:f9d4 with SMTP id 98e67ed59e1d1-3acef1544fdmr3929944a91.64.1792295536643;
        Sat, 17 Oct 2026 20:52:16 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:52:16 -0700 (PDT)
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
Subject: [PATCH v5 11/13] zram: allocate bounce buffer for spanning objects
Date: Sun, 18 Oct 2026 12:51:13 +0900
Message-ID: <20261018035125.3120704-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsmalloc objects that span two physical pages need to be linearized
before decompression, which zcomp does using stream's ->local_copy
buffer.  That buffer cannot be used concurrently, so such reads take
the stream in exclusive mode, even when the backend has stateless
decompression.  And spanning objects are not rare: Bo Zhang measured
23.3% of reads on lzo-rle going through the exclusive path, causing
contention on ->excl_lock of up to 72-96 ms [1].

Allocate a temporary bounce buffer for spanning objects instead, so
that backends with stateless decompression can always use shared mode.
If the allocation fails we fall back to ->local_copy under ->excl_lock.

Per-request bounce buffer fixes the remaining tail latency, as was
measured by Bo Zhang [2]:

  Metric          Base      kmalloc bounce
  ----------------------------------------
  read contended  ~1,959    0
  shared          76.7%     100%

A quick synthetic fio test for Reader vs Reader inversion on 24 CPUs
(lz4, 48 low priority (nice 19) readers, 24 normal priority CPU hogs
 and 24 high priority readers), average of 3 runs:

  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        1,452k             1,466k        (+1.0%)
  Read clat avg    3.46 us            3.30 us       (-4.9%)
  Read clat stdev  165.37 us          15.69 us      (-10.5x)
  Read clat max    306,679 us         7,060 us      (-43.4x)

An alternative approach is to vm_map_ram() scattered objects
(two pages), which fixes the tail latency in the same way,
but deferred TLB flushes add more cost, so it was rejected.

[1] https://lore.kernel.org/linux-kernel/20261014153603.1365617-1-zhangbo56@xiaomi.com
[2] https://lore.kernel.org/linux-kernel/20261015112440.1491168-1-zhangbo56@xiaomi.com
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 47 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  2 +-
 drivers/block/zram/zram_drv.c |  2 +-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index da122bf4dd15..4fda13aac896 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -176,14 +176,13 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
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
@@ -239,6 +238,15 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 	return ret;
 }
 
+static int zcomp_decompress_buf(struct zcomp *comp, struct zcomp_dstrm *zstrm,
+				struct scatterlist *sg, void *buf,
+				struct zcomp_req *req)
+{
+	sg_copy_to_buffer(sg, 2, buf, req->src_len);
+	req->src = buf;
+	return comp->ops->decompress(comp->params, &zstrm->ctx, req);
+}
+
 int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 		     struct scatterlist *sg, unsigned int src_len, void *dst)
 {
@@ -247,27 +255,40 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 		.src_len = src_len,
 		.dst_len = PAGE_SIZE,
 	};
-	void *src = NULL;
+	void *src;
 	int ret;
 
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
 
-	ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
-	if (src)
-		kunmap_local(src);
+	/* exclusive mode already holds ->excl_lock */
+	if (!zcomp_shared_decomp(comp))
+		return zcomp_decompress_buf(comp, zstrm, sg, zstrm->local_copy,
+					    &req);
+
+	/* shared mode: try a per-request bounce buffer first */
+	src = kmalloc(src_len, GFP_NOWAIT | __GFP_NOWARN);
+	if (src) {
+		ret = zcomp_decompress_buf(comp, zstrm, sg, src, &req);
+		kfree(src);
+		return ret;
+	}
+
+	/* fall back to ->local_copy serialized by ->excl_lock */
+	mutex_lock(&zstrm->excl_lock);
+	ret = zcomp_decompress_buf(comp, zstrm, sg, zstrm->local_copy, &req);
+	mutex_unlock(&zstrm->excl_lock);
 	return ret;
 }
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index bf41b27958c4..362a6da014aa 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -112,7 +112,7 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
 void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
 
-bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg);
+bool zcomp_shared_decomp(struct zcomp *comp);
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode);
 void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a34859ff0461..b429c52cb37d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2128,7 +2128,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	prio = get_slot_comp_priority(zram, index);
 
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
-	if (zcomp_shared_decomp(zram->comps[prio], sg))
+	if (zcomp_shared_decomp(zram->comps[prio]))
 		mode = ZCOMP_DSTRM_SHARED;
 
 	zstrm = zcomp_dstrm_get(zram->comps[prio], mode);
-- 
2.56.0.176.g3575e65682-goog

