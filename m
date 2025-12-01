Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2085303A0E
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582506; cv=none; b=ltNzW5HxGvCatUI3b/lZQwAKphmB+u84YwceenfpH25sJbMeiIVgl775lcjNVWYFkwzn4LjXzuOvubSnues8k7mO7qGGcL8FlMP3dNxZee1bev59yVX6A+8xKlIvRWjChBDBrsUQwsDimFW3o8GZVKeYgM/Dz02d//El1YXx6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582506; c=relaxed/simple;
	bh=3WR+Hz4p20TODNgOXzqUGBkhXgJIsLJmME/K+r23E+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H16IUFdKRcBJA/C6ZlwlZvDCqSN3AIM74rgQEXBqNun38YdLcR7ZTfGjD5Hq3c/NMbFck3BUVrmtD6HQLOF2JK/KOeC8tim0Ooc+NNTm4UVd9PqYZ5dQgGwS75+bDp7hgwk9Hdom/zqf6kMa4IA6ZgquPx4gsqyXkgsns1NNy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZOsBqfxy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOsBqfxy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aad4823079so3396096b3a.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764582504; x=1765187304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D55crJZWYW5y22wme+Q0xHtiGm3WaMjTuTpUN/z/uDQ=;
        b=ZOsBqfxyGRzpN5uyih/SwwwP6QZDS0ib3tJwnPIAJSinx75pwvsNaI7PSJq/46JJ9j
         ycw29Vteoy3ykn9Sj1JEZqDd2Qfj6mBRXk13ipbbkx9Z0eCDGaePaXweRLduluyllK6l
         UmyD+AdNEnT4lSz7vg2JSNcxm4CuMzFEgDuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582504; x=1765187304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D55crJZWYW5y22wme+Q0xHtiGm3WaMjTuTpUN/z/uDQ=;
        b=txlXltpYJFAAbVuWROtJltphjNlFTSjaTJT5IbvTWiUZWF8LqNmMH1FHNITKV0Cp2W
         UAoOWEtzO8ntZKmiKLgXkIk06Epy2Yj+EwwPKJNCvHZ1LssBpqE9l5pk69pnTvL19abu
         MJmF90t8tY8wE98tnJLzScds7GLotAcxrv+qYt9ywHsNMashZcDRJYplkjTYjwigAtD6
         O2q7a32LUpx61XA+CJC3REfWcP2NSsg+7QErYOi0OmL2GvJjocWbNm/uiGY7LPBg9VhH
         Gj1GaCIrJUz8DuAhHfWDAOa1ismlTnkDcG8H+xqE2SRwBSdg+Fd6XdCrGQ9dSdxa8C73
         rxLA==
X-Forwarded-Encrypted: i=1; AJvYcCUcmB+fVrz8ub7bsB9NpmzB3LeFtdMVXIhaU+jYvaB5XdC7lkq0VcBfXBC9wFPGSNd7+FBoDjNSw6fMew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIX4PaxPwhjxqMLKnvDmW7jFRb0NXQuGQIc0di4yBzSUrN8iIB
	4tM1TzRjTxqHUSr9azGfrJ+YA1Jfp2bkwO35jCoMJSiQ9kyXMcSXf/lLWzvPH3L1yg==
X-Gm-Gg: ASbGncuu9ryHuIOy/uq6zFiMV3ethvtjsKFldwRm0L+sKFmFVMk3stmoIYh92PU48ys
	3MGCAWrfOdaWsiNs6u+23dohxsgTz7x2G95uTni/zHjY5yT875g9XPIzXl1F7lFCDKeqaWOBpFU
	XRmI2Wa7mp2mF9OOo6KETerW6P1xPFIbCsYL6h1SeZrkL/xweQ5LPDqD4M26UZ4zCgSEFpwdl/2
	nAboDHNaknGP1mixi3BPFBPI9/D7x2o0uwr0/V4Da276GY0pbytA0h/JK4P9gliy2DDysvAictp
	BSevO/DZ7W5toG1/vtWfhKbpZXmHVZVOxKoHy78TNzo8rFLaocbjetqzora4OUSJ8P25m3iMiYS
	khX0ehQi3UoFQrUbMCaEwU1ttNJF9XjIT0sg66Cp2trQeO64PRqAfaiUZZZt4+q7srFsuwo1Ij5
	lckhEzESfiRe0LuvelAbLjRQdtIGi334SlRLBKZnAKcekaqrOaafLnfX4LqEyHhZaGv7hTWwFcQ
	w==
X-Google-Smtp-Source: AGHT+IEl7N/dM1tmzBzSc8w5jctWzUot+nqnpPOQiY3QXNdxfFy7u3OLp9wLsDD2vN5+NSzPEqYx5A==
X-Received: by 2002:a05:6a00:8d6:b0:7ab:e844:1e76 with SMTP id d2e1a72fcca58-7c58c2b20b5mr34419865b3a.5.1764582504112;
        Mon, 01 Dec 2025 01:48:24 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db577sm12882074b3a.31.2025.12.01.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:48:23 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 7/7] zram: consolidate device-attr declarations
Date: Mon,  1 Dec 2025 18:47:54 +0900
Message-ID: <20251201094754.4149975-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251201094754.4149975-1-senozhatsky@chromium.org>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not spread device attributes declarations across
the file, move io_stat, mm_stat, debug_stat to a common
device-attr section.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4b8a26c60539..67a9e7c005c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1966,10 +1966,6 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR_RO(io_stat);
-static DEVICE_ATTR_RO(mm_stat);
-static DEVICE_ATTR_RO(debug_stat);
-
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	size_t num_pages = disksize >> PAGE_SHIFT;
@@ -3008,6 +3004,9 @@ static const struct block_device_operations zram_devops = {
 	.owner = THIS_MODULE
 };
 
+static DEVICE_ATTR_RO(io_stat);
+static DEVICE_ATTR_RO(mm_stat);
+static DEVICE_ATTR_RO(debug_stat);
 static DEVICE_ATTR_WO(compact);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
-- 
2.52.0.487.g5c8c507ade-goog

