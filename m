Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AB143C65
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982359; cv=none; b=jXLmRwj0iAH/IKHmmIzlsPw2BWhuSAIB47tEvhmt3jQbT22O6sjyyeZ0YBXhrmGWlxPluEr+1exRWK2zrIqSL+uGWCBWojoIAfLPLbSDg07/qtQcye5nqjfNK2UsYlKL6fH1bE/s0V6114V4H/2y5wWZR9R0mVtYApKyXkf4ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982359; c=relaxed/simple;
	bh=hqBaAu2Ha8Gh/abMg4Cg6golRoIbO9BVZYRoWaldmIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA0FGHUxNVc7tDITlqdetlCckq6YCBL05YYk55oBws4mMyJvO+kC4zw0nyZVu6ie8bB86Mow3lxkNdp+H1hJNGaS4/u5DQzmSNXedOEnPCJOxqvyvduTTFoVaEgw2YCIx+pMmR2bxsdqiTGvtjRnThJxg4KKDFGfJE5xq018nS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jOQqfVzV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOQqfVzV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso10200195ad.3
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982357; x=1715587157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=une8u6O58vSEqdMRQHIC0PiltZGgPobzLxkJ5Uf2uCM=;
        b=jOQqfVzVUh4iDEKhdp6pilQEjUoYGOGRLd3S5VuYwi9eK48/btkDhINpASI84yYWkN
         oZ6q3DJXvgpH0KZ3QmJcJJ4Fd1CPlYngX4puFcm/vDFHKemW+YjbJhXhRvP6hGZ6JzMe
         xUEaZVn06W9jq2sXc/Q1OoSptFTW5pvvt90Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982357; x=1715587157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=une8u6O58vSEqdMRQHIC0PiltZGgPobzLxkJ5Uf2uCM=;
        b=T8973kpOe3fKFIN+qRjeVwnAeiIRV0QWC3Yx6t1zqtcmU6SwLFABkTp2hnvgTC4pmV
         C5cTesLk61BYHbmF77l+HAknFaB124aiiIKe8n72wosE9Snh0dacnNUtnEDkyCCn1Lli
         H4Yaj7ezNdWvt7fSIM8U5LRCRv19+69iPNX1aES8svQkIkYIoeMGmnnHdy8MqcoNXEVz
         yeTP9Nv7zN6xMTSvQ3MChwmpaZvGaF1CvX+vDY0Nij91Em0/oNR+yJUgE8aSP4+rJZr8
         imYpRGpwh7r1E+J4DRzEtxENuUx7T0q7LYyrBP5NnZYq21VCGe/twQkh9djbGbavU+zB
         l9ww==
X-Forwarded-Encrypted: i=1; AJvYcCWqfg1zq+7ZrmKNcptVeADeBNVzMMdwOTT1UsvTGe9j3MQPIRVDTDbFJnKmfaxidEtQXOYBj4FV1p+bYSAVzj536z0o7cZRwXHJ4Ec=
X-Gm-Message-State: AOJu0YyPcBuINW7r2UU+g2Rs1uNwyfMItkn9TMA5S5OcWjDGlZL8arv1
	BffMMKCI97nNqFl6Ddc+RctULJna2n6X8r30xKqwjABmqOkiJt1zlmksJsA/9w==
X-Google-Smtp-Source: AGHT+IGzsGmfPiTUH/STys9Y8TEuX4yEBZGZlmQlIEqsXRWYr5vbBOXLsW/TZxDNhzdywdQuP5/k1w==
X-Received: by 2002:a17:902:c10c:b0:1e1:a54:1fe8 with SMTP id 12-20020a170902c10c00b001e10a541fe8mr9487138pli.53.1714982357067;
        Mon, 06 May 2024 00:59:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:16 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 13/17] zram: add support for dict comp config
Date: Mon,  6 May 2024 16:58:26 +0900
Message-ID: <20240506075834.302472-14-senozhatsky@chromium.org>
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

