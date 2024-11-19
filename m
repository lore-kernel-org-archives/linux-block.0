Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7861C4A30;
	Tue, 19 Nov 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019276; cv=none; b=BPBBhA8CMWiHCVoLgt1A+/efuFQg17sQOc8VbNbkaeDeiLo9FDyqf0L7+8rOPhqY7igRa/8VGa685mQuNjp6ncSwblx7pMqSQ/9XgLbVLWUEg/ehLBp5DsoRSYXQgN+SB5L9QvHpHKDHQidIIUrVl6pPaTljNEWS0ZB0Qc3kWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019276; c=relaxed/simple;
	bh=D42lwy9xTWB8QZAX6iLYR+0ZcB03TZzQs8+MPtuypKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/HheSre7B4nL4ASLSaw+oerKGxBKfWQBqID2Vy1U3UpkcRDTh1wsf5MFOgJFZQBHVegBEVSBesV/XLjACUNgIfm1D6y0nl5K1CKRRK+uFLYu+zehyry0D3lpXrwKADTLB1B0nHKO8ow3lieuA7DTX8JFwOrWPxBLlqDyni7gCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fZGGKIkF; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fZGGKIkF"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 915A012000E;
	Tue, 19 Nov 2024 15:27:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 915A012000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732019265;
	bh=QPcceA5eUH/BK4VLP8TE3Yj5nWTGC8/LNbJPjG20oq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=fZGGKIkFMcs3xCmuEZD/WImBrSaAS270UESsScgWk43gHnJTOTpil62Zsb29Ay7T5
	 gmsj62R2+gRNsp+r7x/LBqkUXnbdmG87mhqFvAzeBYOHTDSkTfhQL+zAYFd391gLS5
	 eXxySujWc8n1BnR27PWG6cwDIDV63lfpyAHnfdjpWHUbwCQeMy8mpvh1V8Hq8Mkrm+
	 6tPjBUI6AWl8jaYEFJ2ldYG9NqDnuPBbrXVsmlnaNG1Sxc3WbcHqaBLTwXqMLUTHwn
	 LgVBa4bLCZWeK7ftG6txaubnvAJo2OA8R56Ua+R1adSx0silJVTfCHAgeimazbTFfS
	 FRnNUO1JvcSPA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:27:45 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
	<terrelln@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 3/3] zram: introduce crypto-api backend
Date: Tue, 19 Nov 2024 15:27:13 +0300
Message-ID: <20241119122713.3294173-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119122713.3294173-1-avromanov@salutedevices.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Since we use custom backend implementation, we remove the ability
for users to use algorithms from crypto backend. This breaks
backward compatibility, user doesn't necessarily use one of the
algorithms from "custom" backends defined in zram folder.
For example, he can use some driver with hardware compression support.

This patch adds opinion to enable Crypto API: add ZRAM_BACKEND_CRYPTO_API.
Option is enabled by default, because in previously version of ZRAM
it was possible to choose any alogirthm using Crypto API. This is
also done for backward compatibility purposes.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/zram/Kconfig              |  10 ++
 drivers/block/zram/Makefile             |   1 +
 drivers/block/zram/backend_crypto_api.c | 117 ++++++++++++++++++++++++
 drivers/block/zram/backend_crypto_api.h |  10 ++
 drivers/block/zram/zcomp.c              |  73 +++++++++++++--
 5 files changed, 203 insertions(+), 8 deletions(-)
 create mode 100644 drivers/block/zram/backend_crypto_api.c
 create mode 100644 drivers/block/zram/backend_crypto_api.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 6aea609b795c..672578040912 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -57,6 +57,16 @@ config ZRAM_BACKEND_LZO
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 
+config ZRAM_BACKEND_CRYPTO_API
+	bool "Enable support for compression algorithms available in Crypto API"
+	depends on ZRAM
+	default y
+	select CRYPTO
+	help
+	  If you still want to use Crypto API as a backend, enable this option.
+	  All compression algorithms enabled on your system will be available in ZRAM.
+	  This option is useful if you are using hardware compression using any driver.
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..d12d03a01f35 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -8,5 +8,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
 zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o
+zram-$(CONFIG_ZRAM_BACKEND_CRYPTO_API)	+= backend_crypto_api.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_crypto_api.c b/drivers/block/zram/backend_crypto_api.c
new file mode 100644
index 000000000000..1cd792b77aac
--- /dev/null
+++ b/drivers/block/zram/backend_crypto_api.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/crypto.h>
+
+#include "backend_crypto_api.h"
+
+struct crypto_api_ctx {
+	struct crypto_comp *tfm;
+};
+
+extern struct list_head crypto_alg_list;
+
+static void crypto_api_release_params(struct zcomp_params *params)
+{
+}
+
+static int crypto_api_setup_params(struct zcomp_params *params)
+{
+	return 0;
+}
+
+static int crypto_api_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
+{
+	struct crypto_api_ctx *crypto_ctx;
+	const char *algname = zcomp->ops->name;
+
+	crypto_ctx = kzalloc(sizeof(*crypto_ctx), GFP_KERNEL);
+	if (!crypto_ctx)
+		return -ENOMEM;
+
+	crypto_ctx->tfm = crypto_alloc_comp(algname, 0, 0);
+	if (IS_ERR_OR_NULL(crypto_ctx->tfm)) {
+		kfree(crypto_ctx);
+		return -ENOMEM;
+	}
+
+	ctx->context = crypto_ctx;
+
+	return 0;
+}
+
+static void crypto_api_destroy(struct zcomp_ctx *ctx)
+{
+	struct crypto_api_ctx *crypto_ctx = ctx->context;
+
+	if (!IS_ERR_OR_NULL(crypto_ctx->tfm))
+		crypto_free_comp(crypto_ctx->tfm);
+
+	kfree(crypto_ctx);
+}
+
+static int crypto_api_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			       struct zcomp_req *req)
+{
+	struct crypto_api_ctx *crypto_ctx = ctx->context;
+	unsigned int dst_len = req->dst_len;
+	int ret;
+
+	ret = crypto_comp_compress(crypto_ctx->tfm,
+				   req->src, req->src_len,
+				   req->dst, &dst_len);
+
+	req->dst_len = dst_len;
+
+	return ret;
+}
+
+static int crypto_api_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+				 struct zcomp_req *req)
+{
+	struct crypto_api_ctx *crypto_ctx = ctx->context;
+	unsigned int dst_len = req->dst_len;
+	int ret;
+
+	ret = crypto_comp_decompress(crypto_ctx->tfm,
+				     req->src, req->src_len,
+				     req->dst, &dst_len);
+
+	req->dst_len = dst_len;
+
+	return ret;
+}
+
+static void crypto_api_destroy_ops(struct zcomp_ops *ops)
+{
+	kfree(ops->name);
+	kfree(ops);
+}
+
+struct zcomp_ops *get_backend_crypto_api(const char *name)
+{
+	struct zcomp_ops *ops;
+	char *algname;
+
+	ops = kmalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	algname = kstrdup(name, GFP_KERNEL);
+	if (!algname) {
+		kfree(ops);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ops->compress = crypto_api_compress;
+	ops->decompress = crypto_api_decompress,
+	ops->create_ctx = crypto_api_create,
+	ops->destroy_ctx = crypto_api_destroy,
+	ops->setup_params = crypto_api_setup_params,
+	ops->release_params = crypto_api_release_params,
+	ops->destroy = crypto_api_destroy_ops,
+	ops->name = algname;
+
+	return ops;
+}
diff --git a/drivers/block/zram/backend_crypto_api.h b/drivers/block/zram/backend_crypto_api.h
new file mode 100644
index 000000000000..5ff8f75efdb4
--- /dev/null
+++ b/drivers/block/zram/backend_crypto_api.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_CRYPTO_API_H__
+#define __BACKEND_CRYPTO_API_H__
+
+#include "zcomp.h"
+
+struct zcomp_ops *get_backend_crypto_api(const char *name);
+
+#endif /* __BACKEND_CRYPTO_API_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 40b5ab4c598b..da4b370c31c1 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -20,6 +20,9 @@
 #include "backend_zstd.h"
 #include "backend_deflate.h"
 #include "backend_842.h"
+#include "backend_crypto_api.h"
+
+extern struct list_head crypto_alg_list;
 
 static LIST_HEAD(backends);
 
@@ -216,63 +219,117 @@ void clean_zcomp_backends(void)
 		backend->destroy(backend);
 }
 
+static bool backend_enabled(const char *name)
+{
+	struct zcomp_ops *backend;
+
+	list_for_each_entry(backend, &backends, list)
+		if (!strcmp(backend->name, name))
+			return true;
+
+	return false;
+}
+
+static int init_crypto_api_backends(void)
+{
+	struct crypto_alg *alg;
+	struct zcomp_ops *ops;
+
+	list_for_each_entry(alg, &crypto_alg_list, cra_list) {
+		if (!crypto_has_comp(alg->cra_name, 0, 0))
+			continue;
+
+		if (backend_enabled(alg->cra_name))
+			continue;
+
+		ops = get_backend_crypto_api(alg->cra_name);
+		if (IS_ERR_OR_NULL(ops))
+			return PTR_ERR(ops);
+
+		list_add(&ops->list, &backends);
+	}
+
+	return 0;
+}
+
 int init_zcomp_backends(void)
 {
 	struct zcomp_ops *ops;
+	int ret;
 
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
 	ops = get_backend_lzorle();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 
 	ops = get_backend_lzo();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
 	ops = get_backend_lz4();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
 	ops = get_backend_lz4hc();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
 	ops = get_backend_zstd();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
 	ops = get_backend_deflate();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
 	ops = get_backend_842();
-	if (IS_ERR_OR_NULL(ops))
+	if (IS_ERR_OR_NULL(ops)) {
+		ret = PTR_ERR(ops);
 		goto err;
+	}
 
 	list_add(&ops->list, &backends);
 #endif
 
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_CRYPTO_API)
+	ret = init_crypto_api_backends();
+	if (ret)
+		goto err;
+#endif
+
 	return 0;
 
 err:
 	clean_zcomp_backends();
 
-	return PTR_ERR(ops);
+	return ret;
 }
-- 
2.34.1

