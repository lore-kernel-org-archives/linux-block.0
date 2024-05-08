Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A97BB1B
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154197; cv=none; b=Txe28ywTlEUh4ZatAAvN4mEfrYK5iVT1bKVy9N6jxJKDVtwYdooaCARoaqRVTSCgIQpPerzMudbmtKkQfCcxA8JlP5Fiu2fjwsLBad1bqdMTfW5llOklEEKSbKMga1UjYtdhC2Xl13yPF/PwbLRe4OxIjwwGwTK0X8fT74Hu1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154197; c=relaxed/simple;
	bh=d3vFRBqQt4rMVioo0/wvp6HT9RZQh4Y89EivFcAwXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbFvJw0/UanRB0rm5ZhFgZoYKMhnfa2oKQaagvgylVUJ8HoakwV95jZ0Gf9Clavkf5f+eZ2gTNP4M5/OuYmyBnyr94tPOIE5Qt75Bj2DgkCIhOQVc6gbUQs3MObp9NxmeFWhKfgG8Qh0XsjNsRQVIaJmhsG/SfjazUZm/wYjRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LapmttX9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LapmttX9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so2915610a91.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154195; x=1715758995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=LapmttX97atai9mkktgyd6PWh7UO+n9kNoZYrhy0fxaJrd7FxhHgl1dOximLiR6pwB
         i84YOGMhpOu01Wpcsecw2DX6M/AuTPr4ntXdfw3xo14H5zAFXlT5GG2ziisTnQLnQMPv
         Pca7Zk8nBkr4UlD5QDWBzRdSvyJXZ9iHp6Mdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154195; x=1715758995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=tLQ+aagClsYUymIzeAIZURPkz3CbMGEpV1VzkS5PcA4UZ+NeSVV17BaRZ7GDV0cw0n
         J7bWRgtkxVlOGUZ39o+T3b4h3fN8iwNzQSW2lqlPB/F30NtqVhCFkdt9RxMfYLHUmREm
         P3HKQEzpjbKtDbbIO2wxxbkEEFLbeSUxliPHVzdjV9WcIKLzMuasGHgRRWdjUPut81pn
         wzbe6L+JN4+WFSl15RQYMpRdXURDgetpfQp1Al7SNHkkdpaYks4Mv4cfT1xex7B/fIsJ
         jskDG5fO8ryoOLenpGgeSpaifDKTvzc0SPR6s8rBAOeryDOuklDBkxV4BNZYhq+rMqEh
         FUOw==
X-Forwarded-Encrypted: i=1; AJvYcCVBYG1KINfPON+jfwKVOad/RgrXXoPbBoTdn1kOQL6XLfljz7077TgXreY0oDgRlh5MJxO17TSpY9Ql9RjzpQTwhSYYlZcXNzzPUgA=
X-Gm-Message-State: AOJu0YyIrKWuLkfj2dOCyWAPaIKnCIYxWMmJUGS29gBcl7WOy8qjJOR6
	zvcoCh6sMEcLv+YA9rgOyjPj259IgKmaIvf8CU6Iszg0/dyj71OI278KkRI1jrwut8/AvL5PWPk
	=
X-Google-Smtp-Source: AGHT+IGkpZlHcB9WqUD6yMyxsDlX1n4CcJPrejHi03UqRulpJXLYN7DEIDkfCY04As9LHb5/AWDHEw==
X-Received: by 2002:a17:90a:6584:b0:2b3:c011:d28c with SMTP id 98e67ed59e1d1-2b616ae482bmr1652869a91.48.1715154195476;
        Wed, 08 May 2024 00:43:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 16/19] zram: share dictionaries between per-CPU contexts
Date: Wed,  8 May 2024 16:42:09 +0900
Message-ID: <20240508074223.652784-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zstd's CDict and DDict are accessed read-only during compression
and decompression, so instead of allocation per-context dictionaries
we can create just one CDict and DDict in init_config() and make
per-CPU contexts use them. This saves quite a lot of memory: on my
system CDict requires 408128 bytes and DDict requires 27352 bytes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 106 ++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 36 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index df59584b0337..99115b21c264 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -7,14 +7,18 @@
 
 #include "backend_zstd.h"
 
+struct zstd_ctx_data {
+	ZSTD_customMem ctx_mem;
+	ZSTD_CDict *cdict;
+	ZSTD_DDict *ddict;
+};
+
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
-	ZSTD_customMem ctx_mem;
-	ZSTD_CDict *cdict;
-	ZSTD_DDict *ddict;
+	struct zstd_ctx_data *ctx_data;
 	s32 level;
 };
 
@@ -38,32 +42,81 @@ static void zstd_ctx_free(void *opaque, void *address)
 
 static int zstd_init_config(struct zcomp_config *config)
 {
+	struct zstd_ctx_data *ctx_data = config->private;
+	ZSTD_compressionParameters params;
+
+	/* Already initialized */
+	if (ctx_data)
+		return 0;
+
 	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
 		config->level = ZSTD_defaultCLevel();
 
+	if (config->dict_sz == 0)
+		return 0;
+
+	ctx_data = kzalloc(sizeof(*ctx_data), GFP_KERNEL);
+	if (!ctx_data)
+		return -ENOMEM;
+
+	ctx_data->ctx_mem.customAlloc = zstd_ctx_alloc;
+	ctx_data->ctx_mem.customFree = zstd_ctx_free;
+
+	params = ZSTD_getCParams(config->level, PAGE_SIZE, config->dict_sz);
+
+	ctx_data->cdict = ZSTD_createCDict_advanced(config->dict,
+						    config->dict_sz,
+						    ZSTD_dlm_byRef,
+						    ZSTD_dct_auto,
+						    params,
+						    ctx_data->ctx_mem);
+	if (!ctx_data->cdict)
+		goto error;
+
+	ctx_data->ddict = ZSTD_createDDict_advanced(config->dict,
+						    config->dict_sz,
+						    ZSTD_dlm_byRef,
+						    ZSTD_dct_auto,
+						    ctx_data->ctx_mem);
+	if (!ctx_data->ddict)
+		goto error;
+
+	config->private = ctx_data;
 	return 0;
+
+error:
+	ZSTD_freeCDict(ctx_data->cdict);
+	ZSTD_freeDDict(ctx_data->ddict);
+	kfree(ctx_data);
+	return -EINVAL;
 }
 
 static void zstd_release_config(struct zcomp_config *config)
 {
+	struct zstd_ctx_data *ctx_data = config->private;
+
+	if (!ctx_data)
+		return;
+
+	config->private = NULL;
+	ZSTD_freeCDict(ctx_data->cdict);
+	ZSTD_freeDDict(ctx_data->ddict);
+	kfree(ctx_data);
 }
 
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
+	/* Don't free zctx->ctx_data, it's done in release_config() */
 	if (zctx->cctx_mem)
 		vfree(zctx->cctx_mem);
 	else
 		ZSTD_freeCCtx(zctx->cctx);
-
 	if (zctx->dctx_mem)
 		vfree(zctx->dctx_mem);
 	else
 		ZSTD_freeDCtx(zctx->dctx);
-
-	ZSTD_freeCDict(zctx->cdict);
-	ZSTD_freeDDict(zctx->ddict);
 	kfree(zctx);
 }
 
@@ -75,9 +128,8 @@ static void *zstd_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
+	ctx->ctx_data = config->private;
 	ctx->level = config->level;
-	ctx->ctx_mem.customAlloc = zstd_ctx_alloc;
-	ctx->ctx_mem.customFree = zstd_ctx_free;
 
 	if (config->dict_sz == 0) {
 		zstd_parameters params;
@@ -102,35 +154,15 @@ static void *zstd_create(struct zcomp_config *config)
 		if (!ctx->dctx)
 			goto error;
 	} else {
-		ZSTD_compressionParameters params;
+		struct zstd_ctx_data *ctx_data = ctx->ctx_data;
 
-		ctx->cctx = ZSTD_createCCtx_advanced(ctx->ctx_mem);
+		ctx->cctx = ZSTD_createCCtx_advanced(ctx_data->ctx_mem);
 		if (!ctx->cctx)
 			goto error;
 
-		ctx->dctx = ZSTD_createDCtx_advanced(ctx->ctx_mem);
+		ctx->dctx = ZSTD_createDCtx_advanced(ctx_data->ctx_mem);
 		if (!ctx->dctx)
 			goto error;
-
-		params = ZSTD_getCParams(ctx->level, PAGE_SIZE,
-					 config->dict_sz);
-
-		ctx->cdict = ZSTD_createCDict_advanced(config->dict,
-						       config->dict_sz,
-						       ZSTD_dlm_byRef,
-						       ZSTD_dct_auto,
-						       params,
-						       ctx->ctx_mem);
-		if (!ctx->cdict)
-			goto error;
-
-		ctx->ddict = ZSTD_createDDict_advanced(config->dict,
-						       config->dict_sz,
-						       ZSTD_dlm_byRef,
-						       ZSTD_dct_auto,
-						       ctx->ctx_mem);
-		if (!ctx->ddict)
-			goto error;
 	}
 
 	return ctx;
@@ -144,15 +176,16 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx_data *ctx_data = zctx->ctx_data;
 	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
-	if (!zctx->cdict)
+	if (!ctx_data)
 		ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
 					 src, PAGE_SIZE, &params);
 	else
 		ret = ZSTD_compress_usingCDict(zctx->cctx, dst, *dst_len,
-					       src, PAGE_SIZE, zctx->cdict);
+					       src, PAGE_SIZE, ctx_data->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -163,14 +196,15 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
 			   unsigned char *dst)
 {
 	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx_data *ctx_data = zctx->ctx_data;
 	size_t ret;
 
-	if (!zctx->ddict)
+	if (!ctx_data)
 		ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE,
 					   src, src_len);
 	else
 		ret = ZSTD_decompress_usingDDict(zctx->dctx, dst, PAGE_SIZE,
-						 src, src_len, zctx->ddict);
+						 src, src_len, ctx_data->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

