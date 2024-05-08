Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1A745D5
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154192; cv=none; b=IDUKZEgNAE1QxzWypO8TfY84V5fbblxs6aBgvA26mdCIXF3mm78BPYGUHq3kcQ262ubMZ+otWZeEVBVVLjrxaoruIFLbJ2n2tNM4+JJvJqCh1ENmfDXR5TcRQ0nnBwa+IZv8SL0f1URzDimwCBU/l0ZJ+FOQXOMDaP3EAWuh8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154192; c=relaxed/simple;
	bh=S+q9egEJGrJejpCCNByxOEX2jrCMT0cr23KcD3p6dh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzoYs398ftrFYlljJE3OB+18+rMSv3l2kLLoRmd3PVVoIHoCZ5p0fzQI/Mnj/qSMrfXSa6WhQIDgax87lMzx8iNEOMwS7tMFLIiN0kZPb/xwhz9rvYXdb+DWvRE7zh4uQiCOl0u4OJgoXiA1C5m5x70fsvnhc8opxwxEnl0IXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C/fFqpBH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/fFqpBH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b4952a1b51so3123393a91.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154190; x=1715758990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egL7/ZOm/LwTDOSUeZ3gfevqUUa8V/EYy8mdcUtRQbg=;
        b=C/fFqpBHUFTgOJ+SKvQAlmoH8yvxpTX1JXg+wLvGA9pVuCiL26eEVREbP3x8b+uCtW
         ifcd6VFQTpK1PWBS0o8/pOff5uXs6aSfz5PvsYiVwtUp0Vlab6VqX9rLcErDcxirChF5
         wbBZrTsGI0rjRcFBHte456n9VSKuacQM63HEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154190; x=1715758990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egL7/ZOm/LwTDOSUeZ3gfevqUUa8V/EYy8mdcUtRQbg=;
        b=S76XZxxwClOGYpCICnpDYgzPcmOQ5QZZgvQiTU/VxFUulx8PDk60USXn7GcK7sfFyP
         iAuqe57dS82H585zEXEv3fuubF6cq2IYD8UQRf6RoSZfpUoSaQ2vQgbJRscXmu3EJh6/
         XzhE3WE6R/VetBKkbptdWQ5afKHY3x9iUHJVqUYtfbQSL+nxaRHnHuDBHUZvEnxYCw9e
         QrtaswXAEHIiF+Np5GLHyr6x73dvngzp9NhXupjXqWaQFaKDepAyjT8FO5XDQ5HTv2rI
         E8uKKwvbm5I8yafkrchAbuC0h2E83CxgkGhJCV6ekfxegHqjJeJJKhyXNO+IY4GzoQU/
         icKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsoEBxf8TJ01G24DJnLW92NWAy2KX0qLszEj0M++HR8Up9rbgYw8zgEGzikpFMAw+o0v96io6y6huSQa3+OYScTroeNeUTR6XWezk=
X-Gm-Message-State: AOJu0Yyj785Op07I9zSaakJy/hQAeQxxvoYunhnhaZwnVHv9nOyAZgCP
	GBgI6Cf3/Su16suGChhw49B6P84VA2NZzPK88h8glPo/edFkqnk54uTq0NqS/g==
X-Google-Smtp-Source: AGHT+IFZBqF0jjYvlPfasWPt5+AF2jKv+Gvu8wpV0lbwhiTsU35SOMNKGqwZcxg+Jy7o1OR2mNPBRA==
X-Received: by 2002:a17:90a:a592:b0:2a3:be59:e969 with SMTP id 98e67ed59e1d1-2b616c05945mr1560239a91.47.1715154190329;
        Wed, 08 May 2024 00:43:10 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:10 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 14/19] zram: add dictionary support to zstd backend
Date: Wed,  8 May 2024 16:42:07 +0900
Message-ID: <20240508074223.652784-15-senozhatsky@chromium.org>
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
index b2fb94902bef..006d0f40617d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -12,23 +12,52 @@ struct zstd_ctx {
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
+	ZSTD_customMem ctx_mem;
+	ZSTD_CDict *cdict;
+	ZSTD_DDict *ddict;
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
+		ZSTD_freeCCtx(zctx->cctx);
+
+	if (zctx->dctx_mem)
+		vfree(zctx->dctx_mem);
+	else
+		ZSTD_freeDCtx(zctx->dctx);
+
+	ZSTD_freeCDict(zctx->cdict);
+	ZSTD_freeDDict(zctx->ddict);
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
 		ctx->level = ZSTD_defaultCLevel();
 
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
+		ZSTD_compressionParameters params;
+
+		ctx->cctx = ZSTD_createCCtx_advanced(ctx->ctx_mem);
+		if (!ctx->cctx)
+			goto error;
+
+		ctx->dctx = ZSTD_createDCtx_advanced(ctx->ctx_mem);
+		if (!ctx->dctx)
+			goto error;
+
+		params = ZSTD_getCParams(ctx->level, PAGE_SIZE,
+					 config->dict_sz);
+
+		ctx->cdict = ZSTD_createCDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       params,
+						       ctx->ctx_mem);
+		if (!ctx->cdict)
+			goto error;
+
+		ctx->ddict = ZSTD_createDDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       ctx->ctx_mem);
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
+		ret = ZSTD_compress_usingCDict(zctx->cctx, dst, *dst_len,
+					       src, PAGE_SIZE, zctx->cdict);
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
+		ret = ZSTD_decompress_usingDDict(zctx->dctx, dst, PAGE_SIZE,
+						 src, src_len, zctx->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

