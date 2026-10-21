Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550568;
	b=WPaeZS2oNRO2tTt47Gzxb0ttewGjp24cPXzqvE1c8S/oSUJlRGdIbW6W+D4PFbyJxf8o
	 EUwusBdKIRzZD2tEsFifzP6VlW+ABADf7hOIE1vf+irSwXO7MCX++fQVf5GU0XW+hRRMx
	 B5+mVEqtlx450h82o9eAT9cAPC9g+V19mE4njWkVcdfIFQiNjc6n8qmZScR8vDENSJwLx
	 Yl8s/gJNPDlBis246J7XkDrg4WfmiuNEOUu5ZHsTeccZYYIFKOdR2G2fFe+oyR3VwcZ/4
	 uFsycManFSZwyhC7BkglN2mWY7HpBGPN3iuCRkNVr9uZ4ZRqrRrUJfhW2P4nx0WMGoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mz2Ta6sSCS/adIOr1Yl6IEh9cTq0/Y7T2NePoCn0BS4=;
	b=PeqcnbLXeK0qHbOKP2vZTlvn4Es8gMmMrYon/ENJro7KMAmm5LMyKxM0Qy+K7Pd+52k7
	 3zi55FNMfN8gNiCrZJ23XhVNJygkSxppDTiqKh6gG81QZy9MaOZ9tJEB6+WVgM3mQhb2V
	 0Zwd+3aEhdBxKL+L3k2Gn5lnxYffMNp0s2VBJu77y61cU7xgfwjj9a+Nkj4tqkby8zDar
	 XLczlmXNddmGXfmMkATaa62Usfa3GxDUky8Jh1WxdvSXhPabShKOf18T4RebxRG+sVTee
	 n2KaOrAjPzLtFADjwQ7DKQswGceEHunuGuUaRoVjwmsGlq17AODYrAk0YsS1spYIxJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oVnOeSmp;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923F606A325
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B923F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oVnOeSmp
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1438d9363fbso70567c88.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550567; x=1793155367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mz2Ta6sSCS/adIOr1Yl6IEh9cTq0/Y7T2NePoCn0BS4=;
        b=oVnOeSmp399DWRRdWjIHbKji6b+aCPST/ztu3v98ifV82bIebM78ZUmqlMuSs7H2Ve
         uPmZS8YU124ys9y2+HwW5I3f5h5byWNxnPBYUB35eQWRYsGoT67CPbR1W66xe99Q/1Fi
         bCvOcsk9V1n+wJkbJcXJrt7iSOkbVY7bhx9ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550567; x=1793155367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mz2Ta6sSCS/adIOr1Yl6IEh9cTq0/Y7T2NePoCn0BS4=;
        b=Ve8dT4Z1fjfyCQn289U/nySP+mzsBzPXgFVJJ8f042aZeFZDcJmfdNd80Qbs98zvM8
         mn5qEVTjNYrBTSGlYpfdFGh2wd4PuGqDM/AiyMayWHj/WQtOVkVyl0J5xJbULkaGwknT
         7yir2JdYhCzX77UHgSepcWH/JMyXcIli/RfycokJAm6CpoftaziF1A9vnOmMjrASXYx8
         nId8gPDurEiyZQk9e59AxIiCsBLy29RiUkzdMpT/xoztHcA1TllTQAc6D0g9vZWYiqbi
         ggCmPseWpoHjkUgXpRQqb7OtZ2Opie1PSk1+fXA0vQNzTk/OpSD4zfNIuUZYWE5sWWKr
         Iwkw==
X-Forwarded-Encrypted: i=1; AKwUvBxPdSz/SY8pjXW7zaSthafDOqmO9EzvuNKuKdwUNY8G+MbWKWn2qn7JoYogv1P5q7DB+DlLLLJU9jBHyw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKBBiulQoCm5EqPQEO2dnrUE9KPXcFviJxAt2+mcmtTFs3zeM8y
	T9aGyPgkd7uqO8PD4MgdfXrzVkJzrBhowyyhiaUOG0h2nhLKZqZaDGWvOTI4jqaojw==
X-Gm-Gg: AYBFou3FF9eX0OokZ6SNKvTcaZmA5wWxV1M7a4Hs0VEImxQXYtG3FTIINrt3ZabG137
	ujDkNmI/6WFoqlHvS4kSTEKO7yCh9IgNhQm+WkdLo0klsOGIBbE3w6jZtAxauqgjJFHE0OpsAlY
	ze9qLGnc2lvGX9ePiWJO/ixLQjhBIB0SSM2dDw88tXdaKRFmbPaqYGbUXi5WyX5j5MQDCgKShhT
	3PvWiAJJduhQZ/ZcdbyMkfd2zncx+peg98IBv7xPQphsBWRW7yzq6yEPcXNOaGoO/TlamGFM610
	Eb56LxLM9N2fOqez8lt97CfEBy0DJKAsshPykAZ2PpgddhX8f4SMfqPGq7hBDCPDWrnubj6kH+8
	ILZv3zq6QhmsFPOjOCIWlkCkMtuZMdjVRelTH/KhBWDhL1onm3U9ToY4vHyoZiCAuq9U88hYDCr
	FcMo8E5kQE+ag5pfvV1My0gI1lO5uGAo5AVn5++Q/d+FNw2oy5NMgSjL4xWGu3lVzQLhMP+LSYA
	+Nr8rnE6OVe95IUiLTO/Neo4PXOcOxU6P7dz9xeuP4LfniDePgiEOXv0LcFbh+Os0vvkbHsVWmw
	efKM5kq38bB1NyWeeIthOO2dX2246jbQJwXe1e3Y2r48
X-Received: by 2002:a05:7022:3c0c:b0:184:ae11:51c8 with SMTP id a92af1059eb24-18dc094b1ffmr3601255c88.23.1792550566648;
        Tue, 20 Oct 2026 19:42:46 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:46 -0700 (PDT)
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
Subject: [PATCH v6 01/13] zram: prefix backends printk-s
Date: Wed, 21 Oct 2026 11:42:11 +0900
Message-ID: <20261021024236.1787884-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
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
2.56.0.212.g129ede20d9-goog

