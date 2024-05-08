Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD17537E0
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154174; cv=none; b=Ql9f8bnjE+ZSoqRcE98ctLo4+L6E+cQA5BO7SPr4MtE5WukPMCEvF0jGw9YcPE1Y0qBt0XCAgmdC6D5vvvpKTVxw8OMRa+ubDx2Z554J88c5PgzbXe6R/Fl5cnC/Wv514etBJaIbgJDdFyow8pXigk3LNnEseOTRhUMsiSZwI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154174; c=relaxed/simple;
	bh=QlfqxCVzGVqjuU78RUVl7laME8V3Egjqi1IedM7APCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjyWlZtWKgU4iOwdO0lwKlMR4VhVPvQc80iat5TiSmarSRiVbJQeSvgaVpHkjUm3zUMZ8mubNdbOU+mURZCqeFupfQNzEiCEbLVVu0QEO/aqFUhVegBabR0Vyzh5DZg7G802oPvk5QfiKD0uI29k1E/7Qh/rL8PmpN9njdhzqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R7xhMQs+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7xhMQs+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3033053a12.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154173; x=1715758973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II/I/hgLmJhm0CjvuLYW2Y62FUnxRGP17kgZqYB2Ofs=;
        b=R7xhMQs+LZQ5W5ems3eTs1wSRGOew4R44hkK2dxllm5gn8QhYRC9mfK/0+NTrheGQE
         xMa7LIEhfRCGWQbtmy0hDxncvoqDOV7DZVAvPpjpfFUy1/7FQ8wnMdwPy0SpyrqbPM+P
         GIRC5cVZoTDesK2ydc8FZlVYMd3HgJ8I2YoCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154173; x=1715758973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II/I/hgLmJhm0CjvuLYW2Y62FUnxRGP17kgZqYB2Ofs=;
        b=RjfCwn4o6nexwh59qXWM1z+vOdOf+jv21d7NIrLVYWSl7tdjHNF3QHSgdGfUfpwJwD
         LG+Mc6DkmtilGun91C3yKtWnx6F0gDhyYh0zIhZrCJRNkwE4M0S32kd2EMQcUL1M431i
         4Q8t9bBGz5MYNZsnio6vyL3FjvVD7fkBt8GNwj1qjKIO7Q1M799l54TwTAiybB0tPOHr
         K0Bf3txB9HLlX5kPN/fiI1wYogxh+RzMoVC3aC0dmrROR9GoHhbjKzuBwqvEbaBSZJRJ
         v2W/B4zN7uGmO1kCHM/pPoMuTPtX8ZAjKdvp31HPKYjrSbZTfWbMyGGDmXSs4LZZqIkb
         lCAg==
X-Forwarded-Encrypted: i=1; AJvYcCXrV/wnxIPmPDASHb6fl1l+Mk/f1adJaSqIaw1dnt91uKk2apYGbZsPVlz0TVI8dVSf2a/8LdNyeAUUSeyLJOV5nFGNSPORiJUVRAU=
X-Gm-Message-State: AOJu0YwJq0oSC25YuzXQlWgr0fa+l/nud5MeKgw2TKHDZtwPLaYvRCP7
	tJkXFl5QYWnuu33oe525xBMmqp92T5PhBCvMh3tY3U0lZ0jr/JfM8ZDgxC1xzA==
X-Google-Smtp-Source: AGHT+IECICoA7hcDg23NAlDQOI1208s0oA/MgjMrcQhNGoK5Hsv4ExsAu/YczEHWlGdEBYIalK11CQ==
X-Received: by 2002:a17:90a:e011:b0:2ab:e345:4685 with SMTP id 98e67ed59e1d1-2b6165a5634mr1749435a91.17.1715154172664;
        Wed, 08 May 2024 00:42:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:52 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 07/19] zram: add zlib compression backend support
Date: Wed,  8 May 2024 16:42:00 +0900
Message-ID: <20240508074223.652784-8-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig           |  11 +++
 drivers/block/zram/Makefile          |   9 +-
 drivers/block/zram/backend_deflate.c | 130 +++++++++++++++++++++++++++
 drivers/block/zram/backend_deflate.h |  10 +++
 drivers/block/zram/zcomp.c           |   4 +
 5 files changed, 160 insertions(+), 4 deletions(-)
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 71cd0d5d8f35..9dedd2edfb28 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -38,6 +38,12 @@ config ZRAM_BACKEND_ZSTD
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 
+config ZRAM_BACKEND_DEFLATE
+	bool "deflate compression support"
+	depends on ZRAM
+	select ZLIB_DEFLATE
+	select ZLIB_INFLATE
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -63,6 +69,10 @@ config ZRAM_DEF_COMP_ZSTD
 	bool "zstd"
 	depends on ZRAM_BACKEND_ZSTD
 
+config ZRAM_DEF_COMP_DEFLATE
+	bool "deflate"
+	depends on ZRAM_BACKEND_DEFLATE
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -72,6 +82,7 @@ config ZRAM_DEF_COMP
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
+	default "deflate" if ZRAM_DEF_COMP_DEFLATE
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 053fe35e346b..91c07595d8b4 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
-obj-$(CONFIG_ZRAM_BACKEND_ZSTD)		+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_LZO)			+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)			+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)		+= backend_lz4hc.o
+obj-$(CONFIG_ZRAM_BACKEND_ZSTD)			+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_DEFLATE)		+= backend_deflate.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
new file mode 100644
index 000000000000..949d402ea3dd
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zlib.h>
+
+#include "backend_deflate.h"
+
+/* Use the same value as crypto API */
+#define DEFLATE_DEF_WINBITS		11
+#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
+
+struct deflate_ctx {
+	struct z_stream_s cctx;
+	struct z_stream_s dctx;
+	s32 level;
+};
+
+static void deflate_destroy(void *ctx)
+{
+	struct deflate_ctx *zctx = ctx;
+
+	if (zctx->cctx.workspace) {
+		zlib_deflateEnd(&zctx->cctx);
+		vfree(zctx->cctx.workspace);
+	}
+	if (zctx->dctx.workspace) {
+		zlib_inflateEnd(&zctx->dctx);
+		vfree(zctx->dctx.workspace);
+	}
+	kfree(zctx);
+}
+
+static void *deflate_create(void)
+{
+	struct deflate_ctx *ctx;
+	size_t sz;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded Z_DEFAULT_COMPRESSION for now */
+	ctx->level = Z_DEFAULT_COMPRESSION;
+	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
+	ctx->cctx.workspace = vzalloc(sz);
+	if (!ctx->cctx.workspace)
+		goto error;
+
+	ret = zlib_deflateInit2(&ctx->cctx, ctx->level, Z_DEFLATED,
+				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
+				Z_DEFAULT_STRATEGY);
+	if (ret != Z_OK)
+		goto error;
+
+	sz = zlib_inflate_workspacesize();
+	ctx->dctx.workspace = vzalloc(sz);
+	if (!ctx->dctx.workspace)
+		goto error;
+
+	ret = zlib_inflateInit2(&ctx->dctx, -DEFLATE_DEF_WINBITS);
+	if (ret != Z_OK)
+		goto error;
+
+	return ctx;
+
+error:
+	deflate_destroy(ctx);
+	return NULL;
+}
+
+static int deflate_compress(void *ctx, const unsigned char *src,
+			    unsigned char *dst, size_t *dst_len)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *deflate;
+	int ret;
+
+	deflate = &zctx->cctx;
+	ret = zlib_deflateReset(deflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	deflate->next_in = (u8 *)src;
+	deflate->avail_in = PAGE_SIZE;
+	deflate->next_out = (u8 *)dst;
+	deflate->avail_out = *dst_len;
+
+	ret = zlib_deflate(deflate, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	*dst_len = deflate->total_out;
+	return 0;
+}
+
+static int deflate_decompress(void *ctx, const unsigned char *src,
+			      size_t src_len, unsigned char *dst)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *inflate;
+	int ret;
+
+	inflate = &zctx->dctx;
+
+	ret = zlib_inflateReset(inflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	inflate->next_in = (u8 *)src;
+	inflate->avail_in = src_len;
+	inflate->next_out = (u8 *)dst;
+	inflate->avail_out = PAGE_SIZE;
+
+	ret = zlib_inflate(inflate, Z_SYNC_FLUSH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	return 0;
+}
+
+struct zcomp_backend backend_deflate = {
+	.compress	= deflate_compress,
+	.decompress	= deflate_decompress,
+	.create_ctx	= deflate_create,
+	.destroy_ctx	= deflate_destroy,
+	.name		= "deflate",
+};
diff --git a/drivers/block/zram/backend_deflate.h b/drivers/block/zram/backend_deflate.h
new file mode 100644
index 000000000000..49cef8fc1e77
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_DEFLATE_H__
+#define __BACKEND_DEFLATE_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_deflate;
+
+#endif /* __BACKEND_DEFLATE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index c16eb038f608..9fc5477a6259 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -20,6 +20,7 @@
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
+#include "backend_deflate.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -34,6 +35,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
 	&backend_zstd,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
+	&backend_deflate,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

