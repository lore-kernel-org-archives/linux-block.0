Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0393E485
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154164; cv=none; b=qDgLLBHsFFjER0QgcdMwQl3JCuWOEp/+UeexbYm/R3/AjEPKudUTz9wkhhqNq3YMm8AwZ9MxM4IRLxkCZvjHaLkjsgwlWxExOiaKhN7lbrr+570uu/EVSTaqgGGme9L+Ck+TgxQG2pWKZYOJVsRZFO6EUZotsXzKTrCyfN9vbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154164; c=relaxed/simple;
	bh=DHL8kqd+RNQDM+Stwrc0IUTkOPk9/Cbf5eFqQlFrF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLNW8Ov4Jb9gpaFKXCW1NqvocR7m/re8vOeh7f42Gr7L03GgopDht/eidXKlR3OWv1Rgz9XOSznHNTLN0OyiKsYgH2g7B4vKBegoKtAmlKFYBKqGnRaEpZnwJoxnhtHP0TXnEYvKEQMzGQl6c8RaNRh79gRqZgo1J9Irfxc7vDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XFNZJi4H; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFNZJi4H"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b37731c118so3114585a91.1
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154162; x=1715758962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjjXoB1vjVFge1iRvQDKKfu041t9IBLi05g+C6qi2oA=;
        b=XFNZJi4HvIhzDQkvWmhx+ztq8DZ9wYJDktaj5M4DG1OqaAcygfmNWG/jq5Nwanyws0
         0OSN7c6jpZtvl+DdV/gsRCrXblo3AVIsbl/J0OhomhyqMKk18gNH22PtMe8ozuS0MZRR
         glLRxPPwjgf/fXqEIx+zAVu5hup0/gadW1Hbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154162; x=1715758962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjjXoB1vjVFge1iRvQDKKfu041t9IBLi05g+C6qi2oA=;
        b=ErHHbobuYvWEH2cJg5PhCwMgeRSKhN627qdnoky5ndK3VcXDOsn5bHmbeppqm4bPEA
         SGk9cGxXO5gEL+8nkBiCuHTJeqiSl4vXyTug8DJKlIls/ebVgplWcRzl10n3LzOg2/0P
         m/enjac0JCck+w9m3DWi4rZ/GwW1GTpVqDD5yzHsnnCd13OBkOnWDMyNBlCGx9VEZCam
         Jqko920d3dZqN/DadBdALXs5ZRBY/Di5YA0lu219WsrfrCaCHpqfr+TZ4CW27FJTK7vK
         dNmZjaQbDdiSWEYQQxC0VVrIfScvLbi04N+5Ks2uhJ0MER6yYJ9RMEc4SeR1Ds7c60nl
         iGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVG8snLm56mXGl3IAfL60rtBSaEj5067dxcPHhH09tActFyNqHhSI9J2ePm4TrZwhEJ7ht0Lz/ihW4KP6OwfxEMhhRvLHUSSPUPewc=
X-Gm-Message-State: AOJu0YznoJS5sDqhHiIDSku8BUi99WMv2AFRzVlZ3vhnm7V0QKajQ73V
	Mlxm99B+SaeqtdV01Pd6owEOthDlHCpp/XAXcqqGbW7ZkgZxA1WZPvL3vMVYSQ==
X-Google-Smtp-Source: AGHT+IEP96o73mZK4rztyE8+OYRQzbQHXnDNHKL0xwt4vZPXv9Ss/NhZbOzE9smjMNBdXZ+cLY8buQ==
X-Received: by 2002:a17:90a:c001:b0:2b2:b1c7:5fd7 with SMTP id 98e67ed59e1d1-2b616be23b9mr1538063a91.30.1715154162123;
        Wed, 08 May 2024 00:42:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:41 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 03/19] zram: add lz4 compression backend support
Date: Wed,  8 May 2024 16:41:56 +0900
Message-ID: <20240508074223.652784-4-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig       | 11 ++++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_lz4.c | 47 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4.h | 10 +++++++
 drivers/block/zram/zcomp.c       |  4 +++
 5 files changed, 73 insertions(+)
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

