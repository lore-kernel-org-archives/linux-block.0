Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1414EB20
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757428; cv=none; b=O7TXD//KD2d/ovb5STPp5SA+dvndTLxv3ajBdsbSygdlm/2C9Sowul0i6xCHExSltFu1QnW/ENQZAleRzGmwpoJCx9YJu9YfH8CFprJbkl2lNRgJMeKF0U59meg5JiLY+Ca3S5jyC4jYpRj315uT69SSDNkQMPhZ4mnUwwLUPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757428; c=relaxed/simple;
	bh=QIqKpR6W+iYpBKRdE8LyZOci6XU5F9QsGlMydzcKw90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOjIpW6KDxiNu+49WFKyBxuZkDJieOmI5LFZJNpDJSXbLwNB47TGJ5BhE0U8fbF9Eq/ri0/+eQcfZri5m3ElzfEt5CdnFNbrEslBtX5UhdGWB7OLHlaZyLAE0eRN0J01rO/mb6HkWRIQUp+/2a3Z9yu33cS+AAr46K97AMmadmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TqKtLYPJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TqKtLYPJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e651a9f3ffso37226155ad.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757426; x=1716362226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/3U4lC6hcVdfnHTL8Mc0HJ1E1QNWG67FTnBC8OLuFc=;
        b=TqKtLYPJJzfGx3mpymohFTwUklUkkKIHSdVKWhJAsSz8aW4dOO+OaKam8x6KfC889x
         NLSXtm+OXQDkNaOmG0+PcXXlX6ca+RvBY7ej8nMVcNddFoGd/CNY5Tl1TQGv8BlWn/RN
         1btDHINGL6t0k0+NDlPVD0D80Zvv9iIzl6og0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757426; x=1716362226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/3U4lC6hcVdfnHTL8Mc0HJ1E1QNWG67FTnBC8OLuFc=;
        b=mUAcCHhqcvjyImgxHnfUWkPquJ9gRnfz8sYJhrYN6NIhUWTiFM2+72Gm8UM6jCZyf4
         2NRC76A3btViaeRVexIE76uNhc09pC9aSVQVI4mnekRTbfyZmK1NLEee1UL1dxhNxUig
         +aZy+T076HrkxLdy7QtV1nqUkz5rDSnQpxw1zyXe7iWz+avqLgI8j1scLGIbbYLVccTa
         S7XLhl3jFY3HYqxgRkUDCjepwAMNB+azAssbS0ZLc+6WgyKQlqW4tswY2W4LVqAkJy5K
         /IF4X/ZofKa0nGX2svvbjCbLGyPgwenHno/ct6PHf7qlg56L2X87oZTUmR2TxXeOaRqL
         ++6w==
X-Forwarded-Encrypted: i=1; AJvYcCUg37cAW21ML5DWx7vCweRCJHZVn95OqJvzrbyWuAP5W+m85vude+G2L7qteHEqtfvknnPn0ywvW6pOfHNivnoNqwy+0YtXYR8IV4k=
X-Gm-Message-State: AOJu0YwUr8rvwmPOulmanf8EjCPmkrPXJRFOSH/gyIy8qGASmaZJd2RS
	Eyz1om6gbwDETJ8QaBxzFivJyzJJco9cC4K7zlk+BYb3gDM0RQ1adicc/wvE3MsXVk41/D7/vp8
	=
X-Google-Smtp-Source: AGHT+IFhFHm0P8O5jX9tenmwIWFZOdHgBJqiZN6RIu4mGkRSmngvUyxYc09i0GDOD/kiHYBPTyaQyA==
X-Received: by 2002:a17:902:ec89:b0:1eb:58d2:8739 with SMTP id d9443c01a7336-1ef43d0a009mr183267855ad.3.1715757426418;
        Wed, 15 May 2024 00:17:06 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:06 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 04/21] zram: add lz4hc compression backend support
Date: Wed, 15 May 2024 16:12:41 +0900
Message-ID: <20240515071645.1788128-5-senozhatsky@chromium.org>
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

Add s/w lz4hc compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig         | 11 +++++
 drivers/block/zram/Makefile        |  5 +-
 drivers/block/zram/backend_lz4hc.c | 73 ++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4hc.h | 10 ++++
 drivers/block/zram/zcomp.c         |  4 ++
 5 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index f1e76fc8431a..0d890a8d2dc4 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -26,6 +26,12 @@ config ZRAM_BACKEND_LZ4
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4HC
+	bool "lz4hc compression support"
+	depends on ZRAM
+	select LZ4HC_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -43,6 +49,10 @@ config ZRAM_DEF_COMP_LZ4
 	bool "lz4"
 	depends on ZRAM_BACKEND_LZ4
 
+config ZRAM_DEF_COMP_LZ4HC
+	bool "lz4hc"
+	depends on ZRAM_BACKEND_LZ4HC
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -50,6 +60,7 @@ config ZRAM_DEF_COMP
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
+	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 567f4434aee8..727c9d68e3e3 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -2,7 +2,8 @@
 
 zram-y	:=	zcomp.o zram_drv.o
 
-zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
-zram-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
+zram-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
new file mode 100644
index 000000000000..9bcc5aa19a2b
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -0,0 +1,73 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4hc.h"
+
+struct lz4hc_ctx {
+	void *mem;
+	s32 level;
+};
+
+static void lz4hc_destroy(void *ctx)
+{
+	struct lz4hc_ctx *zctx = ctx;
+
+	vfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *lz4hc_create(void)
+{
+	struct lz4hc_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
+	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+error:
+	lz4hc_destroy(ctx);
+	return NULL;
+}
+
+static int lz4hc_compress(void *ctx, const unsigned char *src,
+			  unsigned char *dst, size_t *dst_len)
+{
+	struct lz4hc_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
+			      zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4hc_decompress(void *ctx, const unsigned char *src,
+			    size_t src_len, unsigned char *dst)
+{
+	int dst_len = PAGE_SIZE;
+	int ret;
+
+	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (ret < 0)
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_lz4hc = {
+	.compress	= lz4hc_compress,
+	.decompress	= lz4hc_decompress,
+	.create_ctx	= lz4hc_create,
+	.destroy_ctx	= lz4hc_destroy,
+	.name		= "lz4hc",
+};
diff --git a/drivers/block/zram/backend_lz4hc.h b/drivers/block/zram/backend_lz4hc.h
new file mode 100644
index 000000000000..29c428a850e2
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZ4HC_H__
+#define __BACKEND_LZ4HC_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_lz4hc;
+
+#endif /* __BACKEND_LZ4HC_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 902bdaf7e299..f04f5844a23c 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
+#include "backend_lz4hc.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -26,6 +27,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
 	&backend_lz4,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
+	&backend_lz4hc,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

