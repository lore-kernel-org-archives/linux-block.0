Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953A3DA5DA
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295498; cv=none; b=A03Vzb2g0kari1zdGFfNCxeU0uQ4LicSavEUmUEMGxzGWl+30Dmye2lEK0fPbNP8ftYIKg5I5S13fhmMrNAHlXZV6oLPO8ykB1qM5rpIkuEOjvhMZQTFx+vfNDWEHAkj0zedzFnkTxk3u85XFHAmslcP99myNQVoxSTAnC0uI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295498; c=relaxed/simple;
	bh=ajNNe8N9JiIi6z/58WHY+7M8wVOR51Ewnn5+zaGkgcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDBhCd1cFOK0syd62A4bOckvBUrvMpF3o8j2DCcup8GgIAvuxD9+wTv6Bp8nZzdKO6kyncuk7tllTlOHf58pJvgXh19g63NXKWrveWmVk1FviOM7BrBkdwto79z1euO2vieaFFUmjI4ezPckVtxMqRIAJkahxTnRIpC15fc+g7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nepzn37c; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nepzn37c"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso656682a91.0
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295496; x=1792900296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdQPj6ORXxug2+szeCJ4g7yFuGdwCBNIowOh0yWYffM=;
        b=nepzn37c/f6mEOdKvCodJn9AXFLGSAtcVZdZN0XmdAiqGMaft6Nb7N1ujGAg9Le3du
         BLS5bMDKRxwhKif+NtyaVOKebNOZWMosg3DeNn7e7oekqOHvHBvPRrxJc4BMeNnoEA4z
         4ZbH8jL0NvXf7VTXtSF5hiMFLK41pv3336104=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295496; x=1792900296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdQPj6ORXxug2+szeCJ4g7yFuGdwCBNIowOh0yWYffM=;
        b=0IdfbY0cIo4dgtJvL7/o9cDZ7uSiUBHuUoxBeWtevDHiKdilzVEEiHXqS4Yqhk5SR0
         9n64OqhYmMG2lEB5i3szyeKXbzLAh+NFjoAR77cPkjvpw2pjtnDyQ735fzCurar/MS7p
         b8BP7yAEwwb6qIG64bIFv/eGCNYvaNw/WuhILA1zCZzjfDN+wXDLrsSrIO8jdFWr5+s3
         ELX9wmcWD5pBYhcObYyKMRyKZOY5XdAWTeywMbgwZjtswDk5iazIh4SPVCk6IfAXtCCx
         6gcqWHahonVo6WINs5bMp1gTm3wLdj45tF8FSR8+WFKlscLH+JgBYswWqrZTlEz/a0vV
         1QKA==
X-Forwarded-Encrypted: i=1; AKwUvBwyCkV5kXXpnQNqy/TzwF+HJJCQQgFB2GI5gPPGcU/GmQNKNYzoUgWHOrV5MdQrn5b8hc+91gfVGtR6VA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1qBer4KxqX0vYfqBaWwHxyMuxpYpDWTgu5HMECq/aVnSIzohl
	YWY3+PZEuuWQOD0SiLigPXyAl2j6oUyqSEcofBTsNVOT5c7QxYyPsoV2gEDbhdmWLA==
X-Gm-Gg: AYBFou2GiaM8d+AZLfP6qFEXGjvPjXAKWw0GA1X/O3Nayc4XpMLl05ObIWKR19Y+Dln
	D1FYqOzt5/lmK5Y+CzZx9lgKoIBSqJyOqWk73SBJhaEfd5vy03ZYBXxcgrBB+9HgXHf1ITQdhGu
	MZfXppcI6jS1Zb90L5LLYJr0qgrW7SNEu5L1QOKF1aOgs0WwhSkZ5BNM9+E9/S4aFMEEn7po3Mv
	UaKk5ouhsKoYCBvvsFyGKKzCgbL5xWSgq/G7cEb91mP32utLXhh4v1KM/jZhmwdXqM+NeaR21QI
	aqQ45kVmEySVagXjgDBpYuxwrlfpqyY2cWQzMOU+YhJHEY7riNrrktcIEmIr5HyJ206rosEc6wj
	MvotmqWfST9d6ZA7AaPkLlEJbgeHv0kym85bfYaBl8EdIIEh3OYVeUr2yKzb81BvlWFj/RSWfSR
	kJSHtSNP29ZpqJoylrUnkgA9wuCA0HyGKPpwyBgd4Jdb15yWg0QubayDHYhFtjxmiDmwAFBFles
	tdPWtzYJkvCm5LpmeNH8U3gei0SFCaQMO2H6aWoTuk46Ne4+uhTrPfQG6Me/h8=
X-Received: by 2002:a17:90b:390f:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3acef5f5bd8mr3660899a91.59.1792295496583;
        Sat, 17 Oct 2026 20:51:36 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:36 -0700 (PDT)
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
Subject: [PATCH v5 01/13] zram: prefix backends printk-s
Date: Sun, 18 Oct 2026 12:51:03 +0900
Message-ID: <20261018035125.3120704-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
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

