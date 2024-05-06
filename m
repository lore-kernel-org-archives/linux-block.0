Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F8142E68
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982356; cv=none; b=bAYi2v06HU2rl9Pm2tOg3BpvKtwvlU1nAz7fqIfN/MRXFZga9zTLF0TBq/xrEHdflPyItVCZGWcPl07ANaSJc/sDEcn6p0Wqu0C1d2Nn3/kVjrAOVpqWc987aU+WgMqAsEp61paXgsARrSUhpjfDHgB+rZhnB7YS/ZvXfgvC4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982356; c=relaxed/simple;
	bh=kNJbXxfK8zdnskpjgM5oyiiq8zq2KQp2aiK9qKIm8Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaLLN45x8uix/18/wrM/0ZmcjjyoLd7h+LP8rBuCzYrgfny+RutjzjECD8tUncvex555LeilwmgidmzRKKBIb0g70SuMQDp924BF0wBz6c8akCIFpkDI4v2ykLwgcv9pHq0ycLC0wiAXs93GdovgWHBSOpkPOsiF0R8/ytY2dYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XkbjsdWa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkbjsdWa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so15914065ad.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982344; x=1715587144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=XkbjsdWaI5kxkxIsPYMcVSotFcCqJRHDQuhAsAM1zhvrp6SiZxgh41SgUFPjD+8fOb
         lbWN4drWqJTZLsUt7PX62p51vTsDJqO5JjVZwCGTNQjKTwbXPyitoNSVcrIxgjx141vW
         ywzSZayTzvkYpIlAyWCDUxYuObsxDMPx9RXb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982344; x=1715587144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=aO8JsHIeiGKWPXr2mQhwKwkiXuYmg6YWp5W6shilA/95luZyCwFyYlKn8ggEVpO0pr
         vyN2GoJuRyUn6WQDaN4VRim/Ggs+ta+dhzIsiQp+4n5WVbW5Ji1pZynW49Uzjz0QXoC8
         kPrURV4Ph5jZIyZcy+rz/CJU4a9/1Wgavk5nwmVF2JkjBXSUBSWzBXPcRayeNFKkN/FY
         jfJPNILd39RwBTKYAZiAFZq0zm8yOhXrKFF39w+iKDgslPQtrmaweVLCkWydO3dtiBEp
         6HxvguycWzOSeVpo9tCsuCT5u3gnDZvuU6BmhYKd5ze7TdDpocjty197Nkkfg9a715O/
         C1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCOYf+28KyFHywrhwcrDn9AeLwHPM31MKMP6wcG+6eAzHhS/RMYvFfyVvxi4UuH3u+npHpvpEJxxYeitC6I1aZYvjs+bC64OP0wL0=
X-Gm-Message-State: AOJu0Yzl26hL+AnetTSHNR57UMy+M+UY2hsnMMjFA1vQlAXAyY2nmpvk
	CRRXtu1gDhjk8tAAuqpy3V+47tEfHVuwQ/88rNxHXagHG9o2mSx4g/Ehem3Dlg==
X-Google-Smtp-Source: AGHT+IFvtTM7Cp4XRi4ugjU8maUmX0Y1BJMBzeXwG4uz5NGaWtdCrHH1ePjQEmZ/XZrKEMZrCdrJng==
X-Received: by 2002:a17:902:d2cd:b0:1e3:e1d5:c680 with SMTP id n13-20020a170902d2cd00b001e3e1d5c680mr13775583plc.63.1714982344547;
        Mon, 06 May 2024 00:59:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 08/17] zram: add 842 compression backend support
Date: Mon,  6 May 2024 16:58:21 +0900
Message-ID: <20240506075834.302472-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig       | 11 ++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_842.c | 68 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_842.h | 10 +++++
 drivers/block/zram/zcomp.c       |  4 ++
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/block/zram/backend_842.c
 create mode 100644 drivers/block/zram/backend_842.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 9dedd2edfb28..1e0e7e5910b8 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -44,6 +44,12 @@ config ZRAM_BACKEND_DEFLATE
 	select ZLIB_DEFLATE
 	select ZLIB_INFLATE
 
+config ZRAM_BACKEND_842
+	bool "842 compression support"
+	depends on ZRAM
+	select 842_COMPRESS
+	select 842_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -73,6 +79,10 @@ config ZRAM_DEF_COMP_DEFLATE
 	bool "deflate"
 	depends on ZRAM_BACKEND_DEFLATE
 
+config ZRAM_DEF_COMP_842
+	bool "842"
+	depends on ZRAM_BACKEND_842
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -83,6 +93,7 @@ config ZRAM_DEF_COMP
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "deflate" if ZRAM_DEF_COMP_DEFLATE
+	default "842" if ZRAM_DEF_COMP_842
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 91c07595d8b4..029827a6ddac 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ZRAM_BACKEND_LZ4)			+= backend_lz4.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)		+= backend_lz4hc.o
 obj-$(CONFIG_ZRAM_BACKEND_ZSTD)			+= backend_zstd.o
 obj-$(CONFIG_ZRAM_BACKEND_DEFLATE)		+= backend_deflate.o
+obj-$(CONFIG_ZRAM_BACKEND_842)			+= backend_842.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
new file mode 100644
index 000000000000..8ea7a230b890
--- /dev/null
+++ b/drivers/block/zram/backend_842.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sw842.h>
+#include <linux/vmalloc.h>
+
+#include "backend_842.h"
+
+struct sw842_ctx {
+	void *mem;
+};
+
+static void destroy_842(void *ctx)
+{
+	struct sw842_ctx *zctx = ctx;
+
+	kfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *create_842(void)
+{
+	struct sw842_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->mem = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+
+error:
+	destroy_842(ctx);
+	return NULL;
+}
+
+static int compress_842(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct sw842_ctx *zctx = ctx;
+	unsigned int dlen = *dst_len;
+	int ret;
+
+	ret = sw842_compress(src, PAGE_SIZE, dst, &dlen, zctx->mem);
+	if (ret == 0)
+		*dst_len = dlen;
+	return ret;
+}
+
+static int decompress_842(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst)
+{
+	unsigned int dlen = PAGE_SIZE;
+
+	return sw842_decompress(src, src_len, dst, &dlen);
+}
+
+struct zcomp_backend backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.create_ctx	= create_842,
+	.destroy_ctx	= destroy_842,
+	.name		= "842",
+};
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
new file mode 100644
index 000000000000..c03a2396d7b2
--- /dev/null
+++ b/drivers/block/zram/backend_842.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_842_H__
+#define __BACKEND_842_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_842;
+
+#endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 9fc5477a6259..2a38126f4da3 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -21,6 +21,7 @@
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
 #include "backend_deflate.h"
+#include "backend_842.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -38,6 +39,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
 	&backend_deflate,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
+	&backend_842,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

