Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271247FB00
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863545; cv=none; b=B0ZnT8Dqpa/EBi6Rw9ttecb9u7ALdfA2lkWRIfS9AcbmzOecHJfBsYv7zXYIarWIwTIE3B5hXEjXd9PUamjw6BdcC4Fl5tHJs2yV9fPiPGZaE5CEpddx7ayU0m1zE4EnEGOHzA97f2zNxy/7KH3w2PS2GLs8sACpjWlDPqRmRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863545; c=relaxed/simple;
	bh=DYuppku4rT7n6/3sKP9lI86/iAOWCanZGZfg+/o8eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4BLF9F04RcRu1FMPbNS2lY7Ngnoag7DrN3zctm8BRaYFO6ycd0riCY4bGZKu1ow7g0GYDJCjH5VqazI0zj9bIZ191kxjV0dgoRsVF2O6LJ6LDZaO0k2VXq5ZQbxglVlqozX5hxVVVwqaBNAHZB1Vioub0JVal8xNEo85g09Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j2/3uGa1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j2/3uGa1"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-886e61fa30fso784800b3a.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863543; x=1792468343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fG+ZRnn0wXsUMGdIWlrdX9yA9C4/sFFG7BBKDHx8FEs=;
        b=j2/3uGa1P9VTxkH7xXKQrGC29E7hS0v5f1VxQmt3aLjHz88KVGigPwlGfL+bHypWtO
         8nYsPhBM4pQhKXnSOHu6vYHTpBTjf3iJK+mgQYjXbkpgC139eGV5PgK1Ys/ZZ2yY8NeE
         UIAfEYR7zpIbHS8m3sNMuOkQXX3t2O4G4Jy3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863543; x=1792468343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fG+ZRnn0wXsUMGdIWlrdX9yA9C4/sFFG7BBKDHx8FEs=;
        b=tkLEVCUhFSQ/9rUwsOxylhnVTwFB7yawV1Yu4ez/G3nP4uNA/hOfGOHpnMgFGAvdeG
         HfBWoxy9DUOBxyW1pLHR9axSpf790sv4r26dfG1lPNmZMg735ynuXLJsJwbXfgUo18Dc
         MUPoS1Egpdshts7RkLmaq0MegNyKIDm8gzP/GuxTiw7rjs+S2WhSN912V9vYHhNKpPsN
         sH+dbwrGx0GWl6gtKW4AZ7/U589iwGchEGjvVguF2Cip3ri9xPMUwhE5j9J64OWisCo6
         6TRUyibIiWRub3KqbNgNUt1ALDOUu51nzBskIz4yvf+M/+LLvQc2XmLTzt05bceKHUhc
         WjjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMDrF0pYXb+nM67nC1YCnx/Z/PWP3dkS+E6aO3vaslhHEqEFo2DuP5FZGGbcatAD0iZkm9gyg4nC7AVA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgIsbOdvVrVRP2OHoxfC0k3beXyClSQEbRzA/ITWSbSN5Kzk+4
	7aaPPgqqEJbXYeE4MZKbSoi2L1LQ2e2asJ5R5/oNfONzMxCknp/asoQ2Zm3HSK8iSw==
X-Gm-Gg: AYBFou0ScWULppDJXkOIoJREwfiEm2hWhqrxwxla/0Rjug5XkoWLQxQqLc/PV7AbCDc
	kB32SfBY/8dp7Gd+R0qoWPj6lEsouDCgcJEMyY8olNPOCAV7vlHrGxNHcwiSiYRPUYlIdBko2H+
	k61/E1vZ9d74O+JFkSxI36WA6wsD0G2Q8ZnNbySv1GO/OCDhNQb8qktVGlrokd4kYIDugTCG4uh
	qV5D1FkVkfzFj6m2ho+PhoXLfvpV5hYGbuYXnIJeG4vqyHME57s0N8T+WC3sYcNTXtC0p2FX7gp
	To15NMvCkvUvlTDFnY0SRgZmtHBW5r5cOctN0lLpbeTXtf9nJzIknoKZKODUrnhgONxasDdm8/g
	L5ULMNxz70e6Q8kX/4uoHOj2bmueLueyr6dSLkw8atw+Bs4Kj2eefU+2gIW0sbMyn3H2gbRIp0Q
	DW4WyIKWEYXFZRreCHchF/4c/Y3oOdJfCALojJK4/eBOsL+Qw7MtDgSHJOyWqlnq9DQZDNsQt7z
	P8DPA6Oho79kE7DyU5FlxSs6NFFlyyxwCcdPc+QlZMWGeT7kBlJ4/+cVkAm+Q==
X-Received: by 2002:a05:6a00:1591:b0:898:e7e7:c0df with SMTP id d2e1a72fcca58-898e7e7c34fmr5110419b3a.45.1791863542893;
        Mon, 12 Oct 2026 20:52:22 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:22 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 05/11] zram: lz4: use LZ4_decompress_safe_usingDict()
Date: Tue, 13 Oct 2026 12:50:52 +0900
Message-ID: <20261013035201.2809924-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LZ4_decompress_safe_usingDict() in lz4_decompress() and drop the
per-CPU dstrm allocation.  Store the compression workspace directly
in ctx->context.

Using vmalloc(LZ4_MEM_COMPRESS) instead of kzalloc() for cstrm and
dict_stream when a dictionary is configured also avoids power-of-2
page rounding (~16 KB rounded up to 32 KB), saving ~12 KB per stream.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4.c | 76 ++++++--------------------------
 1 file changed, 14 insertions(+), 62 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 158fd8b5e8a9..5f2e27805d75 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -4,18 +4,10 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
-#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 #include "backend_lz4.h"
 
-struct lz4_ctx {
-	void *mem;
-
-	LZ4_streamDecode_t *dstrm;
-	LZ4_stream_t *cstrm;
-};
-
 static void lz4_release_params(struct zcomp_params *params)
 {
 	LZ4_stream_t *dict_stream = params->drv_data;
@@ -24,7 +16,7 @@ static void lz4_release_params(struct zcomp_params *params)
 	if (!dict_stream)
 		return;
 
-	kfree(dict_stream);
+	vfree(dict_stream);
 }
 
 static int lz4_setup_params(struct zcomp_params *params)
@@ -42,14 +34,14 @@ static int lz4_setup_params(struct zcomp_params *params)
 	if (!params->dict || !params->dict_sz)
 		return 0;
 
-	dict_stream = kzalloc_obj(*dict_stream);
+	dict_stream = vzalloc(sizeof(*dict_stream));
 	if (!dict_stream)
 		return -ENOMEM;
 
 	ret = LZ4_loadDict(dict_stream,
 			   params->dict, params->dict_sz);
 	if (ret != params->dict_sz) {
-		kfree(dict_stream);
+		vfree(dict_stream);
 		return -EINVAL;
 	}
 	params->drv_data = dict_stream;
@@ -59,61 +51,32 @@ static int lz4_setup_params(struct zcomp_params *params)
 
 static void lz4_destroy(struct zcomp_ctx *ctx)
 {
-	struct lz4_ctx *zctx = ctx->context;
-
-	if (!zctx)
-		return;
-
-	vfree(zctx->mem);
-	kfree(zctx->dstrm);
-	kfree(zctx->cstrm);
-	kfree(zctx);
+	vfree(ctx->context);
 }
 
 static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4_ctx *zctx;
+	BUILD_BUG_ON(sizeof(LZ4_stream_t) != LZ4_MEM_COMPRESS);
 
-	zctx = kzalloc_obj(*zctx);
-	if (!zctx)
+	ctx->context = vmalloc(LZ4_MEM_COMPRESS);
+	if (!ctx->context)
 		return -ENOMEM;
-
-	ctx->context = zctx;
-	if (params->dict_sz == 0) {
-		zctx->mem = vmalloc(LZ4_MEM_COMPRESS);
-		if (!zctx->mem)
-			goto error;
-	} else {
-		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
-		if (!zctx->dstrm)
-			goto error;
-
-		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
-		if (!zctx->cstrm)
-			goto error;
-	}
-
 	return 0;
-
-error:
-	lz4_destroy(ctx);
-	return -ENOMEM;
 }
 
 static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			struct zcomp_req *req)
 {
-	struct lz4_ctx *zctx = ctx->context;
 	int ret;
 
-	if (!zctx->cstrm) {
+	if (!params->drv_data) {
 		ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
 					req->dst_len, params->level,
-					zctx->mem);
+					ctx->context);
 	} else {
 		/* Cstrm needs to be reset */
-		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
-		ret = LZ4_compress_fast_continue(zctx->cstrm, req->src,
+		memcpy(ctx->context, params->drv_data, sizeof(LZ4_stream_t));
+		ret = LZ4_compress_fast_continue(ctx->context, req->src,
 						 req->dst, req->src_len,
 						 req->dst_len, params->level);
 	}
@@ -126,22 +89,11 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req)
 {
-	struct lz4_ctx *zctx = ctx->context;
 	int ret;
 
-	if (!zctx->dstrm) {
-		ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,
-					  req->dst_len);
-	} else {
-		/* Dstrm needs to be reset */
-		ret = LZ4_setStreamDecode(zctx->dstrm, params->dict,
-					  params->dict_sz);
-		if (!ret)
-			return -EINVAL;
-		ret = LZ4_decompress_safe_continue(zctx->dstrm, req->src,
-						   req->dst, req->src_len,
-						   req->dst_len);
-	}
+	ret = LZ4_decompress_safe_usingDict(req->src, req->dst, req->src_len,
+					    req->dst_len, params->dict,
+					    params->dict_sz);
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
-- 
2.56.0.385.gd3acb90ef8-goog

