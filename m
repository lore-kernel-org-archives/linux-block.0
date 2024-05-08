Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2817EF04
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154203; cv=none; b=b3q+GVeLkcYP/sZ218yUMjnPDBIj0qkF06apTmVYCYp19z+MqDjy27rtffrZ8I38Ys5PPsUwIK9U1o3TRECDLjcnkCpvUK1dUBuxekD0n/X4nAfpKZVjF8n+VhOmNxetdlUGBrhf0m7SjYslVJ1e63Lxwuj126SDeBQjDy9rkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154203; c=relaxed/simple;
	bh=OdhpOTFPCVgN2eccjlEO6kqeLVB903rqR/qnsmX6Lno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyEoOuCs8yVzX7CRi+k2u6KpFbX8UeFleFN2Wi1xFmhyzlHPNh9Vs8GlzaAu0xipIrXUPA6RBcnmIyF/Hoaw09bc6Radd+OW/gpoYVQ5N2yYtiMAZOgLaslmhvDmTVbdaEQ17TUWdgI8xTbXrr/tfv7t89O+gQaSGxPstGeiIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVQ50cfY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVQ50cfY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so3010227a12.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154201; x=1715759001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QxTKxxqM9CCOnK78l26rfPlNmUT2j4/F00viIdsP1A=;
        b=ZVQ50cfYfOoOS1C06wSLvbD8nXRkfN6+5b/J3wznnKRRPcaFs9JMLJJ1IiG3pFMh/1
         8r+wMHNvYF+MyeuElNBzYEdXoRezPpTw1c03b6CCVRolr6JE/1W1/SM8BdcNublhB6h4
         +KvkFUo1mMINPGHBzqa3UHIoqHSC/4dUP7NEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154201; x=1715759001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QxTKxxqM9CCOnK78l26rfPlNmUT2j4/F00viIdsP1A=;
        b=fwG2arBu1zzURPPH/xQE4ocgPvfJAnj4oXOAtAt8250okzO6ocQnJFo8IBBXjyRKnn
         xznNk8octOppcinWHYkvy6ppO96+Of3ru5WlZAb39dB1u4M1qyWKI2GfLgM8ya7tbjFc
         X3SGspD+Dr4O3bcKweZRULeqHsbJCde/bWXTWzd2Uh1t6lqq3K0wHUq56+VpBYcYpbaX
         172JMrYkGk07Vu67RJyJ3PBd7trzp5d2JIUgDDrnR+CQsrjZINtH18SgfpJKci2w4/2r
         7qMar29fWPdUW+w0pzIAwTNDjLIrwwLhenBWslMryidpTWcLbcHvjbTWqFKkdKS0nwoE
         0IAA==
X-Forwarded-Encrypted: i=1; AJvYcCXWoDbMU0LBZ61JK91IYsxiT6IVY8sTbBWa2EevHBExUqkJWKJQtRL4zX5MGFIlR4SklzcSHe9ozCGVZl+OQwlPIYOxw9jf7opBWTM=
X-Gm-Message-State: AOJu0YxIgIGnrKlD0pFoLmy+qgDOkpXKA3Vq2CTU9YyfOEEB36tewtfH
	O3h/185of8vvDJJediAS4TZeeqf0GsjVoAFjCYXd7i5Rxxw0gMIytIyo+gYJqkGg2WscOXL0jaY
	=
X-Google-Smtp-Source: AGHT+IEzdJrzSXLzatIiUMsCPntn78tgD8O/GIVzTJ0AlqSOg942tNgKxWsOC7FgEZxsD9MYoNfjYQ==
X-Received: by 2002:a17:90a:f014:b0:2ae:6e16:da91 with SMTP id 98e67ed59e1d1-2b6165c1513mr1825272a91.29.1715154201328;
        Wed, 08 May 2024 00:43:21 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 18/19] zram: add dictionary support to lz4hc
Date: Wed,  8 May 2024 16:42:11 +0900
Message-ID: <20240508074223.652784-19-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. Just like lz4,
lz4hc doesn't mandate specific format of the dictionary
and zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

- default lz4hc

/sys/block/zram0/mm_stat
1750315008 609010918 621006848        0 621006848        2        0    34288    34288

- lz4hc dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750319104 499629401 509485056        0 509485056        1        0    34288    34288

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 58 ++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 431a44f0fcfd..c928f94f30df 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -8,6 +8,12 @@
 struct lz4hc_ctx {
 	void *mem;
 	s32 level;
+	LZ4_streamDecode_t *dstrm;
+	LZ4_streamHC_t *cstrm;
+
+	/* Shared between C/D streams */
+	void *dict;
+	size_t dict_sz;
 };
 
 static int lz4hc_init_config(struct zcomp_config *config)
@@ -26,6 +32,8 @@ static void lz4hc_destroy(void *ctx)
 {
 	struct lz4hc_ctx *zctx = ctx;
 
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
 	vfree(zctx->mem);
 	kfree(zctx);
 }
@@ -39,12 +47,27 @@ static void *lz4hc_create(struct zcomp_config *config)
 		return NULL;
 
 	ctx->level = config->level;
-	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->mem) {
-		lz4hc_destroy(ctx);
-		return NULL;
+	if (!config->dict) {
+		ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+		if (!ctx->mem)
+			goto error;
+	} else {
+		ctx->dstrm = kzalloc(sizeof(*ctx->dstrm), GFP_KERNEL);
+		if (!ctx->dstrm)
+			goto error;
+
+		ctx->cstrm = kzalloc(sizeof(*ctx->cstrm), GFP_KERNEL);
+		if (!ctx->cstrm)
+			goto error;
+
+		ctx->dict = config->dict;
+		ctx->dict_sz = config->dict_sz;
 	}
+
 	return ctx;
+error:
+	lz4hc_destroy(ctx);
+	return NULL;
 }
 
 static int lz4hc_compress(void *ctx, const unsigned char *src,
@@ -53,8 +76,18 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
 	struct lz4hc_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
-			      zctx->level, zctx->mem);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
+				      zctx->level, zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		LZ4_resetStreamHC(zctx->cstrm, zctx->level);
+		ret = LZ4_loadDictHC(zctx->cstrm, zctx->dict, zctx->dict_sz);
+		if (ret != zctx->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_HC_continue(zctx->cstrm, src, dst,
+					       PAGE_SIZE, *dst_len);
+	}
 	if (!ret)
 		return -EINVAL;
 	*dst_len = ret;
@@ -64,10 +97,21 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
 static int lz4hc_decompress(void *ctx, const unsigned char *src,
 			    size_t src_len, unsigned char *dst)
 {
+	struct lz4hc_ctx *zctx = ctx;
 	int dst_len = PAGE_SIZE;
 	int ret;
 
-	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (!zctx->dstrm) {
+		ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	} else {
+		/* Dstrm needs to be reset */
+		ret = LZ4_setStreamDecode(zctx->dstrm, zctx->dict,
+					  zctx->dict_sz);
+		if (!ret)
+			return -EINVAL;
+		ret = LZ4_decompress_safe_continue(zctx->dstrm, src, dst,
+						   src_len, dst_len);
+	}
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

