Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111F54BE0
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154181; cv=none; b=eGLeOeazbRF/OqAjLDCpj9p1HzrbZp0nYzTv9VrLAwUSuJgCCh4Az3ghAklb7PZsrQ+aKqUtvqnmsSSHpxDpvr7bIXbges3UwaI31o7VNmoCdaptvxq1HdSEwyAueS/t7cSe+Gk5u4bTy5Fs+Mu73bFZ7t5qDf1Z52URz0hKEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154181; c=relaxed/simple;
	bh=gUBERMicU7WLLq2de8iEQjXt2o8KBPI9FHzu44dkhxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/YgNiH1WQ2m5UMi+7uPgLL8dfjBTgHPyz/Iz7RR+iD+fdsvHtUjNJYVydSV32K42rtB5SL7hCoAirblvfaiA47Mt04nqM6Z6X7vqJC+jPb0qo6T5+EouvPkVLzOJHK8s03UEnS5C8eLnW2gGck2z/T5Y9RpsuBA9pp83ru4vVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BApYeXDE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BApYeXDE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so2915474a91.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154180; x=1715758980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3bUdaYb8VukERAvkARptjjY26yVI43doztfWIHDgkU=;
        b=BApYeXDEjMTKsh9sPhlMdhyCMI3Tz64U3Soqqwi7h5H/rbmmR5CMO/MYmtZhsoRSEZ
         8GvnXQAp4LMXcBqp+is/3XDZssIp8AYljPlk/gWgxpcfPSwN2ztHIjvJkOr8/Je4MfQz
         gaPe+UuM/sv928mxB8kvB7yx02PbLuI7WGvXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154180; x=1715758980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3bUdaYb8VukERAvkARptjjY26yVI43doztfWIHDgkU=;
        b=i1l1+B9ULytehbt1qbtmx/n4UOsnqqmzFLK5+vR7qwNBy/hjr8FZ0/Vt7k54ckkAcX
         HSXIBAhtovAfmYUYrfAyLhbrcpkGXMBWvR0ORBljeitaS8pbRLE8QcN+Jw3dWGeLBzz8
         X5/ms800F2qdb/775CXRPifmRzZzdg3PgAE+Ka8cjiTO9i9TTq2XsK2uoP5iZtjxYaK0
         DagI13lqTVkebt9sVhnyo3isGkEGDTZ6x1g/k0IeobdtR39MhqLHaOq+QENOhwcF9fvu
         5hwWIn8FVnGS+nshnyvMfb2nKDNp84k6ohOk3ADtFG7E9RfqdSS0JyG07rj7zm3mx6+i
         RSAg==
X-Forwarded-Encrypted: i=1; AJvYcCUo8OnjKbtV55JmpsTzLRGuxPKzxUyDEyhzfHSx5cla/ojEy+Kc5EKIVUfdwBbd1m8Z5bF84FZa3+/0uxjFdjsI53KPup0Ut3dis0M=
X-Gm-Message-State: AOJu0YzdsnzHADrcdbDa7MiKzovuUx3JCyTtRwQIPlSA9jNxl9PZakNI
	paYI3LNn7koUWA9MDSQraJuLQsM/rVE2Sn08J56/mv77N5DDhCE4Knju1SgVtw==
X-Google-Smtp-Source: AGHT+IHLDs5Z2qVvaQD54fdwh5bRibjLYhY0MMzGyEEicjkKB8A1A4WJtW4ta3aNVJPQkExUKPlytg==
X-Received: by 2002:a17:90b:230e:b0:2b2:ae4b:9e54 with SMTP id 98e67ed59e1d1-2b61659f842mr1829748a91.11.1715154179747;
        Wed, 08 May 2024 00:42:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:59 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 10/19] zram: introduce zcomp_config structure
Date: Wed,  8 May 2024 16:42:03 +0900
Message-ID: <20240508074223.652784-11-senozhatsky@chromium.org>
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

We will store a per-algorithm parameters there (compression level,
dictionary, dictionary size, etc.).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     |  2 +-
 drivers/block/zram/backend_deflate.c |  9 ++++++---
 drivers/block/zram/backend_lz4.c     |  2 +-
 drivers/block/zram/backend_lz4hc.c   | 10 ++++++----
 drivers/block/zram/backend_lzo.c     |  2 +-
 drivers/block/zram/backend_lzorle.c  |  2 +-
 drivers/block/zram/backend_zstd.c    |  8 ++++++--
 drivers/block/zram/zcomp.c           |  5 +++--
 drivers/block/zram/zcomp.h           | 14 ++++++++++++--
 drivers/block/zram/zram_drv.c        | 20 +++++++++++++++++++-
 drivers/block/zram/zram_drv.h        |  1 +
 11 files changed, 57 insertions(+), 18 deletions(-)

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
index 697592dbabe2..98d9c9274149 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -4,7 +4,7 @@
 
 #include "backend_lz4.h"
 
-static void *lz4_create(void)
+static void *lz4_create(struct zcomp_config *config)
 {
 	return vmalloc(LZ4_MEM_COMPRESS);
 }
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 1735a2598443..e1069f185437 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,7 +18,7 @@ static void lz4hc_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *lz4hc_create(void)
+static void *lz4hc_create(struct zcomp_config *config)
 {
 	struct lz4hc_ctx *ctx;
 
@@ -26,14 +26,16 @@ static void *lz4hc_create(void)
 	if (!ctx)
 		return NULL;
 
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = LZ4HC_DEFAULT_CLEVEL;
+
 	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
 	if (!ctx->mem) {
 		lz4hc_destroy(ctx);
 		return NULL;
 	}
-
-	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
-	ctx->level = LZ4HC_DEFAULT_CLEVEL;
 	return ctx;
 }
 
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
index 4a7734aa1a8a..b2fb94902bef 100644
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
 
-	ctx->level = ZSTD_defaultCLevel();
+	if (config->level != ZCOMP_CONFIG_NO_LEVEL)
+		ctx->level = config->level;
+	else
+		ctx->level = ZSTD_defaultCLevel();
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
index 298ef0e97e03..6c36cd349431 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1994,6 +1994,20 @@ static void zram_slot_free_notify(struct block_device *bdev,
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
@@ -2007,6 +2021,8 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	zram_reset_comp_configs(zram);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2064,7 +2080,8 @@ static ssize_t disksize_store(struct device *dev,
 		if (!zram->comp_algs[prio])
 			continue;
 
-		comp = zcomp_create(zram->comp_algs[prio]);
+		comp = zcomp_create(zram->comp_algs[prio],
+				    &zram->configs[prio]);
 		if (IS_ERR(comp)) {
 			pr_err("Cannot initialise %s compressing backend\n",
 			       zram->comp_algs[prio]);
@@ -2271,6 +2288,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+	zram_reset_comp_configs(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	zram_debugfs_register(zram);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 37bf29f34d26..2c77f3bff166 100644
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

