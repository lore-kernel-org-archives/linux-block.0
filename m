Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550591;
	b=Lp+QZ7v7QkPC+gMUxqLxeCHpATCVWzZd0ZtvEjUUisf65wbwo8OF5rr0tEGwUsClQJQB
	 qOdiki5hvystDW8UwMlG9+0oWBmO5C9NHlaFXzwYyvz7dq452iE+mA0KrS6rt3Dfgd/YR
	 lXTGoxntf/gj4qNfJ4Hbon8F9goJyohHNS2noW+hgXik9fywFBiKab+DsfM+P6a+NmDGF
	 9iAdDIqWwnhWYjpZ1AVXdHUmQf5bgkjtKIilQd+0rdvyuXYZwX6vDaKsgXmt5cS/DDgzV
	 9A1NnwViK4cooIyUVbO0pesOM/5OiRmodB1SeonAL8t3LVL6UWJk95Q1EVaY8auSQ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0wJsI1jUL7IodB6bK+fKvetG4WwE0ff6Da6JrfEeRLw=;
	b=hUZgcKe3eAhlvAz4Twm1KOiLGYbTJrDGnKe8XSE5y3nYdQiUdwMfocqrXjkk1YcfYvp9
	 0yQcEJxCUC3VgNwMwIg2d0dmNibsSaE7eOMQq4GlG191/jMwaowfDkWtwKMHjrokCkt7Z
	 xjzFRFP66Ga2+3/A3wlLaL0HJPFsNZ/e/oOzejwQjjFDLTyykNl4/YHJpz0YzKrLpPXnI
	 p0O5ivQzHNTMtmcj2O9LFo1VojEi6CQIwPETC+KDxH834SehhC18G5UQeY93VkGWA3r7a
	 fkLjR9r/CXSv2R5YEZxbQsQ6g9+PmqPrQNuP8LJvK3enFuaQLmoAXJp0TXToKSqKFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MpV0bsqp;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C8606A336
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 504C8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MpV0bsqp
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f1f76ea84so317579eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550589; x=1793155389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wJsI1jUL7IodB6bK+fKvetG4WwE0ff6Da6JrfEeRLw=;
        b=MpV0bsqpCJXvhXjKLvnjKma9jL+tkmULyObQ/1d+w7IP6tqshcpRmZrgbKQVLRiZYT
         Eakbmf+VD43AyP2qFq/ZcfSEN3DsQIi4TO/0SP+oHdk8nvmBk+k/uJnb0xAJIzW2t0XL
         4Wnpu7BshoUjj9zml76MyZV+oge9kBrqKYv7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550589; x=1793155389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wJsI1jUL7IodB6bK+fKvetG4WwE0ff6Da6JrfEeRLw=;
        b=kbP1tzW7ZRfF5DiVZPSx4NTJriQr1ky0vYfLIKSs4QDZns0ypoLFgSY4klsqk0YGOD
         6xQ1+H1OD5UtlfeDt1yiNVt/iJNBdmfm06kO3ZpPe3jrkciowYPh8fKeRnBg2TzIwAJN
         6kR1WArx+2QUznscPxafFLeQaz4N6mgDaH6V2DLPxDXIIeDNc52OZeHP06D6/UNZv5fr
         zAYODWmtqPv3QjaW8t96YYhYO3u3H4Yv6CbIbGeIrGORMqqahACqirtq7im5E/inHe4+
         krgsyujY43wMzcsFLkL7pbS+tfNZcTbASaR44G3+LkvxyMlEGNXXsGQqlbDn/0/2UNO9
         I6eg==
X-Forwarded-Encrypted: i=1; AKwUvBwcqkLJa+7oKG27aErYSnYMWadYP/fDtI4lvEj1XtpQtyXV/gW21yTmO2OgrPwr1nzRv7gRlrx/FS236Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKWMJ7DUnN+7wGnSRipbXQxvUKlViqXollpXlzBgTWjlUWbTIna
	HmHV/gdrozAVVlni1hGhYplXBdhsDrEb0bPf0Q5LOaFj5bQo24RiZm3L1jC8ZSTYtQ==
X-Gm-Gg: AYBFou37r8RwiMG90V7X+jZDIRcFmIyq78sFZ9jYxBStKqjsd9BO1ISD2PhQNgpGwJ1
	YKeKbQJeEX+gWkfw2U69BcMdxksl4e0eCflIdAwXKXj/2T/FpnHsu5QgLDkd6I3K6RdaRYFC0St
	m8grZtWSPfpl9iyowcAU8kwPd/084daOuRDGfYscv5uqdeghqEJOM0JIBctLeKedVY9asQbHfWv
	ZVJESfk3INDgtJ2o3994mLAo2pN/mSH++nDovSsgnYtNsSmRVJY3UVeeWWW/6XpI0gvBnwrPUZT
	bNiTRDTmgPO2RcpeP2N2UsXDvwW38m/EjF8HNGqL1XEe2a3/3Nd2SF7mPYasx64HsNmPiGqX5Tb
	OlBpWq+G7tMeuLMv6uVAEEj/et/v5/rik89UL/DI93ZYGJ7eEsc4HzQKwmaxFIZ0GJ5tnzTs6B3
	2nVAXAz+orSjHpgO2Wet5VxSWGZP5LTjtmn2XmLz2xuPyPPehAr/qql6SkGi4wZVdKWSd+ovQ8U
	q6mMkksLQVdzoZSI8kASdOy8jAnQ0yzEhbt3jNbQoMApiWNCod8LBBQeUTLu4TKVvEF0lFSBF6y
	GUtJM1EtF5PFuH2WPl7HHRWLBi9x37TzatGoKRZDFp5HPQ==
X-Received: by 2002:a05:7023:904:b0:14c:96a4:b631 with SMTP id a92af1059eb24-190a632f266mr999637c88.30.1792550589285;
        Tue, 20 Oct 2026 19:43:09 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:43:08 -0700 (PDT)
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
Subject: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Date: Wed, 21 Oct 2026 11:42:19 +0900
Message-ID: <20261021024236.1787884-10-senozhatsky@chromium.org>
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

Split struct zcomp_strm into separate compression (Write zcomp_cstrm)
and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
context creation/destruction into create_cctx/destroy_cctx and
optional create_dctx/destroy_dctx callbacks.

This decouples Read (decompression) and Write (compression) paths so
they no longer contend on the same per-CPU stream mutex (Writer vs
Reader priority inversion).  Currently, a (low priority) Writer that
holds the stream mutex can be preempted by a (higher priority) Reader
on the same CPU, which then blocks on that mutex until the Writer gets
to run again and releases it, which can take a long time when there
are other runnable tasks on that CPU.  The good news is that Read and
Write contexts are completely independent - compression uses its own
scratch buffer that decompression never touches, and decompression
uses its own local buffer (for spanning zsmalloc objects) that
compression never touches, so the Read/Write context split doesn't
noticeably increase memory usage.  In addition many S/W backends have
stateless decompression contexts.

A quick synthetic fio test for Writer vs Reader inversion on 24 CPUs
(preempt=full, zstd, 48 low priority (nice 19) writers, 24 normal
priority (nice 0) CPU hogs and 24 high priority (nice -19) readers):

  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        207k               1,150k        (+5.6x)
  Read clat avg    101.50 us          7.76 us       (-13.1x)
  Read clat stdev  5,615.90 us        30.78 us      (-182x)
  Read clat p99.99 258,998 us         111.10 us     (-2331x)
  Read clat max    1,342,600 us       11,217 us     (-120x)

Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     |   4 +-
 drivers/block/zram/backend_deflate.c |  96 ++++++++++-------
 drivers/block/zram/backend_lz4.c     |   7 +-
 drivers/block/zram/backend_lz4hc.c   |   4 +-
 drivers/block/zram/backend_lzo.c     |   4 +-
 drivers/block/zram/backend_lzorle.c  |   4 +-
 drivers/block/zram/backend_zstd.c    | 119 +++++++++++++---------
 drivers/block/zram/zcomp.c           | 147 +++++++++++++++++++++------
 drivers/block/zram/zcomp.h           |  28 +++--
 drivers/block/zram/zram_drv.c        |  38 +++----
 10 files changed, 298 insertions(+), 153 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 56ffda201727..f911cd1ca72e 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -63,8 +63,8 @@ static int decompress_842(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_842 = {
 	.compress	= compress_842,
 	.decompress	= decompress_842,
-	.create_ctx	= create_842,
-	.destroy_ctx	= destroy_842,
+	.create_cctx	= create_842,
+	.destroy_cctx	= destroy_842,
 	.setup_params	= setup_params_842,
 	.release_params	= release_params_842,
 	.name		= "842",
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 20685aca9bdc..5ffdaf80d8cf 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -13,11 +13,6 @@
 #define DEFLATE_DEF_WINBITS		(-11)
 #define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
 
-struct deflate_ctx {
-	struct z_stream_s cctx;
-	struct z_stream_s dctx;
-};
-
 static void deflate_release_params(struct zcomp_params *params)
 {
 }
@@ -51,70 +46,98 @@ static int deflate_setup_params(struct zcomp_params *params)
 	return 0;
 }
 
-static void deflate_destroy(struct zcomp_ctx *ctx)
+static void deflate_destroy_cctx(struct zcomp_ctx *ctx)
 {
-	struct deflate_ctx *zctx = ctx->context;
+	struct z_stream_s *cctx = ctx->context;
 
-	if (!zctx)
+	if (!cctx)
 		return;
 
-	if (zctx->cctx.workspace) {
-		zlib_deflateEnd(&zctx->cctx);
-		vfree(zctx->cctx.workspace);
-	}
-	if (zctx->dctx.workspace) {
-		zlib_inflateEnd(&zctx->dctx);
-		vfree(zctx->dctx.workspace);
+	if (cctx->workspace) {
+		zlib_deflateEnd(cctx);
+		vfree(cctx->workspace);
 	}
-	kfree(zctx);
+	kfree(cctx);
 }
 
-static int deflate_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int deflate_create_cctx(struct zcomp_params *params,
+			       struct zcomp_ctx *ctx)
 {
-	struct deflate_ctx *zctx;
+	struct z_stream_s *cctx;
 	size_t sz;
 	int ret;
 
-	zctx = kzalloc_obj(*zctx);
-	if (!zctx)
+	cctx = kzalloc_obj(*cctx);
+	if (!cctx)
 		return -ENOMEM;
 
-	ctx->context = zctx;
+	ctx->context = cctx;
 	sz = zlib_deflate_workspacesize(params->deflate.winbits, MAX_MEM_LEVEL);
-	zctx->cctx.workspace = vzalloc(sz);
-	if (!zctx->cctx.workspace)
+	cctx->workspace = vzalloc(sz);
+	if (!cctx->workspace)
 		goto error;
 
-	ret = zlib_deflateInit2(&zctx->cctx, params->level, Z_DEFLATED,
+	ret = zlib_deflateInit2(cctx, params->level, Z_DEFLATED,
 				params->deflate.winbits, DEFLATE_DEF_MEMLEVEL,
 				Z_DEFAULT_STRATEGY);
 	if (ret != Z_OK)
 		goto error;
 
+	return 0;
+
+error:
+	deflate_destroy_cctx(ctx);
+	return -EINVAL;
+}
+
+static void deflate_destroy_dctx(struct zcomp_ctx *ctx)
+{
+	struct z_stream_s *dctx = ctx->context;
+
+	if (!dctx)
+		return;
+
+	if (dctx->workspace) {
+		zlib_inflateEnd(dctx);
+		vfree(dctx->workspace);
+	}
+	kfree(dctx);
+}
+
+static int deflate_create_dctx(struct zcomp_params *params,
+			       struct zcomp_ctx *ctx)
+{
+	struct z_stream_s *dctx;
+	size_t sz;
+	int ret;
+
+	dctx = kzalloc_obj(*dctx);
+	if (!dctx)
+		return -ENOMEM;
+
+	ctx->context = dctx;
 	sz = zlib_inflate_workspacesize();
-	zctx->dctx.workspace = vzalloc(sz);
-	if (!zctx->dctx.workspace)
+	dctx->workspace = vzalloc(sz);
+	if (!dctx->workspace)
 		goto error;
 
-	ret = zlib_inflateInit2(&zctx->dctx, params->deflate.winbits);
+	ret = zlib_inflateInit2(dctx, params->deflate.winbits);
 	if (ret != Z_OK)
 		goto error;
 
 	return 0;
 
 error:
-	deflate_destroy(ctx);
+	deflate_destroy_dctx(ctx);
 	return -EINVAL;
 }
 
 static int deflate_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			    struct zcomp_req *req)
 {
-	struct deflate_ctx *zctx = ctx->context;
-	struct z_stream_s *deflate;
+	struct z_stream_s *deflate = ctx->context;
 	int ret;
 
-	deflate = &zctx->cctx;
 	ret = zlib_deflateReset(deflate);
 	if (ret != Z_OK)
 		return -EINVAL;
@@ -136,12 +159,9 @@ static int deflate_decompress(struct zcomp_params *params,
 			      struct zcomp_ctx *ctx,
 			      struct zcomp_req *req)
 {
-	struct deflate_ctx *zctx = ctx->context;
-	struct z_stream_s *inflate;
+	struct z_stream_s *inflate = ctx->context;
 	int ret;
 
-	inflate = &zctx->dctx;
-
 	ret = zlib_inflateReset(inflate);
 	if (ret != Z_OK)
 		return -EINVAL;
@@ -161,8 +181,10 @@ static int deflate_decompress(struct zcomp_params *params,
 const struct zcomp_ops backend_deflate = {
 	.compress	= deflate_compress,
 	.decompress	= deflate_decompress,
-	.create_ctx	= deflate_create,
-	.destroy_ctx	= deflate_destroy,
+	.create_cctx	= deflate_create_cctx,
+	.destroy_cctx	= deflate_destroy_cctx,
+	.create_dctx	= deflate_create_dctx,
+	.destroy_dctx	= deflate_destroy_dctx,
 	.setup_params	= deflate_setup_params,
 	.release_params	= deflate_release_params,
 	.name		= "deflate",
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 5f2e27805d75..9767482a2fea 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -38,8 +38,7 @@ static int lz4_setup_params(struct zcomp_params *params)
 	if (!dict_stream)
 		return -ENOMEM;
 
-	ret = LZ4_loadDict(dict_stream,
-			   params->dict, params->dict_sz);
+	ret = LZ4_loadDict(dict_stream, params->dict, params->dict_sz);
 	if (ret != params->dict_sz) {
 		vfree(dict_stream);
 		return -EINVAL;
@@ -102,8 +101,8 @@ static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lz4 = {
 	.compress	= lz4_compress,
 	.decompress	= lz4_decompress,
-	.create_ctx	= lz4_create,
-	.destroy_ctx	= lz4_destroy,
+	.create_cctx	= lz4_create,
+	.destroy_cctx	= lz4_destroy,
 	.setup_params	= lz4_setup_params,
 	.release_params	= lz4_release_params,
 	.name		= "lz4",
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index b62736b26622..2d1364a29b27 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -107,8 +107,8 @@ static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lz4hc = {
 	.compress	= lz4hc_compress,
 	.decompress	= lz4hc_decompress,
-	.create_ctx	= lz4hc_create,
-	.destroy_ctx	= lz4hc_destroy,
+	.create_cctx	= lz4hc_create,
+	.destroy_cctx	= lz4hc_destroy,
 	.setup_params	= lz4hc_setup_params,
 	.release_params	= lz4hc_release_params,
 	.name		= "lz4hc",
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 78538479c511..e703560d9ecd 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -61,8 +61,8 @@ static int lzo_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lzo = {
 	.compress	= lzo_compress,
 	.decompress	= lzo_decompress,
-	.create_ctx	= lzo_create,
-	.destroy_ctx	= lzo_destroy,
+	.create_cctx	= lzo_create,
+	.destroy_cctx	= lzo_destroy,
 	.setup_params	= lzo_setup_params,
 	.release_params	= lzo_release_params,
 	.name		= "lzo",
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 011787f1430b..e95026e99202 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -61,8 +61,8 @@ static int lzorle_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lzorle = {
 	.compress	= lzorle_compress,
 	.decompress	= lzorle_decompress,
-	.create_ctx	= lzorle_create,
-	.destroy_ctx	= lzorle_destroy,
+	.create_cctx	= lzorle_create,
+	.destroy_cctx	= lzorle_destroy,
 	.setup_params	= lzorle_setup_params,
 	.release_params	= lzorle_release_params,
 	.name		= "lzo-rle",
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 7a8b5ff186f2..d55615f34300 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -10,10 +10,8 @@
 #include "backend_zstd.h"
 
 struct zstd_ctx {
-	zstd_cctx *cctx;
-	zstd_dctx *dctx;
-	void *cctx_mem;
-	void *dctx_mem;
+	void *ctx;
+	void *mem;
 };
 
 struct zstd_params {
@@ -105,7 +103,7 @@ static int zstd_setup_params(struct zcomp_params *params)
 	return -EINVAL;
 }
 
-static void zstd_destroy(struct zcomp_ctx *ctx)
+static void zstd_destroy_cctx(struct zcomp_ctx *ctx)
 {
 	struct zstd_ctx *zctx = ctx->context;
 
@@ -113,30 +111,23 @@ static void zstd_destroy(struct zcomp_ctx *ctx)
 		return;
 
 	/*
-	 * If ->cctx_mem and ->dctx_mem were allocated then we didn't use
-	 * C/D dictionary and ->cctx / ->dctx were "embedded" into these
-	 * buffers.
+	 * If ->mem was allocated then we didn't use C/D dictionary and
+	 * ->ctx was "embedded" into this buffer.
 	 *
-	 * If otherwise then we need to explicitly release ->cctx / ->dctx.
+	 * If otherwise then we need to explicitly release ->ctx.
 	 */
-	if (zctx->cctx_mem)
-		vfree(zctx->cctx_mem);
+	if (zctx->mem)
+		vfree(zctx->mem);
 	else
-		zstd_free_cctx(zctx->cctx);
-
-	if (zctx->dctx_mem)
-		vfree(zctx->dctx_mem);
-	else
-		zstd_free_dctx(zctx->dctx);
+		zstd_free_cctx(zctx->ctx);
 
 	kfree(zctx);
 }
 
-static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int zstd_create_cctx(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
+	struct zstd_params *zp = params->drv_data;
 	struct zstd_ctx *zctx;
-	zstd_parameters prm;
-	size_t sz;
 
 	zctx = kzalloc_obj(*zctx);
 	if (!zctx)
@@ -144,40 +135,74 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 
 	ctx->context = zctx;
 	if (params->dict_sz == 0) {
-		prm = zstd_get_params(params->level, PAGE_SIZE);
-		sz = zstd_cctx_workspace_bound(&prm.cParams);
-		zctx->cctx_mem = vzalloc(sz);
-		if (!zctx->cctx_mem)
-			goto error;
-
-		zctx->cctx = zstd_init_cctx(zctx->cctx_mem, sz);
-		if (!zctx->cctx)
-			goto error;
+		zstd_parameters prm = zp->cprm;
+		size_t sz = zstd_cctx_workspace_bound(&prm.cParams);
 
-		sz = zstd_dctx_workspace_bound();
-		zctx->dctx_mem = vzalloc(sz);
-		if (!zctx->dctx_mem)
+		zctx->mem = vzalloc(sz);
+		if (!zctx->mem)
 			goto error;
 
-		zctx->dctx = zstd_init_dctx(zctx->dctx_mem, sz);
-		if (!zctx->dctx)
+		zctx->ctx = zstd_init_cctx(zctx->mem, sz);
+		if (!zctx->ctx)
 			goto error;
 	} else {
-		struct zstd_params *zp = params->drv_data;
+		zctx->ctx = zstd_create_cctx_advanced(zp->custom_mem);
+		if (!zctx->ctx)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	zstd_destroy_cctx(ctx);
+	return -EINVAL;
+}
+
+static void zstd_destroy_dctx(struct zcomp_ctx *ctx)
+{
+	struct zstd_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
+
+	if (zctx->mem)
+		vfree(zctx->mem);
+	else
+		zstd_free_dctx(zctx->ctx);
+
+	kfree(zctx);
+}
+
+static int zstd_create_dctx(struct zcomp_params *params, struct zcomp_ctx *ctx)
+{
+	struct zstd_params *zp = params->drv_data;
+	struct zstd_ctx *zctx;
 
-		zctx->cctx = zstd_create_cctx_advanced(zp->custom_mem);
-		if (!zctx->cctx)
+	zctx = kzalloc_obj(*zctx);
+	if (!zctx)
+		return -ENOMEM;
+
+	ctx->context = zctx;
+	if (params->dict_sz == 0) {
+		size_t sz = zstd_dctx_workspace_bound();
+
+		zctx->mem = vzalloc(sz);
+		if (!zctx->mem)
 			goto error;
 
-		zctx->dctx = zstd_create_dctx_advanced(zp->custom_mem);
-		if (!zctx->dctx)
+		zctx->ctx = zstd_init_dctx(zctx->mem, sz);
+		if (!zctx->ctx)
+			goto error;
+	} else {
+		zctx->ctx = zstd_create_dctx_advanced(zp->custom_mem);
+		if (!zctx->ctx)
 			goto error;
 	}
 
 	return 0;
 
 error:
-	zstd_destroy(ctx);
+	zstd_destroy_dctx(ctx);
 	return -EINVAL;
 }
 
@@ -189,10 +214,10 @@ static int zstd_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	size_t ret;
 
 	if (params->dict_sz == 0)
-		ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
+		ret = zstd_compress_cctx(zctx->ctx, req->dst, req->dst_len,
 					 req->src, req->src_len, &zp->cprm);
 	else
-		ret = zstd_compress_using_cdict(zctx->cctx, req->dst,
+		ret = zstd_compress_using_cdict(zctx->ctx, req->dst,
 						req->dst_len, req->src,
 						req->src_len,
 						zp->cdict);
@@ -210,10 +235,10 @@ static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	size_t ret;
 
 	if (params->dict_sz == 0)
-		ret = zstd_decompress_dctx(zctx->dctx, req->dst, req->dst_len,
+		ret = zstd_decompress_dctx(zctx->ctx, req->dst, req->dst_len,
 					   req->src, req->src_len);
 	else
-		ret = zstd_decompress_using_ddict(zctx->dctx, req->dst,
+		ret = zstd_decompress_using_ddict(zctx->ctx, req->dst,
 						  req->dst_len, req->src,
 						  req->src_len, zp->ddict);
 	if (zstd_is_error(ret))
@@ -224,8 +249,10 @@ static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_zstd = {
 	.compress	= zstd_compress,
 	.decompress	= zstd_decompress,
-	.create_ctx	= zstd_create,
-	.destroy_ctx	= zstd_destroy,
+	.create_cctx	= zstd_create_cctx,
+	.destroy_cctx	= zstd_destroy_cctx,
+	.create_dctx	= zstd_create_dctx,
+	.destroy_dctx	= zstd_destroy_dctx,
 	.setup_params	= zstd_setup_params,
 	.release_params	= zstd_release_params,
 	.name		= "zstd",
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 028e2f0f587e..1c9f6d5c8cd1 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -45,30 +45,65 @@ static const struct zcomp_ops *backends[] = {
 	NULL
 };
 
-static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
+static void zcomp_cstrm_free(struct zcomp *comp, struct zcomp_cstrm *zstrm)
 {
-	comp->ops->destroy_ctx(&zstrm->ctx);
-	vfree(zstrm->local_copy);
+	if (comp->ops->destroy_cctx)
+		comp->ops->destroy_cctx(&zstrm->ctx);
 	vfree(zstrm->buffer);
 	zstrm->buffer = NULL;
+	zstrm->ctx.context = NULL;
 }
 
-static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
+static int zcomp_cstrm_init(struct zcomp *comp, struct zcomp_cstrm *zstrm)
 {
 	int ret;
 
-	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
-	if (ret)
-		return ret;
+	if (comp->ops->create_cctx) {
+		ret = comp->ops->create_cctx(comp->params, &zstrm->ctx);
+		if (ret) {
+			/* backend has released partially created context */
+			zstrm->ctx.context = NULL;
+			return ret;
+		}
+	}
 
-	zstrm->local_copy = vzalloc(PAGE_SIZE);
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (!zstrm->buffer || !zstrm->local_copy) {
-		zcomp_strm_free(comp, zstrm);
+	if (!zstrm->buffer) {
+		zcomp_cstrm_free(comp, zstrm);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void zcomp_dstrm_free(struct zcomp *comp, struct zcomp_dstrm *zstrm)
+{
+	if (comp->ops->destroy_dctx)
+		comp->ops->destroy_dctx(&zstrm->ctx);
+	vfree(zstrm->local_copy);
+	zstrm->local_copy = NULL;
+	zstrm->ctx.context = NULL;
+}
+
+static int zcomp_dstrm_init(struct zcomp *comp, struct zcomp_dstrm *zstrm)
+{
+	int ret;
+
+	if (comp->ops->create_dctx) {
+		ret = comp->ops->create_dctx(comp->params, &zstrm->ctx);
+		if (ret) {
+			/* backend has released partially created context */
+			zstrm->ctx.context = NULL;
+			return ret;
+		}
+	}
+
+	zstrm->local_copy = vzalloc(PAGE_SIZE);
+	if (!zstrm->local_copy) {
+		zcomp_dstrm_free(comp, zstrm);
 		return -ENOMEM;
 	}
 	return 0;
@@ -114,10 +149,10 @@ ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 	return at;
 }
 
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
+struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
 {
 	for (;;) {
-		struct zcomp_strm *zstrm = raw_cpu_ptr(comp->stream);
+		struct zcomp_cstrm *zstrm = raw_cpu_ptr(comp->cstream);
 
 		/*
 		 * Inspired by zswap
@@ -136,12 +171,29 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 	}
 }
 
-void zcomp_stream_put(struct zcomp_strm *zstrm)
+void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
+{
+	mutex_unlock(&zstrm->lock);
+}
+
+struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp)
+{
+	for (;;) {
+		struct zcomp_dstrm *zstrm = raw_cpu_ptr(comp->dstream);
+
+		mutex_lock(&zstrm->lock);
+		if (likely(zstrm->local_copy))
+			return zstrm;
+		mutex_unlock(&zstrm->lock);
+	}
+}
+
+void zcomp_dstrm_put(struct zcomp_dstrm *zstrm)
 {
 	mutex_unlock(&zstrm->lock);
 }
 
-int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
+int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 		   const void *src, unsigned int *dst_len)
 {
 	struct zcomp_req req = {
@@ -159,7 +211,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	return ret;
 }
 
-int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
+int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 		     struct scatterlist *sg, unsigned int src_len, void *dst)
 {
 	struct zcomp_req req = {
@@ -191,23 +243,44 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
-	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
+	struct zcomp_cstrm *cstrm;
+	struct zcomp_dstrm *dstrm;
 	int ret;
 
-	ret = zcomp_strm_init(comp, zstrm);
-	if (ret)
+	cstrm = per_cpu_ptr(comp->cstream, cpu);
+	ret = zcomp_cstrm_init(comp, cstrm);
+	if (ret) {
 		pr_err("Can't allocate a compression stream\n");
-	return ret;
+		return ret;
+	}
+
+	dstrm = per_cpu_ptr(comp->dstream, cpu);
+	ret = zcomp_dstrm_init(comp, dstrm);
+	if (ret) {
+		pr_err("Can't allocate a decompression stream\n");
+		zcomp_cstrm_free(comp, cstrm);
+		return ret;
+	}
+
+	return 0;
 }
 
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
-	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
+	struct zcomp_cstrm *cstrm;
+	struct zcomp_dstrm *dstrm;
+
+	cstrm = per_cpu_ptr(comp->cstream, cpu);
+	mutex_lock(&cstrm->lock);
+	zcomp_cstrm_free(comp, cstrm);
+	mutex_unlock(&cstrm->lock);
+
+	dstrm = per_cpu_ptr(comp->dstream, cpu);
+	mutex_lock(&dstrm->lock);
+	zcomp_dstrm_free(comp, dstrm);
+	mutex_unlock(&dstrm->lock);
 
-	mutex_lock(&zstrm->lock);
-	zcomp_strm_free(comp, zstrm);
-	mutex_unlock(&zstrm->lock);
 	return 0;
 }
 
@@ -215,17 +288,27 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 {
 	int ret, cpu;
 
-	comp->stream = alloc_percpu(struct zcomp_strm);
-	if (!comp->stream)
-		return -ENOMEM;
-
 	comp->params = params;
 	ret = comp->ops->setup_params(comp->params);
 	if (ret)
 		goto cleanup;
 
-	for_each_possible_cpu(cpu)
-		mutex_init(&per_cpu_ptr(comp->stream, cpu)->lock);
+	comp->cstream = alloc_percpu(struct zcomp_cstrm);
+	if (!comp->cstream) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	comp->dstream = alloc_percpu(struct zcomp_dstrm);
+	if (!comp->dstream) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	for_each_possible_cpu(cpu) {
+		mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
+		mutex_init(&per_cpu_ptr(comp->dstream, cpu)->lock);
+	}
 
 	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	if (ret < 0)
@@ -235,7 +318,8 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 
 cleanup:
 	comp->ops->release_params(comp->params);
-	free_percpu(comp->stream);
+	free_percpu(comp->dstream);
+	free_percpu(comp->cstream);
 	return ret;
 }
 
@@ -243,7 +327,8 @@ void zcomp_destroy(struct zcomp *comp)
 {
 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	comp->ops->release_params(comp->params);
-	free_percpu(comp->stream);
+	free_percpu(comp->dstream);
+	free_percpu(comp->cstream);
 	kfree(comp);
 }
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index f38fd31f9e4e..22be50dc51ba 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -39,10 +39,15 @@ struct zcomp_ctx {
 	void *context;
 };
 
-struct zcomp_strm {
+struct zcomp_cstrm {
 	struct mutex lock;
 	/* compression buffer */
 	void *buffer;
+	struct zcomp_ctx ctx;
+};
+
+struct zcomp_dstrm {
+	struct mutex lock;
 	/* local copy of handle memory */
 	void *local_copy;
 	struct zcomp_ctx ctx;
@@ -62,8 +67,11 @@ struct zcomp_ops {
 	int (*decompress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req);
 
-	int (*create_ctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
-	void (*destroy_ctx)(struct zcomp_ctx *ctx);
+	int (*create_cctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
+	void (*destroy_cctx)(struct zcomp_ctx *ctx);
+
+	int (*create_dctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
+	void (*destroy_dctx)(struct zcomp_ctx *ctx);
 
 	int (*setup_params)(struct zcomp_params *params);
 	void (*release_params)(struct zcomp_params *params);
@@ -73,7 +81,8 @@ struct zcomp_ops {
 
 /* dynamic per-device compression frontend */
 struct zcomp {
-	struct zcomp_strm __percpu *stream;
+	struct zcomp_cstrm __percpu *cstream;
+	struct zcomp_dstrm __percpu *dstream;
 	const struct zcomp_ops *ops;
 	struct zcomp_params *params;
 	struct hlist_node node;
@@ -87,12 +96,15 @@ const char *zcomp_lookup_backend_name(const char *comp);
 struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
 void zcomp_destroy(struct zcomp *comp);
 
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
-void zcomp_stream_put(struct zcomp_strm *zstrm);
+struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
+void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
+
+struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp);
+void zcomp_dstrm_put(struct zcomp_dstrm *zstrm);
 
-int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
+int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 		   const void *src, unsigned int *dst_len);
-int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
+int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 		     struct scatterlist *sg, unsigned int src_len, void *dst);
 
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0e1aa0da11aa..def5266679b0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1348,7 +1348,7 @@ static ssize_t writeback_store(struct device *dev,
 static int decompress_bdev_page(struct zram *zram, struct page *page,
 				unsigned long index)
 {
-	struct zcomp_strm *zstrm;
+	struct zcomp_dstrm *zstrm;
 	struct scatterlist sg[1];
 	unsigned int size;
 	int ret, prio;
@@ -1373,7 +1373,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 	sg_init_table(sg, 1);
 	sg_set_page(sg, page, size, 0);
 
-	zstrm = zcomp_stream_get(zram->comps[prio]);
+	zstrm = zcomp_dstrm_get(zram->comps[prio]);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size,
 			       zstrm->local_copy);
 	if (!ret) {
@@ -1382,7 +1382,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 		copy_page(dst, zstrm->local_copy);
 		kunmap_local(dst);
 	}
-	zcomp_stream_put(zstrm);
+	zcomp_dstrm_put(zstrm);
 	slot_unlock(zram, index);
 
 	return ret;
@@ -2115,7 +2115,7 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 static int read_compressed_page(struct zram *zram, struct page *page,
 				unsigned long index)
 {
-	struct zcomp_strm *zstrm;
+	struct zcomp_dstrm *zstrm;
 	struct scatterlist sg[2];
 	unsigned long handle;
 	unsigned int size;
@@ -2126,13 +2126,13 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	size = get_slot_size(zram, index);
 	prio = get_slot_comp_priority(zram, index);
 
-	zstrm = zcomp_stream_get(zram->comps[prio]);
+	zstrm = zcomp_dstrm_get(zram->comps[prio]);
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst);
 	kunmap_local(dst);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
-	zcomp_stream_put(zstrm);
+	zcomp_dstrm_put(zstrm);
 
 	return ret;
 }
@@ -2300,7 +2300,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	unsigned long handle;
 	unsigned int comp_len;
 	void *mem;
-	struct zcomp_strm *zstrm;
+	struct zcomp_cstrm *zstrm;
 	unsigned long element;
 	bool same_filled;
 
@@ -2310,20 +2310,20 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+	zstrm = zcomp_cstrm_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
 			     mem, &comp_len);
 	kunmap_local(mem);
 
 	if (unlikely(ret)) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
 		return ret;
 	}
 
 	if (comp_len >= huge_class_size) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		return write_incompressible_page(zram, page, index);
 	}
 
@@ -2331,18 +2331,18 @@ static int zram_write_page(struct zram *zram, struct page *page,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		return PTR_ERR((void *)handle);
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
 
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
-	zcomp_stream_put(zstrm);
+	zcomp_cstrm_put(zstrm);
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
@@ -2451,7 +2451,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			   struct page *page, u64 *num_recomp_pages,
 			   u32 threshold, u32 prio)
 {
-	struct zcomp_strm *zstrm = NULL;
+	struct zcomp_cstrm *zstrm = NULL;
 	unsigned long handle_old;
 	unsigned long handle_new;
 	unsigned int comp_len_old;
@@ -2483,7 +2483,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	 */
 	clear_slot_flag(zram, index, ZRAM_IDLE);
 
-	zstrm = zcomp_stream_get(zram->comps[prio]);
+	zstrm = zcomp_cstrm_get(zram->comps[prio]);
 	src = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[prio], zstrm, src, &comp_len_new);
 	kunmap_local(src);
@@ -2498,7 +2498,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 		*num_recomp_pages -= 1;
 
 	if (ret) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		return ret;
 	}
 
@@ -2507,7 +2507,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 
 	if (class_index_new >= class_index_old ||
 	    (threshold && comp_len_new >= threshold)) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 
 		/*
 		 * Secondary algorithms failed to re-compress the page
@@ -2536,12 +2536,12 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			       __GFP_HIGHMEM | __GFP_MOVABLE,
 			       page_to_nid(page));
 	if (IS_ERR_VALUE(handle_new)) {
-		zcomp_stream_put(zstrm);
+		zcomp_cstrm_put(zstrm);
 		return PTR_ERR((void *)handle_new);
 	}
 
 	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
-	zcomp_stream_put(zstrm);
+	zcomp_cstrm_put(zstrm);
 
 	slot_free(zram, index);
 	set_slot_handle(zram, index, handle_new);
-- 
2.56.0.212.g129ede20d9-goog

