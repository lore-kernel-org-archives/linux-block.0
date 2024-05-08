Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3247A7D
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154169; cv=none; b=vGJSg9t5Fb5jfzRmIE8IFfWB+WNVaE0m+0FAyHvu3auaEOicLJH+XhW5yj0+7pVbfj71jJ6X16DPG1DJXoaqydX5dqRpXDrgWUjaGx7j3lDVpRiHZw8yGnwYoz10hHJNPaf0IPgzP0nueF1Dels9FKKfVjRuFb4SPuAHpjQM1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154169; c=relaxed/simple;
	bh=UjfGmtLHYc+ZtfDBltxPDecVYYzszPmAvKAkfS30jKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmFfcNcSKjkrX/Pmag2pmlilVPL7PXQmNANH8L4ZyR1S/YOi4xzFxB0Ip8YhvXrG34u9D1izhX3U+gwZ1N3reKOZxzHGL1ac0DOgTIjoemcODuHJYlY4qk3PGVPc2TvZP852f2MGVMbXqrS/FEZRRV2YmnEXEF2GjdRSWO7AILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S6VNcUZW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S6VNcUZW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso3455856b3a.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154168; x=1715758968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs/oZbuIhbdeWVSnm1Y7/6OB6aLjJFlUrJpqF9jHmLk=;
        b=S6VNcUZWgqpUojvnokrB2g55zLPuYYS+j8+o0zdfbeg5Bkp0ExFlXS02OqqTa98Wa7
         sEYaPI7L17DelYbLwUAVseHynoMVyYfhBIyaPffgrE6hXZDgf6LBKulnWLLW3dbt5JxM
         jL0gewyPNMcUWmxhT38nMIKKI1ifl2SLFewWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154168; x=1715758968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs/oZbuIhbdeWVSnm1Y7/6OB6aLjJFlUrJpqF9jHmLk=;
        b=sJaHJ3GpFSU7oPFY5jxWL9X3fJrYVS5m2Ni8zcrRgU1HbF66XpdWTa0dG6TpBZuMF5
         /VqxgtwfzPLpJpcPlDQeXefyv09jQC8CmbR19jBHMuNIndlC33MCCrKQjwyI+mrOSxQM
         hk28a3w1b4Ydg0M/fnywNUhDJuXzEGeJU7U//vhS9kFQZDo5gm567wFCVz1IRtyapzkW
         exSca9z9SJBmNS8yimFQ8OmWD5BZANR4dPlhIOUq5bgLMAvbXtHpgXDF621z84MpY1dm
         No4Jvoj0KGIMUURcF+iZdJgrLytVpOLIB4GK212QhPL1Ta5ONm5QNfmIxF9O2vJpdWoC
         mIBA==
X-Forwarded-Encrypted: i=1; AJvYcCUj6KYyUJCbpzIlnbRsYpUZ667j6rpTh+1LDazTXldlWKTEbc4/8DQCXbWF7weN9GYqfbwSDbFCCLRu3A2A7hYwL36CZVoQRbuz+H8=
X-Gm-Message-State: AOJu0Yz6Uw1P9iENFnuvHmQZl/lVAADuwrfl5x+O81DYZRDqpX0tqTbJ
	OkZ8jZhIs9bmy8a0ObssoDyYfUhncY7cSMzElVPFecTExuORT/Sy2av55K5v3A==
X-Google-Smtp-Source: AGHT+IFO2VQzLGGAy8b1vLdPgLtYlvSlasHwDwvTd2+OhnH1jF5ePjrL8wvO3+GWqyNffeo4LSj2IQ==
X-Received: by 2002:a05:6a21:6d96:b0:1ad:9adf:febf with SMTP id adf61e73a8af0-1afc8d5be49mr2191762637.31.1715154167678;
        Wed, 08 May 2024 00:42:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 05/19] zram: add zstd compression backend support
Date: Wed,  8 May 2024 16:41:58 +0900
Message-ID: <20240508074223.652784-6-senozhatsky@chromium.org>
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

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig        | 11 ++++
 drivers/block/zram/Makefile       |  1 +
 drivers/block/zram/backend_zstd.c | 97 +++++++++++++++++++++++++++++++
 drivers/block/zram/backend_zstd.h | 10 ++++
 drivers/block/zram/zcomp.c        |  4 ++
 5 files changed, 123 insertions(+)
 create mode 100644 drivers/block/zram/backend_zstd.c
 create mode 100644 drivers/block/zram/backend_zstd.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 0d890a8d2dc4..71cd0d5d8f35 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -32,6 +32,12 @@ config ZRAM_BACKEND_LZ4HC
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_ZSTD
+	bool "zstd compression support"
+	depends on ZRAM
+	select ZSTD_COMPRESS
+	select ZSTD_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -53,6 +59,10 @@ config ZRAM_DEF_COMP_LZ4HC
 	bool "lz4hc"
 	depends on ZRAM_BACKEND_LZ4HC
 
+config ZRAM_DEF_COMP_ZSTD
+	bool "zstd"
+	depends on ZRAM_BACKEND_ZSTD
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -61,6 +71,7 @@ config ZRAM_DEF_COMP
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
+	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 815b45471c7d..053fe35e346b 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
+obj-$(CONFIG_ZRAM_BACKEND_ZSTD)		+= backend_zstd.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
new file mode 100644
index 000000000000..4da49626f110
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zstd.h>
+
+#include "backend_zstd.h"
+
+struct zstd_ctx {
+	zstd_cctx *cctx;
+	zstd_dctx *dctx;
+	void *cctx_mem;
+	void *dctx_mem;
+	s32 level;
+};
+
+static void zstd_destroy(void *ctx)
+{
+	struct zstd_ctx *zctx = ctx;
+
+	vfree(zctx->cctx_mem);
+	vfree(zctx->dctx_mem);
+	kfree(zctx);
+}
+
+static void *zstd_create(void)
+{
+	zstd_parameters params;
+	struct zstd_ctx *ctx;
+	size_t sz;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->level = ZSTD_defaultCLevel();
+	params = zstd_get_params(ctx->level, 0);
+	sz = zstd_cctx_workspace_bound(&params.cParams);
+	ctx->cctx_mem = vzalloc(sz);
+	if (!ctx->cctx_mem)
+		goto error;
+
+	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+	if (!ctx->cctx)
+		goto error;
+
+	sz = zstd_dctx_workspace_bound();
+	ctx->dctx_mem = vzalloc(sz);
+	if (!ctx->dctx_mem)
+		goto error;
+
+	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+	if (!ctx->dctx)
+		goto error;
+
+	return ctx;
+
+error:
+	zstd_destroy(ctx);
+	return NULL;
+}
+
+static int zstd_compress(void *ctx, const unsigned char *src,
+			 unsigned char *dst, size_t *dst_len)
+{
+	struct zstd_ctx *zctx = ctx;
+	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	size_t ret;
+
+	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+				 src, PAGE_SIZE, &params);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			   unsigned char *dst)
+{
+	struct zstd_ctx *zctx = ctx;
+	size_t ret;
+
+	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_zstd = {
+	.compress	= zstd_compress,
+	.decompress	= zstd_decompress,
+	.create_ctx	= zstd_create,
+	.destroy_ctx	= zstd_destroy,
+	.name		= "zstd",
+};
diff --git a/drivers/block/zram/backend_zstd.h b/drivers/block/zram/backend_zstd.h
new file mode 100644
index 000000000000..75d2d2c02768
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_ZSTD_H__
+#define __BACKEND_ZSTD_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_zstd;
+
+#endif /* __BACKEND_ZSTD_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index f04f5844a23c..c16eb038f608 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -19,6 +19,7 @@
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
+#include "backend_zstd.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -30,6 +31,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
 	&backend_lz4hc,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
+	&backend_zstd,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

