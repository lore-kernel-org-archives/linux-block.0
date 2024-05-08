Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D554756
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154179; cv=none; b=APYMdDzHErpcslAQdZ0GCZzHeu2Exx7mwAc7NhsURgwFpacBLBY+eSm0xYr/b3hnKtZ/aJG0vedBwxDL4Uyj6GRCt6iViPbi4eaPhFbqlGShYrKWvgOtLcrN1wLlwKroGvUXzktRCNoAbZRMiilydSAtNlvI8a1XJX0hKVzGnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154179; c=relaxed/simple;
	bh=fkmGnp5H4sYk5AcEucbfVYS4PjNz7ma3EYQ0ecKZnDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLK/rOScRuWVPSF8o2BZW53zwXhOWnYERyU7RV8wH03TTzfWotpfCW+tB8c3zDpMBgRB84pVblwNYOwf+R6sj7m/nN3Bi/k1SxDv9zfayI50Ii/bnxhmKIXTh1tITSM1gXQjHr/APAkcoeeWfs1rupmnSG23iH7hlxCIUsIffHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H80IqcB0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H80IqcB0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b3c1ea9a68so411787a91.1
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154177; x=1715758977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=H80IqcB0FwAB6hHdI88P8f4QJKwvMn7A8p8g+5vrIdknVDA/UZYCXoA0/q3VfdU/CB
         1+DZjgHppFXLxXZPGrkvqpJ9uPMySdsXHIqx7fS3aesMhyAoiV8/VWnBQb9DXk4EniMg
         W0RDcxB+4dGF3xwJtv0vHPRqYmofKxCHMjSxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154177; x=1715758977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=oi2EdNzII0/yF953Z7/Y6tYrqnP14W2cjtx4HBCy/rGBZBiucEkNy0k7YSdRCh23S7
         DO8M3/m9ps21KlfuiG5xcPu5i5Zh1nhVvz3BcGWtydjliPm9LV0ZlOxAlZs10CM92YXQ
         LnhcWmvOC+fUpvxGrPVt4iITm7rfNQr+0EcVFeVaNUr6AcLDgciToCOZh5bYqggkAsXP
         Yk9HiOJnnCqAAjwZvTTwFVo0oq6k2rQy9jJmtNvJZN9JKrDPrPLSjce6fPRqAdNe2bdi
         mNY9PCHD0a4mTVvvWQfIzQma5fik/w7vTrFGaPNv3U5WlKTkK98g/r1WRGuwJ+mbb9GY
         3X3A==
X-Forwarded-Encrypted: i=1; AJvYcCUwoc8ZQlOyw6MQ1HWWk1HJJb8PNUQEDBonywH/JmZOuvi7c5cqdc6ECVSplOuv0B53ifYHJzvD96lFxSnLWe33HGnLu/EtMubWETM=
X-Gm-Message-State: AOJu0YzXointqxtMl5ojcHCFBvVYwhUTjNmdpN7+vULdMwAW8+ymxFNF
	9JwIQiKboW9GU0ppGuYJK+mtdnIPg/sbY6kcrLvAAXTN67r8s19lo0PRI+810xvGM5K8yAPXrp4
	=
X-Google-Smtp-Source: AGHT+IHQgia9i24967sF+3KEw6udtuPb13bMRjWKcpvNAJbkVABQfoU1gdDD8sgKiYoXBBzsmpfN/Q==
X-Received: by 2002:a17:90a:bd05:b0:2b4:32c0:d7d7 with SMTP id 98e67ed59e1d1-2b5bc2ad5b0mr7051893a91.16.1715154177470;
        Wed, 08 May 2024 00:42:57 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:56 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 09/19] zram: check that backends array has at least one backend
Date: Wed,  8 May 2024 16:42:02 +0900
Message-ID: <20240508074223.652784-10-senozhatsky@chromium.org>
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

Make sure that backends array has anything apart from the
sentinel NULL value.

We also select LZO_BACKEND if none backends were selected.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 19 +++++++++++++------
 drivers/block/zram/zcomp.c |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 1e0e7e5910b8..6aea609b795c 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -14,12 +14,6 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-config ZRAM_BACKEND_LZO
-	bool "lzo and lzo-rle compression support"
-	depends on ZRAM
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-
 config ZRAM_BACKEND_LZ4
 	bool "lz4 compression support"
 	depends on ZRAM
@@ -50,6 +44,19 @@ config ZRAM_BACKEND_842
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 
+config ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
+		!ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE && \
+		!ZRAM_BACKEND_842
+
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	default ZRAM_BACKEND_FORCE_LZO
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 2a38126f4da3..d49791f724e9 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -209,6 +209,14 @@ struct zcomp *zcomp_create(const char *alg)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * The backends array has a sentinel NULL value, so the minimum
+	 * size is 1. In order to be valid the array, apart from the
+	 * sentinel NULL element, should have at least one compression
+	 * backend selected.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
+
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

