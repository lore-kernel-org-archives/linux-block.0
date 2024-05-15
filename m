Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB074438A
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757444; cv=none; b=MsjRw2UELsfwSwfFzP3R+zxExlCf1YEmaADjheXDKCANLkPz81zve7tQFgBlqX7Z37w/K6RJf1LLvwHCecg2M30O5+3R/IcyXr1PQbmQGD+ng25rwdx2gTcA9LVknRIULDhMvaBLFn3S9pVQyeddxNRIsN90ni/qbyLgJt0M89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757444; c=relaxed/simple;
	bh=4TR3qcfJHoDHqbXJJ3W7Q7XPODavCGAvmdqEyE6Irws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX1H+f30irZYkPoTpAAVUeDEculjxUrhw/CXhM95Id33wpD/ox7TO2WOxu56yY6c8qPadXObjtMWOytda21/N8Z8zA/hy42nIhEKcoICmdH2p0Z8QK4NBil54rsivg+mcQL7msITLHk7q//15axA214uWQRfnvRg0NnNAaFTieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dWpMaU/J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWpMaU/J"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f082d92864so16526735ad.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757441; x=1716362241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylr3jp2oOM/Qv+5Rzo3O/r/CyrGBpC7ZOv+1y6H5M+s=;
        b=dWpMaU/JxykJog3Lv39wkauy1UVePPOWA8BXNLl7PIXEI4T9Cwf8xduBL9e/DlJqiN
         QFfwNC3WKKOpM3eHdpvrWcAu8ndRU+mw9VuOcyRt+0zV4gwVJz3+31Cbq/9w1T/YxN3v
         HnabcnyAKGWBmN+F0zfYx1ht4xrLkE66fcLKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757441; x=1716362241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylr3jp2oOM/Qv+5Rzo3O/r/CyrGBpC7ZOv+1y6H5M+s=;
        b=WGQdMSsRbxSAf3OvPy/K5nSnHnsEiiYkMvCC9gDx+qL8D8JGTo3QdpovEh99Pf75Z+
         7jdla97h31Nd2WQ9b5VXyKUjZcjwJxlCBxpxhej9wSmNmL+FbJQUnHSqnfjy8KLtXK6E
         T0XSzJ2yYMbv6d0UaxB3Ckapdbi694HBAn2+UZ/g+pKpkwwkPp5SdzhjOhnTIMLoak6M
         uGfnkBWESlCk6QbrzRhF1bM8DN+GUev4+lyShHylGEHWzECQwU4cgyFINMqHy7ONxr1D
         Bu+voukHLD7W9qCoHo7tGD1OOP9EMRVck3bnnVhpusfgIxIKi/yrdrRMIkWEd15ULbMe
         6tkw==
X-Forwarded-Encrypted: i=1; AJvYcCWzybRm/PvC4NIO+J2YUyl5TFIzjFgd+AqVuMsP1pd6TeJ/zlcmWxbDG87M0/KgDKS+3cu0QBwznNEBzhMM2VeGrnJb8wf+b1Xfjm4=
X-Gm-Message-State: AOJu0YyWi6ZhsBcdkHzfDeucXAqta0SaWw/m9TGcmRIKLjTxKVrUXpPg
	hUl3793jYeaxuXNGrfCukOdEy/5CSIWyEHzegaAEJsMoEO1qc++ibePm3uufhMAUL1LfGCSyzIg
	=
X-Google-Smtp-Source: AGHT+IEuqUbMH1dVaUqG9mvERkiQ2Ee7dAVCVB672+cKA0XgZvskGuWFwOFiCoOhsDXfHUCvCcgHYA==
X-Received: by 2002:a17:903:984:b0:1eb:7746:4248 with SMTP id d9443c01a7336-1ef440495abmr176193975ad.54.1715757441574;
        Wed, 15 May 2024 00:17:21 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 10/21] zram: introduce zcomp_config structure
Date: Wed, 15 May 2024 16:12:47 +0900
Message-ID: <20240515071645.1788128-11-senozhatsky@chromium.org>
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

We will store a per-algorithm parameters there (compression level,
dictionary, dictionary size, etc.).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     |  2 +-
 drivers/block/zram/backend_deflate.c |  9 ++++++---
 drivers/block/zram/backend_lz4.c     |  9 ++++++---
 drivers/block/zram/backend_lz4hc.c   |  9 ++++++---
 drivers/block/zram/backend_lzo.c     |  2 +-
 drivers/block/zram/backend_lzorle.c  |  2 +-
 drivers/block/zram/backend_zstd.c    |  8 ++++++--
 drivers/block/zram/zcomp.c           |  5 +++--
 drivers/block/zram/zcomp.h           | 14 ++++++++++++--
 drivers/block/zram/zram_drv.c        | 20 +++++++++++++++++++-
 drivers/block/zram/zram_drv.h        |  1 +
 11 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 8ea7a230b890..12e716deb763 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -19,7 +19,7 @@ static void destroy_842(void *ctx)
 	kfree(zctx);
 }
 
-static void *create_842(void)
+static void *create_842(struct zcomp_config *config)
 {
 	struct sw842_ctx *ctx;
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 949d402ea3dd..83c660adc722 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -32,7 +32,7 @@ static void deflate_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *deflate_create(void)
+static void *deflate_create(struct zcomp_config *config)
 {
 	struct deflate_ctx *ctx;
 	size_t sz;
@@ -42,8 +42,11 @@ static void *deflate_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded Z_DEFAULT_COMPRESSION for now */
-	ctx->level = Z_DEFAULT_COMPRESSION;
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = Z_DEFAULT_COMPRESSION;
+
 	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
 	ctx->cctx.workspace = vzalloc(sz);
 	if (!ctx->cctx.workspace)
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 6ea67511d782..df0753fd8180 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -18,7 +18,7 @@ static void lz4_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *lz4_create(void)
+static void *lz4_create(struct zcomp_config *config)
 {
 	struct lz4_ctx *ctx;
 
@@ -26,8 +26,11 @@ static void *lz4_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded LZ4_ACCELERATION_DEFAULT for now */
-	ctx->level = LZ4_ACCELERATION_DEFAULT;
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = LZ4_ACCELERATION_DEFAULT;
+
 	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 9bcc5aa19a2b..2f03ca5809c7 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,7 +18,7 @@ static void lz4hc_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *lz4hc_create(void)
+static void *lz4hc_create(struct zcomp_config *config)
 {
 	struct lz4hc_ctx *ctx;
 
@@ -26,8 +26,11 @@ static void *lz4hc_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
-	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = LZ4HC_DEFAULT_CLEVEL;
+
 	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index b88b408964cd..79ecfae9c4c5 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -6,7 +6,7 @@
 
 #include "backend_lzo.h"
 
-static void *lzo_create(void)
+static void *lzo_create(struct zcomp_config *config)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 }
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 9bf1843021b0..b0937103b5fb 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -6,7 +6,7 @@
 
 #include "backend_lzorle.h"
 
-static void *lzorle_create(void)
+static void *lzorle_create(struct zcomp_config *config)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 }
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index f930e9828be2..d392d364ad2c 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,7 +24,7 @@ static void zstd_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *zstd_create(void)
+static void *zstd_create(struct zcomp_config *config)
 {
 	zstd_parameters params;
 	struct zstd_ctx *ctx;
@@ -34,7 +34,11 @@ static void *zstd_create(void)
 	if (!ctx)
 		return NULL;
 
-	ctx->level = zstd_default_clevel();
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = zstd_default_clevel();
+
 	params = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&params.cParams);
 	ctx->cctx_mem = vzalloc(sz);
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index d49791f724e9..3f990a715487 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -61,7 +61,7 @@ static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
  */
 static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	zstrm->ctx = comp->backend->create_ctx();
+	zstrm->ctx = comp->backend->create_ctx(comp->config);
 
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
@@ -204,7 +204,7 @@ void zcomp_destroy(struct zcomp *comp)
 	kfree(comp);
 }
 
-struct zcomp *zcomp_create(const char *alg)
+struct zcomp *zcomp_create(const char *alg, struct zcomp_config *config)
 {
 	struct zcomp *comp;
 	int error;
@@ -221,6 +221,7 @@ struct zcomp *zcomp_create(const char *alg)
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
+	comp->config = config;
 	comp->backend = lookup_backend(alg);
 	if (!comp->backend) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 757b85017e23..345c78bc76db 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,6 +5,7 @@
 
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
+
 #include <linux/local_lock.h>
 
 struct zcomp_strm {
@@ -15,6 +16,14 @@ struct zcomp_strm {
 	void *ctx;
 };
 
+#define ZCOMP_CONFIG_NO_LEVEL	INT_MIN
+
+struct zcomp_config {
+	s32 level;
+	size_t dict_sz;
+	void *dict;
+};
+
 struct zcomp_backend {
 	int (*compress)(void *ctx, const unsigned char *src,
 			unsigned char *dst, size_t *dst_len);
@@ -22,7 +31,7 @@ struct zcomp_backend {
 	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
 			  unsigned char *dst);
 
-	void *(*create_ctx)(void);
+	void *(*create_ctx)(struct zcomp_config *config);
 	void (*destroy_ctx)(void *ctx);
 
 	const char *name;
@@ -32,6 +41,7 @@ struct zcomp_backend {
 struct zcomp {
 	struct zcomp_strm __percpu *stream;
 	struct zcomp_backend *backend;
+	struct zcomp_config *config;
 	struct hlist_node node;
 };
 
@@ -40,7 +50,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
-struct zcomp *zcomp_create(const char *alg);
+struct zcomp *zcomp_create(const char *alg, struct zcomp_config *config);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 38afc2c23108..75ecdb885d91 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1979,6 +1979,20 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram_slot_unlock(zram, index);
 }
 
+static void zram_reset_comp_configs(struct zram *zram)
+{
+	u32 prio;
+
+	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+		struct zcomp_config *config = &zram->configs[prio];
+
+		vfree(config->dict);
+		config->level = ZCOMP_CONFIG_NO_LEVEL;
+		config->dict_sz = 0;
+		config->dict = NULL;
+	}
+}
+
 static void zram_destroy_comps(struct zram *zram)
 {
 	u32 prio;
@@ -1992,6 +2006,8 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	zram_reset_comp_configs(zram);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2049,7 +2065,8 @@ static ssize_t disksize_store(struct device *dev,
 		if (!zram->comp_algs[prio])
 			continue;
 
-		comp = zcomp_create(zram->comp_algs[prio]);
+		comp = zcomp_create(zram->comp_algs[prio],
+				    &zram->configs[prio]);
 		if (IS_ERR(comp)) {
 			pr_err("Cannot initialise %s compressing backend\n",
 			       zram->comp_algs[prio]);
@@ -2256,6 +2273,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+	zram_reset_comp_configs(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	zram_debugfs_register(zram);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 35e322144629..c3c7475d6517 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -107,6 +107,7 @@ struct zram {
 	struct zram_table_entry *table;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
+	struct zcomp_config configs[ZRAM_MAX_COMPS];
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
 	struct rw_semaphore init_lock;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

