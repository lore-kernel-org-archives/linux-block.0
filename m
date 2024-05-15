Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6B5BAFC
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757456; cv=none; b=hYgJ5Pu6JehKEUxWiN2Cr2FJCcbRflRQKh8o+tWPcXc2RRPAPPLs14vQjIV6TOrAwEUFUlmL5PHyNYTCH7HJOkNmW8LkIY+nsA8PUMgU/lvTdHB2TLjH3kAWUb4FHHdoeQybqE0RLySMvCqmQekTIGM1Xd+zGS9bA5NAn4fW3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757456; c=relaxed/simple;
	bh=qPxpMzrLexeajXOvydJh+v3ubpdPbmLqWgxknedh2Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQN9TTa6mYnCORpmYG6m658GaU8Iw73GsCViJeSIfCkzr7pjEUEOrsZMcR32VDsahHtoz77UrZ+L5Ok8BzDx71k58uNXk375qDNX3eZCSQJor7VGntQun2dD8V2ShHL4JrxWx64QtLLHyq3qIHYO+mbyg04ekIsOEH4VXTGpTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xdt8p9hv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xdt8p9hv"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so5277447b3a.2
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757453; x=1716362253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Q92/50oEzsFAIXeAasi/lhjVaiDz6wVjSMUCSkV98=;
        b=Xdt8p9hvR9TFDNsREHSqFGtB4LrvWY6k3grut4Jh2mc67rjUSKE6UncsmCO6Lc5F/q
         7q8FhbvOcx+XLoPR+yglbhlOfFlycwo9lgVqS6Mmdfvvvw5icjO9/p1zNM5frFZNuulB
         QBXRdiJqUWmsdPOCwa8nlNr3UmFwQCV1tiXL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757453; x=1716362253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1Q92/50oEzsFAIXeAasi/lhjVaiDz6wVjSMUCSkV98=;
        b=T7/NVgtMXc21ADPnzklqZIXR3tApbATudmnxjp38C2Me8i7M8kR5OoGMtiEfymVlXM
         hComt5M8h5fti9Zg2tDRADtdPcVCbtT+MFKzrPf+j0ykZSNV7voFL2lliebcp34TMSOV
         ZvIax8izGlwO+8or8fEMS6um9G8cFgVaqzwS/c8OnDD6wXv2ID76BNTZd5ECzyym+feh
         mshdkgXkOSTXgvGwAWMSLevtmiUQonA0F3P/N575yil7jBz9M1pZCbsmFwcNYK2bcf2B
         gyWoAYZ/5Ml9OiOWuoak9oM5YO1DtpnJIWwzNZfQjFqutpn8NWPLKLSVDOysIYVVdDNo
         kBNA==
X-Forwarded-Encrypted: i=1; AJvYcCWjAsuHwNyDbrORzT9yfCQzvb3y6puUzj2ulSGMeazTxIdqitr+wwyYc3gPUd3/IoK6cHei4rKZaFRQzIFSmgRB7XsTOuAhddYSo6o=
X-Gm-Message-State: AOJu0Yw3o3Agdv8j6GsbvGRS0lK93FExIDhTsO6X7A58hxNMR9aObcRM
	FbP/SlXp3B5um6447f7nXpsWoJU4H5sV8rXDtjBh3azHL5BXo0xe3vaHW/BoRQ==
X-Google-Smtp-Source: AGHT+IFoXN+G8OBVIyHl2dhkr+cK7yJTsa+IDe8Y4EgCK8SM3Nz6RhZgJrZp6Vf7WOYHuo5IjVDf2g==
X-Received: by 2002:a05:6a20:5504:b0:1a9:8152:5102 with SMTP id adf61e73a8af0-1afde0d54c9mr14256096637.24.1715757453236;
        Wed, 15 May 2024 00:17:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:32 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 15/21] zram: add dictionary support to zstd backend
Date: Wed, 15 May 2024 16:12:52 +0900
Message-ID: <20240515071645.1788128-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for pre-trained zstd dictionaries [1]
Dictionary is loaded once (per-config) and then loaded to Cctx
and Dctx by reference, so we don't allocate extra memory.

Regarding GFP_ATOMIC in Cctx customAlloc(), we probably would
want to do something about it. Either make sure that we always
(somehow) fully setup all Cctx contexts from non-atomic context
before we attempt to use them, come up with some sort of custom
allocator or stop calling zcomp_compress() from atomic context.

TEST
====

- default zstd

/sys/block/zram0/mm_stat
1750315008 504602831 514256896        0 514256896        1        0    34204    34204

- zstd level=7 dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750310912 432540606 441712640        0 441712640        1        0    34187    34187

[1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 126 ++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d392d364ad2c..4be149370e0b 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -12,23 +12,52 @@ struct zstd_ctx {
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
+	zstd_custom_mem ctx_mem;
+	zstd_cdict *cdict;
+	zstd_ddict *ddict;
 	s32 level;
 };
 
+/*
+ * Cctx allocator.customAlloc() can be called from zcomp_compress() under
+ * local-lock (per-CPU compression stream), in which case we must use
+ * GFP_ATOMIC.
+ */
+static void *zstd_ctx_alloc(void *opaque, size_t size)
+{
+	if (!preemptible())
+		return kvzalloc(size, GFP_ATOMIC);
+
+	return kvzalloc(size, GFP_KERNEL);
+}
+
+static void zstd_ctx_free(void *opaque, void *address)
+{
+	kvfree(address);
+}
+
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
-	vfree(zctx->cctx_mem);
-	vfree(zctx->dctx_mem);
+	if (zctx->cctx_mem)
+		vfree(zctx->cctx_mem);
+	else
+		zstd_free_cctx(zctx->cctx);
+
+	if (zctx->dctx_mem)
+		vfree(zctx->dctx_mem);
+	else
+		zstd_free_dctx(zctx->dctx);
+
+	zstd_free_cdict(zctx->cdict);
+	zstd_free_ddict(zctx->ddict);
 	kfree(zctx);
 }
 
 static void *zstd_create(struct zcomp_config *config)
 {
-	zstd_parameters params;
 	struct zstd_ctx *ctx;
-	size_t sz;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -39,24 +68,62 @@ static void *zstd_create(struct zcomp_config *config)
 	else
 		ctx->level = zstd_default_clevel();
 
-	params = zstd_get_params(ctx->level, PAGE_SIZE);
-	sz = zstd_cctx_workspace_bound(&params.cParams);
-	ctx->cctx_mem = vzalloc(sz);
-	if (!ctx->cctx_mem)
-		goto error;
-
-	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
-	if (!ctx->cctx)
-		goto error;
-
-	sz = zstd_dctx_workspace_bound();
-	ctx->dctx_mem = vzalloc(sz);
-	if (!ctx->dctx_mem)
-		goto error;
-
-	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
-	if (!ctx->dctx)
-		goto error;
+	ctx->ctx_mem.customAlloc = zstd_ctx_alloc;
+	ctx->ctx_mem.customFree = zstd_ctx_free;
+
+	if (config->dict_sz == 0) {
+		zstd_parameters params;
+		size_t sz;
+
+		params = zstd_get_params(ctx->level, PAGE_SIZE);
+		sz = zstd_cctx_workspace_bound(&params.cParams);
+		ctx->cctx_mem = vzalloc(sz);
+		if (!ctx->cctx_mem)
+			goto error;
+
+		ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+		if (!ctx->cctx)
+			goto error;
+
+		sz = zstd_dctx_workspace_bound();
+		ctx->dctx_mem = vzalloc(sz);
+		if (!ctx->dctx_mem)
+			goto error;
+
+		ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+		if (!ctx->dctx)
+			goto error;
+	} else {
+		zstd_compression_parameters params;
+
+		ctx->cctx = zstd_create_cctx_advanced(ctx->ctx_mem);
+		if (!ctx->cctx)
+			goto error;
+
+		ctx->dctx = zstd_create_dctx_advanced(ctx->ctx_mem);
+		if (!ctx->dctx)
+			goto error;
+
+		params = zstd_get_cparams(ctx->level, PAGE_SIZE,
+					  config->dict_sz);
+
+		ctx->cdict = zstd_create_cdict_advanced(config->dict,
+							config->dict_sz,
+							ZSTD_dlm_byRef,
+							ZSTD_dct_auto,
+							params,
+							ctx->ctx_mem);
+		if (!ctx->cdict)
+			goto error;
+
+		ctx->ddict = zstd_create_ddict_advanced(config->dict,
+							config->dict_sz,
+							ZSTD_dlm_byRef,
+							ZSTD_dct_auto,
+							ctx->ctx_mem);
+		if (!ctx->ddict)
+			goto error;
+	}
 
 	return ctx;
 
@@ -72,8 +139,12 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
-	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, PAGE_SIZE, &params);
+	if (!zctx->cdict)
+		ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+					 src, PAGE_SIZE, &params);
+	else
+		ret = zstd_compress_using_cdict(zctx->cctx, dst, *dst_len,
+						src, PAGE_SIZE, zctx->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -86,7 +157,12 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
 	struct zstd_ctx *zctx = ctx;
 	size_t ret;
 
-	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (!zctx->ddict)
+		ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE,
+					   src, src_len);
+	else
+		ret = zstd_decompress_using_ddict(zctx->dctx, dst, PAGE_SIZE,
+						  src, src_len, zctx->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

