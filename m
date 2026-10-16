Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43E3AF64F
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125909; cv=none; b=ais0k5NBk887dQFjPVm19hyXoKtPYXp9J4JQGUePfqcfFZhZ0AQaYGE5wN8TWLMO++VaqTSps0rUgELBawNeC9vU/rtvMfY7dyh4O+HWrmZ93d1xhRiKpDgCA2wxy7x4HQQgvoTlQcBgOILTLaANMG+r00CkTOSUiTXNs9Dph6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125909; c=relaxed/simple;
	bh=hG/79XL2NC5bednR016FXnLEa+4PbsgFbKY27XArRFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqvqmmV/W7DKo5q+btmv9O5IfmEWFi9797tO8CAtmBSwyAhaxdy33BEWGnt9kAkjGzeQZ8J+pNiutLmv3kay0tE5fbnDv7JQA0ZGlzbZ2WoBvK7xmCBTM+R2tXHwMemmiwoj4TheY+iKXImfKmpja9w836S1FYdzi6b46dkNEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j97Jz6oC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j97Jz6oC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e901e114fdso26186235ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125907; x=1792730707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0i3/GM+C7HIQ+51vxL/QdBH6G/WwpNAIZ4e9TPzcXVA=;
        b=j97Jz6oCINAd0g/BXjPOhjtuZi/6qoBdnNNMh+48VPqzYoXwzt4MbBq05OYGD0QbFv
         ccMnh1Ubli6wTGA0R/xZBeU5dg6t6A6E/Tb+f12f0S3qTQjoFKGIZQ/OIBDEjJWFKWxT
         +uABnC3kU/+sRDjq0/xILIlou6NAoKqBaGHs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125907; x=1792730707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0i3/GM+C7HIQ+51vxL/QdBH6G/WwpNAIZ4e9TPzcXVA=;
        b=1L+Oe6KNgqy46Dn4ScXra3qg37I8jsNwk5dM1psRcoWmsIEIYRVSe1WxGYwMD6boP0
         hJqHq6makOm3KeYdHaa8e4UVHKTW3yioOtXHLYFgRxkivN161odbh8mSOHpiPvXfypE7
         66wPXTEYelpfbx6567VyoviteR1D2yd80ps+ThHL8PS+LfvhxHtj1zUG9fV3cpcw+oPW
         p1oG8p0YiUtbpJwSjER3JV72TkB07uYLz8MTiLROL0v07GQiMBklCLcwX8EUn4QEvvBU
         9w4AErpHjwMHLMv55HxS9dXZIbj8MnuPZe085km2PHjcdDMHe67O/t9wGvPfsocK5JGm
         JSWA==
X-Forwarded-Encrypted: i=1; AKwUvBzJK4sMlZ3VhNxsAiH52IAM2J9Bs+1l8Udmlacb19eYN5gazmUlckDj4MRa4RjTNbtfQnyWmy4qOVtxaw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIh4EPtPeYXjh82POph5xB1vb1sfeSJst5sWRwWgD6nDwVLOAkY
	L8uVBRknJYiwNclssJdcbreUIzto9XwdAK1KDAmOeYIcnwEUExxRGewYJAn3EvF1UQ==
X-Gm-Gg: AYBFou08bTwod+KkP2s06ihDrHp7tucj9GZvY/c2wIiAqpXM68bhpQl78hnVcLLfDCV
	mD0/GOHcLw3swPXfnjomjcWhGOMBRWvv0fXNlTGoD0yNmXEh/FSQCMAeRYDCSbJKSWUBY2gPmnX
	NFYsJpGKb/ZpaDl7epmro+qSXgdfEiqv0o0ftSfFfhqTn9qc5vM8M9tkwOYl+J0L8JCW7Np9crF
	7Ej3ZgR67n0lq68abj3lgE2OIf48mkIWO1wOtCyVjjAF6P80ga7ZEslt+XIJeMUfQwKqDYrBKaY
	mdqSZHRGaDjQ/uOXRC4qyPbsldCE6V2QNdXHI26HFBA+qAsklzeSWm9S2QhuLcbsQqTUd4Fxb3R
	wRrFOisNQ13ne9+Qelrp0xDeEzGhaVqbeJdWEOpF0jDuVUCvrSMEPsfXeVw91xaqmgphnqPbomc
	RzOXpWyfNIsqt+nc1RBFDJXPPPWAlv414WYBJtNnhT7vLGax5tCQnX+iKdtf2WQ76PUHmru5YuG
	ehsv0PBydAVft6lDm8ysG7UKguNuDriKXaIIsXHHzEvdM2/9zBXgEh8JdvD8kKs2TDBxNxOC0FM
	X4jFKOmY+J2yze2CMjGuB4RDABsNU8i4E3iM9368wANp
X-Received: by 2002:a17:902:dac1:b0:2e5:f62e:2eaa with SMTP id d9443c01a7336-2e842cd5165mr192173705ad.43.1792125906642;
        Thu, 15 Oct 2026 21:45:06 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:45:06 -0700 (PDT)
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
Subject: [PATCH v4 11/12] zram: allocate bounce buffer for spanning objects
Date: Fri, 16 Oct 2026 13:44:16 +0900
Message-ID: <20261016044429.1304561-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
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
decompression.  And spanning objects are not rare: Bo Zhang [1]
measured 23.3% of reads on lzo-rle going through the exclusive path,
causing contention on ->excl_lock of up to 72-96 ms:

                      baseline   patched w/o kmalloc bounce
  read contended      24,749     1,959
  read wait_ns total  239.8 s    ~12 s
  read wait_ns max    757 ms     72-96 ms
  read acquire        3,948,150  3,510,610

Allocate a temporary bounce buffer for spanning objects instead, so
that backends with stateless decompression can always use shared mode.
If the allocation fails we fall back to ->local_copy under ->excl_lock.

Per-request bounce buffer fixes the remaining tail latency, as was
measured by Bo Zhang [2]:

                 baseline   patched   patched w/ kmalloc bounce
  read contended 24,749     ~1,959    0
  shared         0%         76.7%     100%

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

