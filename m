Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A63B1AE
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154163; cv=none; b=UnfvPSrxL111H9Fw/rH5qHM4BoIXWNKrQhZUBvujaqNHu7OYtTdVpUV0VkuyIh6DfSBvoJJwx21PNLiWfUN8ds91gjgKMwltfgJSxTF5xqcC0ljV8dC111vP0+jDobv/4DDxlUj5iAYUXXo7haZxgzBHpMlL20z+ajXUkxF6PQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154163; c=relaxed/simple;
	bh=fwqjI0oJhsJ6IWcPj2TUi+YtZmx3QQeidZjvgSy1/xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h45rEsjSgwpPaUD4PdYXS4V5mXPUuIZel+37AAZt0JzYd3AvRdcCuXOg/6mHaNMAchdrvj8Ieey0MSOcAj6QrMsnmazuyTfp8hm4iH1j2qrphsftqLBOTUgYri/fyNaWgQ3qK23LQIabaDFdhksQHoBnXCimW3pB9n+PZslrNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O00YgaVt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O00YgaVt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b2bc7b37bcso3492566a91.2
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154160; x=1715758960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUr6LRaWPPkzD2etszVDMza5JPEXKiMrJmq3EUCQIHI=;
        b=O00YgaVty94AsK17uKUCbD/JhgikEa8rc0N6DCZ8mnY5qKj6l/e5HC3Xov9iwHksMa
         6kn4utRXVlizLXtKRFcm5A03l/Li14cq7SIzcrbGmQPyqsjyJxvokavyEhYPBvNe3bbS
         S9stMTj3B539NTDhJHgGTZyfe0WiCgqU+WXGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154160; x=1715758960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUr6LRaWPPkzD2etszVDMza5JPEXKiMrJmq3EUCQIHI=;
        b=NLW+JjI3dIjxmXtiev2/Qq8Wcrfb/YidJFofjHozDuRmLZvOp5eiJ+pyiv7O62uWKj
         y9FpWrQX5YKTrW9jdMxHWYcUrmXTT39NoqZCOofDlNaJrmDr3NbgvF6uSvGcdcpFQzLO
         /xP7rDRN/8qmFid7znO3pBB+5tqjeJIFWmDNBiyld7GKGQ5ZL4blewS0h0nGVUp8r08T
         9/i52EqY4ThZdKDfkf8eMYg6mhK0hkAZ7YGluYyo8YAHsHD50ZJmMvX6D4LxFaiSla3Q
         wxWSTTH5dvRe1HVjZVm2jB8JJBd3cLte2/SYkhffQHStELai+4/0eCfV54IduSd6M4wr
         0YUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWZP3qjJmZ+T9zImBYHsAYKXQaYgC3DAVv9gRrvgz4ByRrdF5hFtD4iE9LiKFOYJsR1q/nZWT1UiwkXVQbM6C3RIcwQJ6WF2Fj8RQ=
X-Gm-Message-State: AOJu0Yw/DdohPTpME5irCDxmjqq4U3slkTtjhpGRVd/nIkT3ybZVDI15
	b1pC4WUyDAhKDDVWHJYHYn8h6fNjolOg098PC3+es12L9kAHiipmFFgqepcpcA==
X-Google-Smtp-Source: AGHT+IFK1adbyQut7TJL1cvR0x0aBrGL77aQAU4STPf/S0CRUyW6lbjvBTtWy12MICu+3tfpN4KMvw==
X-Received: by 2002:a17:90b:891:b0:2b4:abc7:d64b with SMTP id 98e67ed59e1d1-2b6163a0616mr1809932a91.6.1715154159769;
        Wed, 08 May 2024 00:42:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 02/19] zram: add lzo and lzorle compression backends support
Date: Wed,  8 May 2024 16:41:55 +0900
Message-ID: <20240508074223.652784-3-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig          | 23 +++++++++++++++
 drivers/block/zram/Makefile         |  3 ++
 drivers/block/zram/backend_lzo.c    | 44 +++++++++++++++++++++++++++++
 drivers/block/zram/backend_lzo.h    | 10 +++++++
 drivers/block/zram/backend_lzorle.c | 44 +++++++++++++++++++++++++++++
 drivers/block/zram/backend_lzorle.h | 10 +++++++
 drivers/block/zram/zcomp.c          |  7 +++++
 7 files changed, 141 insertions(+)
 create mode 100644 drivers/block/zram/backend_lzo.c
 create mode 100644 drivers/block/zram/backend_lzo.h
 create mode 100644 drivers/block/zram/backend_lzorle.c
 create mode 100644 drivers/block/zram/backend_lzorle.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 8ecb74f83a5e..5d329a887b12 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -14,8 +14,31 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support"
+	depends on ZRAM
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
+choice
+	prompt "Default zram compressor"
+	default ZRAM_DEF_COMP_LZORLE
+	depends on ZRAM
+
+config ZRAM_DEF_COMP_LZORLE
+	bool "lzo-rle"
+	depends on ZRAM_BACKEND_LZO
+
+config ZRAM_DEF_COMP_LZO
+	bool "lzo"
+	depends on ZRAM_BACKEND_LZO
+
+endchoice
+
 config ZRAM_DEF_COMP
 	string
+	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
+	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index de9e457907b1..2dcbc9b75d91 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+
 zram-y	:=	zcomp.o zram_drv.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
new file mode 100644
index 000000000000..b88b408964cd
--- /dev/null
+++ b/drivers/block/zram/backend_lzo.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/lzo.h>
+
+#include "backend_lzo.h"
+
+static void *lzo_create(void)
+{
+	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+}
+
+static void lzo_destroy(void *ctx)
+{
+	kfree(ctx);
+}
+
+static int lzo_compress(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = lzo1x_1_compress(src, PAGE_SIZE, dst, dst_len, ctx);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+static int lzo_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst)
+{
+	size_t dst_len = PAGE_SIZE;
+	int ret;
+
+	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+struct zcomp_backend backend_lzo = {
+	.compress	= lzo_compress,
+	.decompress	= lzo_decompress,
+	.create_ctx	= lzo_create,
+	.destroy_ctx	= lzo_destroy,
+	.name		= "lzo",
+};
diff --git a/drivers/block/zram/backend_lzo.h b/drivers/block/zram/backend_lzo.h
new file mode 100644
index 000000000000..377ccb7389e2
--- /dev/null
+++ b/drivers/block/zram/backend_lzo.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZO_H__
+#define __BACKEND_LZO_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_lzo;
+
+#endif /* __BACKEND_LZO_H__ */
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
new file mode 100644
index 000000000000..9bf1843021b0
--- /dev/null
+++ b/drivers/block/zram/backend_lzorle.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/lzo.h>
+
+#include "backend_lzorle.h"
+
+static void *lzorle_create(void)
+{
+	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+}
+
+static void lzorle_destroy(void *ctx)
+{
+	kfree(ctx);
+}
+
+static int lzorle_compress(void *ctx, const unsigned char *src,
+			   unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = lzorle1x_1_compress(src, PAGE_SIZE, dst, dst_len, ctx);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+static int lzorle_decompress(void *ctx, const unsigned char *src,
+			     size_t src_len, unsigned char *dst)
+{
+	size_t dst_len = PAGE_SIZE;
+	int ret;
+
+	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+struct zcomp_backend backend_lzorle = {
+	.compress	= lzorle_compress,
+	.decompress	= lzorle_decompress,
+	.create_ctx	= lzorle_create,
+	.destroy_ctx	= lzorle_destroy,
+	.name		= "lzo-rle",
+};
diff --git a/drivers/block/zram/backend_lzorle.h b/drivers/block/zram/backend_lzorle.h
new file mode 100644
index 000000000000..5c1db65a38a4
--- /dev/null
+++ b/drivers/block/zram/backend_lzorle.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZORLE_H__
+#define __BACKEND_LZORLE_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_lzorle;
+
+#endif /* __BACKEND_LZORLE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 0d0d2e6dbaa9..58fb3ac91f4b 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,7 +15,14 @@
 
 #include "zcomp.h"
 
+#include "backend_lzo.h"
+#include "backend_lzorle.h"
+
 static struct zcomp_backend *backends[] = {
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
+	&backend_lzorle,
+	&backend_lzo,
+#endif
 	NULL
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

