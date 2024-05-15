Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E648CCD
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757426; cv=none; b=KbQjDigDrOLwgqNSS1Ua/MuGn3Ea7ZWs+bPnJMp24QN5JMPgYXQF4+pxBqB+ALXn4HXLfTAiirJ0bvAVYnmuiLyj7E0wLbiJIQf6t2TVwmWRuYeiodgFFP2FrzjB8b4PAJiRCxJ9n+xJET4Dt/6tMcmRmR0ld6cIBQouBJO/KTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757426; c=relaxed/simple;
	bh=YnePQvm5yTrRFyDy+nrRta3ObTgqKOo4iqn1FqtURHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM6cak/y9wBS4JhB6vbXh+Jyrpnpx7n6zTwtApJlo49GTuCJ1oB/itllgLGBcbjCCzEjRgujY0haWURvpvPOcoc5zKu2QRhUeW23oZF51hmCj5AO0UqkrdlEP0/4OfOeA65a3iVTUptayiNbjjBqL8+Q7a6H89fYZUg9C7M9lf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vw+WBCOZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vw+WBCOZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso46473675ad.0
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757424; x=1716362224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y1JEx/byw+/lYPDinjRUJ1Lo0uZERSy7KI3xtlcbP0=;
        b=Vw+WBCOZaKo9SWdEdeLIPfENpcr8UAHjh3BRSzFyrj9WX2igxbRzDaDPXR/1kFESa4
         ZKQ7sdIlW3SMwiPk8Tlz94WtGScKDAP7jWLTxCY59b1TySsQhU0ML7ZmZcTy+fOlXHK7
         T34iemPWtcpVZxQWJemp/wtuUJR6DPepUVw/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757424; x=1716362224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y1JEx/byw+/lYPDinjRUJ1Lo0uZERSy7KI3xtlcbP0=;
        b=OAQV47+mT/uysohgJY6JMhsgKoJrxnh6jNyO+VLEw7eNeVRoOsiBP4tfwkYmcfkdJF
         GT6JIVQjFKtUyNvJwcV0eeyNAVik5yoiS9g7+CTWtzGgbellm4OWriYhsTy3Bi6JtOCo
         7ak4lF/uncgI9ssdlEShseVqWeu8e9VSfmo5x8D7Q8+MRqdYGRQv1kXi0dmK7Yndy/Ch
         1Rakr6sjeBuSkeb64wLQIUTKo9ZZgAJE5wFuQoZEYjNUtflPqxco54OFR9fIUPzpwfCi
         k4UELcIgzfRqqotjZw5UxGx2miDamKiJNyCBwqyeVnp9upajSnO67YH0XFaFulmVbN+4
         LVjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNYRS1Stew4p3ULyQu2+j6uZPt4B7wVG+L/1VKJlUFDgxTeXYfSDswXLtn/kLPg0Ra6mWGqhaH0cWWSlIxog/YbuPcFCnNyI2cTA=
X-Gm-Message-State: AOJu0YzyuFrjTC/1SAIzCVWDWiYR3LL4lKHjjV7RppGuPwi3ZXaIxaRu
	Ak35JMeZL5a0/X/e2jyJO08MFojfzKMrAOzJ3WCG/wLfRfMzfAsknFIDCXLl8g==
X-Google-Smtp-Source: AGHT+IFpWjl6eRWiof5dtv+ykNbLzv4SU4wXOuUgvzR9ccRXR+//FCr7TGf87zxYfy5eESFA9z9pJw==
X-Received: by 2002:a17:902:b111:b0:1eb:d914:64e4 with SMTP id d9443c01a7336-1ef43e25f72mr142390235ad.32.1715757423975;
        Wed, 15 May 2024 00:17:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 03/21] zram: add lz4 compression backend support
Date: Wed, 15 May 2024 16:12:40 +0900
Message-ID: <20240515071645.1788128-4-senozhatsky@chromium.org>
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

Add s/w lz4 compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig       | 11 +++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_lz4.c | 73 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4.h | 10 +++++
 drivers/block/zram/zcomp.c       |  4 ++
 5 files changed, 99 insertions(+)
 create mode 100644 drivers/block/zram/backend_lz4.c
 create mode 100644 drivers/block/zram/backend_lz4.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 5d329a887b12..f1e76fc8431a 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -20,6 +20,12 @@ config ZRAM_BACKEND_LZO
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4
+	bool "lz4 compression support"
+	depends on ZRAM
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -33,12 +39,17 @@ config ZRAM_DEF_COMP_LZO
 	bool "lzo"
 	depends on ZRAM_BACKEND_LZO
 
+config ZRAM_DEF_COMP_LZ4
+	bool "lz4"
+	depends on ZRAM_BACKEND_LZ4
+
 endchoice
 
 config ZRAM_DEF_COMP
 	string
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
+	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 2a3db3368af9..567f4434aee8 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -3,5 +3,6 @@
 zram-y	:=	zcomp.o zram_drv.o
 
 zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
new file mode 100644
index 000000000000..6ea67511d782
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.c
@@ -0,0 +1,73 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4.h"
+
+struct lz4_ctx {
+	void *mem;
+	s32 level;
+};
+
+static void lz4_destroy(void *ctx)
+{
+	struct lz4_ctx *zctx = ctx;
+
+	vfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *lz4_create(void)
+{
+	struct lz4_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded LZ4_ACCELERATION_DEFAULT for now */
+	ctx->level = LZ4_ACCELERATION_DEFAULT;
+	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+error:
+	lz4_destroy(ctx);
+	return NULL;
+}
+
+static int lz4_compress(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct lz4_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_fast(src, dst, PAGE_SIZE, *dst_len,
+				zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4_decompress(void *ctx, const unsigned char *src,
+			  size_t src_len, unsigned char *dst)
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
+struct zcomp_backend backend_lz4 = {
+	.compress	= lz4_compress,
+	.decompress	= lz4_decompress,
+	.create_ctx	= lz4_create,
+	.destroy_ctx	= lz4_destroy,
+	.name		= "lz4",
+};
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
new file mode 100644
index 000000000000..a5fb5564835c
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZ4_H__
+#define __BACKEND_LZ4_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_lz4;
+
+#endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 58fb3ac91f4b..902bdaf7e299 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -17,11 +17,15 @@
 
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
+#include "backend_lz4.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
 	&backend_lzorle,
 	&backend_lzo,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
+	&backend_lz4,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

