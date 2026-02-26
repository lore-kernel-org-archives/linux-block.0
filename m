Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBD44D68B
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134187; cv=none; b=BIyaRTwgElDAabDA4hKnOd5JXVorTGbQ/8CSLsiQEbdAfTAcKoypGU2Vh5IMJxeT0oCx30wN23M+7unv5YhrJfgtnDMjiojU3nX1FHuhYCbSGRBImPhNrTY7/vA0Q/P77Jc8ky6uIrHrHH1u3BXRpw2kd31m/OrIXiZBGfuMszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134187; c=relaxed/simple;
	bh=DT19TRdA5oyg3IgCUS/WqcyK8wzAoIu7HCAdavF1MoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy00WD8+A5XeSXGv54MH+e0U+kO6gbU/Dld4mWXY0jVfeDItyZ2oKPiXKAtdt+sSKjfqcSaZ4cCgn+BDNmFBv2v3GqfuglNdxgGYU+dlVqSGmATPONdGXgC8CDolcQb69YEE4F0d7gG0forFyUUeXyL44pdizc9TH3JPwN7334I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYq4izOy; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYq4izOy"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4648448e387so985950b6e.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134185; x=1772738985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW6bnOf4saMn/cuTsdPZSzO5iSHkVVIBXAzg98Lfp08=;
        b=cYq4izOywjtK6YxQmfJTyS5s4kfpA6siY6kcbJ7BDt1caWXY6V2O3gEMRlPcrTiPRo
         HecR5FnpNKk6/2PN0YRXwWoE3e6AJx5RI00gtRLZTaGY+rLvOwjUw4kZWBFwFp6bFncT
         4lRpQ5eCch0wqzEjgEMWirMd9NYXEU3MzQAICCYxVR2QXGM9Ib5qNuL/zG7LOXLdca/T
         34caMtW2P8zAmTQykmWlNFfna13rh6mlP8ks2gQ2miWugTiztH5GnK/wlSgqF6J02vpE
         ipfClH38nGwxmqwlk1jhr4Q7eVsMaJH2AReDud4CRJqdoOuszH/KXxz1hKN6a1ATDdTs
         EsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134185; x=1772738985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW6bnOf4saMn/cuTsdPZSzO5iSHkVVIBXAzg98Lfp08=;
        b=UXf71bqQ4iVrc0SSjvRTfiUyOHmgvTY5i+QGe4nraqXSotcjkc2N32jF/H1SZaG+K2
         lUVdPeyiJ70wKWgrBwESVlk+rzq9dZaMS7YDScqY7F3UqZKzcBQ+DmaMOS+R2q3viAdm
         WT3hsx8dqYoC5cxf3nCfe92liB1vPWetd+UomNu44raC2vYLUk3yuSVry4ISKa8nknsN
         RqZqxJgbb66JmpEKg7G6voQ8j2apI7V9uC5YerOauGr+CO717AM+PlLJ1pa52Lwj12oR
         8y02mlhySg3P5XYRnpojmeRohEca4Wbmn9nR5GUn8+UK+E1mXUK3A44q9z7SjLWb+Kua
         7qlg==
X-Forwarded-Encrypted: i=1; AJvYcCVkX86tRwIBEWjikEb4hdo3J0xzIL3msfTMOY9410/JnawhNxam2nBCQQmEGpYDi4XunpfQW1IKhM1eGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxErWbb03laNgNnW0tkpqtOy2VD4WY7kG5+zFUR4dbDvBMo4ZAx
	TdAbCEnRXeED40Mj80MVb0/yTvmPs/QpkyBWD8MoWDqxQCpao6xoK9Qg
X-Gm-Gg: ATEYQzzlsp9v83iYKVBAyhSPGYWWTN9kLYeMF+73vxkMQKkg412hWSOVPuksuswGq2U
	mbjYphCVDoDtsLRQeAsgVKHuhYKddOM1OITzGLl9JiY6XpRglPAI7IWorrdJssG9H687qz4gXmh
	+5h3JhacM1WPDDbvJtjWYghFk7vg+TtSPVvCoenLcyRtUa0laSjpaCfrbT2MbwoYe3wQZJ0902S
	UR23SIROfX4m4QPXW4TMNRColWlFQkqAVv6IrPdyZCsEvf0EK1Z6B+kTeeGgROm/A8A91FE4ucL
	CwUi6FGH7t2yyB4QZNQZcz8UH1/NSl1TyfIv29hJexkUPdPnTh5FfbnUmeQzqpngjUj0dk86wN4
	GV46PlO9CePShTPlS1KS0S/Ql7zYUC0o8RWn2L7HDya2mCHsyR2Yh3/gJgi0YpB73wnlWDfA0C0
	MLctVfF+87S89MYyKCNnag
X-Received: by 2002:a05:6808:1907:b0:455:8400:f078 with SMTP id 5614622812f47-464be9d3740mr159972b6e.25.1772134184607;
        Thu, 26 Feb 2026 11:29:44 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm475167b6e.8.2026.02.26.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:44 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
Date: Thu, 26 Feb 2026 11:29:26 -0800
Message-ID: <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an array of struct obj_cgroup pointers to zpdesc to keep track
of compressed objects' memcg ownership.

The 8 bytes required to add the array in struct zpdesc brings its size
up from 56 bytes to 64 bytes. However, in the current implementation,
struct zpdesc lays on top of struct page[1]. This allows the increased
size to remain invisible to the outside, since 64 bytes are used for
struct zpdesc anyways.

The newly added obj_cgroup array pointer overlays page->memcg_data,
which causes problems for functions that try to perform page charging by
checking the zeroness of page->memcg_data. To make sure that the
backing zpdesc's obj_cgroup ** is not interpreted as a mem_cgroup *,
follow SLUB's lead and use the MEMCG_DATA_OBJEXTS bit to tag the pointer.

Consumers of zsmalloc that do not perform memcg accounting (i.e. zram)
are completely unaffected by this patch, as the array to track the
obj_cgroup pointers are only allocated in the zswap path.

This patch temporarily increases the memory used by zswap by 8 bytes
per zswap_entry, since the obj_cgroup pointer is duplicated in the
zpdesc and in zswap_entry. In the following patches, we will redirect
memory charging operations to use the zpdesc's obj_cgroup instead, and
remove the pointer from zswap_entry. This will leave no net memory usage
increase for both zram and zswap.

In this patch, allocate / free the objcg pointer array for the zswap
path, and handle partial object migration and full zpdesc migration.

[1] In the (near) future, struct zpdesc may no longer overlay struct
page as we shift towards using memdescs. When this happens, the size
increase of struct zpdesc will no longer free. With that said, the
difference can be kept minimal.

All the changes that are being implemented are currently guarded under
CONFIG_MEMCG. We can optionally minimize the impact on zram users by
guarding these changes in CONFIG_MEMCG && CONFIG_ZSWAP as well.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 drivers/block/zram/zram_drv.c | 10 ++---
 include/linux/zsmalloc.h      |  2 +-
 mm/zpdesc.h                   | 25 +++++++++++-
 mm/zsmalloc.c                 | 74 +++++++++++++++++++++++++++++------
 mm/zswap.c                    |  2 +-
 5 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 61d3e2c74901..60ee85679730 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2220,8 +2220,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	 * like we do for compressible pages.
 	 */
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
-			   GFP_NOIO | __GFP_NOWARN |
-			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+			   GFP_NOIO | __GFP_NOWARN | __GFP_HIGHMEM |
+			   __GFP_MOVABLE, page_to_nid(page), false);
 	if (IS_ERR_VALUE(handle))
 		return PTR_ERR((void *)handle);
 
@@ -2283,8 +2283,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}
 
 	handle = zs_malloc(zram->mem_pool, comp_len,
-			   GFP_NOIO | __GFP_NOWARN |
-			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+			   GFP_NOIO | __GFP_NOWARN | __GFP_HIGHMEM |
+			   __GFP_MOVABLE, page_to_nid(page), false);
 	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle);
@@ -2514,7 +2514,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
 			       GFP_NOIO | __GFP_NOWARN |
 			       __GFP_HIGHMEM | __GFP_MOVABLE,
-			       page_to_nid(page));
+			       page_to_nid(page), false);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle_new);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..8ef28b964bb0 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -28,7 +28,7 @@ struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
-			const int nid);
+			const int nid, bool objcg);
 void zs_free(struct zs_pool *pool, unsigned long obj);
 
 size_t zs_huge_class_size(struct zs_pool *pool);
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index b8258dc78548..d10a73e4a90e 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -20,10 +20,12 @@
  * @zspage:		Points to the zspage this zpdesc is a part of.
  * @first_obj_offset:	First object offset in zsmalloc pool.
  * @_refcount:		The number of references to this zpdesc.
+ * @objcgs:		Array of objcgs pointers that the stored objs
+ *			belong to. Overlayed on top of page->memcg_data, and
+ *			will always have first bit set if it is a valid pointer.
  *
  * This struct overlays struct page for now. Do not modify without a good
- * understanding of the issues. In particular, do not expand into the overlap
- * with memcg_data.
+ * understanding of the issues.
  *
  * Page flags used:
  * * PG_private identifies the first component page.
@@ -47,6 +49,9 @@ struct zpdesc {
 	 */
 	unsigned int first_obj_offset;
 	atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+	unsigned long objcgs;
+#endif
 };
 #define ZPDESC_MATCH(pg, zp) \
 	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
@@ -59,6 +64,9 @@ ZPDESC_MATCH(__folio_index, handle);
 ZPDESC_MATCH(private, zspage);
 ZPDESC_MATCH(page_type, first_obj_offset);
 ZPDESC_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+ZPDESC_MATCH(memcg_data, objcgs);
+#endif
 #undef ZPDESC_MATCH
 static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
 
@@ -171,4 +179,17 @@ static inline bool zpdesc_is_locked(struct zpdesc *zpdesc)
 {
 	return folio_test_locked(zpdesc_folio(zpdesc));
 }
+
+#ifdef CONFIG_MEMCG
+static inline struct obj_cgroup **zpdesc_objcgs(struct zpdesc *zpdesc)
+{
+	return (struct obj_cgroup **)(zpdesc->objcgs & ~OBJEXTS_FLAGS_MASK);
+}
+
+static inline void zpdesc_set_objcgs(struct zpdesc *zpdesc,
+				     struct obj_cgroup **objcgs)
+{
+	zpdesc->objcgs = (unsigned long)objcgs | MEMCG_DATA_OBJEXTS;
+}
+#endif
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7846f31bcc8b..7d56bb700e11 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -39,6 +39,7 @@
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/memcontrol.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
@@ -777,6 +778,10 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
+#ifdef CONFIG_MEMCG
+	kfree(zpdesc_objcgs(zpdesc));
+	zpdesc->objcgs = 0;
+#endif
 	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 }
 
@@ -893,6 +898,43 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	set_freeobj(zspage, 0);
 }
 
+#ifdef CONFIG_MEMCG
+static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
+				struct zpdesc *zpdescs[])
+{
+	/*
+	 * Add 2 to objcgs_per_zpdesc to account for partial objs that may be
+	 * stored at the beginning or end of the zpdesc.
+	 */
+	int objcgs_per_zpdesc = (PAGE_SIZE / class->size) + 2;
+	int i;
+	struct obj_cgroup **objcgs;
+
+	for (i = 0; i < class->pages_per_zspage; i++) {
+		objcgs = kcalloc(objcgs_per_zpdesc, sizeof(struct obj_cgroup *),
+				 gfp & ~__GFP_HIGHMEM);
+		if (!objcgs) {
+			while (--i >= 0) {
+				kfree(zpdesc_objcgs(zpdescs[i]));
+				zpdescs[i]->objcgs = 0;
+			}
+
+			return false;
+		}
+
+		zpdesc_set_objcgs(zpdescs[i], objcgs);
+	}
+
+	return true;
+}
+#else
+static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
+				struct zpdesc *zpdescs[])
+{
+	return true;
+}
+#endif
+
 static void create_page_chain(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *zpdescs[])
 {
@@ -931,7 +973,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
  */
 static struct zspage *alloc_zspage(struct zs_pool *pool,
 				   struct size_class *class,
-				   gfp_t gfp, const int nid)
+				   gfp_t gfp, const int nid, bool objcg)
 {
 	int i;
 	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
@@ -952,24 +994,29 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
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
 		zpdescs[i] = zpdesc;
 	}
 
+	if (objcg && !alloc_zspage_objcgs(class, gfp, zpdescs))
+		goto err;
+
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 
 	return zspage;
+
+err:
+	while (--i >= 0) {
+		zpdesc_dec_zone_page_state(zpdescs[i]);
+		free_zpdesc(zpdescs[i]);
+	}
+	cache_free_zspage(zspage);
+	return NULL;
 }
 
 static struct zspage *find_get_zspage(struct size_class *class)
@@ -1289,13 +1336,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  * @size: size of block to allocate
  * @gfp: gfp flags when allocating object
  * @nid: The preferred node id to allocate new zspage (if needed)
+ * @objcg: Whether the zspage should track per-object memory charging.
  *
  * On success, handle to the allocated object is returned,
  * otherwise an ERR_PTR().
  * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
  */
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
-			const int nid)
+			const int nid, bool objcg)
 {
 	unsigned long handle;
 	struct size_class *class;
@@ -1330,7 +1378,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 
 	spin_unlock(&class->lock);
 
-	zspage = alloc_zspage(pool, class, gfp, nid);
+	zspage = alloc_zspage(pool, class, gfp, nid, objcg);
 	if (!zspage) {
 		cache_free_handle(handle);
 		return (unsigned long)ERR_PTR(-ENOMEM);
@@ -1672,6 +1720,10 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
 	__zpdesc_set_movable(newzpdesc);
+#ifdef CONFIG_MEMCG
+	zpdesc_set_objcgs(newzpdesc, zpdesc_objcgs(oldzpdesc));
+	oldzpdesc->objcgs = 0;
+#endif
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
diff --git a/mm/zswap.c b/mm/zswap.c
index af3f0fbb0558..dd083110bfa0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -905,7 +905,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	}
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	handle = zs_malloc(pool->zs_pool, dlen, gfp, page_to_nid(page));
+	handle = zs_malloc(pool->zs_pool, dlen, gfp, page_to_nid(page), true);
 	if (IS_ERR_VALUE(handle)) {
 		alloc_ret = PTR_ERR((void *)handle);
 		goto unlock;
-- 
2.47.3

