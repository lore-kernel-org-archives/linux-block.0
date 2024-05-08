Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F4768FC
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154195; cv=none; b=OhB8eNFQFU0OTagrZekEtAvose+qQuNpvd0en8YQBOtOI4tQripDIbhw6EBYkUT5w5eAdIQEPgBMQIxV1RNnkgTQrG2km+P0CcQU/VM3s5qhi2MW/ahRZWd1tjalZSnYt+OpZZe+HiBRn/+zDxtFWMwaP6vgZVYKupCxNG4nRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154195; c=relaxed/simple;
	bh=UKwqjwb9x/OsHkTqcI+97IPeKV8KGD2MI9Ln01YNtM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5j52qhNNDoABSvabXLEiaCsTwUqbzmtCln56cTVeDtAi40n7aS65xUFOGksDGoy7g8f9CSlRAEKJ6Zv21uOXUOlA/t4/Cp71nFnWD1vf4gT/mek+UroYQHS6HBrZpF/8NDgITs8sbYlua5jaGiCANurTWSJ+n6wz17ob3KPYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CQyjCJsr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQyjCJsr"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so3092572a12.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154193; x=1715758993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px5tFo3EeYPEdZvOSeLSW/x5RbwO5TsDAN0dXuxOAa4=;
        b=CQyjCJsrqy/IbH4Z7UU9tMWD2zPEuJ5C+ou+7r7RDVSvD8f/QUHCwJRNMqXSbBVo8g
         eCMMS/NAS09MmeQj6oYGje9n1R5wmh5CQzAVxuWhROuHTqkxg6Hrs3gTuNeOzBIgsH3U
         4yideXo6OYmL9QBEt1T3THUEZEiB72LIPon1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154193; x=1715758993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px5tFo3EeYPEdZvOSeLSW/x5RbwO5TsDAN0dXuxOAa4=;
        b=qQyNXlI8i3o/a69jOVJH90K4tXOMKSOSC3c1DRFGqSqFgz5TTlTVNR09JFlxYd7VBS
         L+slsX3v9BKWmlPbUAQ/cYQntnTRva5vupCC0sMbZlL68kE988vADl40tBSKlEmrJILh
         RQMD+fz7vuwtLn4HmLeV/N2gj80TZzelqxB4SonsMQa/fKavicnRMeYhsOSjR14/KmHo
         apH0OXqUnZ5U44iYQOx6OWXbUCK0oANG92AquYYKK3MygRDAthS9ZyrW1bu8ZfjFgGBA
         XNudO1aTAb7dgVoKzWzjlqrCfAE4QdQGhnIC+3tMpe+vDLnQPgjWUfubT0/kmIoDbv7a
         9SwA==
X-Forwarded-Encrypted: i=1; AJvYcCU8rgP4a3e3935ZK78mdjkJO6CrMueCw3Ez+hMi9B91eH6q3tdc8frqdotTr7A3TORREpx0dfai0hT/NjmZIuo6kDh1ffUSW7Gkw2o=
X-Gm-Message-State: AOJu0YxncQDNX4M9WVTQgcXNGQYAek/I+16GvazmVTpIqd7v1YR7wiqG
	+yty5dlY/FSmybcBY3j0WOYMKAhyIob7jmQWFo0nX2LxykNQFlnE+x7JDbgbgw==
X-Google-Smtp-Source: AGHT+IFEUcpcmTHNCeMSDBeBNcfOgk3fQHMS7MIX9XAd+uxg/0r0afRpez4CJ7Do2vUXxVfXGtcYjQ==
X-Received: by 2002:a05:6a20:394d:b0:1ac:4219:b817 with SMTP id adf61e73a8af0-1afc8d75e57mr2333745637.16.1715154192917;
        Wed, 08 May 2024 00:43:12 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:12 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 15/19] zram: add config init/release backend callbacks
Date: Wed,  8 May 2024 16:42:08 +0900
Message-ID: <20240508074223.652784-16-senozhatsky@chromium.org>
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

Some backends can create a backend-specific private data
for comp config, e.g. parse a dictionary and use it to
init all of the ctx-s later on. Introduce two zcomp_config
callbacks to create and destroy per-config backend private
data. This is also the place where config can be validated.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 11 +++++++++++
 drivers/block/zram/backend_deflate.c | 20 +++++++++++++++-----
 drivers/block/zram/backend_lz4.c     | 11 +++++++++++
 drivers/block/zram/backend_lz4hc.c   | 20 +++++++++++++++-----
 drivers/block/zram/backend_lzo.c     | 11 +++++++++++
 drivers/block/zram/backend_lzorle.c  | 11 +++++++++++
 drivers/block/zram/backend_zstd.c    | 20 +++++++++++++++-----
 drivers/block/zram/zcomp.c           |  6 ++++++
 drivers/block/zram/zcomp.h           |  4 ++++
 drivers/block/zram/zram_drv.c        |  3 +++
 10 files changed, 102 insertions(+), 15 deletions(-)

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
index 98d9c9274149..560fcf139301 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -4,6 +4,15 @@
 
 #include "backend_lz4.h"
 
+static int lz4_init_config(struct zcomp_config *config)
+{
+	return 0;
+}
+
+static void lz4_release_config(struct zcomp_config *config)
+{
+}
+
 static void *lz4_create(struct zcomp_config *config)
 {
 	return vmalloc(LZ4_MEM_COMPRESS);
@@ -43,5 +52,7 @@ struct zcomp_backend backend_lz4 = {
 	.decompress	= lz4_decompress,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
+	.init_config	= lz4_init_config,
+	.release_config	= lz4_release_config,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index e1069f185437..431a44f0fcfd 100644
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
 	if (!ctx->mem) {
 		lz4hc_destroy(ctx);
@@ -70,5 +78,7 @@ struct zcomp_backend backend_lz4hc = {
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
index 006d0f40617d..df59584b0337 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -36,6 +36,18 @@ static void zstd_ctx_free(void *opaque, void *address)
 	kvfree(address);
 }
 
+static int zstd_init_config(struct zcomp_config *config)
+{
+	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
+		config->level = ZSTD_defaultCLevel();
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
-		ctx->level = ZSTD_defaultCLevel();
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
index 863e4e125eaa..d667fe2d0cd9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1018,6 +1018,9 @@ static void __reset_comp_config(struct zram *zram, u32 prio)
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

