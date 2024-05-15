Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81C46424
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757423; cv=none; b=NpZotvW6gu3C2hETQYklJLxM0FjbT5/0bBvWQrlwcxMagcK0K7DGqR0yftzyxs4uTcRVbIPpG+cYOh3smSYqpYX2qKIVB9uPeDnIda/tEdLip+8OSSSh5cRgy1D2HOuuu6dCOwmx7soPP0g+WURtcdPmNLnhSITgHXIl/oRDmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757423; c=relaxed/simple;
	bh=SQspApLzR6A+qI3ABji2AwHeyysKKTXjPbdBT7c8Ig8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5ak9Bxeawj8YY1NxHpcKMKNw4BqCk/21JvRDAu3fQYmw8pjlZFKDIddS84ZIYZfGUzudAEylmZbtfGgXpl2NnZf6jg9mffT9KvNTqY+z5i81DZpAaVkKqUQKcnnDNyWQ+EuMEwfjjUdaHSQOo56LqhC80H3awxOoCRXnQ9pBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aGT3GKz7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGT3GKz7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1edc696df2bso56594915ad.0
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757421; x=1716362221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHiH39OlVbbyYOoV0PVG81/IjMwGnGQnqALJjuzf7+o=;
        b=aGT3GKz7+tMGUzCxJW/Ezcs3m9E++MTurLqHSz5AOQOrIUipU1671dzGqM1nXcP61w
         6r1+TqTp/+GmxYqAV4tmyt1zosJBeNmibXN3l1+Ri7umUkgsXjwM7Rls5MM9ChDSnjVF
         Wle+YjbC54Kdqd31XWNU4A0v6nDcS1SmHPGeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757421; x=1716362221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHiH39OlVbbyYOoV0PVG81/IjMwGnGQnqALJjuzf7+o=;
        b=pchKL0bpuINbPPEzxseHImzAWOxfDCgCdbNA3Orjlsl69tMQ+R+fLiPwlE6LvDvNlr
         bsP8pkDINWidKb3UrHndejcn4xNERomV0YDt0Ha/OK96DnpfsUKiIQqXDGs6sYUFc90B
         0GXESOyLSqgAp+DerxlrVxJRJ7L8KBXmrkHXaoJfEAjUDc02bsDpI15buj7mWw33gaBU
         e2BFiBFG6q+QzR5BQGOmSmQ8UstDbZvQr3p1caJpp/KKDuv4ZGvO3qEvi1Z+v081RpcS
         YsmEjQAfrMDcpfNnEkkeoc04AMnOxf7/6+HdZUIDu+EqNSlGcotCWOZMeTLrSSflWDc9
         Xe5A==
X-Forwarded-Encrypted: i=1; AJvYcCWfQYlzNTb65ChhPyNWiveUz6YE88prsStPmhyxQZa5hDTW3ymqipIMWZKA7Lh6HtiSIqhdAsd3cKPpDV3oOCSJPeya7/+gBYsGzVM=
X-Gm-Message-State: AOJu0YyAxyJClhafD1ar57EFyHXC5CmEyLAy5tinv534yGJbs26pr13K
	AZpOdOaYWDb7yI9OOGUXDagDH2RwvKns+ujZ0Cbe8XP3EY9r+AHVfnApt1bmzXZhqlkZIp/+e+I
	=
X-Google-Smtp-Source: AGHT+IFL9UyLu26jE4g+X6OYAAQOaCxw87D8rJNv/C2yKEFY7GXkl4F5s/LdrGfAqTySIEcbf+3Imw==
X-Received: by 2002:a17:902:7b87:b0:1ea:9585:a1d7 with SMTP id d9443c01a7336-1ef43e293d9mr148335675ad.37.1715757421264;
        Wed, 15 May 2024 00:17:01 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:00 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 02/21] zram: add lzo and lzorle compression backends support
Date: Wed, 15 May 2024 16:12:39 +0900
Message-ID: <20240515071645.1788128-3-senozhatsky@chromium.org>
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

Add s/w lzo/lzorle compression support.

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
index de9e457907b1..2a3db3368af9 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
 zram-y	:=	zcomp.o zram_drv.o
 
+zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+
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

