Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550584;
	b=5EtSOJl+gPY9sKxLW7xpeDHQNlWWMljnTzwZNnEhoC8efnT+rqzxp8mXkoX26x6b9mF4
	 h5RfGZw0gC+8lfK2p9693LlaCy1yu92Fq6l4qWD6W6hRhLpzihiLYd/Efh75m39WihGr/
	 dEGkjEu9HHG8OwMm96q3y0Wm7NI1h9svuNDuYjm7Rkdl+EFfKUfPiaem3G9SM/SeuvNJI
	 LC+RmaxXdVK3cVobj4fZITYjQ1VBl27WtOxhm2FJVYcP8BV7NNYNlwqTWy/0k3BVWe16W
	 xSCjaJN3tN78Axo05HUvAU/rriAZIeDqHkxrJc80XufNd1+fAs18Rt58WanvF8ATzVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yzRBudk57Qqbwf1gK+hPpqIGBBSPqnwfDQYwkBHugqY=;
	b=csF57RMqEehj0r77szvmEaCz/NEjpWa6YnL2iuhOcMWvSDM+JMyIG/q7aQprdUjVnXB1
	 chYIQAwvK8ep+5aWn3uqdZsMBucldgKQbAyTcHC8kuKhLqzCTU9r678K/FwzDnQSCrk02
	 0FjbdK4efyy/ATatvhMsOggA4Gf6wwxTFmYLNTSt0mtTK5TpnVmG9O3ceSxHE5FLhC2pC
	 81bUpDW6pG8F9N17jTOB/V/hMSDXGRnZWkBo30yvKYMWtMCQXU3ku+rEtdnSqATJPpDox
	 2kOeXh+Cc6rP+PMIyuv4jCsD6uWsQf2sglAw2kUmmyiDY4gE3Le0eWSQ8aCKRB3yf5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HJ3Lw7Yf;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130460A2602
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7130460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HJ3Lw7Yf
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so567524eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550583; x=1793155383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzRBudk57Qqbwf1gK+hPpqIGBBSPqnwfDQYwkBHugqY=;
        b=HJ3Lw7YfwGBoTvGBNw8t0sKdOHgcxhoWn17MW+rRnlh6TCkYg1s7GwD+aFp+VUqdct
         rZtZz3KL76MnGz9K+VPfX3ciZX+9WDxel4m5iZrFcn7G4rC1NEPBN7Q/NGweaeSP5JP8
         9/Q24LojPDD40DqWiCL2vIBKwsbKdKBsaRbu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550583; x=1793155383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzRBudk57Qqbwf1gK+hPpqIGBBSPqnwfDQYwkBHugqY=;
        b=vI7KyuA97+i8yQ+eVdmk6UaUj/htX1GZA4b07vmEBsiPJ8U43j+cfFDI/gTICQDpnu
         itYTL3VgWbS00SWZ1JiotD0zMw2RVrqRNYmIgEawAJaBeF4qWeu/rw+YV4qQs3HzhS8L
         nPdc9DIGaI14g4J0p+0gCfSN+3GJjFFc5ZOdYDin+JPMDYW+jMWWObtZEdOOkQvEeaSn
         TUNHvAqRUsleEJH4CwJRjS8O7Iuf9ZXBAvmwwWje09uHXqUkawHs85ylOScI8RCScyQ6
         iF/XFNrmkQdN1qVtVNtjDqYj7XOzE1MCY/M4POSooPP8Hg9ucix7fj5txyn6kfqvwrjZ
         9TuQ==
X-Forwarded-Encrypted: i=1; AKwUvByws/7P/qYX3FWr5dWMQpQRxsveofWy4qIIm0TyH5hMQEL/kOzogDYsrSJ3pjd5pVHml21eed1hl+6fuw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ55MjtOBFbO8odHiwLNkxPyx6ST4rkiQTGXtX+BGgSaCf6tBFo
	5Y2I86L8O/Co6NrMEKp3rjD1DxmT/D8SXYev11VQJzefqHnp7cfhwMngHOAt2wHvQg/j2mwpjTX
	uOh0=
X-Gm-Gg: AYBFou2ghBs2y9NCziVgN/ARSbrO7/BtRAonZSoIwtG5pCX7u9xYiSC+l/XTAwGtnZ/
	h20qPa5JWki6S4BWgNvPPPH2WFvMvNMQ6yYsRGkVNMTPRWkvc3NpTaO0cLgxd9QSgKjmiYKX9cr
	abi4qrOe+rGmM4YXtEKS62AUlEFf70Oz5TnytYV5R44MapXL4xG9406USJfIHHloKnZtQIP/Z7X
	l8/Ut4gRTurQzXzWGQ3LpUJhULmEk4sAnC8Fwr9CAEkiBWjgFML8q1Rp+pVvWgBngPt0qo8JmIZ
	ezBPXbREAH6MQ5plpeJSTkco9SZghw1KT2T7FH4sBykncnj+H1IZt81u8WvkPql3ZP2Z56Awq/2
	853TX6Vt0UVEPUIt7jyoqYoPu2Y8Fz9bNR910tYynpg7VA0Rz9mzp373O2tsx+FuJL3nHkNPXBW
	0bm+vsjLcfDG4u5EEjI19x7YFfOagvJK9ycwsSXh2TV6/+FZ24PXivxNX0vdmigUpv7jKBnvxqb
	gPCvlb2bVLMkgwf3E0YyL64q1e44jWChyMs03MuXdFU+fEbuAx95jZXOJ3AKeFAfshLVUHl2ia+
	5q8CJV+uc2B5cqBpIDfHukQJJhbQFtVX0rF7nIYBVqP2KdypB46om/lRh7jR2gFRgQ==
X-Received: by 2002:a05:701b:2402:b0:187:eb7f:bb4 with SMTP id a92af1059eb24-190a794290fmr879686c88.46.1792550583525;
        Tue, 20 Oct 2026 19:43:03 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:43:03 -0700 (PDT)
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
Subject: [PATCH v6 07/13] zram: lz4hc: use LZ4_decompress_safe_usingDict()
Date: Wed, 21 Oct 2026 11:42:17 +0900
Message-ID: <20261021024236.1787884-8-senozhatsky@chromium.org>
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

Use LZ4_decompress_safe_usingDict() in lz4hc_decompress() so we don't
need per-CPU LZ4_streamDecode_t anymore.  This also lets us drop
struct lz4hc_ctx and keep compression workspace in ctx->context, just
like backend_lz4 does.

Using vmalloc(LZ4HC_MEM_COMPRESS) instead of kzalloc() for cstrm when a
dictionary is configured also avoids power-of-2 page rounding (~256 KB
rounded up to 512 KB), saving ~252 KB per CPU.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 70 +++++-------------------------
 1 file changed, 11 insertions(+), 59 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f3656c27af21..b62736b26622 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -4,18 +4,10 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
-#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 #include "backend_lz4hc.h"
 
-struct lz4hc_ctx {
-	void *mem;
-
-	LZ4_streamDecode_t *dstrm;
-	LZ4_streamHC_t *cstrm;
-};
-
 static void lz4hc_release_params(struct zcomp_params *params)
 {
 	LZ4_streamHC_t *dict_stream = params->drv_data;
@@ -65,61 +57,32 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 
 static void lz4hc_destroy(struct zcomp_ctx *ctx)
 {
-	struct lz4hc_ctx *zctx = ctx->context;
-
-	if (!zctx)
-		return;
-
-	kfree(zctx->dstrm);
-	kfree(zctx->cstrm);
-	vfree(zctx->mem);
-	kfree(zctx);
+	vfree(ctx->context);
 }
 
 static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4hc_ctx *zctx;
+	BUILD_BUG_ON(sizeof(LZ4_streamHC_t) != LZ4HC_MEM_COMPRESS);
 
-	zctx = kzalloc_obj(*zctx);
-	if (!zctx)
+	ctx->context = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->context)
 		return -ENOMEM;
-
-	ctx->context = zctx;
-	if (params->dict_sz == 0) {
-		zctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
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
-	lz4hc_destroy(ctx);
-	return -EINVAL;
 }
 
 static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req)
 {
-	struct lz4hc_ctx *zctx = ctx->context;
 	int ret;
 
-	if (!zctx->cstrm) {
+	if (!params->drv_data) {
 		ret = LZ4_compress_HC(req->src, req->dst, req->src_len,
 				      req->dst_len, params->level,
-				      zctx->mem);
+				      ctx->context);
 	} else {
 		/* Cstrm needs to be reset */
-		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
-		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
+		memcpy(ctx->context, params->drv_data, sizeof(LZ4_streamHC_t));
+		ret = LZ4_compress_HC_continue(ctx->context, req->src, req->dst,
 					       req->src_len, req->dst_len);
 	}
 	if (!ret)
@@ -131,22 +94,11 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			    struct zcomp_req *req)
 {
-	struct lz4hc_ctx *zctx = ctx->context;
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
2.56.0.212.g129ede20d9-goog

