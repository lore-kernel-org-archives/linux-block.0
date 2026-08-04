Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305243935B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836370; cv=none; b=VNuvZXFsZu7f11z82oUKg9C8ciPQHCJjGZPOingwQAOivRsDan7V2gI6OroqiG4athQom9pz9YNxEne5iUdOupzsPr0F7mUi2FaHEIVngkNMN0zir7UpXd0yIHztr/oXeb1yZSqJY8vlVwJwuLZXorKAKNsDeMRqaX7CUKDDAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836370; c=relaxed/simple;
	bh=4WDkqJ5NqKqBlmXNv5UGHEtFFAixJWj53XAO6EYlgtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKWn6Wits0Fdny7ox6WwCzVqa1kqiaxk0JZeuL5RgG1R8ABgv2mFOhCHO2hlXNdZeVg7qcRSH9GGsCVc9b4gnVFQpkZEUDAjTxp+bITtn7oWOT2YkpPCCuLCfibTQmrd36mTaefxjtR2Zf5Pb+gmDxPIDLUQD2HOQBrMYOAik6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgJMc5pa; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgJMc5pa"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so2725214a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836366; x=1786441166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rzvl10fe5wXnUHm1LjdOZRWr4VsPCKLkR+GrS12mpLQ=;
        b=EgJMc5pao+HQwTiPGIySwInH0IEH2UbSUy3VtZDA5yHg9qFgTqrYgsbEW1zLMDYfJo
         ygEYEgiXM64Ot8WNeIqSHKknwljq/9w/fDxLeJ2WKZr4GIwlO+HRYxU4Mk7Dq3NzOl/v
         fcjYT1noG7tlB1Wu5UatfFzrB+gno3FzDRUyHGjZlbNgK+ZrHtEzZ8ieGvtnDS9mrIkf
         y1vkQ57fNiO59gRoBwgQE94SLL2NLnWbKjgmcESc5XwkGU/RHx8tY2cQAAXJhS2wbNhQ
         Fa54qPFw3HQskc42Tjif3GbZR5fQXCu002fKF7IdXmF4D73XNhavTgbWCc/NBAxc3HQ3
         Ay0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836366; x=1786441166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rzvl10fe5wXnUHm1LjdOZRWr4VsPCKLkR+GrS12mpLQ=;
        b=DWBo+seEzUDPFm7J4/tvIeUAulQ1SK8y3gZIAqzeYbYuqQiycChQUwLGYHyWGkaFaT
         6i+w5d5rMQJgzGP6yLxz6sYEzK3OSKh4FDWC0ckqut94dsHbj7v5YM9/+ulb97agVfck
         /4jV0sMTVQbw/Rrwni83Mbhe5QTWk8SZn9a7nu7WsUcStdEExdc6CWrEtdQDTjlZ4TEc
         pInPKW5wniJScDnLEDqVYnvqlxEKGmEFL45Pkatg68gF++GFSqkQOoSTSCiIl28pUrT2
         NzE+iKWd9NYbHFmMezIc3sSZ8WJwLQ0hkgO9XLeSrgDEaIA07+KAygk0HYhxBdxYessX
         ecAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrjTeNiqy9pD3DREa5P1gCBIyq9EfPMFYiz0VNJa5Vau4U1NW/LJXbqXOyceg8swer0lxot/+02Up6YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqPJtRrMj0zMhjGNxmB4b4tGkeFlEin+uq2Fs+CioTs6/sp7y
	7nC9BCqDZHPhX2I5ALvMMRx5jiz9hxD9xMYouAoE/MvzNLoi1iW/NnNY
X-Gm-Gg: AR+sD13mk1Q7pmh70RlGUysG+NDvARjoeZ93pda47iOqVNsiXUdYw8eCFzLUPZDJNLD
	ryRNk9BE1PhH2J8XzSRL5+6l/dDoFUSgs7sO3CEe4X6pT6g2ftg88NBeoD85pUKQYEivVxC3VG0
	vZ8l6Vk5b8koKI1owmPxgo0EGeB8EQ9vbk2gWaXnJj9JPCsM3PY7DbR7JDL0O48WvhZoOwE+wPd
	yxVNS8J3Mc/1kgF/0MUoJXADDaAzJTc7kCVdTZSQA/A5R6WBUKjIpLYU4Hr/wsSMVy9GTNoITMo
	onZumcZjoRZpq3GmXe6uG8NI6REUcpp3PFa/CNOE7QR/UReRoajUQEgJWoRrLjXZPK9kUF3BNrv
	+HDOQ8qOj8B434adm4sGt3LKEltiv5IcJ2Jdg0v53gFqx/ME/lZ1sjtNsMD9Ms1qJn4GxFaXOfD
	wSgm2ZnKJCZHetba1iQFw01OAowQaxYu/hoA7lS5NcIpkF+hH3B6XZb7+AodQ9XMjqomWYgCbBf
	7Ex/H4C8QAqMjd63asaiGR7AQSAHLhDww==
X-Received: by 2002:a17:90b:562b:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-38fbc4053e3mr11588841a91.6.1785836366348;
        Tue, 04 Aug 2026 02:39:26 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.39.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:39:25 -0700 (PDT)
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
Subject: [PATCH v6 3/5] zram: add pr_fmt to backend files
Date: Tue,  4 Aug 2026 17:38:39 +0800
Message-ID: <20260804093841.67920-4-haoqinhuang7@gmail.com>
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

Add pr_fmt to each backend so that pr_err() messages are auto-prefixed
with the algorithm name. While at it, tweak the deflate winbits
pr_err to avoid a duplicated "deflate" prefix.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_842.c     | 2 ++
 drivers/block/zram/backend_deflate.c | 4 +++-
 drivers/block/zram/backend_lz4.c     | 4 ++++
 drivers/block/zram/backend_lz4hc.c   | 4 ++++
 drivers/block/zram/backend_lzo.c     | 2 ++
 drivers/block/zram/backend_lzorle.c  | 2 ++
 drivers/block/zram/backend_zstd.c    | 2 ++
 7 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 10d9d5c60f53..d9b8a6bba2cb 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define pr_fmt(fmt) "842: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sw842.h>
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index b3f7d08b49d9..ee26e6c9282f 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define pr_fmt(fmt) "deflate: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -30,7 +32,7 @@ static int deflate_setup_params(struct zcomp_params *params)
 		s32 wb = params->deflate.winbits;
 
 		if ((wb < -15 || wb > -9) && (wb < 9 || wb > 15)) {
-			pr_err("invalid deflate winbits: %d\n", wb);
+			pr_err("invalid winbits %d\n", wb);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c449d511ba86..6d58956ed5b2 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -1,3 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "lz4: " fmt
+
 #include <linux/kernel.h>
 #include <linux/lz4.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f6a336acfe20..c0c3715087c8 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -1,3 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "lz4hc: " fmt
+
 #include <linux/kernel.h>
 #include <linux/lz4.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c906beaae6b..84330dea6af5 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define pr_fmt(fmt) "lzo: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/lzo.h>
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 10640c96cbfc..b3b03a008b64 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define pr_fmt(fmt) "lzo-rle: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/lzo.h>
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 5fabc3e7e975..fb61acdaef67 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define pr_fmt(fmt) "zstd: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-- 
2.43.7

