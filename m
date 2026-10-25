Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894747;
	b=gT/C1dgLz+a30j0T0lPu3xVPOGepKurn4HAL0dUvrrZNCI3bDGfrz89IV+GjyePWWS+Y
	 fvDYvAtcWnb2qMtCMzEGqAvXJvYx0XO457gjcVXaPqXTgxk5r2adMC/63nUEeNBO5uZXB
	 XG6okKIsiaA3vLbImf1mDmTdeh69Rpq/OffFXPMioRYyXxfy5srGQ6JjDnHPGzmrpIc+v
	 NiJfESwl7O17Qpc94ZqNaiL0ZAAToMmcLw/+c1edEMGcvVw2G/J7/SF/29QzZrI8UdeTe
	 lLikuPf85MuTZXw4NO/6OfifjM2/OiVmoF8Q6gJHCqrrBsPJMILWm4WdmFPDncl0dqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RXHOVm+rIyaOTo+cKj9ItrXebJiPbXZO152D86F4tDg=;
	b=qZmP2jjgAyGF/nGH7EJZZeKQSATtmlpGEQIH4yJxh6HjjsvcmGB7Efist7sMM85RlQd4
	 svQLuIAn/nczetwq2bvWLcktiz2mHMe+FKieCBvJthh/iBqS4swUnPGIJxyzTkL//F2I1
	 rgDEVq9bm8/6riViR2l9KrFUj5jKS6Bc9L4OjGhkuq5ysx0F913yGTMOVpisEdPPJzNt3
	 m949PobMhMmwgViz4mJy1usdK4OkT8bcyRiDA2Uz+3eWgT+vbMNoFeGKc5rPO1L2jeyTI
	 SDKOsvhC/ITFa6hCKcv4dwFRI6t9qMzc+fv17f4ncNc7tdv+sJ4fyz9TqwWLZFqls9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DQGBVhMh;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3A606A335
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB3A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DQGBVhMh
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-369f33df08eso700062eec.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894746; x=1793499546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXHOVm+rIyaOTo+cKj9ItrXebJiPbXZO152D86F4tDg=;
        b=DQGBVhMhTzt8Ap5XQC2lsAh1r1AGAKm8M9N5xB0Vm/ti7r/dm1Gd8whg9Gmew3uZ6n
         7o2/LzMyaS9nZD6vIR7pNIV+sXQkc/6PsfP/LyGo0jGf6Wt5846U1/XA8C/nL81So933
         ZKMroBFLFAmY3ivlExVmLg2ha1I8qeZnkiBOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894746; x=1793499546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXHOVm+rIyaOTo+cKj9ItrXebJiPbXZO152D86F4tDg=;
        b=Lv5zfJFv4/lo9MrHx2Klse7WrINTPi/SdpcAoTrUhMAep+bMCWme4Q4dCbmNIGgVhM
         7kDqNXtWMBpngMcaAyBdo4I0ippGhWbwpArJ878u64bHX5jf0CcKFiW7iIThuwl1p089
         yFKkGXVkwHJGqI5wjIkAczNtzCrvpNJPICwsP5cyQ9Qt/lOieApLD0rfTNcytCAyn/pZ
         C1wSBtKKEnIXefa1Y2L/OVY0yEB1VNTYWUKlk6j8AsEX4vondmdb3bvvbltZNG3VaJFL
         fpt+JTB6febCxZXPERieinVBv17kPUTDWbMieWfMcQA6hpWxtmZ89FEPTxV7i/f3kz1J
         JGVw==
X-Forwarded-Encrypted: i=1; AKwUvBwtTS3f92aO7xT0iujj7xJBPfjHf8jyObsCS+DKqR9P7V0aUIK1Eo6xCzv9rHd5lDfw29VdXJ6fhf30UA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJIEAj1yUazne/RJDg3FKq2NTGBacYU20x0fVB7l8fZ3jzrRBqj
	a5rZ1mOvC7GmmJtkrBdA0i2+54ankf8hRY8aj0uGLQrKd6H10OmZXGbbIesDRB7J5w==
X-Gm-Gg: AYBFou019jLaUA/7QYYh7Ocl50e+77fKo3chKpn/nNCep8asWcALA5CAo7fUxZL5jWG
	eFojghlCP/IAVn77OU5m2m/UUrM85VTLwQXwCrD5oGTxUdzUm5ucZQJX8luyUzOIykTUjZCRHTV
	gIECBdR2YonWOJBpuGEVVH5HWK2f/MY7fiMjytfZZyPr7r+BKjBiOjcYD36i7x9DJPQVCzNEusG
	oPwTmYeG9slKwKDuatWz0JMplHFibdod2GOcAp87JgwUhay3YDDHeybznBVmEc7pLs88rAmniqL
	e8iKjKQLBn6EC8QBn9TCWOvvZd2m7K0okZOAAa3LkrUzxmY5n+NyQ2KIzUrHxxfeQ87dHSE8sUD
	M40+2Wf8GNslwo6SyWtTxifgeUrhiTlkLOfL97EsBXHAY3PlSopeWrml8tsTpK6XEquXofD/5BF
	bG1nyOoQJwdRAoYr96y6UdzOdZ1qqWz0bJToB8++s1LaENNkbPn50iCgh53JHEcX7CgjSbChuwW
	6ryOVcnuvkQxQu6q7HajkgrKLWfksXa/HIUVqJlOVYFoG79SjhswbSmvgZAhUK3mJOrUIoZd68H
	U6XODwVuu0O1QoUO0FAwFxZQiHl/41IqRXUymfrcYXtF
X-Received: by 2002:a05:701b:205c:10b0:155:7721:3a4c with SMTP id a92af1059eb24-19936d400e6mr4672343c88.35.1792894745835;
        Sat, 24 Oct 2026 19:19:05 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:19:05 -0700 (PDT)
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
Subject: [PATCH v7 09/15] zram: lz4hc: use LZ4_decompress_safe_usingDict()
Date: Sun, 25 Oct 2026 11:18:25 +0900
Message-ID: <20261025021839.1542805-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
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
2.56.0.257.gf7497c7d27-goog

