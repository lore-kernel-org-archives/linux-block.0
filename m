Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5A37D103
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258723; cv=none; b=OXSUxCyFoxpAFh1jjt1w/TX26zX7/Oj3LGXeYaykM3nXCm4DLlizPUvbVTB0r2Yd+d3HSuATcZT/5ZdvHNUoK9WcesERyN98QW5qk6y4g44ClEUOfQYGXI5f/wud22JQsl+f0yTZ3kSXyDEQCUF91StnOojZebayzBD2jLiYths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258723; c=relaxed/simple;
	bh=FlX1JxtGQ4L9YMM6+aD5mJkMLFZBnO5Nl+spgsSmm9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As8/BkronPINzHVZY+BBsQB8++dMO29QyaLfCiTHCrgletecPmfU6zIPM+yJiLf3GVdNjFj7gzug+GJudNR+61GiuS3SkQz+iK3JlSvhh6NdxkVtCH+t0aCtHgKm+76GNLa+kgoIioWpH5VEtnsUObm/z9mNZkZyhxBDxWc5CDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbPANPoy; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbPANPoy"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-466f935a82fso193571b6e.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258719; x=1773863519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnVFn/QWUod1peerD4NOctgVgrZtb1oHuY7D76awS8Y=;
        b=YbPANPoyXW0LwO6glEfUA2Fpx9mVsjufWa/85vXlALMXac8oAWxKTspdMrtCR9gc5J
         CktD1x7RR/vjNVCGXyFDo1tjYh21yvl8rpXqKNhQf4LSdhJzlNaRVyPZDK2QHzM8lljj
         9yw++01j1o3GYGLxic4jo9kNZE7WLN4AGht3IH+Rj2UfbTaCfZKFzvSPD+GCstaKoUji
         +cHjUCNBpNmuBShzEEF2OPvnGf7tgRJggFO006DwtCJnUUX9KBRpYzQQ4iX0bjCssiVf
         59stEfMDFLUS6HtZsbL/i+wItGXOVUVsiKrQMX6r3c/Csdfv+2WrBLRl0n7TZAvdR26R
         WKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258719; x=1773863519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnVFn/QWUod1peerD4NOctgVgrZtb1oHuY7D76awS8Y=;
        b=iGEQKTLGCDyrOyXbAZvDipm8nRHQYPSKUxMGF3gN3isX0+doropF0tzvt5e5+qdIpJ
         ivNXytAczjvRS0fPb0VOi2poJ87R2CE1MmKipG+kxhe1HNDH2hqLO3QTDRNMCdD9vRH0
         pmvAhzpU9OHkVQjvgKYPRXDseT/iee6v9Ko55T9RUoxzBo1wvmySq5C9jtHQYayFVTN8
         +enAFR5eewuKxC7k37Tlbzw14yAcb0F70byBnbpeXQ2ZC64T1mUUbaff7G5hNNPKtu3c
         SIkHrzK6Iu1zbgmbK9baCICivyM19+aqSoNSfwEzTJXBrtGk+OR+YTQOPkn3kDGEcISr
         So9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7AH63sywkRBu7S02tBS1xvkqZbQTQOatHXrgdG9/De7HUMPuaXUP4+W1DIl8gQGAH21v2wrvREhWNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LhTdtWCzWNDJNzrQAmdRy3pmNtQcrKRqkAWA/2qlETjYscyD
	0NGiYFlIfgNdEhBquD20cDSw3WvoXWwvq4Nl9b8aFotvUhcQnlYKS4id
X-Gm-Gg: ATEYQzzDHHdbdGn7EVJKQJLqsr/fvuESujIr7pXCf0UFpONOuXoDuY8GTsaceXWZGnn
	l0C4PJ+SGMoIOs9uyDglxqfcsgJWySbD6QzqU8FLqn0DvWkUnfGjTKdDQhjjMTyDdbCDnp+PlMb
	Dt317/r7JkFaYitQewyKM8Hng27Yq9cviHEg4s6eO+4hYVlDOHlZtYO8lOrnEn02oepPYvphLTB
	hNy4gMVDXHwHP/GwF4FU/LVDTksHf4aLmfNStPlM8GwT0i5289QUmv+c5dlOp07Jux4MZfzaQUv
	ChJOuhY210FOWQrtye3rBNCY/zjBW85CCQT3fZRzZfcLEKGa2LpM1BivotqbRIYOLWzqvFZWno5
	dZFpZleu0y2lkuPskEYkC5VtueZV+pJH4QrdxpSFC4Rtyc40xcsZCzNa71958yLK6938OuxGdAA
	UUs2mFYHx1RudDL7CyXVwv4g==
X-Received: by 2002:a05:6808:6a83:b0:462:d09a:cdca with SMTP id 5614622812f47-46733545ca6mr2042383b6e.32.1773258719499;
        Wed, 11 Mar 2026 12:51:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e94b4sm2862488fac.11.2026.03.11.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:51:59 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 04/11] mm/zsmalloc: Introduce objcgs pointer in struct zspage
Date: Wed, 11 Mar 2026 12:51:41 -0700
Message-ID: <20260311195153.4013476-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an array of struct obj_cgroup pointers to zspage to keep track
of compressed objects' memcg ownership, if the zs_pool has been made to
be memcg-aware at creation time.

Move the error path for alloc_zspage to a jump label to simplify the
growing error handling path for a failed zpdesc allocation.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/zsmalloc.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3f0f42b78314..dcf99516227c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -39,6 +39,7 @@
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/memcontrol.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
@@ -273,6 +274,7 @@ struct zspage {
 	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
+	struct obj_cgroup **objcgs;
 	struct zspage_lock zsl;
 };
 
@@ -825,6 +827,8 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 		zpdesc = next;
 	} while (zpdesc != NULL);
 
+	if (pool->memcg_aware)
+		kfree(zspage->objcgs);
 	cache_free_zspage(zspage);
 
 	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
@@ -946,6 +950,16 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!IS_ENABLED(CONFIG_COMPACTION))
 		gfp &= ~__GFP_MOVABLE;
 
+	if (pool->memcg_aware) {
+		zspage->objcgs = kcalloc(class->objs_per_zspage,
+					 sizeof(struct obj_cgroup *),
+					 gfp & ~__GFP_HIGHMEM);
+		if (!zspage->objcgs) {
+			cache_free_zspage(zspage);
+			return NULL;
+		}
+	}
+
 	zspage->magic = ZSPAGE_MAGIC;
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -955,14 +969,8 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		struct zpdesc *zpdesc;
 
 		zpdesc = alloc_zpdesc(gfp, nid);
-		if (!zpdesc) {
-			while (--i >= 0) {
-				zpdesc_dec_zone_page_state(zpdescs[i]);
-				free_zpdesc(zpdescs[i]);
-			}
-			cache_free_zspage(zspage);
-			return NULL;
-		}
+		if (!zpdesc)
+			goto err;
 		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
@@ -973,6 +981,16 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	init_zspage(class, zspage);
 
 	return zspage;
+
+err:
+	while (--i >= 0) {
+		zpdesc_dec_zone_page_state(zpdescs[i]);
+		free_zpdesc(zpdescs[i]);
+	}
+	if (pool->memcg_aware)
+		kfree(zspage->objcgs);
+	cache_free_zspage(zspage);
+	return NULL;
 }
 
 static struct zspage *find_get_zspage(struct size_class *class)
-- 
2.52.0

