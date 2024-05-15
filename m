Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346225C5F3
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757450; cv=none; b=rIkhbABLA8kQXnbUimkcSgsLsqSHPE23MAbDpB4p/Ed1qV63M/wx7zGjynXVcJ9k2TisTzsCW4SDZCvAgMD5mG7psFRAcWyCMHaZ+/b+h6q3V4TSGLYLjRDorQ/cnJyJf/y2oGfAuUtKiVJKjQSJ4AW4UyFafkWtMRMupvZn4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757450; c=relaxed/simple;
	bh=lOpECWNUVFdB4uflmaL917YB3kCc2WBAsq/OEf5OpTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIu1QvC8yHaYZDLUMcDGeqUlZxt0fi8OPcNRlIj/e169plxNom0PFjXYiJC8GYYniQ3N0naFLNHAT5cg3ZngL6ngGEzNlV00qaYDfSUZqGZkWRb77fX3fzM8HOYB5x7yUNXo96c0wNyMDf8qj2nft+KfRlrvMoGvQ5R6JbgB6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GGRlDign; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGRlDign"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed96772f92so51679745ad.0
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757448; x=1716362248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4La/wbPPFJXkOrGYwK5uu1FW9Id7puPhRkViZ/LZt3Q=;
        b=GGRlDignRfYmnYlC3l25nP0NSXAdeAA0fFaCDTPlRzqmu2R00HMa+xFseWbiAYZecY
         krqyHz7O1GrlfcD9VCc0DpRxEehCZAANxUucua0wOLGQiB4VPyuZ+ph8H7W9/MqJBKCi
         SCkKj5SidVFWJR0lkM2Hskh4G6Vm9WRqemLFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757448; x=1716362248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4La/wbPPFJXkOrGYwK5uu1FW9Id7puPhRkViZ/LZt3Q=;
        b=wrT2ORIJ5wGonf7NADaiASW38U5DYadGfzor1M6/BhfUvg/m0c3qZ42BtkjuEifypO
         gitB82PReRCDhn8j0AD2A8E3Sqw7Ywi+SVU6ez9XnFWtUSUlfKhPDj3kGsQf84vKZ2Wi
         WXAndzQ1il0mA2a5lQFL4CnCfRYkhe643ouW1PDc7qlXQ8TNoBahuGepKyYHS1m5H2Dp
         Ah6AA8uzeBGPSc7Zbgka3/RSvo0LwjDGCIqhxKlrJIUycrFI+wxtJpF4ITxrJmI9D2cP
         CdjqRKmRUVuv2YuJ4JgTqxMuwmdHzlndvy0r9etMWbPA326oGWsZQyF1Iz2NVpYOn9GC
         1hvA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVlkgK5AVLwkr4JZeRopvEK1ka3ouEIYAJ4eT/w7615uWCEgiei7ZjdaLWH+mLdwG19/i1GgG+IEr943HXInYyhB7CD+XEscSCMw=
X-Gm-Message-State: AOJu0Yxa9u9Tz6TbevM9tJIxmQRZnlTg6wKEXN8jtg/3eCiTWwzdvRQO
	ye0/OtsmTT2Vha/Cx/P2L8FAV0pDrDBM1qH/DQxd9sRVCwzTY0uORkVm2cNrrA==
X-Google-Smtp-Source: AGHT+IF1uuv1Ow3yvq8pHb/zFsmRaet2oXT4g/kID1xMXGAMF0E6Hhv0qQeFV2atbjmsxgzSnd8SRQ==
X-Received: by 2002:a17:902:e889:b0:1eb:c3d4:349c with SMTP id d9443c01a7336-1ef43d2ec0bmr187724195ad.30.1715757448368;
        Wed, 15 May 2024 00:17:28 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:28 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 13/21] zram: add support for dict comp config
Date: Wed, 15 May 2024 16:12:50 +0900
Message-ID: <20240515071645.1788128-14-senozhatsky@chromium.org>
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

Handle dict=path param so that we can read a pre-trained
compression algorithm dictionary which we then pass to the
backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 ++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 91706889b63f..216686a5f3f0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
 
@@ -998,9 +999,35 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
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
 
@@ -1020,7 +1047,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1048,12 +1075,17 @@ static ssize_t comp_algorithm_store(struct device *dev,
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
@@ -1087,7 +1119,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1116,6 +1148,11 @@ static ssize_t recomp_algorithm_store(struct device *dev,
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
@@ -1124,7 +1161,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, prio, level);
+	ret = comp_config_store(zram, prio, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
@@ -2034,12 +2071,7 @@ static void zram_reset_comp_configs(struct zram *zram)
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

