Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5548CCD
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757446; cv=none; b=rZeghCkvEZJfecMHYBWSLoMFdiW5uev9VngnMVbUR8ZtuCzaHn4tzHAiFq1/bwysSysaGCQ9sgLznCEzMEyQ0dw6DO77fHDXAo4RlbOkQsFF6VmtobcXrgsyZIpRAjn9vR85Y+dydFHDMpyEavfUmkNWPyBYOzl3Bua9tqMdqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757446; c=relaxed/simple;
	bh=YnHUtLMZwpVLI0sVuuwwM6o13HO9vMtZxnKMkrUR/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8yAx2i7V3jL7gZ6CjhdNFohi0+xDnftPn8YEeE9bexwYq1w7lZlbb0Jt5oqRGsNSN8jzEkpoaZEZTS4z76cf+f2M5RJQzzZmiDm0hZrgPh+RZ1f1U+ZHBV17M1SdA9MmCIc7EK1uhXH96tzKgrwmCJWj/NNTK51vm/3fJFosu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LO5Z3Q9t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LO5Z3Q9t"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee954e0aa6so52139845ad.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757444; x=1716362244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKVs+B+0cyVVZhjjQw1NRD02y131beAoNCpGUQE22Zo=;
        b=LO5Z3Q9tbMtRLgU4hrriUYiXGWQbatUGRHUqdFQ8GmElEulIilhJdczdqhlD7j24r3
         Wg/vfrFw+2UCMJ192IWDIvfpG+JpW2wvHIka38x8ZEDgoMHGJpXMTOQjr61At/weeEUp
         M46cAzb6F+/xfEPCrEstxU8oArfne0fJ2p8As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757444; x=1716362244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKVs+B+0cyVVZhjjQw1NRD02y131beAoNCpGUQE22Zo=;
        b=KaJl8hd5M+hEkYd4V+klBOlkXOmwNkWXOyvEzuupkqZFCDXZWBL31OdBlBdy6WuBF5
         rG/GoQhZNE49ziscf2tgiKePfgDfDdGvICEq8iqNrtjm3SMDwMn6pz28pUHCQQfwKn4p
         Qnv7sVC/7rkR0BSTrABYckePmyQC1UXslS21c58arwyVu8ZBh550FKfh8r0L1y3luiky
         1+RKv9dW5K5iMvHaT/UDgQ4HSEd/rNp6S/GLyTeQLiuoWyOGAyeiLLuubdGYDTCpBRdK
         BU1EsIiZrid/mdj/k4EkYm/LBelWaio4nLpifHTluftx7VG8IhifaHbItVhfBZ/43pgr
         O3zA==
X-Forwarded-Encrypted: i=1; AJvYcCXEZE1cSvkzDCffJ8FsY/cJc7TJaqht2Gdetc0QFbIoH0QhZHMSPm/loNWmpUpsBp9sBytpFzNMhKfKlupzQ4FCV5CL4zH8jf7dEqw=
X-Gm-Message-State: AOJu0YxK2k1bbLIMpP8CfUambx9O05EOOUQh65x0gojoKtEW5fWDDrXs
	M2Zlxw2zR6ib82eFj7elPiP6TdQAyv1ItVYRjeIkDVrBxjSczC+tDSS5eJVPog==
X-Google-Smtp-Source: AGHT+IE8qiXvQd9erZoKg5Z5UhnAOTEuylXJnZ57+lB5IHA55FEIIAx2uTY4ujRkG+u9767ycaP2LQ==
X-Received: by 2002:a17:902:cec3:b0:1ee:b23b:ad5 with SMTP id d9443c01a7336-1ef43d2e1e8mr177002205ad.5.1715757443909;
        Wed, 15 May 2024 00:17:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:23 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 11/21] zram: extend comp_algorithm attr write handling
Date: Wed, 15 May 2024 16:12:48 +0900
Message-ID: <20240515071645.1788128-12-senozhatsky@chromium.org>
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

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 75ecdb885d91..7eb500c8fdaa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1013,9 +1013,33 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

