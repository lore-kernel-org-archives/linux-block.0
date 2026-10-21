Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550582;
	b=wp3fGpM0vMSFInrcw6eoQXi9X7Jxuz+7GhCudGSnwXw5FHXB0wLvh7D9YEBxBaIqFm8f
	 B18QEuPJd3/dHr6vdoGEwBQT2P42ruRVV1XaNSPoDQPcppYYiLthKypovJHG+dhBui7HA
	 xYSL1sZ95CpB4ikFK73h4J52drC3C+8mAl1PEy3PrTllaZ5Qm5UFO5ePlMZx4P5Ezihv7
	 TpFaSVnTAwT3sS4PLmcH8it5nHdAFDxDiCXK4rCXJBHcZrg9KCj1sJEwrUTJQh8wSJlrs
	 rFbwlNXqJrhF57FxLE/WCEcA3JjOWMrb+TUXsGVtUou2NTMMptucJTPQEyH74BCkRfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iK8xJeVT2HjyR4JlAaVJiBB2ezLNdeGOL3THtl93coY=;
	b=nyjcd9aL09IFYp39/V4zMWAD9KrnZz/kRIzFZqGqYIE4wu7hVDYQVfoLaEp3uKFQ5s/s
	 SHUoLClMvXQ3iQ9RzLxvHl5F67FNGlZm0fKbGwFqsY1uTW/PW9yu9atH4kWy17cw9d4E1
	 Zg1nAT4eiEGMYhRbNs7kYP045u6Sv73JjJxoNq42xYMLdd/2ZwFdJNIbr+U9biebRhrsc
	 meWWgr8HabmKfqqY8ntYpN076lmSLJf/yRap+hcYsl08ehOELYdzAawTQrHAg0b8xWxR4
	 a5UIx9OzTAnsLBgwLPGpqIVhghRsJowzYs/SyDUZpdTLBlLpPhkjsTBRTd94fflX1yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TrQYpZtA;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D65606A32A
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D65606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TrQYpZtA
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so346954c88.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550581; x=1793155381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iK8xJeVT2HjyR4JlAaVJiBB2ezLNdeGOL3THtl93coY=;
        b=TrQYpZtAdhdUAHxLtUOlXS/NNMuGm56WCkDzVmerEs+RbcNCzVdvaMYSjbS8XruX0I
         +xvo7u8prZh5yauRQgkNgcIxxjD1NQl2mrADpwU3HcYt+pUlyMHa48CjfzUL73vo00a8
         ERM5RU0lqUktr1GowYh7nro3taLA9mXtpj2uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550581; x=1793155381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iK8xJeVT2HjyR4JlAaVJiBB2ezLNdeGOL3THtl93coY=;
        b=xXHlX1Bni8qfMZ06LLQnMG9Z13LQqAvtOjSJNgingHpdZ1kmFydjlROD0zhvnneSDR
         YzV1iTSUpqUyHAO6z6/59Y/06Q6dR9kzX5Qe9Z5VTzfC1IQ0U8BqqEKyoXvN43TBmKZH
         XWl+rB6jW2EZazK9vli5UBZJGXMi1lerCWK25ux7MTWi5lRkyWNACPg4l8S5+XjnmPxv
         TsSk+DSSOrWhOYyXJl2SL0AMio3oDQL/iHFEYujSxyF+jPSp9N+/GaAqKfRATl1jqoRt
         OZHnre39uJksM4n4Q8KO4oxjG6daAYxbXrMkJtCS6BbTkktKlXka7uJjqQLAdGpTWsU8
         Qfew==
X-Forwarded-Encrypted: i=1; AKwUvBx1dXKjqd5Or+PBU8BXGAiPidrxnCcyuz4DniZLaBWWe2eXfIjFpBJvD/HiLQYbwtNrYtDcfuEHBrvSDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYId21UeJb/xI8OGxeJ3XONzg0zlh7y0GszigPILqJY/WT7cUQXp
	Zau4EXxluZ3KuiOqLnjo9CdzneztpVk0/aqO6HQLa070fNBbQOnWr9nsPGoHSBvjSA==
X-Gm-Gg: AYBFou3YsCaPA4Y5UWzHK29GAW3voAEeNKn6vdIPCnxDfw9rcXlkS1MiC4P7A5NTAK6
	2auqBncIeK5UeAtqCwPp2x12wcxVCAaPC/Oyrg9v8/M0z1QYSTi8yuNcAsPueC5DRJZXSLQEJQ+
	Ryj7BS2f9pI1QWTEFXHa8criQMznXxUwMyG9mcbAqXYEIVB10oY2p70Gmv/UG7TJZKoUFEIs6o4
	JKMKZnY5kHasF1ECFndarUK9jb2hYzEPKuuy5Kw1Q8yG6ky7ywmpY1nOHYbgJw0DMno+bjl/u9q
	T87hpPuLHcK7ZRIcvEPIx7kZ4b0/GYj7MFvVVYZrfTL/6+L1HQgyFjaeQQN7p076viZUEExbloi
	HPpKx6sp1UTS8ou90LU7yx0j2rZCd/HQkAkwgnzFfZKAizNgaFAuTySfTxvNviqYjioF2wamcPl
	OagFmg9Lefum6c25PZTfdw2JFHkN/ELJqPlsWWT8epgz5No3SyFdvJVfQP4MxtYqneaV1hr5s/G
	MnNN6nbdUU7M2ZVBK+QJxSqscuv6wAg8n4SKRiAAmc3kiCFC61aQ8ylHgxaPXxRtgtQsP9FtbC2
	mZj6TatYD/TWZSo5QUlliXr42iefEfZwmuf+XXPnQt/G
X-Received: by 2002:a05:7022:b905:b0:143:2968:564c with SMTP id a92af1059eb24-190a67fa14bmr804644c88.26.1792550580717;
        Tue, 20 Oct 2026 19:43:00 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:43:00 -0700 (PDT)
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
Subject: [PATCH v6 06/13] zram: lz4: use LZ4_decompress_safe_usingDict()
Date: Wed, 21 Oct 2026 11:42:16 +0900
Message-ID: <20261021024236.1787884-7-senozhatsky@chromium.org>
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
2.56.0.212.g129ede20d9-goog

