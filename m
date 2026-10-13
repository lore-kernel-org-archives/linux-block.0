Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7D47FB00
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863547; cv=none; b=RzYA9WA2zDnsFfs9Kh4hvC8PUMCpQEURlbaT/coWkNxsYchEgYHhkVCc6SfjO9Aic9HdoFXkeO8Yj0GaxJ03uIvWQ45jsv1ZFg6gm7b+W1iVNiGWOriyYsumUYwI4GJ3C3aQQOLKn7OmS8r1MJTe9O9YP8/3SIO3xGCSbfCr1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863547; c=relaxed/simple;
	bh=TU+o1M2qUaATbEC3JOT57XdbKNrddPj6NB1S8xycGfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/vleSKtk7768P7ArzeE7hloOxwpnDNuCmqQk/l2cF25mvildegz9yFSAYBBVLxfymNWIQGCvmUnaVY/cnzcQHrBoa1ybG6jxYD0MPJ0VnfMXnoM6CryPzZ+TCS2RxbWMUfhRXL/qiuSHAc0iuMU1SAmEB2+cAA+RHFwh7AXyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgdbxvVX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgdbxvVX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8819033dbadso1496689b3a.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863545; x=1792468345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vDwGnfli5YECfAaBIHPOmEI8frIPb+i30TwuUetq8U=;
        b=jgdbxvVXfLP7A5diXcx7XJkKcPps7Umw3b9hFkc+Z4ebiEeVmrLsNlHTjHpMPFJtzm
         jsSN+jfegGKw8Ea2gcIfJHIvYY3wlmBnfW0knzUDSC5sNVMEIV0MHD5mU8iLXOlM6zxr
         HIvxuqgziUDlO8JKJLrrecidS5mSYCwoOFBMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863545; x=1792468345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vDwGnfli5YECfAaBIHPOmEI8frIPb+i30TwuUetq8U=;
        b=0DEI7GpsBp8zoZmkp/aPdOHFLws08y0imGlfuaHuvw9BjsOSXcb5h8O9miaE5r2Wgc
         Jl8lHB6at033Pg2AUXZ2ijpHUWq5UrJGMs1zqUWyRkk6iQ6ZHyfLTl3tbniCNvJOCxnh
         MNbFYzT/r4v4oLYZG1CCJsPFlILk9wCSVOTOvGz8Z8Jdo4lC/uE9rVsfV4Q2r6YvC8bw
         oUTMmHbNHibSG4mzyhULxHMva4m/ROuXuRF2sTd6p1ghS2VCVqzbHiaQ4f/7SfSf7qAm
         J0bTbLL+7kPPEq4ImP3tayoQdWHYr8t9aJ8Uw+NX/WZclqP8IDZOGruISR88VNsGmKsH
         OsHA==
X-Forwarded-Encrypted: i=1; AKwUvByri2nE0ErmiZaYglH3TlJpFgJ8Ymq7RqbHxCD5PHid6TLjwfs/ll6lnUPC6lQ/sjLanCtc3AmdaWh11g==@vger.kernel.org
X-Gm-Message-State: AFq9FYItS60VPonrXWVlpgHpCoVamtqg7bLxCj/BZq0O/L0N8LsGSZYe
	KcPp8oX3DFnoFzc2+LUxe3V/Jnqt0JHC9YDZ0Ni0/P9eFPfSBRjChK79iUBIS5DiHw==
X-Gm-Gg: AYBFou1Kl6yUjS202TxutJgYAIrLnvgWDgjuYDZR7s1FI5ttGGNjcDcNxQ1iKrAqri0
	00Q2HOBDIhYUWYLPLynLCMo/SbT60I6++lZXNrwTazmOC+VQhzN45tuoQEl/Bq6+LLhZbRq3+Oi
	dKYXgbMFQMxTvnk6aRjsvftOm6xDmwEgbKYTzsmZWvyv70aHcR1o6MoZkTioWruIYfXhESux0+u
	Tvx2EZE4zh+UcALJaPhJYnzc3Q5qng1ul3ejJUAFetDPPLzJW21dEvkm32pcemrHcXojmvF+jKl
	xTNaaVPDtqGOswFcM44aMtNtlqiBZjAx6Klmqv6DdFfUrMMN28MTCnDJg2JzLGosGWMUymaIsUN
	rgonrdrAkTUKv7SyVRHEHWZdBtn/UeF/sh1wXN4I65z/QI11ZZRruSpuXZEQMXDsn26q4p3goqK
	KcRx+fKyDF0T5fnXgQ6bE0At0ZZpO6UXdQdGwQ7SuffPc0BBibMQOEli4JsJ9HLn8X47zHvpizQ
	CJ0K1mwD8CFhFzxKLJGVup3WxzHCB/hqt4KZpMKzS7NopoqqRIEvfi3Kv8fzNfX93ewPZJX
X-Received: by 2002:a05:6a00:2181:b0:893:8a6:3801 with SMTP id d2e1a72fcca58-897c6c24863mr9821862b3a.24.1791863545329;
        Mon, 12 Oct 2026 20:52:25 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:24 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 06/11] zram: lz4hc: use LZ4_decompress_safe_usingDict()
Date: Tue, 13 Oct 2026 12:50:53 +0900
Message-ID: <20261013035201.2809924-7-senozhatsky@chromium.org>
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
2.56.0.385.gd3acb90ef8-goog

