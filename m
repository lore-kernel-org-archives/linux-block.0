Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADC3A1D01
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652141; cv=none; b=mO1Q/x9bgnwqeqayY90KsiDR1KFGNG9LPKB7RtYmcnu6wSAhHWIHU69HmurWJG+jj4iXUAwfxh0DgFXVFs0bv5NszIxpvOGnqOe26eXfUepmCDsMuH9Y9PMvoWR+Gbl2skbN6AT3XF2/yf0bMgXI3XZ2zIYuDyO//XXQvHoyULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652141; c=relaxed/simple;
	bh=xh0wq/JDXVle3NdWYWWXd4nwFWgCl9HcbB9h7Lb+cJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd36ORu8o8r7OUz8/0yiSmSOySn3plyrUY5EyAXc4Pgbg+oOS9IMZ+nGRiPvIe4S8E05Qsx5QaGQ8UidQFtJBjkH/k7Ysme+YRfqoCbDwkD+AotsA0SUG7N3i91cf0V5shBaFjc/rpNJFbZJ/GAP3UUC1E2YLZxrdAhrRit/M+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bx4+J/1w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bx4+J/1w"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso696525b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652139; x=1764256939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60qtdCMZp80VF5yuM/N6mmuFIve0x6cnvVTEq7lRrcI=;
        b=Bx4+J/1ww1iXgppJjZ05YjtolM993qrUwcDTgpNBI+DNaSysJnaccmlRxtCa25IwPa
         umhm79wbQyBCWcoTU0sedYw2OhcpF7xd0sjxU1QaUMdEsXNdYguoWfBd6TVJpzs5xcLR
         IIqwhbe20RqrpmNfXxn2SGZXJWYh5/OZ+WqBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652139; x=1764256939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60qtdCMZp80VF5yuM/N6mmuFIve0x6cnvVTEq7lRrcI=;
        b=bs83CIjDw61n7h15pPUSZjV4jeNMiRYflNhshZfTHcQ8fbtUMk/80x5VuACRn+Jg0r
         UE22OO1Mht27yqpKuaCHS74FcXM7Qt8kxvAwVK153/wjIAqaH+cN9JUQgo4ufN/BbbIM
         kkBiV2oWtZNhiOzfVoapHizPZFM/BqKgjAFFYt1PC92szJ1nVSGEJswrYciH00HFpOob
         v6KCgbrYWi2KlBIwjR9uxUv+1MctPrN4gIWy341v/A8zjCVzb5K2CSxZYDqLmKW/eYnJ
         s0BVQzrq9NfiPp9vinyNnR7qhpGZQV0Ex4yMvSUvLqLXHLglvDOfPw8KwfJePYiLcwu9
         smMg==
X-Forwarded-Encrypted: i=1; AJvYcCWlJg+1uBLcVgv1nAxjIbd4maalJOCD+zxnBxN0e8qdHUcTKa4rquaTzkSUVGp2Kv6XAO85lto8FNoNTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSzsBLwsMpyk4o4cmvgvUkigdi1Thj+4vzF6s1tRpNqMwRr7C
	X+MArcPhz426fGG2bIHfCkoo9sW7xHcKAAJIcF15UJ5oQ9RYw81SKy643tNJ0R4Gvg==
X-Gm-Gg: ASbGncvBtGCvCggPQNdZWK+Mzh6y4TaKKMmT5VFhYYWFnqebn1aKjD48/nLwEKOWv7x
	YnehE7rmS2C5dXOHJeR4i6gmtcUswCf0rkrduE/0sviFw3uXC+6ICr+SVl+rv6qQQVWBUvKAlP3
	r7kVeHY5byzGz8a6c6iU7KItVK+RpootWOOsIyXc40+TXqomWWNxqBfxO+zR2gu0MnYeq3T8LXW
	a03vTmYwHtiz4huVQ1s9qXQ8HcT/bh6rLlnuGX7Uy6c7GtXv6kuN0Xd/TzmkiDvP/HfPFbq6LcD
	eS1fGTU6DnJdr92gXvLLR5XR8p3OUmVAgQFZR12d6lR7VwD0NVKovXsaix9vu6hWkPWyldHV8ke
	2/2qO1WRZd3/OdrtVTlk8aTey3W554/CsrjAZyZ66JpNOxCcrQ9+mPYCuIimQAthqSF39hqu4EO
	tZqMDv9801l85xn9Uu6PFhL36yACTpqVhAwuGScw==
X-Google-Smtp-Source: AGHT+IF55sfvtR57vKBk+ytDZecrzkU4GEMllnIDmAZESJWF3inRrxqebY2ATzJpA3aK4tJ/iPpEuw==
X-Received: by 2002:a05:6a00:ae09:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7c41dd0b2f7mr3534869b3a.1.1763652138839;
        Thu, 20 Nov 2025 07:22:18 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:18 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCHv5 5/6] zram: rework bdev block allocation
Date: Fri, 21 Nov 2025 00:21:25 +0900
Message-ID: <20251120152126.3126298-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120152126.3126298-1-senozhatsky@chromium.org>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
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
index 671ef2ec9b11..ecbd9b25dfed 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,6 +500,8 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+#define INVALID_BDEV_BLOCK		(~0UL)
+
 struct zram_wb_ctl {
 	struct list_head idle_reqs;
 	struct list_head done_reqs;
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
 
@@ -887,7 +886,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		 * (if enabled).
 		 */
 		zram_account_writeback_rollback(zram);
-		free_block_bdev(zram, req->blk_idx);
+		zram_release_bdev_block(zram, req->blk_idx);
 		return err;
 	}
 
@@ -901,7 +900,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	 * finishes.
 	 */
 	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
-		free_block_bdev(zram, req->blk_idx);
+		zram_release_bdev_block(zram, req->blk_idx);
 		goto out;
 	}
 
@@ -989,8 +988,8 @@ static int zram_writeback_slots(struct zram *zram,
 				struct zram_pp_ctl *ctl,
 				struct zram_wb_ctl *wb_ctl)
 {
+	unsigned long blk_idx = INVALID_BDEV_BLOCK;
 	struct zram_wb_req *req = NULL;
-	unsigned long blk_idx = 0;
 	struct zram_pp_slot *pps;
 	int ret = 0, err = 0;
 	u32 index = 0;
@@ -1022,9 +1021,9 @@ static int zram_writeback_slots(struct zram *zram,
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
@@ -1058,7 +1057,7 @@ static int zram_writeback_slots(struct zram *zram,
 		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
 		zram_submit_wb_request(zram, wb_ctl, req);
-		blk_idx = 0;
+		blk_idx = INVALID_BDEV_BLOCK;
 		req = NULL;
 		cond_resched();
 		continue;
@@ -1365,7 +1364,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	return -EIO;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+static void zram_release_bdev_block(struct zram *zram, unsigned long blk_idx)
 {
 }
 #endif
@@ -1889,7 +1888,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_handle(zram, index));
+		zram_release_bdev_block(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
-- 
2.52.0.rc1.455.g30608eb744-goog

