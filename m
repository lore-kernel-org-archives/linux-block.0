Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D631411CF
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982332; cv=none; b=VzIta+L+o64DbVt2MfumihsfZZ9KY49SRS+W757c0HNtilWrJphd5vreZ3dzlc8FxLQ7NW80whsEUkaFE7p4Rw3U1OCMiECogKgJIBFbsE6P2e5QLfeu+QdPjnzTDwkmsaY1HwgEmBKl07dA5/iKTrlGJ5oO1CSsSOXXzT0f5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982332; c=relaxed/simple;
	bh=fwqjI0oJhsJ6IWcPj2TUi+YtZmx3QQeidZjvgSy1/xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl9Zns5Ul9Z9ipSjnu99IQ1hDkRJ2ivEipgHkZcri8ZYGrTvWiNT+Aq6GIX88H8n4h9gDNyCvehma3DUstAiulEMzJ4e1wlGtQEaK8/n55ahTGEEU4ks4D3chTey9NszwhqijbmO76QhnwB484/plGjigEbyPdbFvYJ5DfTETt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KzkdujRZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzkdujRZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso9764775ad.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982329; x=1715587129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUr6LRaWPPkzD2etszVDMza5JPEXKiMrJmq3EUCQIHI=;
        b=KzkdujRZdmF//QoBITEX4jredBIYFBEWx7AIDoJOHaLAZyqU9eno5yKpVXu5v2MmvO
         v2wTXafGOnMweH6YcUijDKbID5n4ESrZn73QGQ3n/gG284fcAevQxsq5KX1KpqGOUiC8
         e4T1Xt0bKMuXjsxdqsvazFCUgyzUzf9XIb8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982329; x=1715587129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUr6LRaWPPkzD2etszVDMza5JPEXKiMrJmq3EUCQIHI=;
        b=CChjqIRQJ9edcqNjanuzY9loBLuWlUZyuHer4S2+qBtpfsqALsnDmEOEz17F85u0xe
         65xV0CscPs0yJd1lBbVDz6z1xjpG3xP84lqFy2mYeCkeSDGy6or8SyKfdapCIfSMr0GE
         lCZw/EOJNZ3/wdwg4LnjQEnw6Bm9ijMQ1TwTL130W4rtJaU4HknZg2K510Vet8nlCEIm
         hLrmmmchkF/9pTtf5cAxmvqEm9zJjoqPfcdzijlBU6WqTSWOb1rCFdvcnrQZkvEWv/Zy
         aSde0IaIAibTRP5QNHwA6tIJMt9Oa0PPAQCqctbENnXC8yZeq4X7nZnTlnQjUPD6cjiR
         sehg==
X-Forwarded-Encrypted: i=1; AJvYcCUMuXiEnpxtb2p6xi4KckA4zCi5siJorSWkCcDYgD7fdHhYxWPvF1e2/Lgg0dKI2Lay13+k+iLtMl7O3iWM3RpLyJTeQ1ptFzcmiik=
X-Gm-Message-State: AOJu0YzosD56sUcsSSEkj9UM1wmyqk9PvHfo0RqC4dGNprNr4SmcaLcb
	OqE19A9g4YWWhLNjij6w6Lsg5GxE9ZOAi0O2bRYzAXOus1rJY1BwYRuAXYqnRg==
X-Google-Smtp-Source: AGHT+IE750YP2LajwswRiaw4bJrU4J8mGAKK7f8a+FAwgPbMcbI935faiFbWo4I7VSXEC0hWyn5oFw==
X-Received: by 2002:a17:902:ecc5:b0:1eb:d7ce:1946 with SMTP id a5-20020a170902ecc500b001ebd7ce1946mr9742490plh.52.1714982329560;
        Mon, 06 May 2024 00:58:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:58:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 02/17] zram: add lzo and lzorle compression backends support
Date: Mon,  6 May 2024 16:58:15 +0900
Message-ID: <20240506075834.302472-3-senozhatsky@chromium.org>
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

