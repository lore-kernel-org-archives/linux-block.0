Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E7331ED6
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391333; cv=none; b=H9xemYAhr19zmV6diL5g9dabQzRjYtTurHHaHpXrFGZqLL1Te2bGx5qrz6In5Tu2xvV8AJWLyLi0LxERCe9aFUIDI2OTQqRgfpoOGUCm3Y1tqtTWaIY+yflpfjNQHVHbrT6oc1Xtj5mA1jvFEGQysmF3E3Vus48YKPWbWKPDi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391333; c=relaxed/simple;
	bh=gO2rSRxdGsv8jhZWsDvRPHMXr9zG+J3HKzvsn7gjT3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbbFDlS4WnS12qKxtwtQaiK/XjrSyZaIyM2k3BxwAZBIaSnA6jd4gMUobKWDozXMbZphnieKop0kAb+SYztBjCPS79AWNaoORJwWx9kCa0Hrha2lfHvcsvF04ZBgjL1FKR6OgktDWA+T8KkSBaeheYxR0v1Z02PMmdZTSOXkS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOm/7wKD; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOm/7wKD"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38ed4d37526so867503a91.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391326; x=1785996126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHaCQ7C+foYsSbEdZ9oP+KDLvwJIqs/bj2IIhPeo3vA=;
        b=nOm/7wKDpDO+DbhIaWkHQe/f3RZ+ICANVgO5X85G9sfGpLtrdRGGhIdgDbt+1yIl7r
         fZyUckOwd+9jizEXm0w5lAKp/HZnpFCeJG7roRD3yTIYXFYQhiSGHnZWGCVUwAd6tDXe
         MybA/V5mDtw0LNiUBYehleSmKnmI9rFu0c/65+8k+PhPyZ4j3lPVZFNUXcgTzwW8snHx
         +Pswr0BPKn/ERrc0FfZ3udgR9+KxO0wg4ke3u1qW7C0SvxGkmMktp1f/FyWkPrqGoSW/
         wQ6MThVNo0G7MDPTbjzj5JmCUoNLa38hZX8+wLjrg9M7wEFtq4vYGt5AJZP+tz5Bfi9a
         axKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391326; x=1785996126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHaCQ7C+foYsSbEdZ9oP+KDLvwJIqs/bj2IIhPeo3vA=;
        b=o+sIgJEuRDsfrxpRml5b7YPw+1oC3sj9yAu2LdR3BebrG0TzFRydN0E6vffevRxQGU
         9d6jyP9aWznB7eM4aiNA4IXJXMp4ecfJxVzQMmbQdqY/jbsg28qNOWJXMv8Xy9VQLSeJ
         vJgjAJ7oWREtjU0uynRl3a0TWhRSN/FRORJ6k8l7XMtnWLIPnqAM1DFpYmnY1Ymom0vP
         77bIr3mivIPSLX/KRIVd99SFVaZW8CeZ8g3spuFhJbIVYlGBcSw9ILHotFgNzyjtzpXa
         oJaEitgYN17XR5ZsPstpjnLyCfqhNhbiWtTZzDgsSzZsX+RMlJjpJNkkND7AweHZ5TT1
         tuBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbiXWGVU4X+GRQle66QHk5TIUDlc06wyzwFUm62l3e+WMgJkoUkwy+OWlGVGasiNN/Hin8Z71cWMB8pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCb1YY+e0hhc1ptZQRH9xiNes8FiOR4MDeCNY5A5ZEGtvyCWzE
	hstZIHpsicFarmrO69db5D8RaGxZaHIpo3JYeAR0+GnmjulgNKVQC0N5
X-Gm-Gg: AR+sD12YD5uATIXfI2QfCEihNWTVCDqDVEyv3beZCgP+zFqZyNx3Bz/VIWcwGP+2ITj
	Kh4kvrShpR7suxJUHGhqNAMbcZhDWwDS8zUtr8PsYRbp5wpSVpfWJhdAEUkFkso8YCKtAWs/JJP
	6BRW6ZI7kkQDUxECYnL/nD6zokrL4PeFhMcRlzGCMrsriZsN7SxkdEnVDEaoJV3eUDhnNt0fKXI
	A50kxuZ4QsWKu/bQRJX4Zsi5fhjYMVT3Czh03bwhn/Jj26DuMCCiwgtDiJW/3zoTT+ryZX0wBIw
	hOAN6nNbxyvlrzYUBtmD7fBm6HpssWpIJ1Zgu+xL0ionRPlbQyhJ3NJPgqH32Y6OinT810w/Wdz
	9rq3ItJJaRaiB6Yp4QgJQID7KmI1qgM6+RVOoR9frY0KVQCqDWQcJYUgKLVK6XP0pv6Dy2itfRD
	dUz1O+sHYuX0q7cj8h3VhMdbE0H7FRQGDUxsVd5lPQkQM4DMNszn3aJGD17/Tw803D4Z/Edz3pv
	gtk8wAb7fydcj/qaDKKaaXsxfVlnpb52w==
X-Received: by 2002:a17:90b:584e:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-38f9bd3ed26mr1130584a91.5.1785391326329;
        Wed, 29 Jul 2026 23:02:06 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d6c8sm430737a91.3.2026.07.29.23.02.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 23:02:05 -0700 (PDT)
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
Subject: [PATCH v4 3/4] zram: validate parameters in each backend's setup_params
Date: Thu, 30 Jul 2026 14:01:32 +0800
Message-ID: <20260730060133.80233-4-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730060133.80233-1-haoqinhuang7@gmail.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Dict and level parameters are silently accepted even for backends
that do not support them. Validate these parameters in each backend's
.setup_params() to reject unsupported combinations and out-of-range
levels with a specific error message.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_842.c     | 8 ++++++++
 drivers/block/zram/backend_deflate.c | 9 +++++++++
 drivers/block/zram/backend_lz4.c     | 5 +++++
 drivers/block/zram/backend_lz4hc.c   | 5 +++++
 drivers/block/zram/backend_lzo.c     | 8 ++++++++
 drivers/block/zram/backend_lzorle.c  | 8 ++++++++
 drivers/block/zram/backend_zstd.c    | 5 +++++
 7 files changed, 48 insertions(+)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 10d9d5c60f53..91a22313fe82 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -13,6 +13,14 @@ static void release_params_842(struct zcomp_params *params)
 
 static int setup_params_842(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("842: dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("842: compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f92a52a720d1..1a2be462bc67 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -22,8 +22,17 @@ static void deflate_release_params(struct zcomp_params *params)
 
 static int deflate_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("deflate: dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = Z_DEFAULT_COMPRESSION;
+	else if (params->level < Z_DEFAULT_COMPRESSION ||
+		 params->level > Z_BEST_COMPRESSION) {
+		pr_err("deflate: invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET)
 		params->deflate.winbits = DEFLATE_DEF_WINBITS;
 
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c449d511ba86..6577b484941a 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -30,6 +30,11 @@ static int lz4_setup_params(struct zcomp_params *params)
 
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = LZ4_ACCELERATION_DEFAULT;
+	else if (params->level < LZ4_ACCELERATION_DEFAULT ||
+		 params->level > U16_MAX) {
+		pr_err("lz4: invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 
 	if (!params->dict || !params->dict_sz)
 		return 0;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f6a336acfe20..5d551d165213 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -20,6 +20,11 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 {
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = LZ4HC_DEFAULT_CLEVEL;
+	else if (params->level < LZ4HC_MIN_CLEVEL ||
+		 params->level > LZ4HC_MAX_CLEVEL) {
+		pr_err("lz4hc: invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c906beaae6b..cdbb89aaa0de 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -12,6 +12,14 @@ static void lzo_release_params(struct zcomp_params *params)
 
 static int lzo_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("lzo: dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("lzo: compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 10640c96cbfc..58f7ddf5a55f 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -12,6 +12,14 @@ static void lzorle_release_params(struct zcomp_params *params)
 
 static int lzorle_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("lzo-rle: dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("lzo-rle: compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 2584f47c9b3c..4d19d6089f13 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *params)
 	params->drv_data = zp;
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = zstd_default_clevel();
+	else if (params->level < zstd_min_clevel() ||
+		 params->level > zstd_max_clevel()) {
+		pr_err("zstd: invalid compression level %d\n", params->level);
+		goto error;
+	}
 
 	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
 
-- 
2.43.7

