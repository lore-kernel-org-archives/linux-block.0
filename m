Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685532D248B
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892162; cv=none; b=q42XCajJL/FYCmgsT3fDQcBGc+rqrIlA+awKSsKcl7AlapVSG4+A4GZ8ASIFRNjCER02mLfoW1bJBE6Mi3sA8kKaypQVzF17iof300YO9CYg7/cwG+BlokOnAKtssbD2lkrAPM377+Frr5EGdPi7cjvouu4yKOmyYW1H7GtUbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892162; c=relaxed/simple;
	bh=zynCVvvV1bVokM1Om58nzCK0BDQ/QhLKD6HS/mye804=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYtF+FFJNOLJqggUPHBDRkE/LDXj8oGzahs18ZQn4sw3XtRHChd5cF0kRE1h/2uoOVwYU7kENBud7Fa5Btukt3/cDQrIZH2OQuWyYx0I/5CkMmDov1XyRkhsn4aNiMyNalSkxTnqQVFyuQWKXcW4Hs12b1ys6XhLZK3z5lyL/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GX5KuwfS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GX5KuwfS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829759ca646so331011b3a.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773892161; x=1774496961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TVqouUGbfIurHs4KmCF5QDFnRGSjDBtw8/+7JcMGzE=;
        b=GX5KuwfSf45CSp7ooPtN2+cuxLQR2BnkX0XYQjE9bnt5kAqD570J+YO2sg1Juuq0D0
         h1sUC8BzqakPkuizvjNZERRqSjLXagPXMj2T5ppBWt844LqbFokbnbyE66IK73RTSiTu
         UrMi0gPnQ7SBhOAOJ65RmxwhC3us8PLTOgUH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773892161; x=1774496961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TVqouUGbfIurHs4KmCF5QDFnRGSjDBtw8/+7JcMGzE=;
        b=KdTkgQsD0UY5Y8We4hfOLIE59UjnbfgIlj9DxNbEtRf0dEc/x4FEmk2Uv3t2sP1gr1
         ZSIFLTEMsez788iV2wBu9Pt/eIxZpqqACxdUDhntcjLpi7mJ7Tb7378T4ndnWWI2QoHG
         bCnDwLZONIXE6a/t4AucArf1EWUSGb5MPCXIok6qGFzl2xjZVX0fO3S6/kzf2oiOISGD
         AkRCxunL0LQB7I4hm3z4ObFzH4pN9oUeNAAuISyMztSw9zkMTHTRcUB62ICN+VAizauZ
         cbwgAWFjmE/8zlIOqDwozQGjTtZ8s1GIGTG1J3DnF4u366Ju98iDQkCXb6cX7XNA97Sb
         kj3w==
X-Gm-Message-State: AOJu0YwZVnQ8MI4JCFK0A5GRChetBJevJ9QmLqyFVQnW2b6vJNxyHlVC
	XUg12TKAJ2Z9LDRrQ4UNldcmM12g3kSAaF9f5mX/SlKGzjhsA3RhC1xFqvr65wbjdQ==
X-Gm-Gg: ATEYQzxZKR0yDdYGxgB6Zk3CH+KjYFoGMdyPbwey+rrlYwHp8xna0oaKDyQSbRTs2o+
	y0ZMiCgxee2K2U3Z0HWcagc/7Ix7RnaPTysL9DhQ881EeL+Wd4DUsAUkPixECBVYpl0DaiTo9d0
	9hehF6jtoRQkjXwUNDc592CCYTzsJ1Lsg+J7GDPHdzhJ4+dU8dIxtSLegA62XN1vVkKWIXzjwTL
	ERyjlLxys1OUpSI3HxhFrNByVqa/niIN8K4hUYIkYCW2o9qzi5vg1hgmCV11BXMGqM4IlWb6OyD
	WCi4LslWRCO7EoLME92hre2DEbwagDfwOzgPV1+yQmAIwTG2/ZwHpDQYm4SWd10zy3oyeC/yFo9
	eRI0dnUl0Zg+0XooAJ8ns2X4BuaSE4Lkn/P8iomdmyD3YASnAsa8DFST1ZTjh1MBGQD2yMbOdU7
	G+LiG3t/H5I+TKWj1VQUui5aKPxyGIJaTGQsB7GcIqDw3G4MbYAUEoyu1mPHo8reWIKJB9TImV5
	EvEEL+gMrvzVg==
X-Received: by 2002:a05:6a00:98a:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-82a6aee8af9mr5419132b3a.56.1773892160688;
        Wed, 18 Mar 2026 20:49:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:13e1:7517:52f3:cfc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb985csm4240566b3a.38.2026.03.18.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:49:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>
Cc: linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: do not slot_free() written-back slots
Date: Thu, 19 Mar 2026 12:44:56 +0900
Message-ID: <20260319034912.1894770-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

slot_free() basically completely resets the slots by clearing
all of its flags and attributes.  While zram_writeback_complete()
restores some of flags back (those that are necessary for async
read decompression) we still lose a lot of slot's metadata.  For
example, slot's ac-time, or ZRAM_INCOMPRESSIBLE.

Do not slot_free() on writeback, instead clear only those
flags/attrs that we need to clear.

Fixes: d38fab605c667 ("zram: introduce compressed data writeback")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 39 +++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b0e1c02ece7..5ecc4ba40e9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -917,9 +917,8 @@ static void zram_account_writeback_submit(struct zram *zram)
 
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 {
-	u32 size, index = req->pps->index;
-	int err, prio;
-	bool huge;
+	u32 index = req->pps->index;
+	int err;
 
 	err = blk_status_to_errno(req->bio.bi_status);
 	if (err) {
@@ -946,28 +945,13 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		goto out;
 	}
 
-	if (zram->compressed_wb) {
-		/*
-		 * ZRAM_WB slots get freed, we need to preserve data required
-		 * for read decompression.
-		 */
-		size = get_slot_size(zram, index);
-		prio = get_slot_comp_priority(zram, index);
-		huge = test_slot_flag(zram, index, ZRAM_HUGE);
-	}
-
-	slot_free(zram, index);
-	set_slot_flag(zram, index, ZRAM_WB);
+	clear_slot_flag(zram, index, ZRAM_IDLE);
+	if (test_slot_flag(zram, index, ZRAM_HUGE))
+		atomic64_dec(&zram->stats.huge_pages);
+	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
+	zs_free(zram->mem_pool, get_slot_handle(zram, index));
 	set_slot_handle(zram, index, req->blk_idx);
-
-	if (zram->compressed_wb) {
-		if (huge)
-			set_slot_flag(zram, index, ZRAM_HUGE);
-		set_slot_size(zram, index, size);
-		set_slot_comp_priority(zram, index, prio);
-	}
-
-	atomic64_inc(&zram->stats.pages_stored);
+	set_slot_flag(zram, index, ZRAM_WB);
 
 out:
 	slot_unlock(zram, index);
@@ -2030,8 +2014,13 @@ static void slot_free(struct zram *zram, u32 index)
 	set_slot_comp_priority(zram, index, 0);
 
 	if (test_slot_flag(zram, index, ZRAM_HUGE)) {
+		/*
+		 * Writeback completion decrements ->huge_pages but keeps
+		 * ZRAM_HUGE flag for deferred decompression path.
+		 */
+		if (!test_slot_flag(zram, index, ZRAM_WB))
+			atomic64_dec(&zram->stats.huge_pages);
 		clear_slot_flag(zram, index, ZRAM_HUGE);
-		atomic64_dec(&zram->stats.huge_pages);
 	}
 
 	if (test_slot_flag(zram, index, ZRAM_WB)) {
-- 
2.53.0.851.ga537e3e6e9-goog

