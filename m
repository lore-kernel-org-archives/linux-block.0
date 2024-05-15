Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894566F06A
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757462; cv=none; b=Kb7napogX46DWX6qIoYSNEbKHUyIgpB050j1O6oTpgAaSRSpGeYbJ2PDwWP1mrLm+QpItQ7ctrQPNb11H54WcdmVc0OlkrwwoHzJQKhU4cG2uyjmxdz/tuuIlTjafwRulvViJ7Jj7U4cVVvDoGNmwx+qDeHbo7RC1s8/ZlNO+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757462; c=relaxed/simple;
	bh=MpumSGwS57AOBN7ZGr4e9nw0AvNHL1Xtn57eoC3mKTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swl/hXzIE9Ms79+Y3i3C2HTb/gARdJUAPKX4Kwdi2HJfj/hLxq1oExrjvlX5JFXiBeap/rNMrTQbh4UFIvb7YDNws1PJk9qwlSc6vse0EYYEgvWz5MBOu18j1FMa13LGoBpDx/3E9kWFKVq4AQ0AZdJH1Kxt3WFkybQPxAJhVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXrrCK2d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXrrCK2d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso43076735ad.2
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757460; x=1716362260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMJ82RyKF+6qXGhhZplFfcbZEx2r4rtHTVfrRVwN5n0=;
        b=NXrrCK2dZVHCswEwYlimpfveWN88+wE22uHa+YQaslqB5AS1fJ4BC9AmYGAlDqrzIQ
         9SW2vdMVOB/GFpvZDAGhB2Ttgyi3YHtauV5A/XC3ugUSl1yUpJgklY5ZNvygiB3RcF3H
         5lED72TAQ8o6X+/fWe7q3nm9BWHhh/1ra3Q8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757460; x=1716362260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMJ82RyKF+6qXGhhZplFfcbZEx2r4rtHTVfrRVwN5n0=;
        b=bMFHd1EOpHQPM29RgvCm2bNfC4xC0V9vMElyvTvcozUGcZfB10xWdECWs6K6NsGooZ
         Ql3aVa+KaRc1ZiancOfIcFJpHGel7iKt27E/yDIA+utuShdj+yUEN9x1iwdpR5GTxKb+
         7oIodPC3Zc6cs+BFbzQOin4dM15VVu1RcCworTm1zqY2cUfXAvwmLWHBA0Fc3BKgYfLV
         AKF27+m1RsdixP4nzL4p0vXQy+8FXSSwTYSrLKQRFUOHYIF8cs+33LpCP9q3ZE2MonYo
         Ldb0GnY6gMtefLHpaoSSCxtMgywrNHR/rSrCBCtWZdPPk1Wd5PP/E6qj/0tRJueiOm8S
         3hMg==
X-Forwarded-Encrypted: i=1; AJvYcCUPnym0FwMXq5itZw/FvrconTaNUGPd6TKt5A4dzkZaRtA5e067wd/StZdzVrjEhETANby2/cll9b5pkbXjYrxcLtoUaJrHzxEyJAw=
X-Gm-Message-State: AOJu0YxLOUY98qvMT+p4jlp3nqiv12YbX6ZMCJg7OlUP8joA059dyFFL
	BMyX2EnIXhJRV3Eqta/KyOM1AKzMC8Pf3bEeKj+BfQIlt9EZK01/DUOD/BYncPqSu6CmbLjeo8w
	=
X-Google-Smtp-Source: AGHT+IFWK5yzmfV2TgdVGKOyYOrHWxkziGiQydgnTP8gYfOW1Be1F/ocsMetxNXGL/KQ6FtS97/Wvg==
X-Received: by 2002:a17:902:f60a:b0:1e7:b6b5:1f05 with SMTP id d9443c01a7336-1ef43d1b00fmr170185825ad.18.1715757459970;
        Wed, 15 May 2024 00:17:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 18/21] zram: add dictionary support to lz4
Date: Wed, 15 May 2024 16:12:55 +0900
Message-ID: <20240515071645.1788128-19-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. lz4 doesn't
mandate specific format of the dictionary and even
zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

- default lz4

/sys/block/zram0/mm_stat
1750323200 664258735 676990976        0 676990976        2        0    34288    34288

- lz4 dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750310912 620608254 632852480        0 632852480        1        0    34288    34288

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4.c | 54 ++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index cf39bfc30f5b..47d0e719d5d7 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -8,6 +8,12 @@
 struct lz4_ctx {
 	void *mem;
 	s32 level;
+	LZ4_streamDecode_t *dstrm;
+	LZ4_stream_t *cstrm;
+
+	/* Shared between C/D streams */
+	void *dict;
+	size_t dict_sz;
 };
 
 static int lz4_init_config(struct zcomp_config *config)
@@ -26,6 +32,8 @@ static void lz4_destroy(void *ctx)
 {
 	struct lz4_ctx *zctx = ctx;
 
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
 	vfree(zctx->mem);
 	kfree(zctx);
 }
@@ -39,9 +47,22 @@ static void *lz4_create(struct zcomp_config *config)
 		return NULL;
 
 	ctx->level = config->level;
-	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
-	if (!ctx->mem)
-		goto error;
+	if (!config->dict) {
+		ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
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
@@ -55,8 +76,18 @@ static int lz4_compress(void *ctx, const unsigned char *src,
 	struct lz4_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_fast(src, dst, PAGE_SIZE, *dst_len,
-				zctx->level, zctx->mem);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_fast(src, dst, PAGE_SIZE, *dst_len,
+					zctx->level, zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		ret = LZ4_loadDict(zctx->cstrm, zctx->dict, zctx->dict_sz);
+		if (ret != zctx->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_fast_continue(zctx->cstrm, src, dst,
+						 PAGE_SIZE, *dst_len,
+						 zctx->level);
+	}
 	if (!ret)
 		return -EINVAL;
 	*dst_len = ret;
@@ -66,10 +97,21 @@ static int lz4_compress(void *ctx, const unsigned char *src,
 static int lz4_decompress(void *ctx, const unsigned char *src,
 			  size_t src_len, unsigned char *dst)
 {
+	struct lz4_ctx *zctx = ctx;
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

