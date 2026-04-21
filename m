Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A13BED10
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773809; cv=none; b=YAaZA48lOOIGLQMSBT2ngNNyIsQyu3Cn0OxLkfULdH/aEgzY9WXarQFgJsikNF94OjV1lB33P23lwcoTbObd1mVYsyRoAfQonj6Q0r9B1tRKiFz4vUMR0R7/BYvJGZ66tsdElNcdkt2agH24hoUf91T7WYGxxwZRkCMuVwLlFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773809; c=relaxed/simple;
	bh=i7ThFkM/qArd39OgyIXeWRiSqkQW27QZPpZUUMok1TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcCHO9USlGHLWsk9hqvRSggFDd5GA5qH02l50Vac4UBge0lT82SO+WppLnH4ExsshCnjL/KjposNZ/hVvibCC2OD9zZ6cKwF2CGLgsUx+PWXdsoygzQkEZWtDcCx+Xr8suLkBIUZz9Sbacw6VfOcYPBZVJyuVg6ijAoDbvZwD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8jQ5wLY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8jQ5wLY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7963df6f17so2794258a12.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773805; x=1777378605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Eih9BBnnHT00t9rzMlOXMywyDxDk82fhUWxfKmMkyw=;
        b=g8jQ5wLYrBAr9uK7Wtb2oS6Q8Sb1wnKwTRD23rrwIJE5N7WTq0V+m9WZSdIO/ijLjI
         31VG1CyMtT++jHqzCSMqRqDTSU+KKB5MKYjHdGzcYiDv0efoP1fNl6nRDp8OueKE9wAm
         A+N1lLajRFdacj0uH3+CKvdaXtqTTnWyxAOGgYSQ/QUAO2ruqukywlkKfYKbURQoSzMa
         B9MpIh9jHLn8J80oZA7aze+RcuzGslnTeY1e1gGlmTp58jFC2boRh6Z3XCWn5qMmwsTO
         OKDy5B5ZV9QVCyYqi3LafB2NeMNHp39SCH7r439sYfxOM+aBrXf9Rn22/5KkyuSp0fkT
         Zwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773805; x=1777378605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Eih9BBnnHT00t9rzMlOXMywyDxDk82fhUWxfKmMkyw=;
        b=sNQMxFqCO/Sa2EnYtoN7lKIY0KUCs4EJeWhQ0tBwEzYflrBZhK/u9Q1se53b5t9d7t
         7+y9p/kOUSO4isDNqxJf4l+94EyhtlDSuNHQ8qX/lBZHSHA2wGxYB3+iYo3vTLFCdrWi
         Pdt3ZTrDpH8vhxI9JRUxZHb024cuzdj1JEEu+N8SI0lXuLejStPkyMIInXrxnpN/dLYF
         RinMSK8UQUOt4KXwLr0seaDixgLUy0uasV+wpIv0lZpgi1w7mJjy5ElPHjhDWFJb9Ska
         kLFo2+SAATsLFmizctUmjw3BmFspVdrMsTAR5bxQRPTXZs7e6xHdrAT8yV1VOzB2XL4R
         vcOg==
X-Forwarded-Encrypted: i=1; AFNElJ+D+crHmPD+uq6m6GaeAH7aMoAtc0bDkZ25/ZIy83T+TN9I0fAGY3G8K6bx47Pm6m4wk6QD4mfTTW4BLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvN3jTlte90aXfo7NdeezUUfFKWbF1xiolX7NovnnwHjT4neK
	kT3yNpwZ/G0UEjjTSO/LvJj+Q/CLKkDfnto/cn5NuMf77qOgiCo/B2gk
X-Gm-Gg: AeBDies/LrvNNraEJ3w0WK8yPxnimirJ4EDFDunNEIAd3vQme3u0OY9Uvf/6ggJml6i
	WjwI7yXXZR/HZFA1nuayCivqm3Do199lLWMliBAZ6y5zoGfDQm1Kls2XWfAeBb/JpKaEnW97aed
	5yQCWcVgiyBue7j3Xign9vN2ACFSTniI8cXIGE9JgpZ6Scn2XbPYBhZZyp4mG0h7r6/o18bmWTa
	NHNvjetjVyYLY/MLBa0wWDrJbcZHis1L6RVi0+7m6gnLmi0nB5Pe82oBfh/3e+vUXbURLZH5ZL4
	IlnPW04HNLIcytCSB0ErkU01npvL3Mc/K7NDYCnlzS//OY0OnFr3bhmUMUMSXz6nm5GAWbiT78s
	W+xMebVau4oUCb3URe0Gyf4FoB2io0xSjY/lCr28nBcbO/ccoeTeoGPmBnOzgwc7mOmq00JcjrK
	axreT9TZATHvvZzl6AsLhg9Qh9VbZytOYqb1TZ2Bgn3byXe0o=
X-Received: by 2002:a05:6a00:2d19:b0:82d:5da9:adc9 with SMTP id d2e1a72fcca58-82f8c856e60mr19094536b3a.12.1776773805202;
        Tue, 21 Apr 2026 05:16:45 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm16371071b3a.54.2026.04.21.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:44 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Barry Song <baohua@kernel.org>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v2 3/4] zram: defer zs_free() in swap slot free notification path
Date: Tue, 21 Apr 2026 20:16:15 +0800
Message-Id: <20260421121616.3298845-4-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421121616.3298845-1-haowenchao@xiaomi.com>
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

zram_slot_free_notify() is called on the process exit path when
unmapping swap entries. The slot_free() it calls internally invokes
zs_free(), which accounts for ~87% of slot_free() cost due to zsmalloc
internal locking (pool->lock, class->lock) and potential zspage freeing.
This blocks the process exit path, delaying overall memory release
during Android low-memory killing.

Split slot_free() into slot_free_extract() and the actual zs_free()
call. slot_free_extract() handles all slot metadata cleanup (clearing
flags, updating stats, zeroing handle/size) and returns the zsmalloc
handle that needs freeing. This separation has two benefits:

1. It makes the two responsibilities of slot_free() explicit: slot
   metadata management (must be done under slot lock) vs zsmalloc
   memory release (can be deferred).

2. It allows zram_slot_free_notify() to use zs_free_deferred() for
   the handle, deferring the expensive zs_free() to a workqueue so
   the exit path can release memory faster.

While at it, merge three separate clear_slot_flag() calls for
ZRAM_IDLE, ZRAM_INCOMPRESSIBLE, and ZRAM_PP_SLOT into a single
bitmask operation via clear_slot_flags_on_free(), reducing redundant
read-modify-write cycles on the same flags word.

All other slot_free() callers (write, discard, meta_free) continue
to use synchronous zs_free() through the unchanged slot_free()
wrapper.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 37 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c2afd1c34f4a..382c4dc57c8d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -165,6 +165,15 @@ static inline bool slot_allocated(struct zram *zram, u32 index)
 		test_slot_flag(zram, index, ZRAM_WB);
 }
 
+#define ZRAM_FLAGS_TO_CLEAR_ON_FREE	(BIT(ZRAM_IDLE) | \
+					 BIT(ZRAM_INCOMPRESSIBLE) | \
+					 BIT(ZRAM_PP_SLOT))
+
+static inline void clear_slot_flags_on_free(struct zram *zram, u32 index)
+{
+	zram->table[index].attr.flags &= ~ZRAM_FLAGS_TO_CLEAR_ON_FREE;
+}
+
 static inline void set_slot_comp_priority(struct zram *zram, u32 index,
 					  u32 prio)
 {
@@ -2000,17 +2009,20 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void slot_free(struct zram *zram, u32 index)
+/*
+ * Clear slot metadata and extract the zsmalloc handle for freeing.
+ * Returns the handle that needs to be freed via zs_free(), or 0 if
+ * no zsmalloc freeing is needed (e.g. same-filled or writeback slots).
+ */
+static unsigned long slot_free_extract(struct zram *zram, u32 index)
 {
-	unsigned long handle;
+	unsigned long handle = 0;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].attr.ac_time = 0;
 #endif
 
-	clear_slot_flag(zram, index, ZRAM_IDLE);
-	clear_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
-	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
+	clear_slot_flags_on_free(zram, index);
 	set_slot_comp_priority(zram, index, 0);
 
 	if (test_slot_flag(zram, index, ZRAM_HUGE)) {
@@ -2041,9 +2053,7 @@ static void slot_free(struct zram *zram, u32 index)
 
 	handle = get_slot_handle(zram, index);
 	if (!handle)
-		return;
-
-	zs_free(zram->mem_pool, handle);
+		return 0;
 
 	atomic64_sub(get_slot_size(zram, index),
 		     &zram->stats.compr_data_size);
@@ -2051,6 +2061,15 @@ static void slot_free(struct zram *zram, u32 index)
 	atomic64_dec(&zram->stats.pages_stored);
 	set_slot_handle(zram, index, 0);
 	set_slot_size(zram, index, 0);
+
+	return handle;
+}
+
+static void slot_free(struct zram *zram, u32 index)
+{
+	unsigned long handle = slot_free_extract(zram, index);
+
+	zs_free(zram->mem_pool, handle);
 }
 
 static int read_same_filled_page(struct zram *zram, struct page *page,
@@ -2794,7 +2813,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
-	slot_free(zram, index);
+	zs_free_deferred(zram->mem_pool, slot_free_extract(zram, index));
 	slot_unlock(zram, index);
 }
 
-- 
2.34.1

