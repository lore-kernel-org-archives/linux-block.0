Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637F358D37
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766420; cv=none; b=SqxIOyOxgxOL6Kq3+vsM76rHjpglNxHM/atK0uApeMg7KmcetTmeFnOi7jvCaiTKmP6s7/i5R6Lga+KfuatCa5HSHRezNa6ipAu17MTwgXoBohOYIeBIiptldPnzRJ0SOeHh1jL+thgP9EcQ9EBbyIGt1UqyY7x2yW6aF18o0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766420; c=relaxed/simple;
	bh=snCwLlHVwdQDYtlAPvwM1n1QYprJfHmXHL9lGUbcfg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwOJQdbz/H2/ANUKkidlK8r0bpg41WKEiKbRYaGGN+3x2WAULlOTzpeI/3FUGfVZhdopby4tH1y+gB/krCu8LiMKTK6S2x3daj99zWRoWtCTxRyhvH11bzwGXHl+fa3VmC/dwZeE8YwmnOT/B45VpktXBdVDCLoiwm8nyEA5ZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwMztbCZ; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwMztbCZ"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so1266907a12.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766419; x=1786371219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Axodgx8kBdbHlZ8xxUIltU+O0hU6tw0N0qpmn8u1aps=;
        b=JwMztbCZaovPJd7OVfwZcCOrlp8RDQddwWz5s4hbC2StmEs0mrfEz3YZjdwQFDwCl1
         +gGCTe7sE5K5dk9QJpFyVedhw80V6LSkGjJ+psz33/YqdK9YdbI/qFGtQc9BPkIWRKLo
         pt2R8BxuRwWmbHgG2AMkolucoQ96q26iSwqUmyt1YAn13mW9LKT6jo6K2GGG4/OQJVbI
         Pr4J9eURllod+KgMBjBrCFG+GQ593zHgEVblbASlhDoHDAZ9mlzS5wZ0O9gmmzbtBTVg
         vWkMEauQHHSU8oyZA1zl/r5V8EPJYaB+MHOJKmeR3UN9XsCLaJmCwLC9s/Be6YVDEcOv
         AQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766419; x=1786371219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Axodgx8kBdbHlZ8xxUIltU+O0hU6tw0N0qpmn8u1aps=;
        b=aiGDZImPIpw6Sh1JWcs7T1U3F8M6/WhFHo9inYeGoghqSOxDo/F408X0czDcYhjgIv
         jjJgp8gJTfLwVzLHy5C1yTVOmMKXzDUFWZsxMpdveMd8D7E9fjWrAn2iUJX/C6rTOgF0
         67FwzcSU6KtKib6HvB7tnhZ7+3Ab9ActxiEhwuxbaJsq5UUH2cwH1iT3EFVw4OLbf3P3
         iZDkSgCGqs4Mwqe/kVmzImysr/ULkuipapMO5vwWzghlzmph+zims80M7PDP6MmiJhqv
         6lIrDB1IOZLC127vAMWxEQZvLSPPG4SgO+V3oiCokAI6p1+O5Ok7UWw5SW6/NtDrKCQz
         RT1A==
X-Forwarded-Encrypted: i=1; AHgh+RqD1i12IuhEA8EGdAywnwf7GrlzrroHfcDAGMBjcK72jCslgh5toPHnaJFGwOdsd/PyNhUXmmWPK0lNOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcdc+kNrYABsPBScgdLKUREs9lJnld3KIaRM6o1lAQZ+EzhE5u
	RTGZYh6t2leHA1tsFhfeDQYouMD2HBRCd8XexbsY8rpDaNQbsjeDAZ7O
X-Gm-Gg: AR+sD116I1SO9FFNGSQ009F5NoTcFo+ITa/cJNan+8eltQ+uAzg8e13kex5o/TUyNgi
	9CLjED5pCOnmtPFgBN5AssO7LGjO+PIMNc5rtV/XK30p0+wEu1R04GIwCbH8D5eEJTex+SuKDne
	0lGWgf73FfFu5K/Ev1bI4IPHPlhGR7Ln0ZVF/k06V5HRpfHKGttlBFkx5Ser6TM1U+mGIns+Ovx
	6/AdVkx+h3KS0dzsxwsHljWOhJ4J2fHdDTTTxTJFPhyko/lkVqsYiZMVUNF8WaWYrxd51LnBeKl
	ggB4L5CpI6arM3ySf01n3pm7WaeyNb07dgBSvl9JRXV69S2/OfB8FIuVDkQ+3bFRowUhAyQ3/mX
	9mA5DvFNWNzIfQD11TPz1HUg+/U1BDH20yd4tXEtugOwzGeSLQGKV9RCJF+D1xRgvU+bOkMenGo
	LOsUH8b+7J+4kkpXUQWcLWyFpKjUwcW17eB2JQT5t7C8ySZHJPMUoDQfNOLUN3n0EijIYQk84Mv
	h2drFp3+AXf2v70L8x3rn7g/+bV2+CFKQ==
X-Received: by 2002:a05:6a00:8d6:b0:848:8027:cb6 with SMTP id d2e1a72fcca58-84ee48bc736mr10168089b3a.45.1785766418665;
        Mon, 03 Aug 2026 07:13:38 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:cd52:f161:9c8a:ee77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm3818360b3a.30.2026.08.03.07.13.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 07:13:37 -0700 (PDT)
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
Subject: [PATCH v5 3/4] zram: validate parameters in each backend's setup_params
Date: Mon,  3 Aug 2026 22:12:55 +0800
Message-ID: <20260803141256.60599-4-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260803141256.60599-1-haoqinhuang7@gmail.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
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
 drivers/block/zram/backend_deflate.c | 11 +++++++++++
 drivers/block/zram/backend_lz4.c     |  4 ++++
 drivers/block/zram/backend_lz4hc.c   |  4 ++++
 drivers/block/zram/backend_lzo.c     |  8 ++++++++
 drivers/block/zram/backend_lzorle.c  |  8 ++++++++
 drivers/block/zram/backend_zstd.c    |  5 +++++
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
index b3f7d08b49d9..b2074c44b2d0 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -22,8 +22,19 @@ static void deflate_release_params(struct zcomp_params *params)
 
 static int deflate_setup_params(struct zcomp_params *params)
 {
+	if (params->dict_sz) {
+		pr_err("deflate: dictionary is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = Z_DEFAULT_COMPRESSION;
+	else if (params->level < Z_DEFAULT_COMPRESSION ||
+		 params->level > Z_BEST_COMPRESSION) {
+		pr_err("deflate: invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
+
 	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET) {
 		params->deflate.winbits = DEFLATE_DEF_WINBITS;
 	} else {
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c449d511ba86..f4f5111220c7 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -30,6 +30,10 @@ static int lz4_setup_params(struct zcomp_params *params)
 
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = LZ4_ACCELERATION_DEFAULT;
+	else if (params->level < LZ4_ACCELERATION_DEFAULT) {
+		pr_err("lz4: invalid compression level %d\n", params->level);
+		return -EINVAL;
+	}
 
 	if (!params->dict || !params->dict_sz)
 		return 0;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f6a336acfe20..d7cd97b898bd 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -20,6 +20,10 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 {
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = LZ4HC_DEFAULT_CLEVEL;
+	else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
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
index 5fabc3e7e975..e071fa584f6b 100644
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

