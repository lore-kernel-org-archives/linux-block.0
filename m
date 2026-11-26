Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658392;
	b=snSLfjXhhY+ppTaQ+XV2LFqYbRPLVxWCtdO0T83atVjnM5aTkkzvE+MW4TbbXwB9D8Rk
	 QNjbN9I1pYaR0z0qgCHQPrkL5n/j5Kt0ciPp6UMaSlSVWkRf6leavMuPCtHR1ee29Nwv6
	 cf2w5FMy2g/MuGTo7RfZwT4MRmLXnd/bwI6CrDvJ6+cCERaVCESSAGU04+KUJrfkmDbWj
	 BK8f+BxyyhU6DmfRwQ+Q5Kf0BrBd8zjOhjsNq+uWGfZTTNwEEKzTRKmuQGxar7jZXpKRZ
	 QPwYzjzjntebcFuIIQk0AK36Oy9fgSJTy/yejq8biwXK4AoEpPzGIfXev+EYaPlWp+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cwYQ9S4xNOhgMpsr/2Fw0/uwY52gpltHLNu3ahogehA=;
	b=a+nMlvu3woxQR+6v4XVcFFVQ/SSzhWN0Dd19OvihRu31WhLg9gfeOmSuWY4Yl2g+UaYB
	 5w0lia2ZKYsSfLkvrA/Ji6R6avkbgT/6Sb8Q17qUVS8gJGlJ6ee8GQTG43OEGJMaNT2FB
	 MAHh8Ir8zYObBNmwtGMhlH2x3LfnOCKOtrvSlHA+Ejtb7zo0hsa/dHauldkiFzOAv/c84
	 2KmX06KyVDQ3+hvwOkR0wpo0GVPwIqZ2PkSOOckF6CqnvH4IIz6jbPbOxYphBz6KlCr+9
	 LzOmESXDrTX9LB19h3Dz4B1htRRb090DV352c7ctEfIksdKzW4EDd688DFgL+DnMHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="VyH5ZPW/";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5484606A321
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 01:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5484606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VyH5ZPW/
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso3718825a12.1
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795658391; x=1796263191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwYQ9S4xNOhgMpsr/2Fw0/uwY52gpltHLNu3ahogehA=;
        b=VyH5ZPW/di937qaf+QYD6ib8MkxkHDc4mCHkWBpY5RY/jGABHw8rWQPHapKW9puJc2
         e4mWvTsOemVXHeDlvCrgsq6qVEmCsMr/nZboKPp5HvfoHlb97Ogg2y8/TvYCLtb+vnCd
         NJ5PIaSEMKROT/sUMLWAaTAAXEWwR4IgEKnS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795658391; x=1796263191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwYQ9S4xNOhgMpsr/2Fw0/uwY52gpltHLNu3ahogehA=;
        b=Gu5lmaxvvEmNPUF93iJ8FlETo+8Qfhod9l5MsX5tjI1W86W66ma05eiNPaxU+r8Hl1
         DN15z9g/lWIEkfu7hta8cSUpBKAG4VO1v+XbFtj+Lbj4BXYulbGRpOIu0tlJW8td5/P3
         9laDuPS3Rmv0g5DqcztGcnydPmQBaIRQvsPhtaosMS/Qop3ls3/IC6TO7irUN9Z1c2Iv
         Z6NeKORkUndttxGRaTQbWLF5iWPKH/ZY5ddhqNso/Jivor5klblAb9/96G+HPQrrAZqp
         1UEDyoeJJE94M60MK7WpMImhLkRnutuWPZSJM9SHFBvmGcEjw4bYHWjhwH2SryYDJV2m
         MNdg==
X-Forwarded-Encrypted: i=1; AL+hErHKEW9miH4Y8Ckn+KolgM1MgLskw+NlLZQogKcVpadk+bIfot4MqIx/4sL01XrBAV91U1Xp81QQI15uOQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/d0kMkog0KZ/VfQiDHjs+3rQsVeI3SOxAVvV54/l8Kji0avYfm
	BMf8No3SM3jtVdjfjyu4wY3nVrJRQYJTCmYKiNjQbT0BJkb1g62YC+Q2qzAt2X4OZQ==
X-Gm-Gg: AZFdTZdy0ft3hebl4Z1a0ZqwHDFCZ2ujCOD9h3xbxsikem4kqgLi2lNk/ngXIuSFNPB
	DirOF31rV9O+ZE0pp9dA/dvf4tOTSTzWavjG6F5627c10HRX1PyeZFbwuaVw0gSA99Bs6WQhoB5
	PbL9NP1gPzI3i3YUazmtowEFEKZ00/6s6UI8m5p8G0MC2fYMFykiHRU3mzr0+6s66bOYwXYjM5e
	GebjPQAFrexisrnW3Tup8Sm1c/sXBj5+vb497Re3QjV4C5REam0eIO+o0ROKcSKGyw4oEYOs/I0
	eiDTup4DtDTR8qKGAZe8otY4K3a6gsEI+JpJtggFTZGZH26GpQUmAYYbT4ikl7MF4A30aoiUHwK
	oNAgkCropGJlFowmh40NuNTxXfVzXUpV3WUURXhOtcMaEk1RxpZUh5zEVX9gEsabe1MMIMCeVcn
	DkhLkNAqiInL6pzwcQBedxJqCKFhjZ6NoTtkPXI1hb+/PY/Nz1cMwinIjmEtCLAd7mBC7kzmSwk
	2hfu7lNXjCNrD+4JAgYwutFjTLZgOJy+EdDIHi4PyP+E/aa7hAzSz5jNlzGH8tzL/qWjza88EPR
	TzNCFi8kN1JaW3pdr98jSDS0PUMopqAbrqXmG/Ulp6fGzvAzCMi3jjGn7U5p3E6ckLPGOsXqioJ
	xqRMmMKHuDFMzPQ==
X-Received: by 2002:a17:90a:ec86:b0:3b4:889:883a with SMTP id 98e67ed59e1d1-3b41c9bacbbmr19770542a91.66.1795658390973;
        Wed, 25 Nov 2026 17:59:50 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:59ac:90a:64:4bd7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm14344902a91.10.2026.11.25.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:59:50 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] zram: do not modify cont sysfs store buffers
Date: Thu, 26 Nov 2026 10:45:07 +0900
Message-ID: <20261126014518.1318583-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram sysfs handlers that accept key=value arguments (e.g.
algorithm_params_store(), etc.) pass their const char *buf
parameter through skip_spaces(), discarding const, and then
mutate it in-place via next_arg().  This is not dangerous
per se because kernfs_fop_write_iter() passes a temp copy
of user string to zram, however it is still probably worth
fixing, just for the sake of correctness.

Allocate a temp non-const buffer for args tokenisation.

Link: https://lore.kernel.org/all/awcpkJD6K1xtx_Pe@devuan/
Reported-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 96b135e3f727..ca12c1918aec 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1279,10 +1279,15 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long lo = 0, hi;
 	struct zram_pp_ctl *pp_ctl = NULL;
 	struct zram_wb_ctl *wb_ctl = NULL;
+	char *kbuf __free(kfree) = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
 
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
 	guard(rwsem_write)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
@@ -1303,7 +1308,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto out;
 	}
 
-	args = skip_spaces(buf);
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -1779,12 +1784,17 @@ static ssize_t algorithm_params_store(struct device *dev,
 	char *args, *param, *val, *algo = NULL, *dict_path = NULL;
 	struct deflate_params deflate_params;
 	struct zram *zram = dev_to_zram(dev);
+	char *kbuf __free(kfree) = NULL;
 	bool prio_param = false;
 	int ret;
 
 	deflate_params.winbits = ZCOMP_PARAM_NOT_SET;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -1899,12 +1909,17 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				      size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *kbuf __free(kfree) = NULL;
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
 	int ret;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -2578,6 +2593,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
+	char *kbuf __free(kfree) = NULL;
 	struct zram_pp_ctl *ctl = NULL;
 	s32 prio = ZRAM_SECONDARY_COMP;
 	u32 mode = 0, threshold = 0;
@@ -2586,7 +2602,11 @@ static ssize_t recompress_store(struct device *dev,
 	bool prio_param = false;
 	ssize_t ret;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
-- 
2.56.1.839.g22a8290db9-goog

