Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C416A33E
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154189; cv=none; b=aLpbTv1mHKWcmPN11GoMpGdj/6OkbnI1FNNc7m01xSrC8FxKNKoTKnSRc3NIIvkM7sbUx9CPl6OA+Wy1SSndeEwXABMkDxPA6Jj4fOcKSATCv/7Ie19IuUYRrnTDvggfA4emFFBKueVEyHUToAL4NxfHTszNQCNmagX9I1Irht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154189; c=relaxed/simple;
	bh=hqBaAu2Ha8Gh/abMg4Cg6golRoIbO9BVZYRoWaldmIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EboNn0FWNHW8CUmLZhTJqD5bgObm2HR+BEgDUFvyqa/YpdlsaNp6+bD8L99Vf6Nt2wDd0D+b0eYv6QXw/t4KCfYYmdWw72TJVQpbs5HGE+K2D6UZlB1jXBMI5xgPMCC66I3QX9z3CISncSyWbA+LljLUZjdGT4wgrez/lt4vDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKiywfTP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKiywfTP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so2900717a91.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154187; x=1715758987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=une8u6O58vSEqdMRQHIC0PiltZGgPobzLxkJ5Uf2uCM=;
        b=PKiywfTP7x35TLvZ5Wl70U3In2E6HROkPCFyFEd5xKwwGj7f/8sfEVVyrk/x2H9yyi
         d4Fu3xK7VxfPl3Ffj33ueCtkPgxnF0LVPquV9/C8jDa5MW1wUnzkTSRWq4YHvBYToBX/
         Aa6i1W3uweqQdcvs4SiSWHbcPqtwDxU3Ag6oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154187; x=1715758987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=une8u6O58vSEqdMRQHIC0PiltZGgPobzLxkJ5Uf2uCM=;
        b=F4GC/oV0IDn63Qur203TUg+ZXw+7o6SfNK3S50xCJxTtPV78caQpJjR/hPIB7CZY3S
         sTpK/P2xZtaiZXxMCPlyOznVcrpWo/dxBM0gv91j9mM3rOIiN0rPayHZE9Pz3H/qyQWx
         45cHhKEmntph5niXTfqiTs6C0dlbxGhmMr+MqWM+Z0VYIvdrfJX7eA2sYw9hju+yqzx7
         8LQHCry1r92lMTvr8fM+abVYWU0CSzm2YinSoA36oObQqqptpz4VjQB/WlO2HuKinGF1
         HroSEKt3BprlvVkmuKL7gCu/xzZmcH+RkAPiWz5OXkroixblDxf1/mHZqLt9e8reZE7C
         I2PA==
X-Forwarded-Encrypted: i=1; AJvYcCWEIf+8KymRR8mFHHYZLSFFrAU2j2vCvii4+k0vJsiyrFkdFJfyBTxY43DQhulfTi3M0purFLQDd+i5DvOE2ZicUIDy5m9mMwDYYtw=
X-Gm-Message-State: AOJu0YzIcmgexaxKG+bLM9SS0GkOu97KidxpxT7BEnlchZabdTiGHBoK
	C4k/RNJwSefBORUJ98wuUAk8M+3fhqQT9luRVmgNTWAljbLlmaVpkc6Ep9YX2g==
X-Google-Smtp-Source: AGHT+IHVw5rVeShNRu6xrdN8APaPx44Qmmg3cThkOLagufafTV2ioHSynqyx4HHegBvdxZGaapvtwQ==
X-Received: by 2002:a17:90a:aa81:b0:2b6:3792:ea4d with SMTP id 98e67ed59e1d1-2b637932ademr433346a91.5.1715154187479;
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 13/19] zram: add support for dict comp config
Date: Wed,  8 May 2024 16:42:06 +0900
Message-ID: <20240508074223.652784-14-senozhatsky@chromium.org>
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

Handle dict=path param so that we can read a pre-trained
compression algorithm dictionary which we then pass to the
backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 ++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 89a2eb37e26c..863e4e125eaa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
 
@@ -1013,9 +1014,35 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
-static int comp_config_store(struct zram *zram, u32 prio, s32 level)
+static void __reset_comp_config(struct zram *zram, u32 prio)
 {
+	struct zcomp_config *config = &zram->configs[prio];
+
+	vfree(config->dict);
+	config->level = ZCOMP_CONFIG_NO_LEVEL;
+	config->dict_sz = 0;
+	config->dict = NULL;
+}
+
+static int comp_config_store(struct zram *zram, u32 prio, s32 level,
+			     const char *dict_path)
+{
+	ssize_t sz = 0;
+
+	__reset_comp_config(zram, prio);
+
+	if (dict_path) {
+		sz = kernel_read_file_from_path(dict_path, 0,
+						&zram->configs[prio].dict,
+						INT_MAX,
+						NULL,
+						READING_POLICY);
+		if (sz < 0)
+			return -EINVAL;
+	}
+
 	zram->configs[prio].level = level;
+	zram->configs[prio].dict_sz = sz;
 	return 0;
 }
 
@@ -1035,7 +1062,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1063,12 +1090,17 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level);
+	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
@@ -1102,7 +1134,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1131,6 +1163,11 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1139,7 +1176,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, prio, level);
+	ret = comp_config_store(zram, prio, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
@@ -2049,12 +2086,7 @@ static void zram_reset_comp_configs(struct zram *zram)
 	u32 prio;
 
 	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
-		struct zcomp_config *config = &zram->configs[prio];
-
-		vfree(config->dict);
-		config->level = ZCOMP_CONFIG_NO_LEVEL;
-		config->dict_sz = 0;
-		config->dict = NULL;
+		__reset_comp_config(zram, prio);
 	}
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

