Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466F2D8DA3
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626047; cv=none; b=eXaAb82ILRvrq3luaqEbl5Dac2u4JTsCXQOev7hpGyoo44V7faw24yTcot6nRsf3cAhcDRpMsNgajdZFi3HheC0M47Sp0LIm+q2cwxSedFDC5oIhGGwxZMVYU/P4ttDR7I4iYf7RIDFwyZDmUUDHOKTzAVcEBs710AAnzB5klZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626047; c=relaxed/simple;
	bh=afZ9ifoNRdQ3EODmbrB/PnbH+egRJ9qu00kyjsmC8iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAOjvin21CV7GEhYzTJtingDGGOtYO8d0VVMtm59sceB/O/k1RbgT05rtGnNUSzA6xg7ta5FOdJQyNFQw64YCS2lLAaf8hk89OLgqsfNmbNu29oRE+AZilpTFy01jvM/X4KAGPwhCFZEBTtxIGJoU7oivE84VYH3Ul2KGXSKv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L2GVqCbq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L2GVqCbq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82989744ee0so3743711b3a.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773626046; x=1774230846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYqr+vB0yDmh6RC6NbmJZwyMtP41pGo8Z22GiI8XtgA=;
        b=L2GVqCbqzEMFQEE3+wnCh1DPxwwcZsVGe5kAogZa3nblGxAODZAm6hTk7yauPmAx5O
         qS1g6GDbikxtA2g4zAwKjSYQNtpYDD7T8KtDd7A5w2Fb4a7csDT6Nm8mPsOSRGlGXFSQ
         an+/YNW4Vvv8ckAABLrG3bY5x2tCHSu2od4Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773626046; x=1774230846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYqr+vB0yDmh6RC6NbmJZwyMtP41pGo8Z22GiI8XtgA=;
        b=HMFPoBqNfn2VFaaOWvTvPT1XMlKOD51RfIwAie6UY5XM7K9YFLUNhgT+8062FTPL3O
         VL6/id5U+YieAtl7ZYWw74rJu5sTXk7ivcxlGKqcrz1rrL2om0LpTgDg2/4huNihg/X3
         6jhvqvp+TkDqsE4aOSXDurxy4b4OZfi5gvXbURmOzHoIqP5oMARIkT3vUgI3PrNII0HD
         BJ/oZjbrmA36KnZZwY+K2UcPpK+y7wiIKko/uO6u9d5/52avykd/0LbWBa8prZi40Trt
         kjbiUVsu843GnsFvvXNVYwnZtvohJyOTo5Ndr6dI44+6/32zRM9zmruKACZk0HCzt0Vi
         q8fA==
X-Forwarded-Encrypted: i=1; AJvYcCWHNgvcEfzzT+eTblgjmHYiBEUUUuvf4T5k9D+wnYrn6S5YjNfPZIGv6YE4g8q0I39A7qKcQCM9ZGhLqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymXvX9apXOHQ6QrxKxG8AYGSCBWqCKPkxh6YrA/Eed3zdtTm7Z
	1DvGcQIgZATfrQxZzlWNmCHDp5H624qHOxDKzdd7pz5g6W8lVWxYwfpgP3ZKWoX0ktoQxvpwY8s
	V/lg=
X-Gm-Gg: ATEYQzwp1d3ohFQyiutMXCsh0Zly0D+9sZfdKOy6ragQzTffsHfuc1pyK2we7GzC6AJ
	gKxUXqfkb9mLxtZcuub6KY0bkm2kdBUb8M+hLPkYdUAZSojHQr40ASf1ePv4pb43QKnbHUykrP/
	WlTrWI8LQdyr2mGiQwlTNodDF/bDI4MgNBf4S2rZs8+7+L5dxeCDmpadUAvTCYoikrwUCMvV7oc
	9b1eDg/BITKRPg9aMoW7cICghFspeusoc2t9EwHdK8V2Ek7NX6X69AFJBPLP6cPzfkTPHxNtkrF
	D+TgXkHaSMassFzGkrt/t/JOMf0NWVJ6S99qUtm+tEEZmtcP70hyjiHOH83tziUbwV4lGv8JawI
	xFR9ZnQogdmiqNHo4fjzTTmnpie9S8ZhDZNz8x4prP3JoTH7FmM+Jl6N0fQDjJ7SPt2fNP90It9
	hfBOIBGZTVilmLHw7JrbZ2VG64QNoYae4iCwNEIDtYPNJY+CC+ZfUV8gEr9iaPSsFQwQCnPfhAd
	llLagBzWileQw==
X-Received: by 2002:a05:6a21:6f8b:b0:398:82ca:cf69 with SMTP id adf61e73a8af0-398ecddc6c5mr10663047637.65.1773626045779;
        Sun, 15 Mar 2026 18:54:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:b3b1:8c6a:2e95:3888])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07268aebsm12286440b3a.23.2026.03.15.18.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:54:05 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>
Cc: Richard Chang <richardycc@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: propagate read_from_bdev_async() errors
Date: Mon, 16 Mar 2026 10:53:32 +0900
Message-ID: <20260316015354.114465-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When read_from_bdev_async() fails to chain bio, for instance
fails to allocate request or bio, we need to propagate the
error condition so that upper layer is aware of it.  zram
already does that by setting BLK_STS_IOERR ->bi_status,
but only for sync reads.  Change async read path to return
its error status so that async errors are also handled.

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 63f71371a7e9..b47cb1d99144 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1445,21 +1445,21 @@ static void zram_async_read_endio(struct bio *bio)
 	queue_work(system_highpri_wq, &req->work);
 }
 
-static void read_from_bdev_async(struct zram *zram, struct page *page,
-				 u32 index, unsigned long blk_idx,
-				 struct bio *parent)
+static int read_from_bdev_async(struct zram *zram, struct page *page,
+				u32 index, unsigned long blk_idx,
+				struct bio *parent)
 {
 	struct zram_rb_req *req;
 	struct bio *bio;
 
 	req = kmalloc_obj(*req, GFP_NOIO);
 	if (!req)
-		return;
+		return -ENOMEM;
 
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	if (!bio) {
 		kfree(req);
-		return;
+		return -ENOMEM;
 	}
 
 	req->zram = zram;
@@ -1475,6 +1475,8 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_inc_remaining(parent);
 	submit_bio(bio);
+
+	return 0;
 }
 
 static void zram_sync_read(struct work_struct *w)
@@ -1523,8 +1525,7 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
 			return -EIO;
 		return read_from_bdev_sync(zram, page, index, blk_idx);
 	}
-	read_from_bdev_async(zram, page, index, blk_idx, parent);
-	return 0;
+	return read_from_bdev_async(zram, page, index, blk_idx, parent);
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.53.0.851.ga537e3e6e9-goog

