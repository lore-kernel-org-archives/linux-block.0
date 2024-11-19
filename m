Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7291C4A02;
	Tue, 19 Nov 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019277; cv=none; b=hcVI9fAE1ufyM3B6puIdINglIBgIwwdl+sSPTgsiaCIaZTGqYKNeMMxrJKMEh2hK219mqbMqPH2X+9cg8h/go52+mBOknv0GCqmI9PPz/3olIRleT8HR0rcTk51l0gnbYOsA389wRR5G++GfOEl0JqZQfIFBIM1fhIgSdEfZhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019277; c=relaxed/simple;
	bh=o2BPdw6hLYbIROxy4x7HqarbaLMJHgFW9LvbNuYBJ/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAZ6aptjbnSI+6a60aRzchF1BchjFDXUvDwvppYqSxm++4AedAg7ecxuRncztWRdEArAHKisdFOjtMaH7Mpt4SpX5N1JChVAT35vBxxaPU/l9cy6FJHQuO0KPVUSczLjmupawUtmzP6tIELcRaP9pV4tV+bCiOvTyndZf+j2UUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SpaHxcD5; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SpaHxcD5"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D6FC512000D;
	Tue, 19 Nov 2024 15:27:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D6FC512000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732019264;
	bh=fKiBH4qBVxO9XGXPLT4rNEeVQlKxPf+r+nszEIDn/70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SpaHxcD5n3NKLTRO2oR7U4K5ysgU9qQyfbeuTMR+QvTL2ulmjBqi97DoBBZmweOYp
	 qh9FIpFujQWxppQgqn+uNEwEYkbWDFbuH8Tq3MFUzPauO78/kiAmjmZbp3MnaqBqDw
	 xLKLiNMg1k4BvvSZTM9cqfFDlQ9i/PAMMnkW7dR24PUBdFKzBjRkqS4LuvMVgla6DV
	 0vgw1DtWfwAJMBxUX9lEbNPJXO5Lc29gCHuZ+YjwtK2kDO+AUGcqExK4yvtdR5kwus
	 DAQwc0RH32Ct3sSuRb7i89FgC6hrmmaQys2+WCucVpjs+/pozHR8XgsvVmrRlZhde3
	 QQyvePPCS731Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:27:44 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
	<terrelln@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 2/3] zram: store crypto backends in list instead of array
Date: Tue, 19 Nov 2024 15:27:12 +0300
Message-ID: <20241119122713.3294173-3-avromanov@salutedevices.com>
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

This approach allows us to add backends in runtime.
We will use this in next patches.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/zram/backend_842.c     |  12 ++-
 drivers/block/zram/backend_842.h     |   2 +-
 drivers/block/zram/backend_deflate.c |  12 ++-
 drivers/block/zram/backend_deflate.h |   2 +-
 drivers/block/zram/backend_lz4.c     |  12 ++-
 drivers/block/zram/backend_lz4.h     |   2 +-
 drivers/block/zram/backend_lz4hc.c   |  12 ++-
 drivers/block/zram/backend_lz4hc.h   |   2 +-
 drivers/block/zram/backend_lzo.c     |  12 ++-
 drivers/block/zram/backend_lzo.h     |   2 +-
 drivers/block/zram/backend_lzorle.c  |  12 ++-
 drivers/block/zram/backend_lzorle.h  |   2 +-
 drivers/block/zram/backend_zstd.c    |  12 ++-
 drivers/block/zram/backend_zstd.h    |   2 +-
 drivers/block/zram/zcomp.c           | 124 ++++++++++++++++++---------
 drivers/block/zram/zcomp.h           |   7 ++
 drivers/block/zram/zram_drv.c        |   7 ++
 17 files changed, 180 insertions(+), 56 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 9147feb1e994..3b91b43888af 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -50,12 +50,22 @@ static int decompress_842(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return sw842_decompress(req->src, req->src_len, req->dst, &dlen);
 }
 
-const struct zcomp_ops backend_842 = {
+static void destroy_ops_842(struct zcomp_ops *backend_842)
+{
+}
+
+struct zcomp_ops backend_842 = {
 	.compress	= compress_842,
 	.decompress	= decompress_842,
 	.create_ctx	= create_842,
 	.destroy_ctx	= destroy_842,
 	.setup_params	= setup_params_842,
 	.release_params	= release_params_842,
+	.destroy	= destroy_ops_842,
 	.name		= "842",
 };
+
+struct zcomp_ops *get_backend_842(void)
+{
+	return &backend_842;
+}
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
index 4dc85c188799..9cdc59b0faa9 100644
--- a/drivers/block/zram/backend_842.h
+++ b/drivers/block/zram/backend_842.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_842;
+struct zcomp_ops *get_backend_842(void);
 
 #endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 10fde82dc5e7..c1460ab04b24 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -136,12 +136,22 @@ static int deflate_decompress(struct zcomp_params *params,
 	return 0;
 }
 
-const struct zcomp_ops backend_deflate = {
+static void deflate_destroy_ops(struct zcomp_ops *backend_delfate)
+{
+}
+
+struct zcomp_ops backend_deflate = {
 	.compress	= deflate_compress,
 	.decompress	= deflate_decompress,
 	.create_ctx	= deflate_create,
 	.destroy_ctx	= deflate_destroy,
 	.setup_params	= deflate_setup_params,
 	.release_params	= deflate_release_params,
+	.destroy	= deflate_destroy_ops,
 	.name		= "deflate",
 };
+
+struct zcomp_ops *get_backend_deflate(void)
+{
+	return &backend_deflate;
+}
diff --git a/drivers/block/zram/backend_deflate.h b/drivers/block/zram/backend_deflate.h
index a39ac12b114c..c15b18012aeb 100644
--- a/drivers/block/zram/backend_deflate.h
+++ b/drivers/block/zram/backend_deflate.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_deflate;
+struct zcomp_ops *get_backend_deflate(void);
 
 #endif /* __BACKEND_DEFLATE_H__ */
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 8f7c8f16b6ce..5638eefa657a 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -117,12 +117,22 @@ static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return 0;
 }
 
-const struct zcomp_ops backend_lz4 = {
+static void lz4_destroy_ops(struct zcomp_ops *backend_lz4)
+{
+}
+
+struct zcomp_ops backend_lz4 = {
 	.compress	= lz4_compress,
 	.decompress	= lz4_decompress,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
 	.setup_params	= lz4_setup_params,
 	.release_params	= lz4_release_params,
+	.destroy	= lz4_destroy_ops,
 	.name		= "lz4",
 };
+
+struct zcomp_ops *get_backend_lz4(void)
+{
+	return &backend_lz4;
+}
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
index c11fa602a703..439f96222ee5 100644
--- a/drivers/block/zram/backend_lz4.h
+++ b/drivers/block/zram/backend_lz4.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_lz4;
+struct zcomp_ops *get_backend_lz4(void);
 
 #endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index b0302b8027ab..c502b6afd571 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -118,12 +118,22 @@ static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return 0;
 }
 
-const struct zcomp_ops backend_lz4hc = {
+static void lz4hc_destroy_ops(struct zcomp_ops *backend_lz4hc)
+{
+}
+
+struct zcomp_ops backend_lz4hc = {
 	.compress	= lz4hc_compress,
 	.decompress	= lz4hc_decompress,
 	.create_ctx	= lz4hc_create,
 	.destroy_ctx	= lz4hc_destroy,
 	.setup_params	= lz4hc_setup_params,
 	.release_params	= lz4hc_release_params,
+	.destroy	= lz4hc_destroy_ops,
 	.name		= "lz4hc",
 };
+
+struct zcomp_ops *get_backend_lz4hc(void)
+{
+	return &backend_lz4hc;
+}
diff --git a/drivers/block/zram/backend_lz4hc.h b/drivers/block/zram/backend_lz4hc.h
index 6de03551ed4d..1334519082bb 100644
--- a/drivers/block/zram/backend_lz4hc.h
+++ b/drivers/block/zram/backend_lz4hc.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_lz4hc;
+struct zcomp_ops *get_backend_lz4hc(void);
 
 #endif /* __BACKEND_LZ4HC_H__ */
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 78e611ea841e..88eab940f723 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -48,12 +48,22 @@ static int lzo_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-const struct zcomp_ops backend_lzo = {
+static void lzo_destroy_ops(struct zcomp_ops *backend_lzo)
+{
+}
+
+struct zcomp_ops backend_lzo = {
 	.compress	= lzo_compress,
 	.decompress	= lzo_decompress,
 	.create_ctx	= lzo_create,
 	.destroy_ctx	= lzo_destroy,
 	.setup_params	= lzo_setup_params,
 	.release_params	= lzo_release_params,
+	.destroy	= lzo_destroy_ops,
 	.name		= "lzo",
 };
+
+struct zcomp_ops *get_backend_lzo(void)
+{
+	return &backend_lzo;
+}
diff --git a/drivers/block/zram/backend_lzo.h b/drivers/block/zram/backend_lzo.h
index 93d54749e63c..21493591dec3 100644
--- a/drivers/block/zram/backend_lzo.h
+++ b/drivers/block/zram/backend_lzo.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_lzo;
+struct zcomp_ops *get_backend_lzo(void);
 
 #endif /* __BACKEND_LZO_H__ */
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index b0ff72468ea8..28837acd205c 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -48,12 +48,22 @@ static int lzorle_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-const struct zcomp_ops backend_lzorle = {
+static void lzorle_destroy_ops(struct zcomp_ops *backend_lzorle)
+{
+}
+
+struct zcomp_ops backend_lzorle = {
 	.compress	= lzorle_compress,
 	.decompress	= lzorle_decompress,
 	.create_ctx	= lzorle_create,
 	.destroy_ctx	= lzorle_destroy,
 	.setup_params	= lzorle_setup_params,
 	.release_params	= lzorle_release_params,
+	.destroy	= lzorle_destroy_ops,
 	.name		= "lzo-rle",
 };
+
+struct zcomp_ops *get_backend_lzorle(void)
+{
+	return &backend_lzorle;
+}
diff --git a/drivers/block/zram/backend_lzorle.h b/drivers/block/zram/backend_lzorle.h
index 6ecb163b09f1..7871f44b73a3 100644
--- a/drivers/block/zram/backend_lzorle.h
+++ b/drivers/block/zram/backend_lzorle.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_lzorle;
+struct zcomp_ops *get_backend_lzorle(void);
 
 #endif /* __BACKEND_LZORLE_H__ */
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index b73b975599f4..0762bea90296 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -216,12 +216,22 @@ static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	return 0;
 }
 
-const struct zcomp_ops backend_zstd = {
+static void zstd_destroy_ops(struct zcomp_ops *backend_zstd)
+{
+}
+
+struct zcomp_ops backend_zstd = {
 	.compress	= zstd_compress,
 	.decompress	= zstd_decompress,
 	.create_ctx	= zstd_create,
 	.destroy_ctx	= zstd_destroy,
 	.setup_params	= zstd_setup_params,
 	.release_params	= zstd_release_params,
+	.destroy	= zstd_destroy_ops,
 	.name		= "zstd",
 };
+
+struct zcomp_ops *get_backend_zstd(void)
+{
+	return &backend_zstd;
+}
diff --git a/drivers/block/zram/backend_zstd.h b/drivers/block/zram/backend_zstd.h
index 10fdfff1ec1c..f737fbdfa57a 100644
--- a/drivers/block/zram/backend_zstd.h
+++ b/drivers/block/zram/backend_zstd.h
@@ -5,6 +5,6 @@
 
 #include "zcomp.h"
 
-extern const struct zcomp_ops backend_zstd;
+struct zcomp_ops *get_backend_zstd(void);
 
 #endif /* __BACKEND_ZSTD_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index be3a31f09344..40b5ab4c598b 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/crypto.h>
 #include <linux/vmalloc.h>
+#include <linux/list.h>
 
 #include "zcomp.h"
 
@@ -20,28 +21,7 @@
 #include "backend_deflate.h"
 #include "backend_842.h"
 
-static const struct zcomp_ops *backends[] = {
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
-	&backend_lzorle,
-	&backend_lzo,
-#endif
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
-	&backend_lz4,
-#endif
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
-	&backend_lz4hc,
-#endif
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
-	&backend_zstd,
-#endif
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
-	&backend_deflate,
-#endif
-#if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
-	&backend_842,
-#endif
-	NULL
-};
+static LIST_HEAD(backends);
 
 static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
@@ -72,14 +52,13 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 
 static const struct zcomp_ops *lookup_backend_ops(const char *comp)
 {
-	int i = 0;
+	struct zcomp_ops *backend;
 
-	while (backends[i]) {
-		if (sysfs_streq(comp, backends[i]->name))
-			break;
-		i++;
-	}
-	return backends[i];
+	list_for_each_entry(backend, &backends, list)
+		if (sysfs_streq(comp, backend->name))
+			return backend;
+
+	return NULL;
 }
 
 bool zcomp_available_algorithm(const char *comp)
@@ -91,15 +70,15 @@ bool zcomp_available_algorithm(const char *comp)
 ssize_t zcomp_available_show(const char *comp, char *buf)
 {
 	ssize_t sz = 0;
-	int i;
+	struct zcomp_ops *backend;
 
-	for (i = 0; i < ARRAY_SIZE(backends) - 1; i++) {
-		if (!strcmp(comp, backends[i]->name)) {
+	list_for_each_entry(backend, &backends, list) {
+		if (!strcmp(comp, backend->name)) {
 			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"[%s] ", backends[i]->name);
+					"[%s] ", backend->name);
 		} else {
 			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"%s ", backends[i]->name);
+					"%s ", backend->name);
 		}
 	}
 
@@ -211,14 +190,6 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 	struct zcomp *comp;
 	int error;
 
-	/*
-	 * The backends array has a sentinel NULL value, so the minimum
-	 * size is 1. In order to be valid the array, apart from the
-	 * sentinel NULL element, should have at least one compression
-	 * backend selected.
-	 */
-	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
-
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
@@ -236,3 +207,72 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 	}
 	return comp;
 }
+
+void clean_zcomp_backends(void)
+{
+	struct zcomp_ops *backend;
+
+	list_for_each_entry(backend, &backends, list)
+		backend->destroy(backend);
+}
+
+int init_zcomp_backends(void)
+{
+	struct zcomp_ops *ops;
+
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
+	ops = get_backend_lzorle();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+
+	ops = get_backend_lzo();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
+	ops = get_backend_lz4();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
+	ops = get_backend_lz4hc();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
+	ops = get_backend_zstd();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
+	ops = get_backend_deflate();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
+	ops = get_backend_842();
+	if (IS_ERR_OR_NULL(ops))
+		goto err;
+
+	list_add(&ops->list, &backends);
+#endif
+
+	return 0;
+
+err:
+	clean_zcomp_backends();
+
+	return PTR_ERR(ops);
+}
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 89d32bb13f8c..12d82acd0d39 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -59,7 +59,11 @@ struct zcomp_ops {
 	int (*setup_params)(struct zcomp_params *params);
 	void (*release_params)(struct zcomp_params *params);
 
+	void (*destroy)(struct zcomp_ops *ops);
+
 	const char *name;
+
+	struct list_head list;
 };
 
 /* dynamic per-device compression frontend */
@@ -86,4 +90,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		     const void *src, unsigned int src_len, void *dst);
 
+void clean_zcomp_backends(void);
+int init_zcomp_backends(void);
+
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cee49bb0126d..29df68e0e450 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2726,6 +2726,7 @@ static void destroy_devices(void)
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+	clean_zcomp_backends();
 }
 
 static int __init zram_init(void)
@@ -2765,6 +2766,12 @@ static int __init zram_init(void)
 		num_devices--;
 	}
 
+	ret = init_zcomp_backends();
+	if (ret) {
+		pr_err("Unable to create zcomp devices\n");
+		goto out_error;
+	}
+
 	return 0;
 
 out_error:
-- 
2.34.1

