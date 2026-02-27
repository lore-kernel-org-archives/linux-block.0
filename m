Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA65387596
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180518; cv=none; b=AYP77TBgLXPrQs83dEE2zFw+Iqjwq/B4F+UqZ6RMdFpgNBy7dCMj042FbZo5CgaDJ+ztj/PFDrj8b/m239IFDeTVCsJX9/LqOf3p3pAy00Loyw7PDgSwKllxFG0LTfNoP6SC9lZV0EGIRf2cdgAAu5gvi1uqZ4fhWg+gELDydck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180518; c=relaxed/simple;
	bh=I2tCsJcN+IpfiNO34xEb8+3weBjaHQBL3uLPGcrWzZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Suyoa8Hz8LBVP4hwsgwbuyN4m8tJS/P0TroUI2UZEGY1eGDRn4r1p6SV/7K+HJjrn/HerVly2CvDbZw7XC3v5Zb7SS1ijkM50s5/6U+xCbqCEZBsU5hw+F1kccTIF7CqfGgxH6EyLlHnRg+FxzBw8VCgGaemijA+hTrdyCJ2RDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GuIkhkJ5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GuIkhkJ5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2add623cb27so11690945ad.3
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772180513; x=1772785313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klMEeOc7AupNNDDtt/xwYDltCZD+zghJruOaHj+TkY8=;
        b=GuIkhkJ50STXCKxItvqlt/LNVVsHOPmhefxZ1CeYFVJCK/j2BCM0gjiIKcpRQRSdJ1
         b2Tsm2TtZKsbw0P+ICl2YVcN2CTkDrAt0QFUTsyLK1mZP5aCj/67zxXyArIRcd4/tv5N
         rs7K30nq7SdR+eWWMFnlMhWiN09hR7Gzd5fQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180513; x=1772785313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=klMEeOc7AupNNDDtt/xwYDltCZD+zghJruOaHj+TkY8=;
        b=w7E1XVEQtQw2Qo7w+iDnw8rcAKyEtHMP6v3JTsD92YVAqnQeElrd5Z6oVeol0d4TYV
         D8t5LNcBSmXmHB1/XC5WJa21eD7Adj7tBwY3TTBj2vZUk9AucNGXlukJUzQCWHQG2dSW
         byY/1v3tQQQk7/iXRxQyUNrdWAUpxpCFR0QzT56A0dthFhNIY+i1oBettFYXUGMHRDrm
         po6FDUoU1b6No+0Z7V6xmhI03G6odpE0G9eiDIPzoTirkgavrAIqaPBJvaksz5W4k62Y
         6vXDQ1fLUX2pZrNWCyLvPPSzugzLqnJrqQefUUplaO4vq6bJ0PIYhEGdmG4et+zxVsga
         rg0A==
X-Forwarded-Encrypted: i=1; AJvYcCXipnV/86ceX3qUdNPpNL0bOzet+rBPs8WkTf792C9Y5jEBlYStWETliEIxxw4Wb9swGjv/SCYkW54Ryg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMqQdQ3bhWGgYTzcWmyoOdCRuhI9Esvla7wnFGXkL3CMt8MJJ
	gyPIH0gY0CLY4dGReJ6bYRHWtZyf8jEYpJDVg63jgGNXTtLAW6+F8zSqpHS+ADFSnQ==
X-Gm-Gg: ATEYQzzGU6FMPq3O0YmiqUl0gcSsyRWmhHLxoD9VIEXpxZHCh3HX1U9aFiEqJsiritD
	ia9K+56ezD1fWfpLlYvYNB8tjKv0M2YamOHbXBAYfPfZ62MmTegGQcZAubsfgm0hmcGNO91K6wX
	jFk2WphjUD0zLybOo2vBWqdJuq8py2Q5YkXBtSX8o/9TeEme+GA0PdFutnST87vdcRNTU2ISSwc
	MRU6CBhLzTYON1Vo0EsxmnnsWGyMYcOYPLmUzjj2LGTJUe+WGyNk2qWTJ20CnPy/1kfW5FZnE3o
	8We3E7Le3AxmmvoU+QuFqwuJWkGi4TvpWcCaY7QYJBFJR1UJQRXpLUO8E3ISA7pekA8mHuMZiav
	ePSDFGk7LcsDpMqlu58jZYzjyD1P+L8YLF1z4MvZSc9E4TDT8M96U+DzlNyMwWNdbj3GEnb7da3
	FjpC81rtu9zM8wMK4UXQbk8rxw9DJWyTDLlu3dM6DIZnJb4gqKjVyHW1q2birl4oeWZI6O2191j
	cEJUhn2QJNBBA==
X-Received: by 2002:a17:902:f710:b0:2ad:ae75:68ad with SMTP id d9443c01a7336-2ae2e417d69mr17948965ad.57.1772180513501;
        Fri, 27 Feb 2026 00:21:53 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm48796025ad.45.2026.02.27.00.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:21:53 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Geffon <bgeffon@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 5/5] zram: remove chained recompression
Date: Fri, 27 Feb 2026 17:21:11 +0900
Message-ID: <cf100b13afb62641d7f3bc10fd77068833f56af0.1772180459.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chained recompression has unpredictable behavior and is not useful
in practice.

First, systems usually configure just one alternative recompression
algorithm, which has slower compression/decompression but better
compression ratio.  A single alternative algorithm doesn't need
chaining.

Second, even with multiple recompression algorithms, chained
recompression is suboptimal.  If a lower priority algorithm
succeeds, the page is never attempted with a higher priority
algorithm, leading to worse memory savings.  If a lower priority
algorithm fails, the page is still attempted with a higher priority
algorithm, wasting resources on the failed lower priority attempt.

In either case, the system would be better off targeting a specific
priority directly.

Chained recompression also significantly complicates the code.
Remove it.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  9 ---
 drivers/block/zram/zram_drv.c               | 83 ++++++---------------
 2 files changed, 24 insertions(+), 68 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 967b58c3aad2..60b07a7e30cd 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -533,15 +533,6 @@ unexpected results when the same algorithm is configured with different
 priorities (e.g. different parameters).  `priority` is the only way to
 guarantee that the expected algorithm will be used.
 
-During re-compression for every page, that matches re-compression criteria,
-ZRAM iterates the list of registered alternative compression algorithms in
-order of their priorities. ZRAM stops either when re-compression was
-successful (re-compressed object is smaller in size than the original one)
-and matches re-compression criteria (e.g. size threshold) or when there are
-no secondary algorithms left to try. If none of the secondary algorithms can
-successfully re-compressed the page such a page is marked as incompressible,
-so ZRAM will not attempt to re-compress it in the future.
-
 memory tracking
 ===============
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 118b0b277e37..ff1931e700c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2331,7 +2331,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -2357,8 +2357,8 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 		    test_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
-		/* Already compressed with same of higher priority */
-		if (get_slot_comp_priority(zram, index) + 1 >= prio_max)
+		/* Already compressed with same or higher priority */
+		if (get_slot_comp_priority(zram, index) >= prio)
 			goto next;
 
 		ok = place_pp_slot(zram, ctl, index);
@@ -2391,8 +2391,7 @@ static bool highest_priority_algorithm(struct zram *zram, u32 prio)
  * Corresponding ZRAM slot should be locked.
  */
 static int recompress_slot(struct zram *zram, u32 index, struct page *page,
-			   u64 *num_recomp_pages, u32 threshold, u32 prio,
-			   u32 prio_max)
+			   u64 *num_recomp_pages, u32 threshold, u32 prio)
 {
 	struct zcomp_strm *zstrm = NULL;
 	unsigned long handle_old;
@@ -2404,6 +2403,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	void *src;
 	int ret = 0;
 
+	if (!zram->comps[prio])
+		return -EINVAL;
+
 	handle_old = get_slot_handle(zram, index);
 	if (!handle_old)
 		return -EINVAL;
@@ -2426,51 +2428,10 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	 */
 	clear_slot_flag(zram, index, ZRAM_IDLE);
 
-	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
-
-	prio = max(prio, get_slot_comp_priority(zram, index) + 1);
-	/*
-	 * Recompression slots scan should not select slots that are
-	 * already compressed with a higher priority algorithm, but
-	 * just in case
-	 */
-	if (prio >= prio_max)
-		return 0;
-
-	/*
-	 * Iterate the secondary comp algorithms list (in order of priority)
-	 * and try to recompress the page.
-	 */
-	for (; prio < prio_max; prio++) {
-		if (!zram->comps[prio])
-			continue;
-
-		zstrm = zcomp_stream_get(zram->comps[prio]);
-		src = kmap_local_page(page);
-		ret = zcomp_compress(zram->comps[prio], zstrm,
-				     src, &comp_len_new);
-		kunmap_local(src);
-
-		if (ret) {
-			zcomp_stream_put(zstrm);
-			zstrm = NULL;
-			break;
-		}
-
-		class_index_new = zs_lookup_class_index(zram->mem_pool,
-							comp_len_new);
-
-		/* Continue until we make progress */
-		if (class_index_new >= class_index_old ||
-		    (threshold && comp_len_new >= threshold)) {
-			zcomp_stream_put(zstrm);
-			zstrm = NULL;
-			continue;
-		}
-
-		/* Recompression was successful so break out */
-		break;
-	}
+	zstrm = zcomp_stream_get(zram->comps[prio]);
+	src = kmap_local_page(page);
+	ret = zcomp_compress(zram->comps[prio], zstrm, src, &comp_len_new);
+	kunmap_local(src);
 
 	/*
 	 * Decrement the limit (if set) on pages we can recompress, even
@@ -2481,11 +2442,18 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	if (*num_recomp_pages)
 		*num_recomp_pages -= 1;
 
-	/* Compression error */
-	if (ret)
+	if (ret) {
+		zcomp_stream_put(zstrm);
 		return ret;
+	}
+
+	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
+	class_index_new = zs_lookup_class_index(zram->mem_pool, comp_len_new);
+
+	if (class_index_new >= class_index_old ||
+	    (threshold && comp_len_new >= threshold)) {
+		zcomp_stream_put(zstrm);
 
-	if (!zstrm) {
 		/*
 		 * Secondary algorithms failed to re-compress the page
 		 * in a way that would save memory.
@@ -2535,11 +2503,11 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
-	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
+	u32 prio = ZRAM_SECONDARY_COMP;
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	struct page *page = NULL;
@@ -2604,7 +2572,6 @@ static ssize_t recompress_store(struct device *dev,
 			 * "algorithm" name lookup is ambiguous.
 			 */
 			algo = NULL;
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 			continue;
 		}
 	}
@@ -2624,7 +2591,6 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 				found = true;
 				break;
 			}
@@ -2653,7 +2619,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto out;
 	}
 
-	scan_slots_for_recompress(zram, mode, prio_max, ctl);
+	scan_slots_for_recompress(zram, mode, prio, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
@@ -2667,8 +2633,7 @@ static ssize_t recompress_store(struct device *dev,
 			goto next;
 
 		err = recompress_slot(zram, pps->index, page,
-				      &num_recomp_pages, threshold,
-				      prio, prio_max);
+				      &num_recomp_pages, threshold, prio);
 next:
 		slot_unlock(zram, pps->index);
 		release_pp_slot(zram, pps);
-- 
2.53.0.473.g4a7958ca14-goog

