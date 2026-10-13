Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAA46D2BA
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863533; cv=none; b=mh7ljxTGvabaK2fHsVaX8djIn+9T40sQkXMrWb6q0cNT37WtOMGu5g8WhXi+84onB0f97hMtiIKYFRruOV0XKLlG2CIuXvUiyo+0O7dJKwXYvEdvrISs/WveBQVF9LXj3/tgHamF57nAx82whW1Kh8zs2kKQaWyV2aqHpnSVnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863533; c=relaxed/simple;
	bh=FNIJPxvqaSfE2w+rcVfBKa+Ai0eyweCp/G63gRyxRsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QORLicbzXKNaQt8byT2ofM9jLolt0Ap3BDdpEOcz0eCKOKf4CPiF32RNChW+CR3HxJLYH3SjZ0fDCX+xvyzkRxhvs3G8saNaOxZGpPifwW1R92ghxM6k594J12ByaRr6IaVe0+AfU6VT7FjRmCEoBb18og59p14K7Z0o+CPEXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BLKL1xTx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLKL1xTx"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso885346a12.2
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863531; x=1792468331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kck/eLyUGfb+c2Plo1iRp4ljs5N+AUj2dW9HbonDGoE=;
        b=BLKL1xTxiB2H0jbzgeBEYSt829Hw9Nz6OsEN68lqSzsMB2rcY/SfaBLJV/X6o7P901
         4X6zc3UW6dyr9adqI3M01wE/YJKW4XYmVk9WQ4NOMib3E66GI4xML4cuTKFlPdsZNsQa
         kaCvSzEX6RtM1PI0DjEF6DRHU7GST4KaV0lxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863531; x=1792468331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kck/eLyUGfb+c2Plo1iRp4ljs5N+AUj2dW9HbonDGoE=;
        b=CuYpdnwdD2yluTca0UKmzPPu9Ep5s9YRSODYZGomB1vf3DJBj69Af4HNo0XRCM0W1T
         R6mUeYxqQ3g4OGw57bf8141VgTkiGQNZSpubKJy/JdFMvWx6u9upkBs+c7M6Tw8VR3EL
         mW4Otih++qDHAnaU+0lgCFWjWOCIR6vjpR4dCHK+rIxTkoOcxGV9umy67ZfzLiOfQzjt
         MT/8rm+TW63JJpNlnNg5uWtSnKniEuZIGP1XUvC1o++m2GjFcvZii1n+BxnSsQ1BKycp
         KeHENuorpM0Zm+4rPKA0wx9hDGdcw/6SswkQeCKGcQuWR0W8AlZFmkVYN5qQGmJO5utx
         1s2w==
X-Forwarded-Encrypted: i=1; AKwUvBz8BHEnWcFjAYBhJqW9xqeOhsc03CwyVL+06ezPOK5+kje29S6mJaIEdnJbQCe4nPQ+jBc8O4/NoAgjNg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJhFuWe70IjG6u9A2hXomQGzdibyHmtFE4V6eHfXZwZjJLf0eOR
	K8kTm0WJso+UfkvDUkkO2iBUBu32WDz6wc5r+b32Q5WZsPxp26Q559OXyQZzGafLiQ==
X-Gm-Gg: AYBFou2YFbzPQCFrHOORxIumxa4ecrP9v23RZYGzXVdFNPjAfPvef5BdrjBR4qi6RQP
	bMzeonU6rX/0lCSvCqGNGNe1jXDnXw5e0JqKYLp0IM1Jepef2JcQdyBeQtBZJ/DuBY1hmcf+nBs
	AQ4KmVSmBvRt8wXQjOdypUjzoZnrBJOZ7W4rzuX02QXIIAxg1o7LNMlvsEXX+QH31UqwSyO1x8V
	LpPs/CYzJjWAaLs/8WjYppRj4+yQ575c9y3UGzcvGDI/zVOAaRMloTMVYC8YY4D/KO9Nsvq3ZGn
	DyG/w4PGHPZ8RHzTs/I1c3/UlN5Mujeua0O2Q8V1Lw3qtDPAygCO4AOzsNKmFx1NZWWM905k7mi
	+98yQHLvOuPM/msEmQrRKff6fIcLPRLYqCdyrJqqMXqMBfUdsM4ryuRXpp3JhEB4RtAofDdjSP1
	RIbbDhc/r1VuanRQ8E+2q3W9kQKD2N8dLDlDW9q20GtY2QsneUpX1aoxRi0+tnSL4GwIwBqosUW
	CWa8N3MgavxR57JboJvKHhJlFgXI2xP4CVsQMYYoqx8iaZs57GD56bH8MwV7w==
X-Received: by 2002:a05:6a21:a383:b0:3e1:a8fc:18f9 with SMTP id adf61e73a8af0-3e1a8fc1b58mr3084223637.62.1791863531492;
        Mon, 12 Oct 2026 20:52:11 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:10 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 01/11] zram: prefix backends printk-s
Date: Tue, 13 Oct 2026 12:50:48 +0900
Message-ID: <20261013035201.2809924-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, zram backends prefix printk-s with their
names, which may look a little confusing, e.g.
"zstd: alloc size 408128".  In addition, prefix
backend names with "zram:" so it's clear that the
message is coming from a zram backend.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 2 +-
 drivers/block/zram/backend_deflate.c | 2 +-
 drivers/block/zram/backend_lz4.c     | 2 +-
 drivers/block/zram/backend_lz4hc.c   | 2 +-
 drivers/block/zram/backend_lzo.c     | 2 +-
 drivers/block/zram/backend_lzorle.c  | 2 +-
 drivers/block/zram/backend_zstd.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 3846a04c69d7..56ffda201727 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "842: " fmt
+#define pr_fmt(fmt) "zram: 842: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f71b11bcac78..20685aca9bdc 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "deflate: " fmt
+#define pr_fmt(fmt) "zram: deflate: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1e4ad31d39a6..158fd8b5e8a9 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lz4: " fmt
+#define pr_fmt(fmt) "zram: lz4: " fmt
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258f..5c009835a684 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lz4hc: " fmt
+#define pr_fmt(fmt) "zram: lz4hc: " fmt
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index d83f92cf757c..78538479c511 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lzo: " fmt
+#define pr_fmt(fmt) "zram: lzo: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 1b120d062c92..011787f1430b 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lzo-rle: " fmt
+#define pr_fmt(fmt) "zram: lzo-rle: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 08da3810cffd..127976b5455b 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "zstd: " fmt
+#define pr_fmt(fmt) "zram: zstd: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-- 
2.56.0.385.gd3acb90ef8-goog

