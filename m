Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595B153579
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727945; cv=none; b=TTdaeDzMMJaWLMDJuJdsBLEtgGgIZJJDZ40B713sUTU5yHLrWVGPEtttRj3GrYJ3tr1RwtBQ8PbUzPw5uump1wofggFoiYb+vdz9z7yL3FvVrfefO/17VZ2zl4+i1jjFP/r0mADomm4IeYh9rxlAbJQxJOh+uaxpjum9koKr3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727945; c=relaxed/simple;
	bh=0st2HobpNox1lw9rfTM0Izpmujgy1vssbMv9Vmn3p4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVbAjWz6B1L9OBg4sWKjGVsZjetHUbGHSEIIFbFA/9ZAyBRTcbH3qDOYae02dPkvUC4hpgn8uTmg0YvpEez5PcgUON0pyPT0lz344hdBmkpzA2AuSiGIFSnutVjf0Xyh+sThzMZfQBkkeWwWRzUacIJv2Dp+TLNcdY93R+j/1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m3ujW7ck; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3ujW7ck"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f447976de7so927426b3a.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727943; x=1715332743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkEHTBQxR1IAOMp6Di+8t+w03Mn2F1ACoLhl2VS9uYE=;
        b=m3ujW7cky9Trd8BhZnN2Ty/1+lBol3GrzKwLLT8nG3zu1O+EsCPWk1XDQXx2RL1l/c
         EzFFVT2k5mij/RwR78T+7xXqqouQNHiIww4KLmeHE8hGJDyemgV0cxI5AD191P3bU5QN
         yyyxj+kg5W+9clYqJWmVEnQlO/NiMy27JgFNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727943; x=1715332743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkEHTBQxR1IAOMp6Di+8t+w03Mn2F1ACoLhl2VS9uYE=;
        b=q3U60uXEhd/hV6iK1Xr7iKO+Vm42BO5HRYwdJwdjG3btyxV5xNV/orneXmxy8vWVlH
         /7tSO6qHWFRRXL/sE341qoZe/b5sY3JyeSd2EQUCa/Vl640yPSB8cV/MTPYE8VWd2M5B
         La0P1+qHEnLBXOS9W9uMtfGE/k4q6QtVDZCaRDUyW0N63+NTzWOyRFRiol+M/QbOlPsH
         pLIgzokl2ssQNolxZzpoxEd1hwO/jBlLy7P8gSe541Rt36WG73T/XSXwh/ITWB290tTv
         eZRSFpmQxax2CYS2C1ex+RbQ6WtaU4InI8t3ICOIVie6LRUS0/ApIgjAef/vyPx87kvJ
         tZIA==
X-Forwarded-Encrypted: i=1; AJvYcCVh03O2tet8Jy3C9mv4QSCkRhVqXha21PpqAgkSqzhfu9ybE5zNx1rkla6Keib+6Lw1ZQQZotm/Sm1GgrHUUeZEb9lwwA4Wlk/DhVs=
X-Gm-Message-State: AOJu0Yw6eZSeaT+v6WFq2/jP+glvTio7huUPJEkjf6d93m2yElHvF6A6
	4S3sB4QZ0I67TXG1dNuo3Bf3Cfl42I29X2dipjh/fPLpblZc58rqqBQq5b0p4g==
X-Google-Smtp-Source: AGHT+IHPfkg+X9GkqI+WL5uh/PWaBh9iygZx9qFc257y4/YG1wrDms+rR+hPW8EPaj7MxNhEKY0ihw==
X-Received: by 2002:a05:6a00:140b:b0:6ed:332:ffbc with SMTP id l11-20020a056a00140b00b006ed0332ffbcmr2011169pfu.20.1714727943515;
        Fri, 03 May 2024 02:19:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:19:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 12/14] zram: add support for dict comp config
Date: Fri,  3 May 2024 18:17:37 +0900
Message-ID: <20240503091823.3616962-13-senozhatsky@chromium.org>
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

Handle dict=path param so that we can read a pre-trained
compression algorithm dictionary which we then pass to the
backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 89a2eb37e26c..c50283c7231e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
 
@@ -1013,9 +1014,23 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
-static int comp_config_store(struct zram *zram, u32 prio, s32 level)
+static int comp_config_store(struct zram *zram, u32 prio, s32 level,
+			     const char *dict_path)
 {
+	size_t sz = 0;
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
 
@@ -1035,7 +1050,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1063,12 +1078,17 @@ static ssize_t comp_algorithm_store(struct device *dev,
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
@@ -1102,7 +1122,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1131,6 +1151,11 @@ static ssize_t recomp_algorithm_store(struct device *dev,
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
@@ -1139,7 +1164,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, prio, level);
+	ret = comp_config_store(zram, prio, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

