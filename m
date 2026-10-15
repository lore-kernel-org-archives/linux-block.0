Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24058501F45
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063493; cv=none; b=vATpa2JrOWwErwYc8o0h4ByUeq1Rs6Q+Uzg1NZs6Of8UdN6y30FsXS+eAHByAJX03pNuE4D6SqneVB/+mTgBim/eTyOfD+nZ9CNHT/iYeyek7FrLpLjIf8R0Iz4LSC4b0KKIDiOC0GCFff0jakYZq3+1jQA2R/s1cdHLMENa8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063493; c=relaxed/simple;
	bh=OuzZ0UmKpoG23RR+4wGy7RGYBwxYdgHUOlN9CNTGkWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWuxA5oGmTskJFBWGv/bMILPHv0Jz2FYmFV5KCJ/ZIl5Cgb3r6O2t5cQx+N8dgsOqVqo0AFYNdpBxs1eN62wxXftVtJOP1/lbk3V/HKneVeDvDYfm6zVZRaMMdZ0lOPhuFyuAVfEk5SzOxxuaQT/F3onkoiCFEH07Novv3B8DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/MB9SQi; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MB9SQi"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3037400eec.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792063488; x=1792668288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTGaRSiOlFT8MfguHaHZjIElUHA1XvWJ2csa7S+idE8=;
        b=U/MB9SQi4oZt5Tc82p6jdlHsTAg/QP2/Ygny+DBOcNu0Wwb4YUjXeDuCtuaP/FsYnp
         PtNr3CwBuA5RNk26HuVlQp4LVyd4En4gI8g5gGm2GPYfWII1F4qx+pY/Cf4d8bQwv/Qd
         Jhg8FcGR1djQILMonewLyqr0aBV5eLlL14/oJzvQLN1aH3v2z4//hkpq5qxK07YXg6/W
         MSjMh0aulMCesPp5CLzjV0pZnJ8ANBBHwiiHXPf67+fLC7I86RJ+H3FTxVHGvKLgKen+
         ixaZ3ZOuI4BGpoFJXfn3P8Z5CAve5ZcLeaBAcGFHIsPHnvQ2wKLGXcL8Fo9ah3OMvGRG
         yP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063488; x=1792668288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTGaRSiOlFT8MfguHaHZjIElUHA1XvWJ2csa7S+idE8=;
        b=z1/SeRf5o4otZZYzWLDrhIlvKiK9iyaBWABTbG2l+hI24d29MOOgZoG82UgfefBi17
         k+c8I7o2/j5hG4YDLDLIV7DGtwAMbkQPdLpLKCa9/FE/Mk3C+GfUvPbOOMGFZF5zWfx+
         Zx4aP3mmUrsimdtU0kbqrWo4MK+7YRtIxo7oLAaeWD5kJyzpNCYwDIryH2NBTmbcfDMd
         pobSXASOcX/KegdCCdFPHL3jYxu8EBdm5JJ4/Sxya9FYLIbi5AilhKzdHLsZX0lzXcVB
         61hLNTArOiC/QMad5sTouyNowslpBV6/g487J75DGW0jCn8k2JD7Q8cAB5/wkMW/AXPG
         XpLw==
X-Forwarded-Encrypted: i=1; AKwUvBzWSZiqttcnuuluOSZbUorLxDUszAdOePJsNtXamqPDZLr/K7fmhy+VlrJxJUgHqXpWuSC2SGvOW5a11Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/V5C2zaBeOkGYpHfsfxazAb8p6I/ARJ1qiSh2kFtK1vHA1KO4
	nvJjH+FgF4xDFEcTfBHQiJWlBeEij23SGEL46dUIteHZRa1RKbrOtH8T
X-Gm-Gg: AYBFou1wH3+tyC0xDTf/fq1qylDjgE8uEKv+17Y2Ca4J7f4cScGVsnUta6aKSl35ixT
	vVICTnk6agFe7yopLBKAePv9Y+fycPADn8FCBTowjlPuzUNOXKxSBFuLdNQ2sBYNBF9CQEK87Xx
	jPgK8S19LWFSF/gEQjQjGwD1e8VXwQqTg0GbVQGZBjF1MNFnPt0TiYG0bHATH8eh/ZnGSFG0XJh
	Qu5QYYaYGjhiZQzAhi1smQ8DcwZrw94iUVxXzXlFu/twhFM6+UpQkHDMcQ/7vsadf5qhNJzINow
	Iwk/+Qr7B5WD6MUp2IS4CFUX3cAzh7NoF69pEhVMoCadjI3rDMmFXvb6e3P8Wq+0TVc1d3V24+d
	Rshbs9m/UovuJRPTJBxjeB3ejxM2ej3LB3pyTRFMvdk5jyFmY6VnvyrsJrQ1tQcO+JkKo5hmcT1
	vLZhCCmAuRyTAzAudh6QKqBSjcwstsHKfPrBGQdU0dJzNVmcpya0OR2IctT7o2Xbw7qIlU5Dmt2
	JVUeD8D274iUKiR
X-Received: by 2002:a05:693c:88c6:20b0:359:89b9:5e09 with SMTP id 5a478bee46e88-35989b98cabmr19639355eec.36.1792063487634;
        Thu, 15 Oct 2026 04:24:47 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm60818382eec.30.2026.10.15.04.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:24:47 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bgeffon@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Date: Thu, 15 Oct 2026 19:24:40 +0800
Message-Id: <20261015112440.1491168-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atBh9xfpOji_A7A_@google.com>
References: <atBh9xfpOji_A7A_@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 12:19:49 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> Or perhaps we can avoid vm_map/unmap.  A slightly different approach.
> kmalloc on fast path + memcpy (zsmalloc objects are strictly less than
> PAGE_SIZE bytes)

I applied the kmalloc+memcpy variant on-device and re-ran the same
Android A/B. It removes the exclusive path entirely in our workload.

                      9+10       9+10 + kmalloc fastpath
  read contended      ~1,959     0
  read wait_ns total  ~12 s      0
  read wait_ns max    72-96 ms   0
  shared              76.7%      100%
  exclusive           23.3%      0%
  dpin_contended      0          0

Every decompression now takes the shared (down_read) path, including the
cross-page objects that previously had to go exclusive. The ~1,959
residual contentions on the exclusive path are gone, and pin contention
stays at zero, so the full read side runs concurrently with no stream
contention.

Read-side contention end to end:

                 baseline   9+10      9+10 + kmalloc
  read contended 24,749     ~1,959    0
  shared         0%         76.7%     100%

This is a stateless-backend result (lzo-rle). zstd/deflate have
create_dctx and stay exclusive, so they don't benefit from shared reads
at all - which, as you noted, is the sad part about zstd on that list.

For those backends the serialization is unavoidable, but the actual
root cause of the long waits is still the holder being preempted or
migrated while holding the stream. So on top of 9+10+kmalloc I tried
a quick-and-dirty preempt-disable for synchronous backends. Allocation
can no longer sleep under the stream, so a two-stage zram_zs_malloc()
does a non-sleeping attempt first and, on failure, bounces into a kmalloc()
buffer, drops the stream and retries with a sleeping GFP_NOIO.

zstd backend, same A/B workload, on top of 9+10+kmalloc:

                       9+10+kmalloc   + preempt-disable
  cwrite_contended     14,880         48          (-99.7%)
  cwrite_wait_ns_total 137 s          0.32 s      (-99.8%)
  cwrite_wait_ns_max   243 ms         43 ms       (-82%)
  dexcl_contended      15,919         54          (-99.7%)
  dexcl_wait_ns_total  109.6 s        0.68 s      (-99.4%)
  dexcl_wait_ns_max    145 ms         34.6 ms     (-76%)

zstd stays 100% exclusive either way; the win comes purely from the
holder no longer being preempted/migrated, so the hold time stays short.
It's the same mechanism that took lzo-rle read contention from 24,749 to
406 earlier. So the two are complementary: shared reads remove
reader-vs-reader queuing for stateless backends, and preempt-disable
covers the exclusive/write serialization that stateful backends can't
avoid.

Quick and dirty, for discussion only - Patch below.

---
 drivers/block/zram/zcomp.c    | 17 +++++++++++---
 drivers/block/zram/zram_drv.c | 52 ++++++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index bb2a8101445a..5c31bd58c616 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -165,8 +165,11 @@ struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
 		 * so then unlock and re-try on the current CPU.
 		 */
 		mutex_lock(&zstrm->lock);
-		if (zstrm->buffer)
+		if (zstrm->buffer) {
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+				preempt_disable();
 			return zstrm;
+		}
 		mutex_unlock(&zstrm->lock);
 	}
 }
@@ -174,6 +177,8 @@ struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
 void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
 {
 	mutex_unlock(&zstrm->lock);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 bool zcomp_shared_decomp(struct zcomp *comp)
@@ -207,16 +212,22 @@ struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 		 * Exclusive requests additionally own ->local_copy and
 		 * ->ctx and hence can only wait for each other.
 		 */
-		if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+		if (mode == ZCOMP_DSTRM_EXCLUSIVE) {
 			mutex_lock(&zstrm->excl_lock);
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+				preempt_disable();
+		}
 		return zstrm;
 	}
 }
 
 void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode)
 {
-	if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+	if (mode == ZCOMP_DSTRM_EXCLUSIVE) {
 		mutex_unlock(&zstrm->excl_lock);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			preempt_enable();
+	}
 	up_read(&zstrm->lock);
 }
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b429c52cb37d..079796b17bde 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2297,13 +2297,37 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
+static unsigned long zram_zs_malloc(struct zram *zram, struct zcomp_cstrm *zstrm,
+				    size_t comp_len, const int nid, void **bounce)
+{
+	unsigned long handle;
+
+	handle = zs_malloc(zram->mem_pool, comp_len,
+			__GFP_KSWAPD_RECLAIM | __GFP_NOWARN |
+			__GFP_HIGHMEM | __GFP_MOVABLE, nid);
+	if (!IS_ERR_VALUE(handle))
+		return handle;
+
+	*bounce = kmalloc(comp_len, GFP_ATOMIC);
+	if (!*bounce)
+		return (unsigned long)ERR_PTR(-ENOMEM);
+	memcpy(*bounce, zstrm->buffer, comp_len);
+
+	/* Drop the stream (re-enables preemption) before a sleeping alloc. */
+	zcomp_cstrm_put(zstrm);
+	handle = zs_malloc(zram->mem_pool, comp_len,
+			GFP_NOIO | __GFP_NOWARN |
+			__GFP_HIGHMEM | __GFP_MOVABLE, nid);
+	return handle;
+}
+
 static int zram_write_page(struct zram *zram, struct page *page,
 			   unsigned long index)
 {
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
-	void *mem;
+	void *mem, *bounce = NULL;
 	struct zcomp_cstrm *zstrm;
 	unsigned long element;
 	bool same_filled;
@@ -2331,22 +2355,20 @@ static int zram_write_page(struct zram *zram, struct page *page,
 		return write_incompressible_page(zram, page, index);
 	}
 
-	handle = zs_malloc(zram->mem_pool, comp_len,
-			   GFP_NOIO | __GFP_NOWARN |
-			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	handle = zram_zs_malloc(zram, zstrm, comp_len, page_to_nid(page), &bounce);
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_cstrm_put(zstrm);
+		bounce ? kfree(bounce) : zcomp_cstrm_put(zstrm);
 		return PTR_ERR((void *)handle);
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_cstrm_put(zstrm);
+		bounce ? kfree(bounce) : zcomp_cstrm_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
-	zcomp_cstrm_put(zstrm);
+	zs_obj_write(zram->mem_pool, handle, bounce ? bounce : zstrm->buffer, comp_len);
+	bounce ? kfree(bounce) : zcomp_cstrm_put(zstrm);
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
@@ -2463,6 +2485,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	unsigned int class_index_old;
 	unsigned int class_index_new;
 	void *src;
+	void *bounce = NULL;
 	int ret = 0;
 
 	handle_old = get_slot_handle(zram, index);
@@ -2535,17 +2558,16 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	 * modify zsmalloc API to return this information. For now, we will
 	 * make do with the node of the page allocated for recompression.
 	 */
-	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
-			       GFP_NOIO | __GFP_NOWARN |
-			       __GFP_HIGHMEM | __GFP_MOVABLE,
-			       page_to_nid(page));
+	handle_new = zram_zs_malloc(zram, zstrm, comp_len_new,
+				    page_to_nid(page), &bounce);
 	if (IS_ERR_VALUE(handle_new)) {
-		zcomp_cstrm_put(zstrm);
+		bounce ? kfree(bounce) : zcomp_cstrm_put(zstrm);
 		return PTR_ERR((void *)handle_new);
 	}
 
-	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
-	zcomp_cstrm_put(zstrm);
+	zs_obj_write(zram->mem_pool, handle_new,
+		     bounce ? bounce : zstrm->buffer, comp_len_new);
+	bounce ? kfree(bounce) : zcomp_cstrm_put(zstrm);
 
 	slot_free(zram, index);
 	set_slot_handle(zram, index, handle_new);

Thanks,
Bo
