Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57776FC5
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973914; cv=none; b=EFDJ7bTXMW4mAIEGkpMMcjwqTjDitfsCmCLKwWKf5rzljusxBcNHUqBWlc7gW1bSifg7iwAUCh/zbbuUo3ITG564u+H2kUkEK5BjLIQwH+Dmlmf6lRmvIP2IBOajgA0UFlme6XrsSbIFEpaWEUKiWQn/GQvBrAvzyDKMegXLN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973914; c=relaxed/simple;
	bh=BgnW1oz84M3KuUrWpngDtb0UZ05RA1mLGZuyuyQTX14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxJ3Zo6u0U7UwF4GsoFUNIW1GgZATBJLNKhmhkYG3YzLErLu4REPwOYmvd/BDTcg0Y54B6WAPyfPMcyFIXoZAcnnKU/SxRT1nKGHgxDqUApWVeZdUOJ3xA8cP6Obvqm9F6ePsaz8E+qoRhBsXCNuqYQe7PKyyYaCPfm1DPQHe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OsRvXNK/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsRvXNK/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9d08644so117154b3a.1
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773973912; x=1774578712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b3I8g3+9/WU3GqIQO3em4o8Xa6BctjWUjYBwk/WMMs=;
        b=OsRvXNK/igZJguZ5AQQz5zlz/9wJuOHHFBril64teQNsdmpABBBqS3ShMR5nZqo7qB
         8Kgymbt5ewlY2dweGC/zeCvgq1XSTIfQsjfbvDhyq3pn87N9mEn6wFbpM/dT9m0I1W/m
         vxW5N2lrx0ySjmnAoycRBWqIE++uMgx6UFknI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773973912; x=1774578712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b3I8g3+9/WU3GqIQO3em4o8Xa6BctjWUjYBwk/WMMs=;
        b=H5633h4IcH7yt4GN1iS82pc6ee2N0vmcp0Pt3srpCahygAGZDpp6gkPQjCddkNMK47
         EjIysVViWQx3mIp80XcRQ51rAWLDT1suYJBLMYVgOffA/xUnVceGw4DfHoc3IgkE6teM
         IP/AfahvFM6IjTHa4e2TkGpLbUr9jwoPjIrThaeRr5tHp2jeJfg6J1WwYxv8Y3vNgv9l
         7g9G+DarMxxYl7jOG0LeB0qDyfJODWUrGudmHuRExOkzct0oOIARelegVL3mtzcCUGQG
         uflGx+L4jU4B2BAGyfydwkgYZXbYe2POhC2dViSRxdKt74ytYObOYO6riU1azLqt242z
         j9zg==
X-Forwarded-Encrypted: i=1; AJvYcCXDEqHnyb3hzE1zkoZB52a54Zc7YWAdZeRaaSGXSD7SN13N9/MQdM5iUyCaxadpIcp2QZthE5nrI6ZPAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUDtiZ20K15eKPRlxbuJloSrZRKDna2SipByHuT/aqeBYoaGCb
	SCYFT/Zemam5/14L0h7o3L5elToB/myRWnJywbT/tHM02p2cBjJIZ60F6MQA3eADKw==
X-Gm-Gg: ATEYQzwQC9Aqi9AU51UuDGta2ZibgQswBxz7ziRiwjqPQx9R/nC5IO8wN4EOyhTyjlQ
	BDO6QJozAzRGbd6uJ0CIpEfMkfbDnhRjDCqiRMSAZPCphdrb1qrkwU9Z81Y2yPfIvfIiA+sPCLO
	PHz5eejj5xGMaFTY4XxqFgmw2tMSKIsz+x8wG2UU3/EuRCzm6GE5PaGvfUDYhYbFOnwlZLVf0YX
	o376y+cQDqR67U6/cTMFmCyW0l9kOYRNNs9qAV6ETn76jRRIbk3wt4oO3dNzlZBa/DwIva9QUm2
	AMakBxzLQNrunHWlVcG8X3nthFtz3rvI6r/uAR0yhupOkfmZXgW9G+60eLiKKLUyF3n8VXlV/Su
	oCukWnutji34eFELgkEvB9QaoYuRRw2hUj2cnLh7eN3NAPd93uVN8/ejQhFQ9AY396v10IsULqN
	Cuf2IlAWUo4r9Y4+qJ+LCTNMeW5zYaxqxkYRD7U0+A0UPiwg4ExL7cAle9ehNU8jarjl0ifcamQ
	nRMqDypaj1P
X-Received: by 2002:a05:6a00:9089:b0:829:8969:b8b4 with SMTP id d2e1a72fcca58-82a8c237aa1mr1066056b3a.11.1773973911764;
        Thu, 19 Mar 2026 19:31:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:65ca:c086:eef:123e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6881sm562042b3a.22.2026.03.19.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 19:31:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2] zram: do not slot_free() written-back slots
Date: Fri, 20 Mar 2026 11:31:31 +0900
Message-ID: <20260320023143.2372879-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
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

More importantly, restoring flags/attrs requires extra attention
as some of the flags are directly affecting zram device stats.
And the original code did not pay that attention.  Namely ZRAM_HUGE
slots handling in zram_writeback_complete().  The call to slot_free()
would decrement ->huge_pages, however when zram_writeback_complete()
restored the slot's ZRAM_HUGE flag, it would not get reflected in
an incremented ->huge_pages.  So when the slot would finally get freed,
slot_free() would decrement ->huge_pages again, leading to underflow.

Fix this by open-coding the required memory free and stats updates
in zram_writeback_complete(), rather than calling the destructive
slot_free().  Since we now preserve the ZRAM_HUGE flag on written-back
slots (for the deferred decompression path), we also update
slot_free() to skip decrementing ->huge_pages if ZRAM_WB is set.

Fixes: d38fab605c667 ("zram: introduce compressed data writeback")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v1 - >v2:
- Updated commit message.

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
2.53.0.959.g497ff81fa9-goog

