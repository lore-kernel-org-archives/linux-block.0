Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EC3B4EB3
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125896; cv=none; b=Oi3BIKo7yUM9MYdO/M5ES9SW/cbYkV6dftcVtyPC849GLmN39aMqfHWuHvfdGkh8ybiKR7WRmXY6azmXXFPci53GtKJISwEWRmN5UFTJh0GMIMcn4/by/Np4NT6XR06RmIEgHOCQaQEQpBWF6wWHgr6JYhlyC4Rhmeb+EnKCtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125896; c=relaxed/simple;
	bh=Vi/sR9UBL3IE405tG8zRS6aqkD7d5j5shZvamUz/8as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijbUirJBoBP3eX+TPXqmIRv7b3wDk5bKU47SI2qH2vrHeMoc7doXxzEcZQ15OF0lK680vzGok6VuVFXv92s7z0sMgWQzWNjU2dQpH3zRyoOuY+24mL6pg6t8/n7ikGq6mx/I4ytOZovm3fHceXmzWM8yzhroHOmPdmcTqz6GSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nDGsJizY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nDGsJizY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8fe8e343fso25752935ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125893; x=1792730693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXRdAMjjFZfXtnEnr4dqDWWhcOJ/4Lnn/GYCEcpDeYg=;
        b=nDGsJizYp/Ltpa5yx8nDnfVBPMwr/G3Q4zFNv22BPNSkd7ZYot8+nn1TFTNpLY41AM
         mz0PPh6M0p0IY1D8bonWpN4roDGUCid4RJEVa5p9a1YBaKM/ahDduJacq46KIexIYac0
         wVW25Br7WLnQlYZ53Xfax8YdETHwpF4ckC6qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125893; x=1792730693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXRdAMjjFZfXtnEnr4dqDWWhcOJ/4Lnn/GYCEcpDeYg=;
        b=nyDWDEtxYcANkU8CG2eqFISaCoEijyc/B3pEgw1Dpc81odFQIKu5ZWvHU4PkV0LOx5
         9ktXSGvEDUdkoZfr/1WyPIUD+srSCiaAAecwZQSi2kOUOsXDecAD6iMNB/JNDoKfHFU3
         dodpTiAvChpI1J7HMQdUeEDe8Vu9hQGbrPGedr8/qec2oXFcopjY36obcQpwtJRuTRyD
         qjASy7qTO6FRwYnBdgsL3en4kdFamgUljSShSBdZuXZvyAc2c+WQRKwtSGsk/CRP/pWg
         7N1TNfOWrjOjVYnT9We3B5oeUbZGXBdBANUK7UuYhVCOlkLBeC19ndw1tSZYBsiSjRND
         JnPQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0zTPQ8DWFf/JkgWphYk7J3YkP+tzrAL2SaR58p6kwZKJ8rKUJmVYR4ehBJ/wmCvxaLKUjejR1/iM05g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOMFfJA8C3zs4/BBNZrhpvciS9MLIkjW9GiZQoo1luDec142eK
	kRW9Su73ede3CxM2+bXKNN1Va7SR5NV1dZSYYwRqNn761aRZ/GgarT6e0bxHOWy4LQ==
X-Gm-Gg: AYBFou1jU7iDbWqTuF+KJmU/93feGVhHY4U8q0RhDrD2GkZrs2J5huydUDbeCSfSl+X
	ohlISQKQjTjPmnN88+ViX1Upn2Noil5vWeCgrtbZSNWAn2CAIa+bfN+P4G1ZHJ3kcZdQxNxdWbS
	qBgG39pNfXtbGClgWXUDAOF8B+TZ206lR36SACfl1WzPOcM6v6hmAlfilTUzMRPuDlC2QwNhaG9
	EXyxLLzN0WTVtR5mvEUtPNq8ooYpdeg+KbJojKQJH1Wy1NisWdDU/kzekYWPEICu9OrA/4dQr6A
	ZxZX8SVgPkYyvRpJglSN+2nHa5UsJ835hCzX59pv+QLuUBXBgWdJk/IX9vUP3arEpSk6bNKk9vs
	3mHzvgCCoWFNUYubvYHNoa5xPKmB/GYXdNTlLrLN258EzCY0TXBsxD95iyY6aSgrtzLv7h76Lq8
	shlo+739KQs5nrWBG5FUrJOxa9WffzPo+kOp79NaQ1Rz30ueSQXhY9nwj+gHfYAeM3x9a43uSC3
	0P7EB/MGjZZNDCTFfLLL77fJXCZnTi4BgeFtPIbkV3HtvEnfxjL8bZ7xJbO/VM=
X-Received: by 2002:a17:903:2ac4:b0:2e8:1c7b:3b6e with SMTP id d9443c01a7336-2e933775c8amr70192855ad.26.1792125893414;
        Thu, 15 Oct 2026 21:44:53 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:50 -0700 (PDT)
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
Subject: [PATCH v4 06/12] zram: lz4hc: use LZ4_decompress_safe_usingDict()
Date: Fri, 16 Oct 2026 13:44:11 +0900
Message-ID: <20261016044429.1304561-7-senozhatsky@chromium.org>
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
2.56.0.176.g3575e65682-goog

