Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AF6D1A8
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757460; cv=none; b=hlqzM1Z4D+AhgLxHUhpVpVULW08v7bI48S05GqkhTEKtTtw7zQRZMrcZceok/ROYC+Rlnel0KwfqByZCbRwsLaxG1X59mYV5CB02uDjjzZ9TozceFC9saUPLQlQ+LLVWjlsPj4C/2CuAJ+D+7FnHZfdUb8VPH7oO9VaBKqOF9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757460; c=relaxed/simple;
	bh=27D84d9fXLJIjEidlYnHwUN44hOlRv9gnV3y+W6WffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC7zDsI8j63uK/GHTCy7kTksAtLwvD11MNEsh8zxFD3OxvfUMKqJlWGdtQupZsvwJX2CD0b7PJyPQCBsARyBUMe4J0sJfJ4h1LPMCh9lz84eX+rCp3CR3bp/kz5h0s1tEfPf9zexEAyRdgBjVF94iFhSVopEg54OJ+1yNj5TpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cf+6dqrd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cf+6dqrd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed835f3c3cso56415985ad.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757458; x=1716362258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NDMJY3isqUp1Ew8boWj0krAQJNa5FH6QFiRGHLN6Vo=;
        b=cf+6dqrdu3Tq1OTezw3qOVjOrFhtLLoHjo3nt3iGZtzq83y9P04BG5WLsVXq1sw/BY
         aoloOrBTZbEhJ7E08d8fl0YcphjchIRzE6E5XLSxfR8VV03yRWlVCpKrFV2Y81i3xZJG
         dNdvHwnOAncDJxlRc4+7TDz24qzCqoCDgfiN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757458; x=1716362258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NDMJY3isqUp1Ew8boWj0krAQJNa5FH6QFiRGHLN6Vo=;
        b=tpr02wLEIkGyPAa0BGal5tq2B7xA4FNw0eSzFCRigwYa6dXO796OXk2Fb/EQPe0b4h
         kXWzzUod2TPp6PPo6c2h4N1pO9CFrOa4wTqZHsgkUaLbW8oi7vaoq08FCzLB7h8XXuWT
         g43CLH0VVPS5PY7WepbBIlAyMWcXzdPC1Jf7OriBQ8kn8FzY+U6exuHKsyOZ1hg1OLl5
         jLLw/cZTO4+cMqaQ4YOsFQsA+uOrYgPnmk3CmodLkuT9yZIB+nFNmnwDRMmupN/1sAkm
         +IIPX7eVsXR5WPV8ySLTgW5g4r+/K3FHKSCe6aMsfudGxoYdYtRXaR8k73TBkxI82TiZ
         sCwA==
X-Forwarded-Encrypted: i=1; AJvYcCUJc0eScBqA1wDQu0B0DkPqlkpX0DVhUR1oVLa7F9puRYl7lPw5m659GEnTPtDF9BqEaB0/oXz7tVWK/B1Oe9ivqoFmrF6ZH8VrM4w=
X-Gm-Message-State: AOJu0YzHbV+pjczxHc2gL90AfgdcPZbnbHbv1ljTG6yk60P0TDSTdc1l
	4Zt4qiQb0rQ5VEmciJhMdcm1ptjiMJQxRHdKh3+YWYD3dVjc/YJ1B+slNOLEMA==
X-Google-Smtp-Source: AGHT+IHeoSK5yxNBWrJqyEizK8yAwDS+DFO/v6xnM5tOk4j5OWsHulkeJfcNBaP6LY2IvO2BEnwfXg==
X-Received: by 2002:a17:902:ecc7:b0:1e8:c994:b55b with SMTP id d9443c01a7336-1ef43d15786mr210891335ad.7.1715757457712;
        Wed, 15 May 2024 00:17:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 17/21] zram: share dictionaries between per-CPU contexts
Date: Wed, 15 May 2024 16:12:54 +0900
Message-ID: <20240515071645.1788128-18-senozhatsky@chromium.org>
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

zstd's CDict and DDict are accessed read-only during compression
and decompression, so instead of allocation per-context dictionaries
we can create just one CDict and DDict in init_config() and make
per-CPU contexts use them. This saves quite a lot of memory: on my
system CDict requires 408128 bytes and DDict requires 27352 bytes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 108 ++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 36 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 9d2cc27d4c9d..836de2af7c11 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -7,14 +7,18 @@
 
 #include "backend_zstd.h"
 
+struct zstd_ctx_data {
+	zstd_custom_mem ctx_mem;
+	zstd_cdict *cdict;
+	zstd_ddict *ddict;
+};
+
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
-	zstd_custom_mem ctx_mem;
-	zstd_cdict *cdict;
-	zstd_ddict *ddict;
+	struct zstd_ctx_data *ctx_data;
 	s32 level;
 };
 
@@ -38,32 +42,81 @@ static void zstd_ctx_free(void *opaque, void *address)
 
 static int zstd_init_config(struct zcomp_config *config)
 {
+	struct zstd_ctx_data *ctx_data = config->private;
+	zstd_compression_parameters params;
+
+	/* Already initialized */
+	if (ctx_data)
+		return 0;
+
 	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
 		config->level = zstd_default_clevel();
 
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
+	params = zstd_get_cparams(config->level, PAGE_SIZE, config->dict_sz);
+
+	ctx_data->cdict = zstd_create_cdict_advanced(config->dict,
+						     config->dict_sz,
+						     ZSTD_dlm_byRef,
+						     ZSTD_dct_auto,
+						     params,
+						     ctx_data->ctx_mem);
+	if (!ctx_data->cdict)
+		goto error;
+
+	ctx_data->ddict = zstd_create_ddict_advanced(config->dict,
+						     config->dict_sz,
+						     ZSTD_dlm_byRef,
+						     ZSTD_dct_auto,
+						     ctx_data->ctx_mem);
+	if (!ctx_data->ddict)
+		goto error;
+
+	config->private = ctx_data;
 	return 0;
+
+error:
+	zstd_free_cdict(ctx_data->cdict);
+	zstd_free_ddict(ctx_data->ddict);
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
+	zstd_free_cdict(ctx_data->cdict);
+	zstd_free_ddict(ctx_data->ddict);
+	kfree(ctx_data);
 }
 
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
+	/* Don't free zctx->ctx_data, it's done in release_config() */
 	if (zctx->cctx_mem)
 		vfree(zctx->cctx_mem);
 	else
 		zstd_free_cctx(zctx->cctx);
-
 	if (zctx->dctx_mem)
 		vfree(zctx->dctx_mem);
 	else
 		zstd_free_dctx(zctx->dctx);
-
-	zstd_free_cdict(zctx->cdict);
-	zstd_free_ddict(zctx->ddict);
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
-		zstd_compression_parameters params;
+		struct zstd_ctx_data *ctx_data = ctx->ctx_data;
 
-		ctx->cctx = zstd_create_cctx_advanced(ctx->ctx_mem);
+		ctx->cctx = zstd_create_cctx_advanced(ctx_data->ctx_mem);
 		if (!ctx->cctx)
 			goto error;
 
-		ctx->dctx = zstd_create_dctx_advanced(ctx->ctx_mem);
+		ctx->dctx = zstd_create_dctx_advanced(ctx_data->ctx_mem);
 		if (!ctx->dctx)
 			goto error;
-
-		params = zstd_get_cparams(ctx->level, PAGE_SIZE,
-					  config->dict_sz);
-
-		ctx->cdict = zstd_create_cdict_advanced(config->dict,
-							config->dict_sz,
-							ZSTD_dlm_byRef,
-							ZSTD_dct_auto,
-							params,
-							ctx->ctx_mem);
-		if (!ctx->cdict)
-			goto error;
-
-		ctx->ddict = zstd_create_ddict_advanced(config->dict,
-							config->dict_sz,
-							ZSTD_dlm_byRef,
-							ZSTD_dct_auto,
-							ctx->ctx_mem);
-		if (!ctx->ddict)
-			goto error;
 	}
 
 	return ctx;
@@ -144,15 +176,17 @@ static int zstd_compress(void *ctx, const unsigned char *src,
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
 		ret = zstd_compress_using_cdict(zctx->cctx, dst, *dst_len,
-						src, PAGE_SIZE, zctx->cdict);
+						src, PAGE_SIZE,
+						ctx_data->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -163,14 +197,16 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
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
 		ret = zstd_decompress_using_ddict(zctx->dctx, dst, PAGE_SIZE,
-						  src, src_len, zctx->ddict);
+						  src, src_len,
+						  ctx_data->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

