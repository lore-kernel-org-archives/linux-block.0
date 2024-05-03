Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7214F9F0
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727925; cv=none; b=DhUWK3L+vTdUloKb0IuYowZ+Z/rzwEFL6vWtT4EkjB/q6puG8Jk9mK3DCm7vZkusNZtxvqmHtS1QFUPLfboaFJx/e+YDI/YQaFJjvGnWUI0D3+TNwWpzHNiiwIO4tI0ygEBajl1qi5QMho1Gu0szSghmqkEbq7Ig3z5ZkqTxMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727925; c=relaxed/simple;
	bh=EKAT1WJh1EliVsTf5ivSjhdf0Ww0Lxw//zNfOlfD/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1/XvIY+nWaGUNgKfnlN+HiwhMO5l0fBexJLVyaNYuSoa2SFiSBhdcpHp07trj49c0l4wml1yf/hFkoTKCuARZWHt6y85OszKrDZ0s1OCEj7GskhnW9DOqtpkAVfWvd3v7/QxFng9Iza06WB77juLfOl0MdqtH6QM2UudAOITPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvfitemo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvfitemo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4302187c0so1528795b3a.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727923; x=1715332723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVS3+TSlg0IqVrQHwIV1m7p4VAUVoaOGVLA7sdPdngs=;
        b=gvfitemoeBBMYIjFQz43cgxT49nmrxppM1yjkSPhjE23jj8KkvbI5LV9K/UW/hIhD8
         /dvFGcY0OT+jGwn6f4+BfYfyh/VOdVTDxKMNE8FFNYry/ckxNwaNC5bVn/UMnQ6+VGJD
         DwowwjT1Rb+1kfZPG3Fw9KW1VbPRvi4sZNfOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727923; x=1715332723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVS3+TSlg0IqVrQHwIV1m7p4VAUVoaOGVLA7sdPdngs=;
        b=uI/ioOWDBgodEPodSv5qQ5YZnKxdO2lHvQXhwkM3gQUqMdfon/0pZgMT9at4VXPZ6L
         nHXakJ4kw8ZF5Yx1Xrr+LoBNHxbtwWXG0uPbo9Q8z7qUjFEg3aclX8UK+J4WESIcB0sv
         PE9QUPyLeg2mgeatjfpAsqHtv3tYEafJsjiZ6Pu/t5jOhCLOu56pbPH5RG4sOdQm18pr
         xyNLPnFwS6D85Xv7FWzXqa4byWJmrxRpbT/H6Iz3mX+PWaY13T8GWmfe76/L/U+eUHuu
         CttpJ/XEXaE2QmuZeD0jUIB5Jo/Tjq+sP56+uSJsiWI+qMLTLGZqeL67MduX7EuvfA7h
         BjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWofPDcjJnbAuX4H5dRbQlIPF65cm1ZgMht45tizlgUv2z4HbY83q/5vG26u8bEu0uEAp5HyzriP4Wp999tBqEs86QiF9rF3qyzKEc=
X-Gm-Message-State: AOJu0Yz1O6Vj/hwRCnjldnPRrSz6WAujaAJflsz/KAZ0i4dsswXNKDHv
	mq65AekW0S3llRNz3X+9iQxGJXkP/xdGEkqDmcQsAnE3HiyzLrFah0oscTWTng==
X-Google-Smtp-Source: AGHT+IHpun0/Mf7vhFFOo7XO2Awdr9+kxI65A2c+6ONOuFY9pNRz/FqYS7TM3psXW6WeZSYOCJ5Lqw==
X-Received: by 2002:a05:6a20:c91c:b0:1a9:509c:eba6 with SMTP id gx28-20020a056a20c91c00b001a9509ceba6mr2972873pzb.25.1714727923145;
        Fri, 03 May 2024 02:18:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 03/14] zram: add lz4 compression backend support
Date: Fri,  3 May 2024 18:17:28 +0900
Message-ID: <20240503091823.3616962-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig       | 12 ++++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_lz4.c | 47 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4.h | 10 +++++++
 drivers/block/zram/zcomp.c       |  4 +++
 5 files changed, 74 insertions(+)
 create mode 100644 drivers/block/zram/backend_lz4.c
 create mode 100644 drivers/block/zram/backend_lz4.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index a1fe8b989ee2..02d20a30bf6c 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -21,6 +21,13 @@ config ZRAM_BACKEND_LZO
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4
+	bool "lz4 compression support"
+	depends on ZRAM
+	default n
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -34,12 +41,17 @@ config ZRAM_DEF_COMP_LZO
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
index 2dcbc9b75d91..1be5d2657960 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
new file mode 100644
index 000000000000..697592dbabe2
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.c
@@ -0,0 +1,47 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4.h"
+
+static void *lz4_create(void)
+{
+	return vmalloc(LZ4_MEM_COMPRESS);
+}
+
+static void lz4_destroy(void *ctx)
+{
+	vfree(ctx);
+}
+
+static int lz4_compress(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len, ctx);
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

