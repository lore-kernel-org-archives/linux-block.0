Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67632DCF46
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836375; cv=none; b=BN3G4ZIr6odDt/DknnR2Fm/Y1mZ/StCMB9x18IdWSn9rHBs+TFqVtyP2mqMH7IZuyGNlU2plpYBuED/TMWoWnHRljcuDGGDxcK2V2i7ptseCB834cWJtaP7FQK7shqazvEAlw/B/0kSF8m0KWvuGtmn0W6Vt57Rfqop8Clvk+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836375; c=relaxed/simple;
	bh=mzXlhD4EsPplX7xLnL0gq0I/jyWj8XgkqKgzE6m0sSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDUQHAbEcd6AVrlFpOw/b27aj8SVL1od87cTOu+hRCR43D4/IWtFwTP1JTQOjCvyY52kK6hqWTr447J8IVGREtigIYDTtm+nxXvK1KIxeDoN8fAxQ480IdgJelAAHEmWJlrneEFiEVWqIcHW23A1vOAx8/yh2OlJZITIiZU5jFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVYGR+Ko; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVYGR+Ko"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38e8adc1d70so2034213a91.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836373; x=1786441173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rRNkoK3p4xDENHUzYr9Ku+zX2ZCm/WrueoQfpHUQmU=;
        b=OVYGR+KoeyD0pHrgVeQCx05jzWeiGegKJ1bdaPQ1Hl79AoZqrjSRtFaMU2u1pjTK6K
         idBR6gvxLNV/53ahVMp9xctrCHjB3SKRpwo/3v7WugsihuvUEnrp2ieBgXPcwWniv6mM
         5vdC34ceZYQM86s9eT4V0IRq0pL88EaLPNayCdaAn57c7odWccd4ixNrBGy89sE22jpx
         2qGbF9/TMp+bkYfQTnf41CwdEGFxbNNsfINbm/ObYXTPLdBR6RLJcGYaOyG8h3YUCMtC
         FuAqWNxMO8eyILGgz3fro7HlnsZj2BikobKCdwrjsB8XTnfdKDJfcvqu5Lt1AV4FhS+0
         lK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836373; x=1786441173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rRNkoK3p4xDENHUzYr9Ku+zX2ZCm/WrueoQfpHUQmU=;
        b=fRlBy/98iKYrhpDaw5nAz0GsR+wOsbA6qnPQ0nNaNRDRzRcBL7agcP4L5bqVhGH+Pt
         Y4iweFa5472DHW4raF/8GEOpLdU9zlR4xJFD+d1tPgaS4qkHAhRTxMZ39c/4/zS7EhE1
         kZ7fajEzJpmwEcqzehTpowmYMS+lHVkmZ3sDwe+Sni+SsSzVeAdAK5nLkBof0Zv2WP8V
         3TzhnVJxOswj2LAEYiIypM1pMBCFk7Gu88ZLrpGYgc5WyAEejhcSMN3tJVu6xzaFpfj8
         /AaIIcszLNPK056hv14fyoJu80Ir7tcb/I1cIrW4V2OBGCf/jL9CBtAsMdUxn9TTYReE
         Gkxw==
X-Forwarded-Encrypted: i=1; AHgh+RogC9hsEGjspVPL7VYhUUFlFZoh9Thlt0U4lHJ/mVJMsdKxqCkOHVBzyKcG4ZQcFAMiz3RVz4MdFQHLTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoXKRq3FGss2+X6vLJzruLoFMA6bNm51n+GMFRNuNY0qXn3D/
	XVJm9lSavbh6BoQP5y7TInZhyp2Y2+MPvpOfUZ4eMaTHFo50TTwYMYNr
X-Gm-Gg: AR+sD114nFtKplPzi8nxEtXfPZhetzIOcStHnDBTrdBbR84+Fy2jNFct9b8urWbDpi0
	ynp9098DLK/EVBj/mur8wFOuXdu3zIYbWG0sBhL/z52P45iQzU1PZFVYj+RCfAf45JCbvsy6k/+
	4FaUbrp7XCG5aP5QxXtpgl2ts5mjv5Dq5UrhzT8J1Gbx4JJ3uRj+43rielCqtRYXTIcxescSVgp
	Uaz03uYj37zC43p+7nWEQXsMLfCyAAB+MdeL23F0NTCAK3eQrqCT9gMsaj2vXumz+SFjptsDSxp
	jGdCL+lLlu0rP0UvP8blivm+eL/4WkaL0v14MvCXnJywfPJtA949IYNGfvKzysBMysXOL5Hy+m+
	5Es6PeVYpKvGG22Z77n8EFFtf4qe3PESzs8zi9Sv4SOKaWyBxow6zaMCL/765jWH9v1BFqMABgM
	t/LGlU4Wl0BMPcij37aqNPzI8WhNOvZT/TLxjNPRT3O9WtBCmwFTLUXSRqwQXPqKRg50GyKGOJ1
	6ZfawvNGuc07gMQMVsf74VWMZ+6h2EUiQ==
X-Received: by 2002:a17:90b:4c42:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38fbc4cf1b2mr12982888a91.27.1785836372663;
        Tue, 04 Aug 2026 02:39:32 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.39.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:39:32 -0700 (PDT)
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
Subject: [PATCH v6 4/5] zram: validate parameters in each backend's setup_params
Date: Tue,  4 Aug 2026 17:38:40 +0800
Message-ID: <20260804093841.67920-5-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260804093841.67920-1-haoqinhuang7@gmail.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260804093841.67920-1-haoqinhuang7@gmail.com>
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
 drivers/block/zram/backend_842.c     |  8 ++++++++
 drivers/block/zram/backend_deflate.c | 13 ++++++++++++-
 drivers/block/zram/backend_lz4.c     |  6 +++++-
 drivers/block/zram/backend_lz4hc.c   | 12 +++++++++++-
 drivers/block/zram/backend_lzo.c     |  8 ++++++++
 drivers/block/zram/backend_lzorle.c  |  8 ++++++++
 drivers/block/zram/backend_zstd.c    |  7 ++++++-
 7 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index d9b8a6bba2cb..3846a04c69d7 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -15,6 +15,14 @@ static void release_params_842(struct zcomp_params *params)
 
 static int setup_params_842(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index ee26e6c9282f..f71b11bcac78 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -24,8 +24,19 @@ static void deflate_release_params(struct zcomp_params *params)
 
 static int deflate_setup_params(struct zcomp_params *params)
 {
-	if (params->level == ZCOMP_PARAM_NOT_SET)
+	if (params->dict_sz) {
+		pr_err("dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = Z_DEFAULT_COMPRESSION;
+	} else if (params->level < Z_DEFAULT_COMPRESSION ||
+		   params->level > Z_BEST_COMPRESSION) {
+		pr_err("invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
+
 	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET) {
 		params->deflate.winbits = DEFLATE_DEF_WINBITS;
 	} else {
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 6d58956ed5b2..1e28104ad964 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -32,8 +32,12 @@ static int lz4_setup_params(struct zcomp_params *params)
 	LZ4_stream_t *dict_stream;
 	int ret;
 
-	if (params->level == ZCOMP_PARAM_NOT_SET)
+	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = LZ4_ACCELERATION_DEFAULT;
+	} else if (params->level < LZ4_ACCELERATION_DEFAULT) {
+		pr_err("invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 
 	if (!params->dict || !params->dict_sz)
 		return 0;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index c0c3715087c8..d8aa01bb258f 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -22,8 +22,18 @@ static void lz4hc_release_params(struct zcomp_params *params)
 
 static int lz4hc_setup_params(struct zcomp_params *params)
 {
-	if (params->level == ZCOMP_PARAM_NOT_SET)
+	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = LZ4HC_DEFAULT_CLEVEL;
+	} else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
+		/*
+		 * Use < 1 rather than < LZ4HC_MIN_CLEVEL here because
+		 * LZ4HC_compress_generic() only clamps levels below 1
+		 * (levels 1 and 2 are valid). LZ4HC_MIN_CLEVEL (3) is
+		 * advisory and not enforced by the library.
+		 */
+		pr_err("invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 84330dea6af5..d83f92cf757c 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -14,6 +14,14 @@ static void lzo_release_params(struct zcomp_params *params)
 
 static int lzo_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index b3b03a008b64..1b120d062c92 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -14,6 +14,14 @@ static void lzorle_release_params(struct zcomp_params *params)
 
 static int lzorle_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (params->level != ZCOMP_PARAM_NOT_SET) {
+		pr_err("compression level is not supported\n");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index fb61acdaef67..08da3810cffd 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -60,8 +60,13 @@ static int zstd_setup_params(struct zcomp_params *params)
 		return -ENOMEM;
 
 	params->drv_data = zp;
-	if (params->level == ZCOMP_PARAM_NOT_SET)
+	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = zstd_default_clevel();
+	} else if (params->level < zstd_min_clevel() ||
+		   params->level > zstd_max_clevel()) {
+		pr_err("invalid compression level %d\n", params->level);
+		goto error;
+	}
 
 	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
 
-- 
2.43.7

