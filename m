Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5CD76025
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757466; cv=none; b=p0B9xNeKrx6hmQhanKrN086DYO8uaIj3+HK7uQnk1gn7Xf6Wwj8qXmCheqSKzkgNOUcaWcGNnFK4maT+tP8Ocru8taI18HHI79jsPwmN8UCYKmcviHumzIpWUlFLdIxa0SfHUW8CGlAkPbyrrzHV6SO3MSjg0k5v0sXhpu5yMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757466; c=relaxed/simple;
	bh=qtvmUsQREyXmjeLbpuxebnWi3agfG2+3rkkIDgBbtXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF5gqnjegv6bsEPA+T6CLGKb1tbJXCVZBZNySBJhhSYzsN7Toh69e+FudzBMr4ojNQh3DiCuHtWnL99xfbqFiy8kY8cOzJr3jWGxuMA/ltcxVmfudTK5D7iuDFl4rXv4GhGvt6T+mDlGW6UWHw6+3ztJfm4/NaC/74aRDUB2gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fdh7B8/Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fdh7B8/Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec41d82b8bso61704155ad.2
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757465; x=1716362265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHfG35o7+8/7OU1lSE40PRM3WsVXKsxMJUAQYr8zh6U=;
        b=Fdh7B8/ZhcGrI2v5MO0se01y9b5gbob6rKAnF1fJY7gwhE8c0SUAhpUFtyHzHOSq3Y
         0hugWD0WUKa+/NJByWV/RAad3bt4YtwXF3YVLhXA+F1sFpRKzVymT0gXY6Js+QCyGkkk
         ZOfnWzBX5WjLBwZVK+j9FzJzfuZvGYydJNZGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757465; x=1716362265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHfG35o7+8/7OU1lSE40PRM3WsVXKsxMJUAQYr8zh6U=;
        b=c8XlYfEnDEsIp8dFBQ0jpkllYdSBWOGaKjfciDspvOkkIGLyLlcmEMIKU6rtAFbTfP
         AQ4bmCQh+timnixqF6Q5o6DdNb3hR1n9Qcy2cWSeba8qX1isvU2rLEpXmbL9AjNPAvHe
         fsES+r3Amxik6Pv8rqIpmP0cTjNmSE1IHXSpDc76vfTUOe6Fz6IL6dLf6TKCftajCPk9
         qjH6AvnkijmpCWxYLl03yxOosH7TaXqXlBIpmGOlRL8lQMD7hEK9sKv876warb4A6FAf
         5mvYn8IaP7GPD/OkxO1mZrmHoHrpJOUmoWMniZRD9c51+DwvJMaEg8zfdHB+j9Gd15hn
         jVSw==
X-Forwarded-Encrypted: i=1; AJvYcCVm2QZcuWUHjVRgwmRWrtCmBL9ovjU1Wo6P1Xb8IHP7TuCMVkFxIGCOFQJ5N7Op8a4a8WPIB6DoZERYfk6krU3J/a1Ml0LOtk/JO+g=
X-Gm-Message-State: AOJu0Yx/TOQHkSWR/L44hDEOLGQRNKbeRG8QktM6IenhqmDfRmoscWvE
	KYK61G/hdST2/Bq7q3Qd0ZUJvU5VK4ykIrZITidcVoiiTOqilr8JU3wv9m4G5w==
X-Google-Smtp-Source: AGHT+IFWdGVgCe1JBmXZ3hDnpc6dFO9Vvt71Vj0tCFKh+5tnuApc6QuAnmJpi2vhaAxChIPFAqL2cQ==
X-Received: by 2002:a17:902:8542:b0:1e2:be4b:dd9f with SMTP id d9443c01a7336-1ef43d29670mr140437795ad.15.1715757464806;
        Wed, 15 May 2024 00:17:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 20/21] zram: add dictionary support to lz4hc
Date: Wed, 15 May 2024 16:12:57 +0900
Message-ID: <20240515071645.1788128-21-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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
 drivers/block/zram/backend_lz4hc.c | 54 ++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 428b393371d7..c928f94f30df 100644
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
@@ -39,9 +47,22 @@ static void *lz4hc_create(struct zcomp_config *config)
 		return NULL;
 
 	ctx->level = config->level;
-	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->mem)
-		goto error;
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
+	}
 
 	return ctx;
 error:
@@ -55,8 +76,18 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
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
@@ -66,10 +97,21 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
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

