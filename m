Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C63B27F4
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125890; cv=none; b=FQ01KjQMqHddqWWAGih2btsFSxeLpPCHycZ8O2DIz0VFi9pJ3LI4prUuIqLIoZyb0dUEUuLAm5Q7IswvdHpoc44OOUlmjGKBcMUeZRU7tITB9zNi7yLWQb+/5zWUMKteEtnvxF0yxW2A8/EpBUU+X5HQqZOQpLCbGaaiWW57Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125890; c=relaxed/simple;
	bh=nEbEeobJbXktuzOILSBD1n+yXckgTMekzcgJoY8hHy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIWNFQTic2Rmnw6ZL1CRnvV5m+S7hVhOnc5pgdBJhW59cBrGUf3mO0HDSILEmAKDHxPQFyOyg8iQgkiGSH95mc+QiUMZt7ovo5iH685na04diNATy6iSSyzgyeG+ybVM6WMCnZYP0WfgnN5tm22mLUCK/aZG463zrxqLzMfzAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uq5/cUV4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uq5/cUV4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e5378b281aso34533175ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125889; x=1792730689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkV3g9p5RWCtmaVyEIk2+X1novLUQhh3QP4NEkjHPO0=;
        b=Uq5/cUV4yDXS9WPLnUn7hDQtjMuim/do6kJ2OK3Ivm+TvxuottVRN8Ye5RmzmzE5Nz
         OXUYiSW91rKkYAj1ycevLFn4ydqEq3NBqBUn5cA2faDUpTcw2G1k+I2G0qfswIf7SWq3
         CZN6CgQ33a0J0sUEEMCXh1OFOuYqBbSGyoDOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125889; x=1792730689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkV3g9p5RWCtmaVyEIk2+X1novLUQhh3QP4NEkjHPO0=;
        b=BL5UGPXNCMLpKD0Yp7FKt13ZjvBKtApUVwVsrPJz9QRD54ByQRP13EdAqmmUozi9Uy
         CRjAVltqm2SKoGNfnTBcdCAoetE1hvBB0WqZ3bHfi2wAgyfSsAE5zBnTdvFWUXFbdsXU
         eq57MiKcWVCbRxwJMWzS5QZz9RJtyxkeVaw2ROqjs4P3l9jnBDotZk/9qFS1KSRjBL5r
         byIV9Lk7annptJUKsqsWplR7O2XT5KGYY38rAZdMzmxEq4Ldbhc9r7KO1AlVOVl8b0V8
         Kd2JO+PpG1+bjclc8n1nn+VVi1Mj/5yEweINpL3SycgtHSvHetAyp0IPXqDoR56N49ld
         +4sg==
X-Forwarded-Encrypted: i=1; AKwUvBxzk5w0qNmC7we4mMz7cyozGtxIWzcENJ76wqunrUrIfzBnP6AUULYN47eIKaQp8P6moL3BaTkc4iVMOg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKY/Cs8ZN1ZSDNWpPLmksXYn3hb5e6gJF4EbX8aHONA45GejBKs
	xo5Dboddn95lJtLk/2K3sWzHPU2sPbkzJCxCgH3H9idtGi4PNaPh/VMpvv5egID4b1/23c544Sk
	uhBA=
X-Gm-Gg: AYBFou12EM39r0BjKDcEyCCfwfGbWNFKZMU3P3OrgazACDXXGjU9ijUqkHJQx/WBGzj
	9IVKCV7BQhqLie58TY2n2I5Xy4N42Bp0wOTzNj4ohe0azu3TKYTlnNAAjclprbWc9RlJ4a9DjDf
	EIXzmbLtWeRxEjYTHuDvtg639QExvgMCJEAh+civfkUDZ6urypilwLWfh+C3x2+W4yvGkm6og4b
	WvLHM24bhNwRz+O+6HvbF5qR9XeUccKkJDkYb8ZJOFw0M2Zfv0bSS7bRZM6ubW73BNeC35mj0AT
	Eavu5CHrLy7UblYLfuJozTmHVU9X+HrDCmKcVWoefT2hlAfspM/AKVOMQSowu3iG4YvLL/AidQ9
	WVb0KwRBSr7Ke2Bc1NbrRDyoKAgZR6l6/94xGSGtagbPwtqJgTMqUZoZphoDLkIV4WaS/7Wilq1
	DkKvrcAj/Ym8ndxH4ZAEFyX4mw6l5Vj+l3OVE5n/NRsc8Kx7GjeP53F5b1jFjdCx7qFZmED4g35
	zWSH4V9n7bhW7/nCMoI6sIIGjdeTGJNt7BtMMRFd7SKfjUrZEzbn0SAfAFWqyE=
X-Received: by 2002:a17:902:fd8c:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2e948deee77mr60342135ad.7.1792125888837;
        Thu, 15 Oct 2026 21:44:48 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:48 -0700 (PDT)
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
Subject: [PATCH v4 05/12] zram: lz4: use LZ4_decompress_safe_usingDict()
Date: Fri, 16 Oct 2026 13:44:10 +0900
Message-ID: <20261016044429.1304561-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
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

