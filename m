Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE12D1925
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797263; cv=none; b=M8/XF9QtlS0zSdaq2cFh7QhSH9eO0GKzcSS+pirqstlM9ndRWQUjoRPdJ1Est5KEVElHbGHsHmrVJVNSUU+fdHYhWymBdx9u2bE96eCA2HQvhOvlzgSvlOC5xbxwFp/nmW5rN3GGmBqEy1o7JLN9x79YaYKWG+6FI3lCkelflzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797263; c=relaxed/simple;
	bh=qDK3/KDP2yGyLUfSxb9ErGoYh406S27gFyX0GJy3yrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQTsk/mpARb1YX7X7k9beLGtSeTW8or/ccZ/y6n8UyeKraDEcu3Rc8hN6pnDidP9i9wSxaUOCxP2jqYDunL8sSjeZb3L8tUL28WKTI/Ez6koMizbJpLYxCKmd2EApmNm8l4W1RckiHvM8RaHZPIr5p3RR8pkAdcOVTyt5klnqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kKpTt6Zv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKpTt6Zv"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so3007261a91.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797261; x=1764402061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqXmvB06Z2fB+k4+MBqw/8L077gQXIHuVUXIRxAoKgE=;
        b=kKpTt6ZvwrNmZa+0BzJ2BlB4gskRWkG8l3MoCNcJBuCpdwHWK1o5xemPEV0HgQFkMb
         82v0gKyoGc6Snk2123g/Q2/rDZJgHWP+gZEVWZQCCWH3TsmR41f+EyiEWtppvm7bZaQp
         3ZTrTGiAFJJkGU3oM0mwW2fv9LXEk+3LJxnEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797261; x=1764402061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqXmvB06Z2fB+k4+MBqw/8L077gQXIHuVUXIRxAoKgE=;
        b=RiZ75LU4d4cJ+OyKbO/BEYnHJmfz0t1N4dWPR5Iy8YpGxAlqdc9aGNZ9Zlu97IbL5f
         01790Z9qYGEI3bh+7rw4MUSkxS2vmF73yI83KRA7Rn/StqNzEeFgXs5YlSMtnwvn/+mG
         In8UkI5IfKP15SHLLnu+24+kyvbYMzTt9a1UVTsHg/8+SQK2uRhCJULgBI998X8G49yw
         lzLVq01NS8NeoqjUmcaPwyKEd4MNv12u3OP4TgHoZp50/4RbuE6xxYNfMPufDvcsW8g7
         Wm4PHcg38jEsL6JxTTwRQ/J986hyGV3qWlenxPpNvZF3pyv8OtAso7UmkqLHjd5riwle
         s9xg==
X-Forwarded-Encrypted: i=1; AJvYcCUviRAvkwbQWVOIPEXo9QEu3SO5vL4pHjqO/ic17C9lF7JJxNshuAZT5pp4zDhsz0rGyg//bGRq/irRDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+KG1BwmeAoUGFvDDZ58KDdU9olrELPzb1cpaUT1/6Ip5GpAf
	dwerZyFtV8tAa41h+x//YI62GQ3twDLI1/ztTQiC7C1MC9u1ExhkjW8JHQvyxcxU3w==
X-Gm-Gg: ASbGncsVrxz5/BR/2qce9YpT+cSkvEzOnlBc/O4fDPm7oxnpFHlLFY+FPuiQTN3Vzo0
	0FczhCqPnN71J1+K0LY2JR8gBWPxvSIp5aZxJ1Rh8e9q3Jvyh8mg1+HeZzn03I35ZDD1snN6+ff
	aZPY3m7zYayIrCBhkO2Pn3SASue5uQiTamvOvHwYKHiLEjjJKhkIIXlRroRe32byNV54Wbl2M27
	RekcujMPZsM+24WtQop94/WgPFgPk4GVSfgGxEKPYNJyCkK1D4GMKxgfqvcBbxvQHnZhQqqGIxo
	bOYP1J5c44fAervXYrrYT52OfM+trGZcNi2ZenyDPBd9fw5KhQwxhicWydRfR0oTh+f7x3y7TJP
	SWwfbs+Qru1ECiDlaUuJP9h+2vEk5Kab8d/uBVugQIT1LGHVmX+yZ0UDvr4H4poSZNgXuJz8pL5
	/io/l5CFe06unV3/3HHpwMTGh/HEZHzhnlWsyws5MolnL2gTSFL+JzoXrhl2/ZESHudGRblLCrR
	K4ArWmAL208
X-Google-Smtp-Source: AGHT+IFDKI29A6Uqi041LAbC6kcpz5R1IMRKmCudzuYMIMwbcjwLb7vtZ5IKwHJVMEc42d2kp0CPqw==
X-Received: by 2002:a17:90b:3cc3:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-34733ef71f2mr5625087a91.18.1763797260926;
        Fri, 21 Nov 2025 23:41:00 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:41:00 -0800 (PST)
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
Subject: [PATCHv6 5/6] zram: rework bdev block allocation
Date: Sat, 22 Nov 2025 16:40:28 +0900
Message-ID: <20251122074029.3948921-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
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
Reviewed-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 37 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 806497225603..1f7e9e914d34 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,6 +500,8 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+#define INVALID_BDEV_BLOCK		(~0UL)
+
 struct zram_wb_ctl {
 	/* idle list is accessed only by the writeback task, no concurency */
 	struct list_head idle_reqs;
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
 
@@ -990,8 +989,8 @@ static int zram_writeback_slots(struct zram *zram,
 				struct zram_pp_ctl *ctl,
 				struct zram_wb_ctl *wb_ctl)
 {
+	unsigned long blk_idx = INVALID_BDEV_BLOCK;
 	struct zram_wb_req *req = NULL;
-	unsigned long blk_idx = 0;
 	struct zram_pp_slot *pps;
 	int ret = 0, err = 0;
 	u32 index = 0;
@@ -1023,9 +1022,9 @@ static int zram_writeback_slots(struct zram *zram,
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
@@ -1059,7 +1058,7 @@ static int zram_writeback_slots(struct zram *zram,
 		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
 		zram_submit_wb_request(zram, wb_ctl, req);
-		blk_idx = 0;
+		blk_idx = INVALID_BDEV_BLOCK;
 		req = NULL;
 		cond_resched();
 		continue;
@@ -1366,7 +1365,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	return -EIO;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+static void zram_release_bdev_block(struct zram *zram, unsigned long blk_idx)
 {
 }
 #endif
@@ -1890,7 +1889,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_handle(zram, index));
+		zram_release_bdev_block(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
-- 
2.52.0.460.gd25c4c69ec-goog

