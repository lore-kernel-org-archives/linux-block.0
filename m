Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B641F7ED
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231028; cv=none; b=NtA8fdWc2cuSRaTvueBrVSyG1etsAyflGu/KWzHhAC6PAiizPQ76r+RBrmU7lOpzZZdMvIbQTwKH0TJbRPiSVgbUw2HA4M0ciRfJIbGVV+nq2vZ4xQqPdFFcaphuWhGyrh1Sd3Z/453Rj5zjDDllaku8rCvYIpczieH9zmmSApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231028; c=relaxed/simple;
	bh=40uKPFS7a8lBX98UCEOfv5Mjx9aLr360bF9N3kfriZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRg4imLRKcozVA6+Px0CjOz5SljQXtU6/l4gYawK7aEO1o5cWb+pVuE7FtkyNjewKzmDGgFwPMngV4n2O6oNCeGhkftvDQVvBBrKuFbsGR1uEyAF+nQKamt65v4yRcX0a1ox+OFru3csuVTaa9knzy17CXdMMMqWLbwXX9mDnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz13IwkY; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz13IwkY"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso2673646a91.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231026; x=1785835826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7E5eEkwnU2zTV/glinXkKn1M0x2EZG31DiZx6CBD00=;
        b=mz13IwkYCmBqkXG9MGC7tG7ECC4FSKOlyKp5NXGPth8iZTEYZZMgz+NHV6CUBkbp1X
         1AyjvGI+X1M3Oik7awNnejuO0oYLW+lD3lrQH4GEyaOUaiXgZR50+QETjC51M3nqoB0t
         S7qwaSJeDIS7erPyxg559PDdrQ3YVGdMlIWGt7NMDS8ED+N4Xvd77TbfPB+h4erryrbz
         iE1F3o1HPJ4qKvYWtpzc2EfNcnyb9pmMi8ZMDR08yyVaT41StzRiusOG5n+vDBH51vnb
         A7KRCsfvljsunSegScNMM3U9gvTzh9OobZpbMNTC59bQhh+TyoGAcECkQ5wgkRvU4Fhm
         8Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231026; x=1785835826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G7E5eEkwnU2zTV/glinXkKn1M0x2EZG31DiZx6CBD00=;
        b=BN+xg820yuB6zWO5UIg2hT2mYx0i0v+T+dg2jimlE+C1gAGZg+9foRbPC8J+wSTkUo
         PyWw/FqQ1hBoMu9apX32NgQ5Ku+4RqwAvTIVtI7R3czXqJn5WeMyYD3diNB6RoNxx0Mt
         RQnjoUF3nkV8nCdmegoSAv3DA2+nxxF+rN5mqGdPmkxeTvCuSIHtFBBQpjvr/EwoqxaM
         qsz2cZzp4ypoz/WiRtCC/9xHRwp53wlFAcgoGOgUod9Es26HVRHctw2ZC0U/V4rDmHWa
         uwzG4i8hOHbvXj+U2O0/czcZzuICW6n8oB7Hi3Q2hbWJgc9g0WwqjdvK5HomD/Yg0H5h
         MSSg==
X-Forwarded-Encrypted: i=1; AHgh+Rquw15B8Hk4RpwwUxw9JwjTQq9e5uBHm2iyBrnFBJmunN1zFS+SuvKt46RIx8eaOYLKkj8RtjVd8Oynrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCq21Y+IRoi4zsHOe9y10OZSOEEkJW/ft2ZQDbajrt5pTlr/H
	WZFWTy3V5dTBnwDQR4PlKwRndDZO6mMYM8GnfUzeOvQENHcks/qXPhLA
X-Gm-Gg: AR+sD12kSTqMNZOz6R05GQr2bHRyOa8hWtrkcmcbjiG+6yKvZ+q5LjjZIJaS2NwFcoS
	EkLbPSSztQt6IzkDDb5TXj2x+PAMA2S1GIzKiGYaxh/NXdnJBQMY4s+rjAEYx/QLabx5iY8NmOH
	7EF1BGsr2d3WSIGC3R42Sr953G4QoAATHHwThy14xMroT6GMjaTctzGfCqbZooODuPN3TzQDq0M
	PMKuGsRfNtBp4gIXOogwNM4rLobrGfYEC9cQnguo5c/LdWvgwXDUABt/BbDUMwymKD/GtYb/+b0
	uFeFPQAK9/TORXW4qvTDoQkB0NZ1yjDRtuZNl2divLC2KFGuePNq7Q5yc/pqzr/iol/OEmP7Zla
	MHrzUdoz4FG1QoHd+dq+A2Ps9a9GhgwADZ88UcBW3AzbHVlJAmTAo1I7FWrrqCkyyVoLNd3FyPy
	yDkjmqWQK51qYzNBn/LVntbivcL5sxLrH3H+ju6X2iqc7BPAie4CaQ2NDefQ==
X-Received: by 2002:a17:90b:55c5:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38f6a336613mr1848949a91.13.1785231026137;
        Tue, 28 Jul 2026 02:30:26 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm49151225ad.71.2026.07.28.02.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:30:25 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v2 4/5] zram: add per-backend caps and validate parameters early
Date: Tue, 28 Jul 2026 17:29:34 +0800
Message-ID: <20260728092935.31139-4-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Writing dict or out-of-range level for backends that don't support
them is currently silently accepted but has no effect. For example,
"algo=lzo dict=/data/dict" succeeds but lzo_setup_params() ignores
the dict entirely.

Add caps, level_min and level_max to zcomp_ops and validate
user-supplied parameters in algorithm_params_store() before storing,
printing an error on failure so the user knows what went wrong.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_842.c     |  1 +
 drivers/block/zram/backend_deflate.c |  3 +++
 drivers/block/zram/backend_lz4.c     |  3 +++
 drivers/block/zram/backend_lz4hc.c   |  3 +++
 drivers/block/zram/backend_lzo.c     |  1 +
 drivers/block/zram/backend_lzorle.c  |  1 +
 drivers/block/zram/backend_zstd.c    |  3 +++
 drivers/block/zram/zcomp.c           | 23 +++++++++++++++++++++++
 drivers/block/zram/zcomp.h           |  8 ++++++++
 drivers/block/zram/zram_drv.c        | 19 +++++++++++++++++++
 10 files changed, 65 insertions(+)

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
index 9ea7ba9d1ed0..d86f4eb06d58 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1796,6 +1796,25 @@ static ssize_t algorithm_params_store(struct device *dev,
 			return -EINVAL;
 	}
 
+	if (zram->comp_algs[prio]) {
+		unsigned int caps = zcomp_get_caps(zram->comp_algs[prio]);
+
+		if (dict_path && !(caps & ZCOMP_CAP_DICT)) {
+			pr_err("zram: %s does not support dictionary\n",
+			       zram->comp_algs[prio]);
+			return -EOPNOTSUPP;
+		}
+
+		if (level != ZCOMP_PARAM_NOT_SET) {
+			ret = zcomp_validate_level(zram->comp_algs[prio], level);
+			if (ret) {
+				pr_err("zram: invalid level for %s\n",
+				       zram->comp_algs[prio]);
+				return ret;
+			}
+		}
+	}
+
 	ret = comp_params_store(zram, prio, level, dict_path, &deflate_params);
 	return ret ? ret : len;
 }
-- 
2.43.7

