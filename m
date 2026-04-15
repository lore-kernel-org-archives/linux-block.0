Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F7347BC4
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249852; cv=none; b=UzcTLybuMK8IpacUCyv+Z/48Bejf4BiB2eu0oU7U0svk6rUalz1oR83v63UdkvrA+mKKGk7JlsnBsdNp5GJsNTng5icLH0aMzpZaxZEIX7IkhLtNvNvZzjGz7rconiQwHeo5oq4GRyD0vY5e1NpdvGI2ycmGGB2VTvPMPGWdZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249852; c=relaxed/simple;
	bh=lHzFCy6pEOx7EISczk2suaQiyl0tGjL9dkRVT2ECXYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrUFIb3W5fGdZDdLw/p+7WqWj1yBjsnXKoMFFEwWH6knc5rQxHGI1hR5c7jkKDKvATxtSqd1v2s/MHThaAO9wVzJ+3m05H2OQqTtOFbYccJnd1s9Fms1IN0/dt8mnG7XQybE5TPVQn/LMLvXuhgnZmYb59Tq8hP08IU/wOh3jlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC7k5Umk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC7k5Umk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so50558695ad.2
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249850; x=1776854650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiJe1Hi9oQ/cmA4CtiFYHAXrSluo92QTvEGuC0xhX5g=;
        b=MC7k5Umk5gDoYbZ2i1xQCvTy3ZdBwknToGhxQ7ALkqV+ZnCtddJqYYb40lOSm+oXzU
         HFgjcuoSYlVgSllas+wlH4GHEQfdm4Mj3B40UdsTc3/LptcLgLxP56UnoNa7k5EvkMvi
         n06oExJTL/3hiJ0TXh4Q/R0t4wj3+08pDPV+8+ZIA6RjyOAIuBryn82/CmLapN4ZX8ba
         rhbWoweEk39L14gn/yO6YACdaDzY8cpEBJoEObjyDvbIVutc5Cpn1o3JbkUus8pmg4J2
         omI93bJKmR+dHS9UbnScpqkecFdNDfG5ipCFoM6xStna3PqsnNxohAPofzW1QfFQXj6f
         lUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249850; x=1776854650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiJe1Hi9oQ/cmA4CtiFYHAXrSluo92QTvEGuC0xhX5g=;
        b=eGSnhRFuzV+x8heAvJYbWzgVuL3fGz6LVvizSaOKnUsBRt1W8ijkYQTBl7nr/vHSME
         WUL6swSjfOunZfD0EKHxcUAlf9PWPl69dW0ndiFfLQ1TmnE62/AcunGPukMtR2VVZ87w
         nVAT8/uVUGyLEPh5rbdE+SSOFFKAXlYWzxNENyPTkU7ZJMk/2FahcyfGFgnoqUYvg1ZE
         Jo7YrCSjIXbcXNAN5fLXaRPRD0I85U59FKhyPjoOz119CUenpbGDydRowkP0BMxw+50V
         MbB7fp62siDjhxErZZPjcsp/q7+qd/zb8J5D598nR4mWLgT3uW/5aywRUkd6JoRxJSwK
         kFkg==
X-Gm-Message-State: AOJu0YyPnJ00JV3Tl+4LIvDwJv2I9PCHgwROAR8LIwSHYLTxQWzEUz3g
	zj7hOzjkST1XjvdcDBR4SsfD+RTXqykgx/TIQYJteiwW5p0IAA39KnQa
X-Gm-Gg: AeBDietU9oQRMujNhYvC9zZdg+i6O8cjoDzlvUJFOcms1oqyNnGS011GIJvmyOtopR4
	fyKSodd8CszPv2y7ngMx+BAi8mfa5dERpuYExrVstvklIJuiFU7UnNj+acFJcoGjMOEa1TuluTj
	Hm46JZsPwm5KZR+7eeY11bfitn7uka6O/zXzBZJgcuG5FISoqdJGHEV4hJrtnTHO1cb6lREcesf
	7mFmdUo3siHGZwV98mktMdAXAN8Xi9DbdSJNafvSoj+PYbnEPf6kbl1NYFO2Gb7qCkfWJCrXoYa
	ONnMYmdyZQ45dA3ZqxSa3ZiT1Af1fVkooh3rcVbpTGLRfwWAS1qzNi6Eg4txtPRVAPjG5I1i88f
	ir7Rf+FIKL37s5gAw8Ne1z8vQj5jznvcb3Wx2LnJkXLKhQjma7mVPmIoKO3dlAs/NOL28wkZFyA
	hSiQIXf3OGVzV/bN37ZW76TXTginH3TmI9VBJVQEhDUNuaXII=
X-Received: by 2002:a17:903:40c6:b0:2b4:5ddf:24f with SMTP id d9443c01a7336-2b45ddf0454mr131473015ad.10.1776249850463;
        Wed, 15 Apr 2026 03:44:10 -0700 (PDT)
Received: from localhost ([154.39.63.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780f035csm17741685ad.15.2026.04.15.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:44:09 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: senozhatsky@chromium.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH] zram: add accounting for incompressible pages
Date: Wed, 15 Apr 2026 18:43:56 +0800
Message-Id: <20260415104356.82248-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Rename write_incompressible_page to write_huge_page since huge page
could be recompressed with secondary algorithms.
2. Similar to huge page, add incompressible_pages accounting for current
incompressible pages, and incompressible_pages_since accounting for
incompressible pages since zram set up. The accounting value can be showed
by mm_stat.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 drivers/block/zram/zram_drv.c | 21 ++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  2 ++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index af679375b193..f16d52c4ed79 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -948,6 +948,8 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	clear_slot_flag(zram, index, ZRAM_IDLE);
 	if (test_slot_flag(zram, index, ZRAM_HUGE))
 		atomic64_dec(&zram->stats.huge_pages);
+	if (test_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		atomic64_dec(&zram->stats.incompressible_pages);
 	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
 	zs_free(zram->mem_pool, get_slot_handle(zram, index));
 	set_slot_handle(zram, index, req->blk_idx);
@@ -1908,7 +1910,7 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = sysfs_emit(buf,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1917,7 +1919,9 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 			(u64)atomic64_read(&zram->stats.same_pages),
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			(u64)atomic64_read(&zram->stats.huge_pages_since),
+			(u64)atomic64_read(&zram->stats.incompressible_pages),
+			(u64)atomic64_read(&zram->stats.incompressible_pages_since));
 
 	return ret;
 }
@@ -1989,10 +1993,15 @@ static void slot_free(struct zram *zram, u32 index)
 #endif
 
 	clear_slot_flag(zram, index, ZRAM_IDLE);
-	clear_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
 	set_slot_comp_priority(zram, index, 0);
 
+	if (test_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE)) {
+		if (!test_slot_flag(zram, index, ZRAM_WB))
+			atomic64_dec(&zram->stats.incompressible_pages);
+		clear_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+	}
+
 	if (test_slot_flag(zram, index, ZRAM_HUGE)) {
 		/*
 		 * Writeback completion decrements ->huge_pages but keeps
@@ -2197,7 +2206,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 	return 0;
 }
 
-static int write_incompressible_page(struct zram *zram, struct page *page,
+static int write_huge_page(struct zram *zram, struct page *page,
 				     u32 index)
 {
 	unsigned long handle;
@@ -2268,7 +2277,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	if (comp_len >= huge_class_size) {
 		zcomp_stream_put(zstrm);
-		return write_incompressible_page(zram, page, index);
+		return write_huge_page(zram, page, index);
 	}
 
 	handle = zs_malloc(zram->mem_pool, comp_len,
@@ -2487,6 +2496,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (prio < zram->num_active_comps)
 			return 0;
 		set_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		atomic64_inc(&zram->stats.incompressible_pages);
+		atomic64_inc(&zram->stats.incompressible_pages_since);
 		return 0;
 	}
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f0de8f8218f5..cec84638f626 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -85,6 +85,8 @@ struct zram_stats {
 	atomic64_t same_pages;		/* no. of same element filled pages */
 	atomic64_t huge_pages;		/* no. of huge pages */
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
+	atomic64_t incompressible_pages;	/* no. of incompressible pages */
+	atomic64_t incompressible_pages_since;	/* no. of incompressible pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t miss_free;		/* no. of missed free */
-- 
2.25.1

