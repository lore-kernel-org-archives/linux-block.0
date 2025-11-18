Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259F301715
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451026; cv=none; b=BX25tmKC6xptg85Uj7D5XKvi6xiJhjh9jYZTJDsFjcUvbvEP0fYRJ8sofT8cHmkZhPRiKnKd63AFDnYFuZqoQf1S0tqI4MBTMJtmRH/cjlQ+WR+2D1W9y055fyWxjiK3IqDuqAgEqBiMMaXmBIQd4FP+j0pXAzTwuVyAHJYZRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451026; c=relaxed/simple;
	bh=wmywxqnED32HJVGKR47kqa9PyXCMZnodT2U0NloKWRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV0gn7HKZ7C10IiIdN56VCaWTAZNYeBl4KEItaqTfGwtSl3VrSSu8jLJtW0f/xt6c52V0Eniln7qZT3p3JdfCDHQ/X/R8smnryKqXjfgDHLE3rXu7LczOEMq4kr08MXYXRX1hTcmOMaUsfqsAi7rd4KhUJVqqsg+1KXik39o4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f7RCcnS4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f7RCcnS4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29558061c68so60717545ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451024; x=1764055824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5s1n8emEbRVEeKrAhj4AgcEk08attFm4KUuCDQvhIk=;
        b=f7RCcnS4P6QkDgw7nfv/kpyvweLcO8vDcLA2AQn+BALqyCgL7y//6SiQAV9D6DyMAU
         dIHrrhl2bzQeHfZt0p8MHed04UhoxZiFBT1zcdkOdToxQ8o52yyP8nSAkxPHAc/lOBba
         ry/IR2hdG8zuRdiqvcafdt+8E9YBanBAbdRb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451024; x=1764055824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5s1n8emEbRVEeKrAhj4AgcEk08attFm4KUuCDQvhIk=;
        b=r51+RfXgUPXhDayjh0MmZYsgt/j47Xcac0Eu53ufmnyfEzwLr36zAkbLXbStbK8+C3
         Y195YrL7Tfql28F7T61WklDd/jefRKUEyhQ3+g/L90WoxgDL6EGBurqOReVUJ/auM8zO
         j6hwi9m3MOIskGSR0AITtKkdaJMpZmvNJD/V5a31jfGJou96r1dKR5joBCqUahYcXAc5
         K4iS4FcZgjbdTurBSbGfSxQdn/hcSRsPXfdT0uj/+PNIgUvOgemwQ/m6fKGmX7XRY4e7
         b8/rZgxPmc1ZGbT6Lj64LiQKH6POnAlR8DcYm/j0BwGt5Bh+NjbRq6qu+5KTUqnQ4JBI
         PJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe6y7dVJeeZ7ySjotY+J9pzladBIryWmvk+pUD5Y+lCb+4CFP7o9BVDAY/k4HAqoXikR4raq3aYVKS+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhePwJi4f/p+wQdk9ftu+NgixvG4gH+XiyUF2aqd7LASCTzFnH
	sXGV2ur1g1o8GyWdZxrsgP5lJ3ibuhPKJVfoDQU0z96dsrdzJkNnTn8JBqoMdpQy4pNOlXlIScO
	iIPs=
X-Gm-Gg: ASbGnctL2tjObr3UeLL7iMZrteHENTiOycKJCNn+V+a21pPL9hJ04a8ucJE8Cia4tKq
	D9xuGzzgjr+eC2DgrgfLYnkfa4v++f78iyZdA2g1cbhLRB/ksepfYxY/YrbnrWGdz6mdk4MthmV
	DHhGafwd9bjzk/xxJlS5VpRb4c+h+6veCKuZFZgvpWwNZVC3VgxzEUQRvgco28cSe6sM6IYMDWi
	AUk8XfsmPfCJc7afjhEzHdDaV7uOkEzLI+Jg3ElXfgQlhrJiRD72s8a9YAQKnGQ0yyG6zybiHNo
	UTXeeqrwsDwG3yaTr1Q+FUpzplKOAe0iCEzM8EnVyZ7Uk16a1JrRX5OcPsbWCTx0aHa965DVGlC
	AEUupd/VZpPI5NcuFlqtZfu6hgwS7g+1Z4yJoNOXxKIA+VrYnSS2zjeHP2DaKTbheAHbqVOnc1H
	2HJU3cuToMGNjawGz0Mc896VI1+Fo=
X-Google-Smtp-Source: AGHT+IEFUxpDM4RZB/8QnapGp2d+TGrwoXbvzGp7l35DJ9jW3FWtnGNox8kM6z3lPxn7O64J6J5u/w==
X-Received: by 2002:a17:902:f64b:b0:297:c638:d7ca with SMTP id d9443c01a7336-2986a6bf2damr172314225ad.14.1763451024123;
        Mon, 17 Nov 2025 23:30:24 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:23 -0800 (PST)
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
Subject: [PATCHv4 4/6] zram: drop wb_limit_lock
Date: Tue, 18 Nov 2025 16:29:58 +0900
Message-ID: <20251118073000.1928107-5-senozhatsky@chromium.org>
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

We don't need wb_limit_lock.  Writeback limit setters take an
exclusive write zram init_lock, while wb_limit modifications
happen only from a single task and under zram read init_lock.
No concurrent wb_limit modifications are possible (we permit
only one post-processing task at a time).  Add lockdep
assertions to wb_limit mutators.

While at it, fixup coding styles.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 22 +++++-----------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 073a12132cb3..1cfb58516a8e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -530,9 +530,7 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -547,9 +545,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	val = zram->wb_limit_enable;
-	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return sysfs_emit(buf, "%d\n", val);
@@ -567,9 +563,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -577,15 +571,13 @@ static ssize_t writeback_limit_store(struct device *dev,
 }
 
 static ssize_t writeback_limit_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	u64 val;
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	val = zram->bd_wb_limit;
-	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return sysfs_emit(buf, "%llu\n", val);
@@ -864,18 +856,18 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
 static void zram_account_writeback_rollback(struct zram *zram)
 {
-	spin_lock(&zram->wb_limit_lock);
+	lockdep_assert_held_read(&zram->init_lock);
+
 	if (zram->wb_limit_enable)
 		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
-	spin_unlock(&zram->wb_limit_lock);
 }
 
 static void zram_account_writeback_submit(struct zram *zram)
 {
-	spin_lock(&zram->wb_limit_lock);
+	lockdep_assert_held_read(&zram->init_lock);
+
 	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
 		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-	spin_unlock(&zram->wb_limit_lock);
 }
 
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
@@ -992,13 +984,10 @@ static int zram_writeback_slots(struct zram *zram,
 
 	blk_start_plug(&io_plug);
 	while ((pps = select_pp_slot(ctl))) {
-		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
-			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
 			break;
 		}
-		spin_unlock(&zram->wb_limit_lock);
 
 		while (!req) {
 			req = select_idle_req(wb_ctl);
@@ -2947,7 +2936,6 @@ static int zram_add(void)
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_batch_size = 32;
-	spin_lock_init(&zram->wb_limit_lock);
 #endif
 
 	/* gendisk structure */
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 1a647f42c1a4..c6d94501376c 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -127,7 +127,6 @@ struct zram {
 	bool claim; /* Protected by disk->open_mutex */
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
-	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u32 wb_batch_size;
 	u64 bd_wb_limit;
-- 
2.52.0.rc1.455.g30608eb744-goog

