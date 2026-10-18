Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43F39448F
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295516; cv=none; b=D8uad+DwJwaXZA4gMF7+o/Z9nfltgnWqvVsHaHnB3CE8AfNtwB250KgtBnZ/nI284FuClJNPFM6I+WxdHe6j/2YK3DRWjUIFp9CImFT3ee4ATtKXzqT3XSQQGbNi6zcLMCnt2LH21t5QkXLvUVvx7IK+aTkPLlZwN4te+TFYukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295516; c=relaxed/simple;
	bh=nEbEeobJbXktuzOILSBD1n+yXckgTMekzcgJoY8hHy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY88z7PwR9jJ9Xm/q9vlTUM10npuKDOrMxXjcVaSxwvN4/l5b+MK6YoOV6Biq/TCI9p4LjhDcNhJENN9Jf7AF7l7wDgXPPXcCBb9ivadHqma9jQqooVIaV8lxxEXRNgGoxCHi+HF3P0JnHQhrhJRqVYndsPVOmBi996xsNZWGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UAbvGC61; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UAbvGC61"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso987417a91.3
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295514; x=1792900314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkV3g9p5RWCtmaVyEIk2+X1novLUQhh3QP4NEkjHPO0=;
        b=UAbvGC61xamJtIkzM8x2Z8j5lPIoE9E1YYKm89BH+5i7OYxImL2nAwAVGPVo6XI1M8
         M1OfJOZsT42CIpRJeg8CVq4RJZltGeJyTFuRTlar9JjqL7ShUJvJH84nwsCDdHDjk21C
         qkF6LpohDGtIYO1Qve6qldESqSX82xnp2UmcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295514; x=1792900314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkV3g9p5RWCtmaVyEIk2+X1novLUQhh3QP4NEkjHPO0=;
        b=I8nkHNGmEAZ+XajDohCfbOpRDSm8tb5pThEnRHZBCZwL8F6bs0mWqEW6dzfvhl5Ywe
         Vl2bRzFZGxVcORNAxl7+CztD0vzzG8crRAz+Aw1V2JU2wKt43kElFwUQzOeiHFt2VfyQ
         9KYP4rOKlew7C316D4xClMWxex6dH36FFE9/jJuLUxH3CaHjlHtuPlpOcqZNCTqg9PLo
         hoTI2c8YCNUwACDgssYir94mOuoho+GHYcrywUdcLI/ogpC1k8lTAE+5IUscmNpmWD9l
         GO/G250464M6Ki7f2mNb8lzyMi6hK6HdXpfY6dC7MCNvv1dZpRkMT8nvzM9zyfJvM8dn
         a5og==
X-Forwarded-Encrypted: i=1; AKwUvByxmCcJfxbDa/jPRwzU1iDjCeNqWZnVrhpjRTw3r5okG/x/ZeX7OMpUK/cqNkC4Jvu3TdUZtNQBpDdOjw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLBEppL5xekjZ+6RKqSiratAprgFw8JvUG4gnlYPdLHmgQENHLm
	puP2aNNm0oJXdACsB6UY+7pvNxmuRQrXch5eyAyTl7AuXs2xITRsQbAvnTWtpwrXIg/N1xqD2QF
	5p1c=
X-Gm-Gg: AYBFou3GL8d5KqeJxXS10VjV2zhWhQSkZRmZZihO5GT2DlJ6+wbvTIzwPHCK1sjYJ22
	FvWExTpJ3l6tlFMm9MpNcHZ4UEfL0HD6H4EUVr37Jukw/5AjFcM5K9fgYKmQNPKuEgWW/UKByzy
	Eagf+kveWauywYArpr++ygZGaat5MmCPszjdZmWl1A67OMP+J0itbmOjoQiNKt9NW8lQchGOCtc
	1x6ymgN+OUaRzXeIE7Mp5cPt4WG/PDMBExm8qRUhDhVHB03i0LC3D2OYxKpgHjtBTX0yV7oWbJ/
	YI1Au6d9ASMLM7TSftyVXh87Dcxah2ZbmrMIQwOJeB6SW9uYnlJ5gm6mdRC+jDLJZS0Xj3/C192
	Ung5CTiMpITR1X+w4UfW0oxP3H0jhBG3avFQvshVbL3Asz6H3azHd5ixTKtlyCznTIrduBUaqqd
	letuC5NDFIO9CbNiLgDqf83ruamqoQT8JUYrfpSV2qgV6C5RYUnE494B1RAwJq8oBec2moulY+B
	YpBptntLp9x2BeIqDI669tGuynE/SwVpHbOHlAIDyN/E7dwR/EuWhFiJrO34C4=
X-Received: by 2002:a17:90b:55cd:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3acef101a73mr3668360a91.12.1792295514356;
        Sat, 17 Oct 2026 20:51:54 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:52 -0700 (PDT)
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
Subject: [PATCH v5 05/13] zram: lz4: use LZ4_decompress_safe_usingDict()
Date: Sun, 18 Oct 2026 12:51:07 +0900
Message-ID: <20261018035125.3120704-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
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
2.56.0.176.g3575e65682-goog

