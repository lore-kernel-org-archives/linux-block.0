Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F013BADA3
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218620; cv=none; b=fgZezw8G59tHhYxCMQr0QLxn38KlDWtgCBunwZbOqIoZ/WW2obQnSzyHGF2YhkksWNq/DOeii51PkCuYjsgXUi7dYdFOoQWKXC3fkir58fFarctZqQQAmqgNYhyufKb56Tg+JRQlW5P0J5C9YK1GIoHHKX7wW/OfbEREEVw1mCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218620; c=relaxed/simple;
	bh=WBMHmexoRnc5u2CT7nYF5zKkcKfbf8ml7Qp9WCj0ZzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUlX0RLMobekdBAhKP9vUIfAqeY+aBm/JJGF0HlHCKI7UyAKwh6ocqhl7cFDOJnxC5iMjppswDdy2oFcDazKY1D1d4djjIpOOrxZM/pgEK9quitcuIuzBdH9+8BIqKRtUOkg3JRq7BTQE4r+mqXLSzkldTizc2pGFK/4rf07VN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BVFFU7jk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVFFU7jk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9516a653so57295705ad.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218618; x=1773823418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J71zgPkooXiG75+C8zjSqtAWOtBSB5HTzljq+F1tO8=;
        b=BVFFU7jknFhgFept2qe8is8o45TEgpRpSvL/0Ww1DgJ44+Z6jtRG+28KdfHo6fha3G
         HHorJ0+vFm56kRCVM7mozbf0uXgLSdFG7MQm866FVjgQr0JH3PIjL0FqzWJDlSC3Ag78
         h1nitBu7h7NzDuaMjF3FcZs3HaA6+n9GI4u34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218618; x=1773823418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3J71zgPkooXiG75+C8zjSqtAWOtBSB5HTzljq+F1tO8=;
        b=LQxqrlNPXcewTWMdROvs3RMMTjBde9Tqzxl8a3tn4FWSlkUe/5492UbRSr0P+Cm5vv
         nkTNUfFvzDHHQqHrRjCayAkQ7z0OmNnbWlA0mgf3KXLdlhhX/Q9N03cwTt2vxCVbKT7n
         xYFEZYdUSajjPpf/dyVXdwLdSYL4a6iLnAjv03Mb1e3zLCzQcnIrMZ5Yysoh9SYmDD5T
         hCnT9xER+k4HNNTF4qpOsd2PDtjSwbfzP+Cmi2uqqJlu9boOzA44tQOtQRoUjYchNrTP
         k5FL0O574g2j475BECozy7JCUKM8DVOa9aRMw0md155tMYD9KDhzZx449z8jkYXm3MxH
         +raw==
X-Forwarded-Encrypted: i=1; AJvYcCVmtvSDBPI/ctzdzZ6pbUpxhkPOY6E0mpvfo1IszPSnYj6WA0fwMwx10UrgXYUzIP4JKkYTi85ZJDbjtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzR/F4fcou6g+rbgL1bPV40aj85LWr9GAWSQYqGX4T0Rw1OB0f
	Ehi85bojFZVKJgV2BdkEuXYXeuUC3dqmONfeTZBxLDK6KRNoN9fD6v4u1SZnBqo66A==
X-Gm-Gg: ATEYQzxGKA6M5uDp0LsbEX/ZtFFhQ6xHrExmEGVOwxW9NNF4vfS2besOiGMQIq1ftbr
	Zapi/ZtA4HB7YBPDIABWlrmsL0aKGX68GF1jgyipj9HgoYqaA848Os9WUBezutLUaKBg5LL8v0L
	LWyDf0HDyBUJb/zFUAntNWoymWwPTEvGVy+2CxneohjwTC15qdvJeLS2X3cUE13oAc3zOQMpvrF
	8AT7mHN6QnLLkIlopqh/dSGtnmv9J6LK4ntNWBzE44ZgNn4B796A/pTuB8AQyvPeMIB7Df7BkpJ
	ABODF64xIypkZvekvoHozwfJdF2cGK2fkYcg/99+TA0DQvvh0zuyt56YIzvjPdazMA9BwJRADLB
	+kMSMOi0Do+T3IAdUHPwJzqc5SIpPWpJc09aMcthSWxJ7OgxK1iplSpFRKHLYDS2U2b5Ugb3uyV
	ggtyFjPmXvty4bXpvqq959/1s+in87hC9lAlBe6BdNBo9BJUq/1O4wqPyUQwzCGnIB2gnFLOsw1
	tfI7c+yijHw6GcF5QB7ML/v
X-Received: by 2002:a17:903:2f8d:b0:2ae:3fb9:2690 with SMTP id d9443c01a7336-2aeae7ef14amr17051225ad.19.1773218618446;
        Wed, 11 Mar 2026 01:43:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 5/6] zram: remove chained recompression
Date: Wed, 11 Mar 2026 17:42:48 +0900
Message-ID: <20260311084312.1766036-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c               | 84 ++++++---------------
 2 files changed, 24 insertions(+), 69 deletions(-)

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
index 0c3e83787d9d..02fb70f35ae8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2347,7 +2347,7 @@ static bool highest_priority_algorithm(struct zram *zram, u32 prio)
 	return true;
 }
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -2373,8 +2373,8 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 		    test_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
-		/* Already compressed with same of higher priority */
-		if (get_slot_comp_priority(zram, index) + 1 >= prio_max)
+		/* Already compressed with same or higher priority */
+		if (get_slot_comp_priority(zram, index) >= prio)
 			goto next;
 
 		ok = place_pp_slot(zram, ctl, index);
@@ -2395,8 +2395,7 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
  * Corresponding ZRAM slot should be locked.
  */
 static int recompress_slot(struct zram *zram, u32 index, struct page *page,
-			   u64 *num_recomp_pages, u32 threshold, u32 prio,
-			   u32 prio_max)
+			   u64 *num_recomp_pages, u32 threshold, u32 prio)
 {
 	struct zcomp_strm *zstrm = NULL;
 	unsigned long handle_old;
@@ -2408,6 +2407,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	void *src;
 	int ret = 0;
 
+	if (!zram->comps[prio])
+		return -EINVAL;
+
 	handle_old = get_slot_handle(zram, index);
 	if (!handle_old)
 		return -EINVAL;
@@ -2430,51 +2432,10 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -2485,11 +2446,18 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -2539,11 +2507,11 @@ static ssize_t recompress_store(struct device *dev,
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
@@ -2597,8 +2565,6 @@ static ssize_t recompress_store(struct device *dev,
 			ret = kstrtouint(val, 10, &prio);
 			if (ret)
 				return ret;
-
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 			continue;
 		}
 	}
@@ -2618,7 +2584,6 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 				found = true;
 				break;
 			}
@@ -2647,7 +2612,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto out;
 	}
 
-	scan_slots_for_recompress(zram, mode, prio_max, ctl);
+	scan_slots_for_recompress(zram, mode, prio, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
@@ -2661,8 +2626,7 @@ static ssize_t recompress_store(struct device *dev,
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

