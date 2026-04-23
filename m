Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE566263C7F
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915097; cv=none; b=szpR0z2PKeh1AckpMBwqnkEbRwlZaoNm69lqg87zOkgpBOlk2t6fGaw+jbdeMMMdMInY54cPbVD8hrkbiHwlpt/8ek7bnz4NociCwqCMvc5m9/wN/fLEK3QG+KXD3Rnrn/ERFrwi4BWFAGH7ohrx1VkvVnEr94SIQZUmrEh3z1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915097; c=relaxed/simple;
	bh=Zk2XoZDEUQKYcYjxrv7SP+KH7p/yrktYkocc89mrM0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZQDTM56cCC3Lic5dES+AUH0K/OzYQzWaT2IaJ4wJ1/tnj+cVVf32VYtN9nnBMEETHi9SGDoCgxVGi3YlUKTWwvZlUu8xJNMKtZ+pb9urGeAXESlgru2uMITJA2V9FKy3WZlJVq5C//+dd8PUrF8QxIBuKg+YwA/yEjbvyvBVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxTsas9q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxTsas9q"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso48622245e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776915094; x=1777519894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfiBpziFGILmgZP6qHTKVDfLjg1hNLypwwPgsN1l96k=;
        b=HxTsas9qP4p8kVZqJwIO8zZ4PhEjHBKw2fHevsw0KqCcZZifn8JxZZdiawF4DrFBFP
         fqtX12DQ6sVWL/t4mLr7G1AKrB50B0Ogsru23KTo7C2go7dpzKdP2hHaHPvK4yoCfBnS
         eCOok5WM87CTmkVeX4cJjvaf+ydOfTBozWrdkIeaVp7h7TilrUf8rVqlguGoRVcoKb8w
         Uq0bisTCnGTC3RvmvL1BxtBdQ/EczJWy5jvrlA16vuST8oeLWYC5N3ik+Uv7Fd+HI98L
         jPkcYEky0v8gU5feKPABnJHlMRyu10JulavbhzfsaCDg89KAnQp+za7ZmG7L13CoBqGP
         U1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915094; x=1777519894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfiBpziFGILmgZP6qHTKVDfLjg1hNLypwwPgsN1l96k=;
        b=n3YcNC1A0jIE0XUTiEivRoVTf1oiXvG5EeNQljSnB1KzL1/6XUDcyPU5Jot4hdYE+8
         qqVjydj4GtcY26KKWlCFiV2NkaWyAFWY3i9M4ExI8/hdJeaMAOIb7SxXypaRsy24F4jD
         KxA+kwsdI7+Rcipi8wdmeqcGHZrgkgiqGN/zwTPr+uSJEZkrJ8jDanzHUUuWE05ihv5h
         pYXpcDfba8aK6s9LmwccbH0GMF4My1/jNnCUOMm2nFlPHKd1yFpZT45f/bjtvGj9RQMM
         PCTAZuDAK7Ls0qlYq53ko0AZY/uVZwIZpzNsDNV6qm+y0ArISVN1r4HGpII+CJsSIBvA
         GKBg==
X-Forwarded-Encrypted: i=1; AFNElJ9zJNRK+RfL1AgCGHc+q4d7FuP1L/0TKqzZKabPDk+bZXGRQrRYMmzb4SyYSEJ7yEHGYEexXLCeF/ux2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEu/r4QbBXEsI+kG1B1gxzotoAhtst43MUUjXOr1b/DK9MBEt
	NCyI/3C8yuhkmyQki0h7KcUsr5hdXA+26riyEEsMggH64kwN2d8CT/w/
X-Gm-Gg: AeBDievpJcbzlN7ffM0e+mT4oahIuF1xsmpx7dtDpMaQ4g9nBEQtQQ06L4anHJGv+Cg
	ugm8+1iFANpu33M0N44jyI9RXg9EjC02pO2TanlBOcFXInANlMHP/tjLqRPOb2773qeSx2Fj4ey
	/ObT24nPfal8Hu3G0Wj/UyZz1eFd4Rl0hsIC32Uvh8d8jF0nXzyv4Zg5mPJXo2Z7kAoDMue9hmP
	PypXK1MGe2pgI3eMF4nvTfYWBut3KBUGU4ofgIAjMVMEiOurjvqZMX0IU/XHkXHZDK0uo8CXRpV
	8fCEqGjBicxtbrhDyihPzphEtNWT8hfAFC6GbR50gUXg7PljLrBd0rckHPyn+fn2cryz7GqH3I+
	Dt6EKKWCGNqtj5ZFeBkaCRFfLZ0hF5DtoejVXu6vY5VI5aXrYgcOerXQkFobqQ0MhQWkGXCkRRe
	7qdywElZtYMFyxIN9w2/y3G67VFqF/lLtyFUeks6UIvWPu4O7twFyuG14MkdtoCFDzNFcIK74Dp
	UnpPDOMFXbI0F/eBCs=
X-Received: by 2002:a05:600c:c177:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488fb78129emr325779365e9.20.1776915094078;
        Wed, 22 Apr 2026 20:31:34 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm104438085e9.2.2026.04.22.20.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:31:33 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 3/3] ublk: avoid unpinning pages under maple tree spinlock
Date: Thu, 23 Apr 2026 11:30:58 +0800
Message-ID: <20260423033058.2805135-4-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423033058.2805135-1-tom.leiming@gmail.com>
References: <20260423033058.2805135-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_shmem_remove_ranges() calls unpin_user_pages() while holding the
maple tree spinlock (mas_lock). Although unpin_user_pages() is safe in
atomic context, holding the spinlock across potentially many page
unpinning operations is not ideal.

Split into __ublk_shmem_remove_ranges() which erases up to 64 ranges
under mas_lock, collecting base_pfn and nr_pages into a temporary
xarray. Then drop the lock and unpin pages outside spinlock context.
ublk_shmem_remove_ranges() loops until all matching ranges are
processed.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 56 +++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6edc65af250d..a68bff69844e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5424,32 +5424,68 @@ static void ublk_unpin_range_pages(unsigned long base_pfn,
 }
 
 /*
- * Remove ranges from the maple tree matching buf_index, unpin pages
- * and free range structs. If buf_index < 0, remove all ranges.
+ * Inner loop: erase up to UBLK_REMOVE_BATCH matching ranges under
+ * mas_lock, collecting them into an xarray. Then drop the lock and
+ * unpin pages + free ranges outside spinlock context.
+ *
+ * Returns true if the tree walk completed, false if more ranges remain.
+ * Xarray key is the base PFN, value encodes nr_pages via xa_mk_value().
  */
-static int ublk_shmem_remove_ranges(struct ublk_device *ub, int buf_index)
+#define UBLK_REMOVE_BATCH	64
+
+static bool __ublk_shmem_remove_ranges(struct ublk_device *ub,
+					int buf_index, int *ret)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
-	int ret = -ENOENT;
+	struct xarray to_unpin;
+	unsigned long idx;
+	unsigned int count = 0;
+	bool done = false;
+	void *entry;
+
+	xa_init(&to_unpin);
 
 	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
-		unsigned long base, nr;
+		unsigned long nr;
 
 		if (buf_index >= 0 && range->buf_index != buf_index)
 			continue;
 
-		ret = 0;
-		base = mas.index;
-		nr = mas.last - base + 1;
+		*ret = 0;
+		nr = mas.last - mas.index + 1;
+		if (xa_err(xa_store(&to_unpin, mas.index,
+				    xa_mk_value(nr), GFP_ATOMIC)))
+			goto unlock;
 		mas_erase(&mas);
-
-		ublk_unpin_range_pages(base, nr);
 		kfree(range);
+		if (++count >= UBLK_REMOVE_BATCH)
+			goto unlock;
 	}
+	done = true;
+unlock:
 	mas_unlock(&mas);
 
+	xa_for_each(&to_unpin, idx, entry)
+		ublk_unpin_range_pages(idx, xa_to_value(entry));
+	xa_destroy(&to_unpin);
+
+	return done;
+}
+
+/*
+ * Remove ranges from the maple tree matching buf_index, unpin pages
+ * and free range structs. If buf_index < 0, remove all ranges.
+ * Processes ranges in batches to avoid holding the maple tree spinlock
+ * across potentially expensive page unpinning.
+ */
+static int ublk_shmem_remove_ranges(struct ublk_device *ub, int buf_index)
+{
+	int ret = -ENOENT;
+
+	while (!__ublk_shmem_remove_ranges(ub, buf_index, &ret))
+		cond_resched();
 	return ret;
 }
 
-- 
2.53.0

