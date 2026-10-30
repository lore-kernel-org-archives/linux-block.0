Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333832;
	b=mtgljLIV1Rsv/CwnRQjgBlxbIM2ehc3BaDXL6cxYLaLsdbGkiHusZ457ztc6ZVMAtGDD
	 /ybhbQ9DAqM6ZGYn/ReLYxZASjJup43712A/CNkOg5kL9YunA4qphjOeSJMo7Chzuzjo+
	 ofNOc671E3K9DdL+ifXqqLE8e4xn213/7UE9Pwahnycax6h7z0OtBJJKrn3WMv2SUAm3w
	 SM0+Y/po0FvfRSCa8GBZSo5E0l8cD25KL9NB5iLPziw1Kl6t1suCb05y8KJFMwllB4E3e
	 9oPawe7Bx3rhCSGkuEPP7X95YR9fn4LHFHwHWj2pJjouiXVOpLBhfx19xNaKhRGh1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ziKDLwdi7Xg2BI9BGIHbHFAW0eYl874oVOo8/AYqvjQ=;
	b=n8/mC0dIVGXP4FU47+z/gHC3Juls7O+0aetTLgjnge313/5/jXR8EKmlVCrJ4zLG4Kx1
	 YRL0iMiQFlPf6PB/O0lbv1uTjonMxw1bt6ku7cdw44OXaoNsUz3jLwAmW7ZaA57wp+g+K
	 tjgCxG1DpdkdTGatW8BF7dG4KZtbK6JRLuZPtyHm6V5xK6qYpXHeaxg/f93jUJJ7THg1w
	 RypdiyWWQHKI0o+5FgN79VlLHoo4llh63XhlMA7TRim4LQwjQeY+YJxa3uAofwZRZHnZL
	 NaU8oMV2ZVHN2My8khWkF9j7XerQ9TowwbOl0M+lrVB48UunpGEDVmhd56LcOrNstgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kt5NiV1X;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A3606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 04:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC6A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kt5NiV1X
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3550c917fd3so483482eec.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793333831; x=1793938631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziKDLwdi7Xg2BI9BGIHbHFAW0eYl874oVOo8/AYqvjQ=;
        b=kt5NiV1XzdrUNLqVPkFe6Xv/M6Di0/5+haZkjC0a8jVKqlurAtkpAB8dfgkadzUqnB
         VjvUNTmWC9sRjf55AWwhiCa6eFVkynjF3arODyS2yiAo/pTr1Fw37+RUbc0SZeng0w5H
         7vlXSqbBrIF9P7GE2zjo+/ryFE/NblPI2cbBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333831; x=1793938631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziKDLwdi7Xg2BI9BGIHbHFAW0eYl874oVOo8/AYqvjQ=;
        b=u7yqwpJYeAqbWmoVQSzV3KkMpwBff7HL/REfN5Ocu7h3c+ztTk4OTYEaNM7v3Ho0Uw
         yxDV2nL2KLqd5VBpTEx6c6nnrXXcdvULhRcW2epOY31TaWkvA3doGhnUN/mUixdCPl3m
         ImopPpvHvOSJPFZYuP5e5Aq6fdMuzNJZ4KgENZrzrDDc9uTMOnNkrX0xXKU/w+z1K6Sv
         vhxqimGqO5ftnVF6cBcP1rmYjmUn+DqHl3jfO6BcvNwYypBqYOXL4C7ovzJetso0Ad1S
         GJ5Siybu5lnUFQQOaX+6lxdoLF+Lp3ueyQgOqBHfSsKuzmISmBz1SBHPSkdWNV7PvSA+
         KgWA==
X-Forwarded-Encrypted: i=1; AKwUvByvxSctF2aTIQe+C4U9g1+U8YOnrO1H8tG1XaQtYm6h/S6v4ruAwjEXsjU7iR/6GlKpGH792p4sjCF43g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDb5fpji6k0cpz0v+clxY6Rw/25J9O+Kz6VREad+w/VP/AmpkE
	3CkZ6U8jw8g0dlPITx9q1NruUxBJ8Oqsx+MejjSLwmK1qHZ9HUgNnKz7JIIpDrcvhgubiGTl1n5
	kmOg=
X-Gm-Gg: AYBFou0k0b+j+dx4wyc4jR6T3+znyipPUm7/UPaxQc14Gc+3w/sSLhiJ/UAUaql/JOF
	NhKIuDWzcVLGziFJXoxMHSFHbA6nAkwC3WnIdLM4Dm/zSoYCJQ7o1ZcLtK8JBdfivihXo4Q5hau
	6ayu2s+gIa29uluRFuUsiGxPE5bHmAUPYBd2dazGjh7dS7jcGCd8aKq7Ty9lbAsk+Wd3KuvpNTQ
	IOmVSDhlOTQZbHXVjxBRmCU5IfJVR/GSjyIW3fpCwnxdU3uNqCYZCt2jE3KU9WmuVAg+k2IASvh
	VkT7BI7jm+NJDo/arylOh2aLH80GwgohZulZn4vkMWX/elF1obd2QyNKJwMgJCovSCC4MtMZJ23
	cHoDY5SUWwtKRX7ULItw+MS8yhMprR5BVRajf2JiGTHXAxcpRwCRugGhIm7EKHWo6Mo2dIPfKnr
	rVGGk4dcX5oK+qgbLkfooZwMD0hItK3b0LAd5wf/iYBb/zS/VH/ExTeCmpBDQs2cMYodC11CHX3
	GKBXjfbJB0Mo1E9BYNy9yNKPILM1GAaOly0iZDTUqlU4s5JJKaQcZjyAj2gm7hVt/UG7X8OYMI2
	ATY5sbeJmnGwoaWyEK4C9jqA1B3QnrEq3FlBlx/p5LsAzMqyzktdA0yJ9prOb/TAIcqhH7f/MSm
	r9Cu2EWDV9rMmZHOGXw==
X-Received: by 2002:a05:693c:880e:10b0:369:987f:d15e with SMTP id 5a478bee46e88-36a4221b055mr2051888eec.2.1793333830552;
        Thu, 29 Oct 2026 21:17:10 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:7476:5b7a:d979:2d91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm3329154eec.19.2026.10.29.21.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:17:10 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zram: fix quadratic writeback bitmap search
Date: Fri, 30 Oct 2026 13:16:49 +0900
Message-ID: <20da9e9a5ffefd1e6875e311d3740b9f3c1061f3.1793333729.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram_reserve_bdev_block() always scans writeback's bitmap from
offset 0, which results in quadratic complexity.  Introduce
per-device bitmap cursor member that is set to next to most
recently allocated bit, so next time the bitmap scan starts
from that offset.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++++++++---
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9593c14a1f81..632045b65bdb 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
+	zram->bitmap_cursor = 0;
 	zram->nr_pages = 0;
 }
 
@@ -786,6 +787,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->bdev = I_BDEV(inode);
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
+	zram->bitmap_cursor = 0;
 	zram->nr_pages = nr_pages;
 
 	pr_info("setup backing device %s\n", file_name);
@@ -807,10 +809,19 @@ static unsigned long zram_reserve_bdev_block(struct zram *zram)
 {
 	unsigned long blk_idx;
 
-	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 0);
-	if (blk_idx == zram->nr_pages)
-		return INVALID_BDEV_BLOCK;
+	/* continue after the last allocated block */
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages,
+				     zram->bitmap_cursor);
+	/* wrap */
+	if (blk_idx == zram->nr_pages) {
+		blk_idx = find_next_zero_bit(zram->bitmap, zram->bitmap_cursor,
+					     0);
+		/* bitmap is full */
+		if (blk_idx == zram->bitmap_cursor)
+			return INVALID_BDEV_BLOCK;
+	}
 
+	zram->bitmap_cursor = blk_idx + 1;
 	set_bit(blk_idx, zram->bitmap);
 	atomic64_inc(&zram->stats.bd_count);
 	return blk_idx;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 7a55d751417e..c563a7c13a49 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -152,6 +152,7 @@ struct zram {
 	u64 bd_wb_limit;
 	struct block_device *bdev;
 	unsigned long *bitmap;
+	unsigned long bitmap_cursor;
 	unsigned long nr_pages;
 #endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
-- 
2.56.0.317.g454f8302e1-goog

