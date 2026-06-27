Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CD2C0261
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543813; cv=none; b=BuCQC2wSY5umfbxCwc0MZwLNsv8Uy/Vc+RhNXZqRKv8HpzTNtDQyA7OEr66k7FzHzzRdQ3PRTCwrxeM1598hAGrwxj7keL5vBBoDheJ0M49frAelVZ7GxmWxyLn/R+2QnLSTeUggwyJTsUnq3+lHed5+Yl3587TxPuczmVNbwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543813; c=relaxed/simple;
	bh=ormYHVRgY6p8IQrkO/lsXWj7N3iASqsV9VYl1GtdODU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxLdqyfsFoGakdA5FwUtO1AOLqOgAqTJig8+cjt2BX+tCYLbccu9WhwEv5OlSzIGX03l3HWAwfWjDB0Wd6mnyCbYzFZs3a+9rx2hpmowwI8w0Agt7Rr9Ax5BYPNmREvBhJEJ7eCDpgL0HYltMIWm7GP5yvPcL0j9BHrkXwNku68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHY3GNr+; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHY3GNr+"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c9b19bbaefso1141485ad.0
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782543812; x=1783148612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIa9VkNScpXkq+Xp5NC6c4EgjNX56H5FN6qwROXRmhM=;
        b=AHY3GNr+7m7Z/qy7d0cYepIas4D55ne+5HTioq8mDIV/M1H+1wQpygvKuACxOMDxLh
         9v8Up136s/Ur7Raj4Oy39EM65kDW233vQzzDoPkh6aVKOK/5RI4b8GA8yM909ndy+HmI
         vh6/8L0xdwKPtCAdG4kjcDC8jCXgc2TlBOA7+BTGcZOzCAcvsRTV5wQjWn56cuLM+gEt
         rE57K/yPtX/vxObfHmD+DSUKyzq1zB8BVqU6x+Jrh58ewq3zOzk3ck0fjBLUlzbXWxfK
         R14P/iVuXBJQSE6+zTj0DJ+bnD8SRTyGZMHQ9nIa9fazQSXSGPNKg2UktSLoIP0KarVc
         Kdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782543812; x=1783148612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TIa9VkNScpXkq+Xp5NC6c4EgjNX56H5FN6qwROXRmhM=;
        b=mJVyJc7/MU6Dzvt1P8z1oWCJ0CQhsEwut4PJBkMuPWSyokPAKkdeg3/34g9JKfxHwR
         KwkPCfQtXNE4Y3hfEIgzN/SNy66lma4ydCdav0+lAgfSC2NUarHjqHZKShB3OjS34TRV
         cwRr0VCcTXUdwJf41VFxhs85B3MgF+gSPDsy7dnI0lQDzqnMLsgVRopZIO8d+LJc4RfQ
         VQ0x4iHwGxP7zRqTQHLURzwgWzIsqcK8+2LYXD1teNONCNzieraNCMZSAkb4QOIkXU4N
         IzgB8WZET35dUw5Viu4OmVniqTKWt4GEsH7wEIfS9q8QYcBhJgi6X/ZkJ43dfDS5IMx7
         gXcg==
X-Forwarded-Encrypted: i=1; AHgh+RqZ66Gq2nqTQ/ZY96Mc5ygJUmTrp0vYXkDAZPH1WYjBnPthNnPbAnKvH9Ke/bStKd/v0yuGAU4K8tdsNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CMXoSWEFEi85flLreyrpxNPxiuCfwpY55M1tTKd44TfYfSOu
	Smovtd66kHoDKnsr0kfo32MH29h3thUJiesIAMW1aAY4H1TbWrzT09GQ
X-Gm-Gg: AfdE7cn4edGYnFYO0FnotRDGgS2jioF7jC9dZLYhPwmgLY768REXKo0ozYzGNwY7cQ8
	EBCVhCXsRjsYxFmg/4FMmvKaz0690ZGyVyjpe6yliOdPpCDb7QvM+O/LmCfypSMAOOqpoolVFI7
	7vT+aoWlpIUvxe/ATxTgKIS7NDGg7jpMYIqYydLQlu1nqTksBmW92i3GHuMC0ocVH463zzWgF/P
	PiAfrcCVNBUOhgoj6cFGaQ2ZxuXO1W+slMCtN0DzISsj6U7TSiji7fJt3PeF/SVByeiL/cZijVa
	ofYmE86/LV9iGCNmfPd3V0w8lSpgWrfZF9E+LgEbYfImH73QYYFHTt5Ep8a/Fy0uyphvrbwEzL5
	BpNb59x2QNTgep3S5WEhe4gm4wTLIH/KQpPoDj2zq8uw74h8yelRxNgvGP1GiKFFVUImvBrZ30H
	MFJ96+mN0DgTff3hN7sEskGb22ugxWKvrvh0lF3dkWa4FZOcy/gU5rHg9sHkE6VY6BUwQx
X-Received: by 2002:a17:903:2441:b0:2c9:97a7:71ae with SMTP id d9443c01a7336-2c997a773damr25274275ad.41.1782543811612;
        Sat, 27 Jun 2026 00:03:31 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:71bb:5f2e:c181:eb3e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f65088cesm51596995ad.80.2026.06.27.00.03.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 00:03:31 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk,
	terrelln@fb.com,
	dsterba@suse.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	haoqinhuang7@gmail.com,
	rongwei.wrw@gmail.com,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH 2/3] zram: add per-backend capability flags and validate parameters early
Date: Sat, 27 Jun 2026 15:02:15 +0800
Message-ID: <20260627070216.13511-2-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260627070216.13511-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Writing dict or level parameters for algorithms that don't support
them was silently accepted but had no effect.  Out-of-range levels
were silently clamped by the underlying library.  Dict read failures
always lost the real error from kernel_read_file_from_path().

Add caps, level_min and level_max to zcomp_ops and validate
user-supplied parameters in algorithm_params_store() before storing,
giving immediate error feedback. Also fix comp_params_store() to
read the new dict into a temporary buffer before resetting old
parameters, making the update atomic.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Reviewed-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_842.c     |  1 +
 drivers/block/zram/backend_deflate.c |  3 +++
 drivers/block/zram/backend_lz4.c     |  3 +++
 drivers/block/zram/backend_lz4hc.c   |  3 +++
 drivers/block/zram/backend_lzo.c     |  1 +
 drivers/block/zram/backend_lzorle.c  |  1 +
 drivers/block/zram/backend_zstd.c    |  3 +++
 drivers/block/zram/zcomp.c           | 23 ++++++++++++++++++++
 drivers/block/zram/zcomp.h           |  8 +++++++
 drivers/block/zram/zram_drv.c        | 32 +++++++++++++++++++++-------
 include/linux/zstd_lib.h             |  1 +
 lib/zstd/compress/clevels.h          |  1 -
 12 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 10d9d5c60f53..d796ebda1fa0 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -57,5 +57,6 @@ const struct zcomp_ops backend_842 = {
 	.destroy_ctx	= destroy_842,
 	.setup_params	= setup_params_842,
 	.release_params	= release_params_842,
+	.caps		= 0,
 	.name		= "842",
 };
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f92a52a720d1..cedc3daad33a 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -144,5 +144,8 @@ const struct zcomp_ops backend_deflate = {
 	.destroy_ctx	= deflate_destroy,
 	.setup_params	= deflate_setup_params,
 	.release_params	= deflate_release_params,
+	.caps		= ZCOMP_CAP_LEVEL,
+	.level_min	= Z_DEFAULT_COMPRESSION,
+	.level_max	= Z_BEST_COMPRESSION,
 	.name		= "deflate",
 };
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c449d511ba86..bd1e5ca4d134 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -146,5 +146,8 @@ const struct zcomp_ops backend_lz4 = {
 	.destroy_ctx	= lz4_destroy,
 	.setup_params	= lz4_setup_params,
 	.release_params	= lz4_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= LZ4_ACCELERATION_DEFAULT,
+	.level_max	= 65535,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f6a336acfe20..0e0d7c68a7d4 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -124,5 +124,8 @@ const struct zcomp_ops backend_lz4hc = {
 	.destroy_ctx	= lz4hc_destroy,
 	.setup_params	= lz4hc_setup_params,
 	.release_params	= lz4hc_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= LZ4HC_MIN_CLEVEL,
+	.level_max	= LZ4HC_MAX_CLEVEL,
 	.name		= "lz4hc",
 };
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c906beaae6b..965f007e2ca8 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -55,5 +55,6 @@ const struct zcomp_ops backend_lzo = {
 	.destroy_ctx	= lzo_destroy,
 	.setup_params	= lzo_setup_params,
 	.release_params	= lzo_release_params,
+	.caps		= 0,
 	.name		= "lzo",
 };
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 10640c96cbfc..757b4598be03 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -55,5 +55,6 @@ const struct zcomp_ops backend_lzorle = {
 	.destroy_ctx	= lzorle_destroy,
 	.setup_params	= lzorle_setup_params,
 	.release_params	= lzorle_release_params,
+	.caps		= 0,
 	.name		= "lzo-rle",
 };
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 2584f47c9b3c..0fbd2460883a 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -212,5 +212,8 @@ const struct zcomp_ops backend_zstd = {
 	.destroy_ctx	= zstd_destroy,
 	.setup_params	= zstd_setup_params,
 	.release_params	= zstd_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= (int)-ZSTD_TARGETLENGTH_MAX,
+	.level_max	= ZSTD_MAX_CLEVEL,
 	.name		= "zstd",
 };
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 974c4691887e..15de28b50d42 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -9,6 +9,9 @@
 #include <linux/cpuhotplug.h>
 #include <linux/vmalloc.h>
 #include <linux/sysfs.h>
+#include <linux/lz4.h>
+#include <linux/zlib.h>
+#include <linux/zstd.h>
 
 #include "zcomp.h"
 
@@ -94,6 +97,26 @@ const char *zcomp_lookup_backend_name(const char *comp)
 	return NULL;
 }
 
+unsigned int zcomp_get_caps(const char *comp)
+{
+	const struct zcomp_ops *backend = lookup_backend_ops(comp);
+
+	return backend ? backend->caps : 0;
+}
+
+int zcomp_validate_level(const char *comp, s32 level)
+{
+	const struct zcomp_ops *backend = lookup_backend_ops(comp);
+
+	if (!backend)
+		return -EINVAL;
+	if (!(backend->caps & ZCOMP_CAP_LEVEL))
+		return -EOPNOTSUPP;
+	if (level < backend->level_min || level > backend->level_max)
+		return -EINVAL;
+	return 0;
+}
+
 /* show available compressors */
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 {
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 81a0f3f6ff48..16f812a94c67 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -7,6 +7,9 @@
 
 #define ZCOMP_PARAM_NOT_SET	INT_MIN
 
+#define ZCOMP_CAP_DICT		BIT(0)	/* dictionary support */
+#define ZCOMP_CAP_LEVEL		BIT(1)	/* adjustable compression level */
+
 struct deflate_params {
 	s32 winbits;
 };
@@ -66,6 +69,9 @@ struct zcomp_ops {
 	int (*setup_params)(struct zcomp_params *params);
 	void (*release_params)(struct zcomp_params *params);
 
+	unsigned int caps;
+	s32 level_min;
+	s32 level_max;
 	const char *name;
 };
 
@@ -81,6 +87,8 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at);
 const char *zcomp_lookup_backend_name(const char *comp);
+unsigned int zcomp_get_caps(const char *comp);
+int zcomp_validate_level(const char *comp, s32 level);
 
 struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
 void zcomp_destroy(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..a667d0672720 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1699,21 +1699,24 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 			     const char *dict_path,
 			     struct deflate_params *deflate_params)
 {
+	void *new_dict = NULL;
 	ssize_t sz = 0;
 
-	comp_params_reset(zram, prio);
-
 	if (dict_path) {
-		sz = kernel_read_file_from_path(dict_path, 0,
-						&zram->params[prio].dict,
-						INT_MAX,
-						NULL,
-						READING_POLICY);
-		if (sz < 0)
+		sz = kernel_read_file_from_path(dict_path, 0, &new_dict,
+						INT_MAX, NULL, READING_POLICY);
+		if (sz < 0) {
+			vfree(new_dict);
+			return sz;
+		} else if (sz == 0) {
+			vfree(new_dict);
 			return -EINVAL;
+		}
 	}
 
+	comp_params_reset(zram, prio);
 	zram->params[prio].dict_sz = sz;
+	zram->params[prio].dict = new_dict;
 	zram->params[prio].level = level;
 	zram->params[prio].deflate.winbits = deflate_params->winbits;
 	return 0;
@@ -1794,6 +1797,19 @@ static ssize_t algorithm_params_store(struct device *dev,
 			return -EINVAL;
 	}
 
+	if (zram->comp_algs[prio]) {
+		unsigned int caps = zcomp_get_caps(zram->comp_algs[prio]);
+
+		if (dict_path && !(caps & ZCOMP_CAP_DICT))
+			return -EOPNOTSUPP;
+
+		if (level != ZCOMP_PARAM_NOT_SET) {
+			ret = zcomp_validate_level(zram->comp_algs[prio], level);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = comp_params_store(zram, prio, level, dict_path, &deflate_params);
 	return ret ? ret : len;
 }
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index e295d4125dde..f4b26844e53a 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -1241,6 +1241,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #define ZSTD_SEARCHLOG_MIN        1
 #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other strategies are limited to 6 */
 #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster strategies are limited to 4 */
+#define ZSTD_MAX_CLEVEL		22
 #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
 #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constant to an unsigned results in a tautological test */
 #define ZSTD_STRATEGY_MIN        ZSTD_fast
diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
index 6ab8be6532ef..db3b275b502e 100644
--- a/lib/zstd/compress/clevels.h
+++ b/lib/zstd/compress/clevels.h
@@ -17,7 +17,6 @@
 
 /*-=====  Pre-defined compression levels  =====-*/
 
-#define ZSTD_MAX_CLEVEL     22
 
 __attribute__((__unused__))
 
-- 
2.43.7

