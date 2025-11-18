Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4D301499
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451029; cv=none; b=DI1nUh+LaGJLhinAFH2VGCTNTgbEm7rmQq666mqfI2OxPskuO+VSXguobi5NXNMesRUqyCS2S+5oKeIT1/HYCRoC0lTHX4fFOkA4e5g1yTWw/2NZQN3NsjOArvrVZuyfxybqeFcAxOz7NPjGhbG7mro08aF2bcD0tb1JcS/w4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451029; c=relaxed/simple;
	bh=/5XXh+y6wWNZuJJspQ2Rz5x3DVKLEU5OZgWNXe2QjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fawgFxTrLYcZvDCJujVsudpvGRaIlRSbKwdwGNDvWnEGkEUriaRGKSMZ7mK/oZG62Ysjd2psRD/s2zrnVq8AKUbj/WS/nxnlTmS/HG6r7UDCgZPxgtZf8C2R7ORSiJr/P1dAwa2Sio+SFq749yWIU0+cghIU4UjI3u1ff0B9qEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AuSfcpR+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuSfcpR+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2981f9ce15cso65663205ad.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451027; x=1764055827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jutJ+oFjCEnvR38mjyioMxG346Cjl5qLDOdOQPQB++s=;
        b=AuSfcpR+zOFox3TIqpAOXVxcBSDxD4vobis/BN/fjE9nNI5SIEWL5uPNq9p0sf0oLP
         ZcWr64hJ60e1Q+/nPIb661C6qlx8Z63r7b8Rbn3EEmUF+SwtFOkhNWbJ3/tASZFdvJrm
         pCb8PIgAJEG8HtTkINNwuIKr1NWjRas9Uop9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451027; x=1764055827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jutJ+oFjCEnvR38mjyioMxG346Cjl5qLDOdOQPQB++s=;
        b=PgiJV7MlMX76OD5WXVPjrYLF2ig1XTXB9D4z1p5Z+TMjms34JDpe/fyvGtkqAHBMbw
         RT1Ij4Cb7S/vf9pfdmDhbJed3hAnLjBQm4uguXZlq1ln4KFyLZDMcHR0yrYC3o8GkbCA
         kiGhcMwUjJJRPPgsrbwSmZqt97GD5+6BEoJjj32efOseJqddvFI9xrlH1BQ3GRUoJ1Nt
         R8Al2fKsEWW3iIAI50ndlVwOSXrfdECTZPGZ6yYcCkxxVE12bT6r7KfQbzfZaujFoVu5
         e4SRcihwU4ICVGUEeEfKSmBcOeUhGw1ggEPYkDcVcAoUxYJKrq7IWN6vOG7H7GDM96vB
         7gsw==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZfNcUQOpADuTir4sFjr47B6T1lx8HnWmChLBRFpHkICve3WFq19bvyB26q6JpV7JUe9+DlluINuZxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxff0YEtlXrMYxXQ3PW7nUDGthDKlAmQ+wk85gYIfSb0/1RDGt8
	nWdtNeDSnHenmO1I2KIWJHpKdxgQ7kvsVuYsNkYFiMN/Frd3ntbHopAWRv/1wQzdxg==
X-Gm-Gg: ASbGncu3LGvuMgfnNX0I4obVKIuXOfGoTLwu8k/uMTSRUSuorjokU12lR1KfMHZ9A1z
	PtagPnortLeFnARhVvpwJC4Aooc9DSus1SmnH2U8gzbMOfvrLxPQslW7BqJSmrPtI1BkDkiGDgC
	2+hdTARSR4WSevQAaIL+iRZVSSoonyzQ2swRZpRK/rFwJSCRDRAwmVxYbsTtKsOq5RT+L4llup/
	4R23QtPUFJuinMrfrIp4kzgWG2ZwELOU/sggUolTTdRkl4gfJ2o96rV+WtP1qr/tvEYN1v+qLQc
	PieP8O5kHcYucVWIYzCKztxDqd9dGU6UxW0K62YO2MvlCGMrmWuOdbWCFINbjfgs71q59OxhXzF
	jfsOyyRst6xoYKxVJ/gkgnvOdIOJrhYI/E2VPgHm+xVL6uc8789OMdkjlWFaD/pNb2HR54n/nzH
	Qiz+Qhx/R7rJPk3GcmVYNRh745m/vEArpSbCZ4NscJ7bboB7OP
X-Google-Smtp-Source: AGHT+IGTrSIAYxiYWQprs64AyT1Eid4jFJ2RFXxHbIDaASHF+bW10DGkq3qZf/woCLFk2DJb10FTEw==
X-Received: by 2002:a17:903:384c:b0:298:68e:4057 with SMTP id d9443c01a7336-2986a759838mr194649485ad.59.1763451026976;
        Mon, 17 Nov 2025 23:30:26 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:26 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 5/6] zram: rework bdev block allocation
Date: Tue, 18 Nov 2025 16:29:59 +0900
Message-ID: <20251118073000.1928107-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251118073000.1928107-1-senozhatsky@chromium.org>
References: <20251118073000.1928107-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, writeback bdev ->bitmap bits are set only from one
context, as we can have only one single task performing
writeback, so we cannot race with anything else.  Remove
retry path.

Second, we always check ZRAM_WB flag to distinguish writtenback
slots, so we should not confuse 0 bdev block index and 0 handle.
We can use first bdev block (0 bit) for writeback as well.

While at it, give functions slightly more accurate names, as
we don't alloc/free anything there, we reserve a block for
async writeback or release the block.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 37 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1cfb58516a8e..93365811781b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,6 +500,8 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+#define INVALID_BDEV_BLOCK		(~0UL)
+
 struct zram_wb_ctl {
 	struct list_head idle_reqs;
 	struct list_head inflight_reqs;
@@ -746,23 +748,20 @@ static ssize_t backing_dev_store(struct device *dev,
 	return err;
 }
 
-static unsigned long alloc_block_bdev(struct zram *zram)
+static unsigned long zram_reserve_bdev_block(struct zram *zram)
 {
-	unsigned long blk_idx = 1;
-retry:
-	/* skip 0 bit to confuse zram.handle = 0 */
-	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_idx);
-	if (blk_idx == zram->nr_pages)
-		return 0;
+	unsigned long blk_idx;
 
-	if (test_and_set_bit(blk_idx, zram->bitmap))
-		goto retry;
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 0);
+	if (blk_idx == zram->nr_pages)
+		return INVALID_BDEV_BLOCK;
 
+	set_bit(blk_idx, zram->bitmap);
 	atomic64_inc(&zram->stats.bd_count);
 	return blk_idx;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+static void zram_release_bdev_block(struct zram *zram, unsigned long blk_idx)
 {
 	int was_set;
 
@@ -882,7 +881,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		 * (if enabled).
 		 */
 		zram_account_writeback_rollback(zram);
-		free_block_bdev(zram, req->blk_idx);
+		zram_release_bdev_block(zram, req->blk_idx);
 		return err;
 	}
 
@@ -896,7 +895,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	 * finishes.
 	 */
 	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
-		free_block_bdev(zram, req->blk_idx);
+		zram_release_bdev_block(zram, req->blk_idx);
 		goto out;
 	}
 
@@ -975,8 +974,8 @@ static int zram_writeback_slots(struct zram *zram,
 				struct zram_pp_ctl *ctl,
 				struct zram_wb_ctl *wb_ctl)
 {
+	unsigned long blk_idx = INVALID_BDEV_BLOCK;
 	struct zram_wb_req *req = NULL;
-	unsigned long blk_idx = 0;
 	struct zram_pp_slot *pps;
 	struct blk_plug io_plug;
 	int ret = 0, err;
@@ -1009,9 +1008,9 @@ static int zram_writeback_slots(struct zram *zram,
 				ret = err;
 		}
 
-		if (!blk_idx) {
-			blk_idx = alloc_block_bdev(zram);
-			if (!blk_idx) {
+		if (blk_idx == INVALID_BDEV_BLOCK) {
+			blk_idx = zram_reserve_bdev_block(zram);
+			if (blk_idx == INVALID_BDEV_BLOCK) {
 				ret = -ENOSPC;
 				break;
 			}
@@ -1046,7 +1045,7 @@ static int zram_writeback_slots(struct zram *zram,
 		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
 		zram_submit_wb_request(zram, wb_ctl, req);
-		blk_idx = 0;
+		blk_idx = INVALID_BDEV_BLOCK;
 		req = NULL;
 		continue;
 
@@ -1351,7 +1350,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	return -EIO;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+static void zram_release_bdev_block(struct zram *zram, unsigned long blk_idx)
 {
 }
 #endif
@@ -1875,7 +1874,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_handle(zram, index));
+		zram_release_bdev_block(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
-- 
2.52.0.rc1.455.g30608eb744-goog

