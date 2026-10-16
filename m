Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99229394783
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125883; cv=none; b=sVAo8verv4t15/V1sy8FLcESKn7ssaP2BLl37zEkrX8scQ6lMtRSU8S5YElEIoSH20o/gwjiHt0L8r2BZEAke8KTyvBuZ74FbbygNEmgePZ/NF1oR458nqjmdlfRZZ7DsBHbV7IMWXj5EjQJ82KtNYjFcoWTggTYYMZn6YU4B58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125883; c=relaxed/simple;
	bh=ajNNe8N9JiIi6z/58WHY+7M8wVOR51Ewnn5+zaGkgcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhvmPHuZHPt/eIcxZxsw1qtB16HFYtCugatCc2ay3A906RWlP42pKKSJgAAcDvo0OdLk+N1i+LwgkWdm1hlzaY2ewjb6a/CUUt1gCd2PY0aBzVmJq4d4ryLlTbTTU5vcYT3dsO2LdEZ6yxJp/u0mj7PSkXAxQVJNz3r0a3cuxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gnSgr7/s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnSgr7/s"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e812e2b31bso35097845ad.3
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125879; x=1792730679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdQPj6ORXxug2+szeCJ4g7yFuGdwCBNIowOh0yWYffM=;
        b=gnSgr7/sJ+UVRu8jDuOd1/M33qA/roX4i2kbAikmdS128wR75luq8MnFtoRnyjsf7s
         q8aCriKMRnXSaJI25uGhlarWInv5VIr78y7DBJY1Ff8UBE5RgmFfZpv70hXrYIYwzXyo
         erZhgHLTba9wX+O7/JyQbYzeKX3DJscTQBcPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125879; x=1792730679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdQPj6ORXxug2+szeCJ4g7yFuGdwCBNIowOh0yWYffM=;
        b=vU57oBJLf2m8TJc4kx2GW/7vMjbNj28QmzU7doMkTlsO1t7br4iycZJx0Vf4bQZ3px
         Pxw/QbYMEXd0kuGfJcOCvJzqt5b3/QkEz1m1fsqV3S5n86JdMPxrww+NVGPZD1V5amoz
         YFVljha974ermar89UTVSVyh3XDWeEbfAeZS7SjENUhwcTRJTdg+shH0Uv5YF/LjFUE9
         wBEtzG10LbAQa5j9im+Mo45NMOlactqt6+lVMOLlcgCpKrfUD/U2D4vAJBhycuNcXPXp
         SMpcVB7smyC72eJYKpqKQr/cLguRIh8GLVxSmBtzc66qAyaTVxTjmLR7LRkAmAagedIB
         hxyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwUydJLXDkW1L1nI01lEQ8v5FMCWI7UyArsjQMAnZ7gtYq450FyzROd2TKPLtOGQ7upUL0YLkctfvkVQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK/jrOrQjarm9Sb9g8x21kNFByipM3QZnnHmM/fbQ8sOI6hki4o
	ptgJOPvBScGD0gN8YtAnrNTFQtqbVhlYo3D9nSLhA/amhiQks+lgXITsWujZWaLclQ==
X-Gm-Gg: AYBFou3/0mhDXNXODP6/WkpWaJfqshDsNFsUEzZiCeKx7FHc7pueYdK7IEtGylgseh8
	HHHVmJ1gEmqpCqVzWCWsGcqEyENWAn12Tb7gDb2ifZPiKXnpVovF8zMbkJgYwqRngMuEXfy2hXx
	Z1ik6ibn16cjh3U5vcnSrsUNwejaIuPtJZG9TeZ68PMLvMzuPku/7ob4PYwSUXz1FAO9ydc+5P0
	Hzb2mq+0ZlChqCxruciyD9pFKLcneVMwnUo1uMTmYheDB/KIt+yn//ctHaZ8yRKTsgck97s2pAq
	ZZ0qa/TKkYZ5jO4SCgz+5VlL/WDLxZUBwY8Wo9sMF9IdgVp1E8Vkep41VYiGY1Sweeti17V8B3F
	ptcD1OeWZh7q9RPQ3lgYpg+cI50uuwIYEzevcnSJ1+gyqV3F/TLrPnoi201MDsfNbIDZgGPo/Zn
	3EQDrYeulVyRMtmceRtFPBTHAylYrMjHrMTVmsX0Bz+9gVr/dq+iv8L8yJO4TCknqVGBn6H+ijY
	EwMH8x7eY/PH4Kfpdh9/aLBiWKCPedw7x2QFf49rJYKMWFSX7V+SxAwdGgAZDk=
X-Received: by 2002:a17:902:ef4f:b0:2e5:c563:c0dc with SMTP id d9443c01a7336-2e842cdb0f8mr195353235ad.42.1792125879042;
        Thu, 15 Oct 2026 21:44:39 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:38 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 01/12] zram: prefix backends printk-s
Date: Fri, 16 Oct 2026 13:44:06 +0900
Message-ID: <20261016044429.1304561-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
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
2.56.0.176.g3575e65682-goog

