Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C2361951
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034397; cv=none; b=ki3iD7RX3LplumaTMiPY/5DHcvGyBMxNfGrx4PKj0HuZxz7xWgRvu8YHQxSiLz+Rg5b0k6wr6OPeZLbJy2hBYvGP80UMSj5HtvIBJC+uFYlXIaa0u4/kqIQFuh5qotmm464IVIEaZsyS8WrzqR2xdlxEpHqGUPvpX03sj1SSXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034397; c=relaxed/simple;
	bh=RdJ1LMfXhwEH8kQNKNKpLI1nQetgc/cP5rnIj4SWq+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grb77hHA1KdtXxPNk6V0Q+0JsRBZEUh48SaMBQke/z3rHh12Tlw/KJuPY7kag56QiGanx5a8IMOJ/yqGm5/WeNoQr5LiBAaDN6/64TXDAtRV2/KGsk50GKwZgPEfrS812SlzQjfOrKzPC+xFa7MIigW6wlkW4k97acrXKA1bC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SG/zHRsv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SG/zHRsv"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8875d220446so2489196b3a.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 20:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792034394; x=1792639194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V9QLU7Zy1JxvuPwl1RadI1Kh1ZC3AW3elrtvC4EPZVY=;
        b=SG/zHRsvgTyuEwB8NwRMEZ/Sh0zwmXD2f7/03/U6W61OmkjF9wwh/e4aQdcNWlzc9I
         0mTPJxZdOqYrxX9bRLKQKVBf8lHp+RapMBB8xx7RpVRdCIMxebAr5GuBOnlN0FL7wneq
         BQCIwHwDP/3gPrAETu/dMshKy6vyBt82nCLWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792034394; x=1792639194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9QLU7Zy1JxvuPwl1RadI1Kh1ZC3AW3elrtvC4EPZVY=;
        b=PcMNhn/ayhIpYVP/5L+kj2JkMBga6k6e9alSCk684TAw8F+72GbJlp75XgEj1BGFwR
         Zl+ON6AStuSxdbzu1S7NrQIo4aUFg3dv5HPR7KETFHA9YL3gQtPFRBrmrdW3jiOfDLT8
         /fL73CNENzKP4TodsmuPJvm8om+LHkZMivPiO/pX6/SgXF2UEoyw9y/CjEos1XP+D0tA
         yfvI2Q2Su1sAhkk7VLoniUfdGVeHZFO90jVz6BXX+X060Q3cKBbDqO0kMlXtKQryaSrW
         q/cOsUKohVOuTDP6f2zn1VCDBXFnmAlewQTQTmrMy96nSR/5LEV91ZYuAfq7t5p7MzX3
         3sDQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/MXUnIBya870sujdDFSAQGfkTmOFbL2VUlaG4f/a3WMGcY91nzbOrtr0ucTlIksOhvxp1GgvJlr6VWw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKj7e8oHqyFvO+JmcQB+h5dI+bNxRCrhroZTKPBKDPFKXs2Xc0X
	24itZaoCONp9nEQKOUnqj3uHEYTnNDdR0RumicZ+cLDoLTl2TnW0rsMw0kFJO8sCH53m4GI+a55
	H5R8=
X-Gm-Gg: AYBFou3Xhpk0+5aXVBepMRbDum4orqFTykg3kq3ZQAIPWJfz7I+uHzjnQ/WDuHdcZWn
	POQDWvIbUrG0fMqwyM5BNSzk8Jq4ORW9F5UFiZ2fl4H3zTpAdvKv2h5/c17KmaFpoyeErd1jFzb
	ZLsg31R3dtTlJ3EMttnFyQzdQU+phxAB2hPWsXZVr7oluQACkCUuoISUphRIJcaz9SHwQlCI9B4
	Ysjww2cgr6O0XpTRsP6hckYIvD+jRx2BfMQIlptAVdsrV/FA0YWGMNGPTdQuM+cRE+a4frrgAfr
	etmEdYl9onabnyZqfrkBaAsfxdXE3SvRz7fRZY+TDxtA1rrqexqgf3+HIRCOVP48KZx1yxnMwMC
	iyaEv++KtygE3a3nkxLG7vNI5rXxxhdq2lwAqjRsKcBiYPhdOxTPZs8QKPOSj9l9JfPEVWGot42
	DcLl+Seh93gX8t20/U3s1Tn5nzhZqQab/U5Wwb9BacpMCZHtww7gVTRoLAnde2FWe+7ODrXA10o
	HCUVZoQh8TciZomc5honYtg4FTB3mkkd2ZllPA=
X-Received: by 2002:a17:90b:39a4:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3ac8ee5e69cmr1654880a91.20.1792034394534;
        Wed, 14 Oct 2026 20:19:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93849da5sm1176737a91.4.2026.10.14.20.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:19:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:19:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bo Zhang <zhangbo0325@gmail.com>, akpm@linux-foundation.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, baohua@kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atBAWZ3WZvat3UA1@google.com>
References: <20261013035201.2809924-11-senozhatsky@chromium.org>
 <20261014153603.1365617-1-zhangbo56@xiaomi.com>
 <atAj9o5IgrAeiGiW@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atAj9o5IgrAeiGiW@google.com>

On (26/10/15 10:41), Sergey Senozhatsky wrote:
> 23.3% is a slightly high bounce reads number, basically almost 1/4 of
> reads are exclusive.  I wonder if we can do better.  Technically, the
> number of bounce reads depends on the data.  Data that are not compressed
> good enough can results in much higher numbers.  E.g. if most of the
> objects compress to say 2500 bytes then every second object in the size
> class becomes a spanning object.
> 
> I have a quick and dirty patch that turns ->local_copy into a fallback
> slowpath and uses vm_map_ram() for fast path.
> 
> A synthetic fio test in VM (reader vs reader inversion test).
> 
> BASE (local_copy + excl_lock for spanning objects):
>  Run #0: 1,434k IOPS, avg 3.74 us, stdev 443.11 us, p99.99 23.94 us, max 741,374 us (741 ms)
>  Run #1: 1,465k IOPS, avg 3.36 us, stdev 99.88 us, p99.99 26.50 us, max 187,415 us (187 ms)
>  Run #2: 1,454k IOPS, avg 3.51 us, stdev 171.87 us, p99.99 24.45 us, max 257,715 us (258 ms)
> PATCHED (vm_map_ram() for spanning objects):
>  Run #0: 1,471k IOPS, avg 3.33 us, stdev 14.69 us, p99.99 28.29 us, max 2,844 us (2.8 ms)
>  Run #1: 1,463k IOPS, avg 3.32 us, stdev 15.93 us, p99.99 24.96 us, max 5,182 us (5.2 ms)
>  Run #2: 1,458k IOPS, avg 3.34 us, stdev 14.70 us, p99.99 24.96 us, max 5,619 us (5.6 ms)

Or perhaps we can avoid vm_map/unmap.  A slightly different approach.
kmalloc on fast path + memcpy (zsmalloc objects are strictly less than
PAGE_SIZE bytes)

   Run #0: 1,475k IOPS, avg 3.26 us, stdev 14.24 us, p99.99 24.45 us, max 5,617 us (5.62 ms)
   Run #1: 1,472k IOPS, avg 3.27 us, stdev 15.35 us, p99.99 23.94 us, max 5,619 us (5.62 ms)
   Run #2: 1,473k IOPS, avg 3.29 us, stdev 15.37 us, p99.99 24.45 us, max 7,190 us (7.19 ms)

---

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 39d1f9384939..1838057475f4 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -181,14 +181,13 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
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
@@ -257,22 +256,37 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 
 	might_sleep();
 	lockdep_assert_held(&zstrm->lock);
-	if (!zcomp_shared_decomp(comp, sg))
+	if (!zcomp_shared_decomp(comp))
 		lockdep_assert_held(&zstrm->excl_lock);
 
 	if (sg_is_last(sg)) {
 		/* the object is contained within one page, read it in-place */
 		src = kmap_local_page(sg_page(sg));
 		req.src = src + sg->offset;
+		ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
+		kunmap_local(src);
+		return ret;
+	}
+
+	/* the object spans two pages, linearize it */
+	if (zcomp_shared_decomp(comp)) {
+		src = kmalloc(src_len, GFP_NOWAIT | __GFP_NOWARN);
+		if (!src) {
+			mutex_lock(&zstrm->excl_lock);
+			src = zstrm->local_copy;
+		}
 	} else {
-		/* the object spans two pages, linearize it into local copy */
-		sg_copy_to_buffer(sg, 2, zstrm->local_copy, src_len);
-		req.src = zstrm->local_copy;
+		src = zstrm->local_copy;
 	}
 
+	sg_copy_to_buffer(sg, 2, src, src_len);
+	req.src = src;
 	ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
-	if (src)
-		kunmap_local(src);
+
+	if (src != zstrm->local_copy)
+		kfree(src);
+	else if (zcomp_shared_decomp(comp))
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
