Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D33E639B
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041544; cv=none; b=nUvwImM/fusmXuJ0I1VoiYvCbQtIDiG+BWvSM/Qgm9DLpyqJ9ljb+1gfHmDOm3ZFm0Jhbh845/mjFXyt+8Tl/6G861ovDannuGf2gD6i9Fo7KI9u3f+TrEtuIDEFwnpIl1DPRE5JuyQQnJIplOgUYHfhbF3hwW+pQ9qy0Rutf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041544; c=relaxed/simple;
	bh=aF9SvMDmwlsn0gbumWIRW0qhCr0OjB8SXn9NS13t2HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoxvd+AQnaXpnaXM2UFrEEoyIX9tkGRrx8WF2sLqUYy15lWhxivTJVibgnroa3gkKa2jhbwgxJDqNaEgLHJ5PszD0VHZ8oNn/lBzFJn8xGPYR/oHo4hGaps2pg1uOA7W1GmnDjYemDaHAWcWWr5r0qjOKzyGioNiIxwbROzF9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rrn5Z/Pp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rrn5Z/Pp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso26466525ad.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 22:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792041541; x=1792646341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aL42kwtpY9xz2nUxaLVspyn822mepZz266L04+MLaso=;
        b=Rrn5Z/PpsExSK7JMfJgza25GCDKER2AU/R2fehrRTxt441Z9960ACvL83tmFrEdO70
         ByjM4janZ3EaLUjWGpvskdOWQRPLH7bK8/t+fanNxfy7i+BbBAGZBc6tpYtmB7njI7t6
         0s7HISMyQhnmFW06f3yyIDipBHR4Vx2C+gHWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041541; x=1792646341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL42kwtpY9xz2nUxaLVspyn822mepZz266L04+MLaso=;
        b=FtMirpAqqMnkugPS24cYfskPLYeUGGelzcX4RDC1lM6ReLExQjJEysOa3h5LEwr5eY
         ZqHMt+bR4V6eMiu0OOp2RhUvHK23qygGBY94PZ1b8YugCGpPCESntdzC2Hmgm2ttYSVm
         ypK/EynTVrdRrqAeiekCR9QmZKJukOg6YJtwMYO0c+Rwn1Vd5wEIjimjL5I5ccqMqcxj
         41qIjgPgC8HtatouvoL+ptQ91vycMZeOREt5jG6sX096HHLv7MlZTmjm6uhT1/PQhevR
         e0teMt8SGmHMlmB8ewLtPYHlyAiTMqeSNiejRmlzTi9eNEDUd9+YE5hDoicnOcqGRg4I
         86Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxsU7wIYaMLQhFkyKWozXr21kxn0AOyp0y2ImHmTfEkeki2+zR9OtPxhHq/b1yURcbIYcjPFNZoLCKQkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJa80DapOA9IrmPG0sxC0n/bReSpuZvbFQsJMs1Y0h0KPF4njRX
	N6HMCjBEitwnY5H07eYbNiRGWrgomnR/PtKplE8SK8OJEXBvpOTYV52YOm3W+6RZy8IpBOHAzrL
	0M6w=
X-Gm-Gg: AYBFou1dRQVzvNlvwH58CP+tM4dBTb2G3bRB4ZJmoHWIcc5G2E8bQ/G6Mun/KMXpYEa
	4luoJJgjdvgQQDWYXtQ+O3h0iCTKD7wISbZvQ26OFvFwK0R09eElZ8xxpY4RjdpcIlN7EdzPlb8
	JDsvukDVUvhUvW6WyBALUV+w71NH2lqZhHyWgKCOhL9NigBaWjdo6PPXi9/nSX/XxST1TWPDdg3
	SdCw17axn4Su1BUM6XzZuMOxkK+ULB5ob25sGsw58z6CP1qssRqUx/4Aq6GURETeat2OBAuD/6O
	lu2CIanO6wyB2bCBdQDo9wRQOTbEpDyU9RodLaEt7bzGnCoESQfH7wjf64yEG7jQycsyEnhm88B
	CLBbcbzFPtlKlTG1mrEgFhHeLmkfFvajiGN1UFOhQ/YwCGpblXQq+atOAExs/sQtwKjMWaMCsAg
	507pOHBsPZhINaJOTfk2T5gN9uxKwoLCvGUXAflWqwus+rYLAVJpfBgQcC7jSDZ2W8d/eQwTA6Y
	+dipgV3ijXMneXC9VNYc/AMDUXi+YE2dZaSNko=
X-Received: by 2002:a17:902:e748:b0:2dd:c053:e669 with SMTP id d9443c01a7336-2e842ab7902mr153442525ad.47.1792041541599;
        Wed, 14 Oct 2026 22:19:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b1562sm77412345ad.34.2026.10.14.22.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:19:00 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:18:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bo Zhang <zhangbo0325@gmail.com>, akpm@linux-foundation.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, baohua@kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atBh9xfpOji_A7A_@google.com>
References: <20261013035201.2809924-11-senozhatsky@chromium.org>
 <20261014153603.1365617-1-zhangbo56@xiaomi.com>
 <atAj9o5IgrAeiGiW@google.com>
 <atBAWZ3WZvat3UA1@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atBAWZ3WZvat3UA1@google.com>

On (26/10/15 12:19), Sergey Senozhatsky wrote:
> Or perhaps we can avoid vm_map/unmap.  A slightly different approach.
> kmalloc on fast path + memcpy (zsmalloc objects are strictly less than
> PAGE_SIZE bytes)
> 
>    Run #0: 1,475k IOPS, avg 3.26 us, stdev 14.24 us, p99.99 24.45 us, max 5,617 us (5.62 ms)
>    Run #1: 1,472k IOPS, avg 3.27 us, stdev 15.35 us, p99.99 23.94 us, max 5,619 us (5.62 ms)
>    Run #2: 1,473k IOPS, avg 3.29 us, stdev 15.37 us, p99.99 24.45 us, max 7,190 us (7.19 ms)

Just a better looking code (but same idea).

---
 drivers/block/zram/zcomp.c    | 47 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  2 +-
 drivers/block/zram/zram_drv.c |  2 +-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 39d1f9384939..81f21bad787e 100644
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
@@ -244,6 +243,15 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
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
@@ -252,27 +260,40 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
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
-- 
2.56.0.385.gd3acb90ef8-goog

