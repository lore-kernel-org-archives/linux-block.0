Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809569D2F
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757457; cv=none; b=U4hPrXRslgm0ji2/stnHcYbRCq6hqIJwzF/FOz2EE8jXoHsP93N31BKL+QmOlnKlFPpwxrfID+HRqcX/rMGmbp6CewINUCdZCC5PB/HrQy5Et5oh4ZDafqgc3Xf7RyMbrvdEOVUli7pQqAOxPqz78zm7qNOnNFw1XFJPh3xGGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757457; c=relaxed/simple;
	bh=EdcVeRKP/KQ7J2vOPlmfMisYBBpem1rc+IBT0Rrt74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Trhyx3oBPSJtLft/Hq4s2FDv2IR93XbcuvebTj/PgSIUzJ+rfVGMWL5zGpAQuWnM0svVUTecv8VpFVcaUkDrWp7PxS0rzXNSda5x2UMmVyAYH/E7QRlrEnqooK2k2Hz5+dipjoVClBxf4zQfhzCfD/auvn72a8Cm6hXsgJxE/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LYOGCI/y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYOGCI/y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so39285605ad.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757455; x=1716362255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqMJS5agkLEOzJWW1AUSO+pWta3iupztSYk/iAWBNyc=;
        b=LYOGCI/yIuAyRPoBAN9Lhn3v1z52/Tj8mf633vwkwvzNGMv2Jcg7rYe/JyUJA9bgK6
         bbCJW4kiYIc5NzxoFGBozGvRP+BHGZa2z6IIXQdTpYCeU9KpuJ2e/7cLFtZOpGcoil5i
         TY7HgCvmkTtBcpEDI79AQ0Zeb+AOU3uRV0HAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757455; x=1716362255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqMJS5agkLEOzJWW1AUSO+pWta3iupztSYk/iAWBNyc=;
        b=HqvfIzLBaFi4VP4L81qAOHSrNt7JC+n1CJBhaNJgUgZBEwS7DWvS1B2MBhegvoW16p
         n++ijPkmVGl3/B4fmUUTA8GkCKxeIHxeSh5m4VX9XG9C5PpTfxmDXz0PJdnM+zosjHRq
         6GBnQ2VNJLsV8n/6QJRWkkLQfxO2G4IlWFRU4dq+ACfhQ5gZGn8Z5LN7ns1+f6Jrzye6
         LRM64qutmJ6fEyQHSKyGtkSuNKpj7+A2Xc6s93xRQhBs7UxeH5qJqeAp6jU/n9/f3Jc8
         OK6GHo2iYdmyRrwAil+z5iZPFYYYuSDFmzMv7wFR9Z8O3vfqU57exvYXSxtsCgAO4VQK
         jkyg==
X-Forwarded-Encrypted: i=1; AJvYcCWxaVbtFM0Jet1AsJo6KT949/iZKlMCFZogz3XEey/JgDBIkOOHnHpc0cBNwxwc/3dWPO0qt2Pmy8p871sRni9YfEVdHcP3BUsx50Y=
X-Gm-Message-State: AOJu0YwwoUsN5nTxCLO6UBTldnqduqTRS3M6jpJDZdkrRJ8tMhYHFT+c
	OPs8PJ+GeaNflbGmXkp6+1dB3+iQJCCvEOPzO6qyV6CLajdRg50yXeeg4hCQvju6h4yWRo4q6yI
	=
X-Google-Smtp-Source: AGHT+IEqDaF2jnae7dsuVOOBN2n95AgJH3VLf55Gs8FaRkx1MfHX06Cxat1HEPBqfloibFYY9DeFyg==
X-Received: by 2002:a17:903:283:b0:1e3:e081:e7f5 with SMTP id d9443c01a7336-1ef4404bf29mr165136805ad.66.1715757455517;
        Wed, 15 May 2024 00:17:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 16/21] zram: add config init/release backend callbacks
Date: Wed, 15 May 2024 16:12:53 +0900
Message-ID: <20240515071645.1788128-17-senozhatsky@chromium.org>
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

Some backends can create a backend-specific private data
for comp config, e.g. parse a dictionary and use it to
init all of the ctx-s later on. Introduce two zcomp_config
callbacks to create and destroy per-config backend private
data. This is also the place where config can be validated.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 11 +++++++++++
 drivers/block/zram/backend_deflate.c | 20 +++++++++++++++-----
 drivers/block/zram/backend_lz4.c     | 20 +++++++++++++++-----
 drivers/block/zram/backend_lz4hc.c   | 20 +++++++++++++++-----
 drivers/block/zram/backend_lzo.c     | 11 +++++++++++
 drivers/block/zram/backend_lzorle.c  | 11 +++++++++++
 drivers/block/zram/backend_zstd.c    | 20 +++++++++++++++-----
 drivers/block/zram/zcomp.c           |  6 ++++++
 drivers/block/zram/zcomp.h           |  4 ++++
 drivers/block/zram/zram_drv.c        |  3 +++
 10 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 12e716deb763..1522aa88ac35 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -11,6 +11,15 @@ struct sw842_ctx {
 	void *mem;
 };
 
+static int init_config_842(struct zcomp_config *config)
+{
+	return 0;
+}
+
+static void release_config_842(struct zcomp_config *config)
+{
+}
+
 static void destroy_842(void *ctx)
 {
 	struct sw842_ctx *zctx = ctx;
@@ -64,5 +73,7 @@ struct zcomp_backend backend_842 = {
 	.decompress	= decompress_842,
 	.create_ctx	= create_842,
 	.destroy_ctx	= destroy_842,
+	.init_config	= init_config_842,
+	.release_config	= release_config_842,
 	.name		= "842",
 };
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 83c660adc722..2e166b507f5a 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -17,6 +17,18 @@ struct deflate_ctx {
 	s32 level;
 };
 
+static int deflate_init_config(struct zcomp_config *config)
+{
+	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
+		config->level = Z_DEFAULT_COMPRESSION;
+
+	return 0;
+}
+
+static void deflate_release_config(struct zcomp_config *config)
+{
+}
+
 static void deflate_destroy(void *ctx)
 {
 	struct deflate_ctx *zctx = ctx;
@@ -42,11 +54,7 @@ static void *deflate_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
-	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
-		ctx->level = config->level;
-	else
-		ctx->level = Z_DEFAULT_COMPRESSION;
-
+	ctx->level = config->level;
 	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
 	ctx->cctx.workspace = vzalloc(sz);
 	if (!ctx->cctx.workspace)
@@ -129,5 +137,7 @@ struct zcomp_backend backend_deflate = {
 	.decompress	= deflate_decompress,
 	.create_ctx	= deflate_create,
 	.destroy_ctx	= deflate_destroy,
+	.init_config	= deflate_init_config,
+	.release_config	= deflate_release_config,
 	.name		= "deflate",
 };
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index df0753fd8180..cf39bfc30f5b 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -10,6 +10,18 @@ struct lz4_ctx {
 	s32 level;
 };
 
+static int lz4_init_config(struct zcomp_config *config)
+{
+	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
+		config->level = LZ4_ACCELERATION_DEFAULT;
+
+	return 0;
+}
+
+static void lz4_release_config(struct zcomp_config *config)
+{
+}
+
 static void lz4_destroy(void *ctx)
 {
 	struct lz4_ctx *zctx = ctx;
@@ -26,11 +38,7 @@ static void *lz4_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
-	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
-		ctx->level = config->level;
-	else
-		ctx->level = LZ4_ACCELERATION_DEFAULT;
-
+	ctx->level = config->level;
 	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
@@ -72,5 +80,7 @@ struct zcomp_backend backend_lz4 = {
 	.decompress	= lz4_decompress,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
+	.init_config	= lz4_init_config,
+	.release_config	= lz4_release_config,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 2f03ca5809c7..428b393371d7 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -10,6 +10,18 @@ struct lz4hc_ctx {
 	s32 level;
 };
 
+static int lz4hc_init_config(struct zcomp_config *config)
+{
+	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
+		config->level = LZ4HC_DEFAULT_CLEVEL;
+
+	return 0;
+}
+
+static void lz4hc_release_config(struct zcomp_config *config)
+{
+}
+
 static void lz4hc_destroy(void *ctx)
 {
 	struct lz4hc_ctx *zctx = ctx;
@@ -26,11 +38,7 @@ static void *lz4hc_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
-	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
-		ctx->level = config->level;
-	else
-		ctx->level = LZ4HC_DEFAULT_CLEVEL;
-
+	ctx->level = config->level;
 	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
@@ -72,5 +80,7 @@ struct zcomp_backend backend_lz4hc = {
 	.decompress	= lz4hc_decompress,
 	.create_ctx	= lz4hc_create,
 	.destroy_ctx	= lz4hc_destroy,
+	.init_config	= lz4hc_init_config,
+	.release_config	= lz4hc_release_config,
 	.name		= "lz4hc",
 };
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 79ecfae9c4c5..75e0e3d297aa 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -6,6 +6,15 @@
 
 #include "backend_lzo.h"
 
+static int lzo_init_config(struct zcomp_config *config)
+{
+	return 0;
+}
+
+static void lzo_release_config(struct zcomp_config *config)
+{
+}
+
 static void *lzo_create(struct zcomp_config *config)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
@@ -40,5 +49,7 @@ struct zcomp_backend backend_lzo = {
 	.decompress	= lzo_decompress,
 	.create_ctx	= lzo_create,
 	.destroy_ctx	= lzo_destroy,
+	.init_config	= lzo_init_config,
+	.release_config	= lzo_release_config,
 	.name		= "lzo",
 };
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index b0937103b5fb..d1dc2e35061b 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -6,6 +6,15 @@
 
 #include "backend_lzorle.h"
 
+static int lzorle_init_config(struct zcomp_config *config)
+{
+	return 0;
+}
+
+static void lzorle_release_config(struct zcomp_config *config)
+{
+}
+
 static void *lzorle_create(struct zcomp_config *config)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
@@ -40,5 +49,7 @@ struct zcomp_backend backend_lzorle = {
 	.decompress	= lzorle_decompress,
 	.create_ctx	= lzorle_create,
 	.destroy_ctx	= lzorle_destroy,
+	.init_config	= lzorle_init_config,
+	.release_config	= lzorle_release_config,
 	.name		= "lzo-rle",
 };
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 4be149370e0b..9d2cc27d4c9d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -36,6 +36,18 @@ static void zstd_ctx_free(void *opaque, void *address)
 	kvfree(address);
 }
 
+static int zstd_init_config(struct zcomp_config *config)
+{
+	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
+		config->level = zstd_default_clevel();
+
+	return 0;
+}
+
+static void zstd_release_config(struct zcomp_config *config)
+{
+}
+
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
@@ -63,11 +75,7 @@ static void *zstd_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
-	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
-		ctx->level = config->level;
-	else
-		ctx->level = zstd_default_clevel();
-
+	ctx->level = config->level;
 	ctx->ctx_mem.customAlloc = zstd_ctx_alloc;
 	ctx->ctx_mem.customFree = zstd_ctx_free;
 
@@ -173,5 +181,7 @@ struct zcomp_backend backend_zstd = {
 	.decompress	= zstd_decompress,
 	.create_ctx	= zstd_create,
 	.destroy_ctx	= zstd_destroy,
+	.init_config	= zstd_init_config,
+	.release_config	= zstd_release_config,
 	.name		= "zstd",
 };
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 3f990a715487..a7013a4b6575 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -187,18 +187,24 @@ static int zcomp_init(struct zcomp *comp)
 	if (!comp->stream)
 		return -ENOMEM;
 
+	ret = comp->backend->init_config(comp->config);
+	if (ret)
+		goto cleanup;
+
 	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	if (ret < 0)
 		goto cleanup;
 	return 0;
 
 cleanup:
+	comp->backend->release_config(comp->config);
 	free_percpu(comp->stream);
 	return ret;
 }
 
 void zcomp_destroy(struct zcomp *comp)
 {
+	comp->backend->release_config(comp->config);
 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	free_percpu(comp->stream);
 	kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 345c78bc76db..aa604e5db7ad 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -22,6 +22,7 @@ struct zcomp_config {
 	s32 level;
 	size_t dict_sz;
 	void *dict;
+	void *private;
 };
 
 struct zcomp_backend {
@@ -34,6 +35,9 @@ struct zcomp_backend {
 	void *(*create_ctx)(struct zcomp_config *config);
 	void (*destroy_ctx)(void *ctx);
 
+	int (*init_config)(struct zcomp_config *config);
+	void (*release_config)(struct zcomp_config *config);
+
 	const char *name;
 };
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 216686a5f3f0..ce63c3f12f58 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1003,6 +1003,9 @@ static void __reset_comp_config(struct zram *zram, u32 prio)
 {
 	struct zcomp_config *config = &zram->configs[prio];
 
+	/* config->private should be freed by the backend */
+	WARN_ON_ONCE(config->private);
+
 	vfree(config->dict);
 	config->level = ZCOMP_CONFIG_NO_LEVEL;
 	config->dict_sz = 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

