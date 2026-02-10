Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE960211A28
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770695502; cv=none; b=JnpM1ILRy95kd1cE4mmp4+nRtoMFEL2JYYVcocBbGINme8GU8zAGEeNNY5SLz6FcRu4VjFnCOBPgPYJa875IAEu1N491Qkko9bp/FPaZ+YhjUhvgv7Zc0s8n6fp5yYhHHf6YeOCGoeedjOPY0kmr4RhIgqB8DEl8AsAJ1f8/bZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770695502; c=relaxed/simple;
	bh=xngDvGsGosuy02NazjVqvK35O1orHk+G2QwT3iWYfkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kp1lu4D2oS0mVxLlDWI63yn0oo86NAQesrQZGCkMJqjXbcRW1k39ahVo4t4oK4sNrN8AJ857sZ4Seu+aKhJHxAhj6KsvSpnlx89T4fgPGuYHDFqVe02dS6+j3a3cNMOuyEoRnM1pwVM184bfsSjNQFhi1UNm3QdMzE0bBM2pOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XJug/nBm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJug/nBm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354c67da885so2173454a91.3
        for <linux-block@vger.kernel.org>; Mon, 09 Feb 2026 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770695500; x=1771300300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWBrWovJfp5dTcCCQ+5p+inQe0fMxZzVyOmIoUXcNY4=;
        b=XJug/nBm4kMqwESjVhpzY2V2Ow3L+OTQYYdhfX3mOM0IzcfSYCdgzfgqBT9LOAzrfs
         AMc6XhqDkHEHW/DN/Pd3ejNjeGCIA2OwfAbd+6gUTDf39+N5bTZ66jYJRZ5prVRi0bUa
         mh0E9XlqkAs7PP2GeWXZs/R0oDcpNhGrrmyec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770695500; x=1771300300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWBrWovJfp5dTcCCQ+5p+inQe0fMxZzVyOmIoUXcNY4=;
        b=G6ROQV9lyuJ+DjqAmKYST1oPSnY9ctmhDnRKxYUB+qHpJHrOQuh7fG4JU5oY7P3q+e
         ehx+LVclrpboj/8jq8XitgD3sNrn+MMFuIxM89f5OCi9po3LmVDshj7KLzry4SzpGI+P
         +FlZpLKTJhiIOeTkDr+WIzMkt1ZCdsYmNRPM7PqkX+V9hoSXaiKbUWlWc20PvZgoCUfX
         0yu3baAz6YIaYY74qQtUq62gFaj7RgnUrz8ksLpU1O7q5sDz66uCbjGpiJJutLKH0qRN
         QEVCAUhnhIWGmMtZXuvrG+0QMd7eHcM2gH7UKmZY8WdHwYoVKboScomajEKwBiWFElqM
         lp/A==
X-Forwarded-Encrypted: i=1; AJvYcCXPEiEPt59R16zmIAZpTqCHh04OCxEcBHyixSx1nfKGDWNmRRoELQ3k9vzHHrWJ485sJOG3qDK1FfpTDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MuY+nZqBE4elqAiu2WESAQaFH/7nzzMKetm3NdIySA7S3H70
	9VA2h5/3oHNI0kH14ykN/ebhLBdD1s4Ial1qaCtF7fzK0wqWHMmt7pxATMmM+9I3NQ==
X-Gm-Gg: AZuq6aKGeOvJEgW2KB1Y+Mb7vNYFQXYetPZRZI/NBzcTgiI2u3Uy6Woq9Lal/T5TaA3
	Fw2Soqxx4wf2h4j0Rv1tl9+lC5zGyhUQ+75BjuJJ1TX35vb2oV1Sq7UCAb3yWCf2EvHPj32SE5x
	7KZa8A4o4hOVZhyU9Jz1Aasx5aIZDAT0/wNrvEGpuZItm3TI1WuWQEl04UwHJ96QAVe9KobAKqL
	f0BhXFunnLkEwGMCmndkLzGbV9qpjhzXYADSOGDgPdedrgns5ORF5GVivWShPL/mYU4SHbzm4tC
	lSfIsnoFV+7mfcy7KS9b1IXEDi46Qo+rZd7eNrVFd9kWE4Tnvde2nClsdKMwEd2H07Vwnbqi1mF
	mICiRmmkzJ/3k11X1ljfUOHd6Auh/KMqQntk9rbT0i0BwCJOusqots2AhDCFh0Q3FjvyHXQ0Uo+
	8b3q0BMJeOCWh4Pl/6iT/RCw4HJ3OIZPQGCmKBp+LA9d6aJ3kcS0YQ4j7uaFVjpx+nzdxGcH5ox
	s4sV18aS9A=
X-Received: by 2002:a17:902:d48a:b0:2a7:51b3:859c with SMTP id d9443c01a7336-2a9519b5a9fmr127587185ad.57.1770695500190;
        Mon, 09 Feb 2026 19:51:40 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:3f6:92b2:887b:120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aadeb4d345sm65979895ad.54.2026.02.09.19.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:51:39 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Richard Chang <richardycc@google.com>,
	David Stevens <stevensd@google.com>
Subject: [PATCH] zram: drop slot trylock and miss_free
Date: Tue, 10 Feb 2026 12:50:37 +0900
Message-ID: <20260210035045.3817297-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e914d8f00391 ("mm: fix unexpected zeroed page
mapping with zram swap") removed swap_slot_free_notify()
calls from end_io callbacks.  This means that there is
no more slot_free_notify() from IRQ context and hence
slot-free cannot deadlock on slot lock any more.  Drop
slot trylock.

Suggested-by: Richard Chang <richardycc@google.com>
Suggested-by: David Stevens <stevensd@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 34 +++-------------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 61d3e2c74901..c2894023c0cd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -74,23 +74,7 @@ static void slot_lock_init(struct zram *zram, u32 index)
  * 2) lock() function can sleep waiting for the lock
  *
  * 3) Lock owner can sleep
- *
- * 4) Use TRY lock variant when in atomic context
- *    - must check return value and handle locking failers
  */
-static __must_check bool slot_trylock(struct zram *zram, u32 index)
-{
-	unsigned long *lock = &zram->table[index].__lock;
-
-	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
-		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
-		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
-		return true;
-	}
-
-	return false;
-}
-
 static void slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
@@ -1943,15 +1927,9 @@ static ssize_t debug_stat_show(struct device *dev,
 {
 	int version = 1;
 	struct zram *zram = dev_to_zram(dev);
-	ssize_t ret;
 
 	guard(rwsem_read)(&zram->dev_lock);
-	ret = sysfs_emit(buf,
-			"version: %d\n0 %8llu\n",
-			version,
-			(u64)atomic64_read(&zram->stats.miss_free));
-
-	return ret;
+	return sysfs_emit(buf, "version: %d\n0 0\n", version);
 }
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -2814,16 +2792,10 @@ static void zram_submit_bio(struct bio *bio)
 static void zram_slot_free_notify(struct block_device *bdev,
 				unsigned long index)
 {
-	struct zram *zram;
-
-	zram = bdev->bd_disk->private_data;
+	struct zram *zram = bdev->bd_disk->private_data;
 
 	atomic64_inc(&zram->stats.notify_free);
-	if (!slot_trylock(zram, index)) {
-		atomic64_inc(&zram->stats.miss_free);
-		return;
-	}
-
+	slot_lock(zram, index);
 	slot_free(zram, index);
 	slot_unlock(zram, index);
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 515a72d9c06f..d90d9b6c9575 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -87,7 +87,6 @@ struct zram_stats {
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
-	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
 	atomic64_t bd_count;		/* no. of pages in backing device */
 	atomic64_t bd_reads;		/* no. of reads from backing device */
-- 
2.53.0.239.g8d8fc8a987-goog

