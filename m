Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C433F8A4
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713111; cv=none; b=KjWssZ455C+SYWKHgDrEi2UXNd1EkH6Gn7oUkj5yhmyEFnta8WlcQknYM/PcHfyw96RjvFOGTW4m4s738Eeb3NZPx0UZw5kStscHhyE+sH5vtKDUYwT3/iWRKVoywCXLb8dlOyeXKqi3icolKLEVS6Qie5xd2h607ZcpD/prFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713111; c=relaxed/simple;
	bh=9fX1h1fO3q+pLGnSgKJ0rzYXjH5JwLqWD06FUxR/tqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEA3viLhTjs7Hag3BkeZx/UvBDaK4DHiTOWp4LNuRa59c2i6kWMbQNJ+S5pBywDcMs/Nefe97z6KIwFpiCr6xekb39+qMGBdD0D9WGIItRA92kWe3QLfz2stIuRjzApg8X+2sv123Zh6Co6GNA7u8uWHMMcURsmv72LuiQebmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkvMICQO; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkvMICQO"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso2707909eec.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713108; x=1764317908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=UkvMICQOAa9lvM00pS6KYtx10LvrXamhBy5CpqQJPkSK2KiPS+uvLI+oBYO2vti4u/
         welt4xopdNnhjGmgdJlTb/3+PERlNpnhKwr6VGWosG5Rag7Q5nQzhpd0dv3knEBfDxrD
         6TEh1PNMDAk4IWMVeHlTzyT0WLZsVolgisdElvVD264vS155XKJ/j2+WjCmgek5bKtAg
         96MBPLoViy+GAfUkOz/eVHpT3g+eMOCZxFk7AKra0Fuc3E/2L7Hf5hqXiOb2N7uUIIYY
         Fm7j+hrwyNhEl0nddmgkBKqzLfsxbAeYn8+nBwSeCBFknOYljpoZH46guWb7CncRIY8R
         NOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713108; x=1764317908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=wuGAa0g3TChSOp/RuoW+VkrxdNiJJ44oF4noFrNgmRQX1PSLs71EA7EbAEhsb86wkO
         Vo/O2ijgc6Bjs5qh3ZQzBQRqxSvtTPuRp6/5OOzozuIM1HUdv2LeaFcs6nBOsvCAEN2G
         To9ch87AlBbcgRme/d4ucquNE80Zn6QRiSzcsbE+kSsc9vya+Pngf6I/oddb1OwLVVUk
         KcKHCJJfDEbqJkrsGcWoOAhrQl3Z9YATnsh6hDKMNburodcbVV6eXzXhjzxZ1cqunZgb
         W+8dnAmYgJyb5QLiBcTwjWlki0EOwJ/5L1KYmBHjqsIc1q5aGb9VaR/8ZKjlj4ja7eIk
         4kzQ==
X-Gm-Message-State: AOJu0YwzVF2WWKmQF8a8Y3rJxm2AGZTBCKjcshbW027B+bhhGt32QNfK
	5NYV9lEI7AEYO4DDDQgi6hvuajmWhuBA7DTs4CGjMNQ6j/0lG1NI+S9m
X-Gm-Gg: ASbGnctboh6CwK4nGE+Ayq/bCzFnUDvP1Ccblv1KD04qq78JeWYabbYI5cuityK7pml
	d2WCGm96sNM9pDSlgfq5DMOyor8R9CBTc46MeZorZ7rnmrXHc6VJV6phIFlVlMUhp6WLTE9GMKB
	H8alZbJ/lowTOmPUMoAODYe+QGjHCspQSK94Xuy8oSop0xyPXPS+Xetn4zehLelBlaABXh7VVN+
	P/VzE8AKg6iNk2aizZVKHg6yRRnZCDOvbd0dENBLTecsLm2FK5Ip450zXhrcy9fYFXs7CsG+4Cr
	/asGxpzU4L/+IgfDIk6XdL8NAeX4ydQ7gdIDUN5aSQ2gUbMJHU1J85XTuyNNV9mqjzsCqtANXfu
	6dcvI6lkXEHaw61c1sV4QemlXXhF/6c3EaADsV+/HKZJg1jwjsMkqFkLHaH3q7V2PZrfC/zexw+
	rk8whNqmTpxuC6AmwgEllGIBm27A==
X-Google-Smtp-Source: AGHT+IFrMbMVzab5Rj4WbT0evERr8uBJOd6ao5iaP3Dv1k5XAo7Ky5wuHi6tXAqFVzNQo5RQ6s2gYA==
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr1713151c88.20.1763713107996;
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 7/9] zram: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:46 +0800
Message-Id: <20251121081748.1443507-8-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a4307465753..084de60ebaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -730,8 +730,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
+	bio_chain_and_submit(bio, parent);
 }
 
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-- 
2.34.1

