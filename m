Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5C335548
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024075; cv=none; b=caU3kBQGzGWqDcgPFVZWQkhOIwC1Hl8KAiHIywb6+JUHXMQRpNOaeWl/dCURL3sKFrqkZqUEpGmzSXg3y0coqWI4B6Q67lK6zhij2awSj0VsUK9dvzBO80XCac0eZryD1vLCYRsFc07uLo7tNY3bN19Se6IPMbKQhe/YOsCPK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024075; c=relaxed/simple;
	bh=GKNA5sK22EBgrN4HZDB5/e/zDMa2o07L2CPe8NP9GFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOqWIJM07wub5qS8kLRK6XvyUs5ZmtYXp3FhaP1GIcBdVyvnhv7vXNf9evdVV2dooUwl9paaZORJwxL6r0Zc/zM5c371uYtns8nNeTt2JF/OHN7wb20aJYgmYOQFwrOhAcRRCFg2wC5J1NmxfpzcCRhntO3M94xOvRg2GsOHhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=huOhOgCm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="huOhOgCm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980d9b7df5so4875035ad.3
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024073; x=1763628873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+JRL9kiPv0pDFSMaNJ0bpAVD07o+mb0mBj6g1Zy7bM=;
        b=huOhOgCmd/VZKOhV0smGsx/KW2l1QJVhgqa7089gyI7rbVsGGAENYnLKbKNkGPvaWd
         lupHlTbje5y2HerxqCPMmxHqA3quM3OuYr3gOf/n5vIA2ubhddj4AjF6mY7Mgzc3oTL0
         Am2qmREs+v2HtIS4O5dNDs9YDFss2TZ1dhYO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024073; x=1763628873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+JRL9kiPv0pDFSMaNJ0bpAVD07o+mb0mBj6g1Zy7bM=;
        b=nAHFl3vqiPcUidImMOhrS+cVl6AUERqHjlAMNSXJc62U3AobXcnf03n1525TQQ+Pvb
         Zi+/WhRrx65pRwkN1pHsjXdFbZvDACrnRlEz2I69oAMCe/FNac6697L4EdfNfVOpUlHk
         QA+nn+XqCl+efslidl21usIZfSCnsaikuyVD8VSzEPhwJq0uVwyhVubAr84mp92VHDYL
         niEXeaODPtlvpvTfjEOKi2malkPG9AWdWbXdAwFWepMSYYRtDlpHvwtTSZa4mLoEel79
         sjqX2VV8LXzdlAOlf92dHMOgnTcdxLBrab5DAE5+rMwyEaGUeU5uPPZZBeBludMjYWJP
         Taxw==
X-Forwarded-Encrypted: i=1; AJvYcCUrz46pJ36AZb5VUmlb0QU3EMDi3bd3KcUQpg5bH0eDIkTl2CXGnvRONKqNxzY9Ef/XsnyzCZasLkkHXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/DlyUCMKaFirW3LZD6Km6la73WhpQDeq02wmYNRMZJzOdoRI
	PtSPb+onmuuHJ0ldG8upfSPxXNjK5YSU/tmpdb4KfD7xBLajOf2tciX0N7iWPCd3Ig==
X-Gm-Gg: ASbGncvGPX5mqhSGuZrKRW+fDn01hAyEtG1Ko93cygqM0pHLmvJdrapWRQEKgbp68nJ
	f2uYLkocQD3SVSsP1In7r6HX6huroF5ueUHL0ibY54if8yOPSuZUyihqmKLBbT2Xw7qyw4LHuNG
	Ce4MVZ0NZelJ4SNrUK7qCjAOTeWkabFcamf1ZafNZU4cd5zgQXCUTCtKgRZxNAlPaLEdvhNsxOC
	eL4HW+Cw8w1eNbIbwDOnSybkJeeoe1ndCoArW6xMVahz5fxL0rNyMqV/CqSBRZ5dKGo9yyXwgQj
	FFwag07XDlyVpcMPpqiYQUlw4XG8lq5Amc/ZeQ1c6jq5iqLn8yz9QGLBgiTMnBJ6RDdat/ihC3V
	0vkzQs9ngiPvpgWxuG0l5zL82gTBbNVcG2zfwCbCAotGzGbt/NoW6j946FPV2xHQWVYYPO0K2ck
	AeD0qjR6swsDU9Ggctciwt/wGEvYs=
X-Google-Smtp-Source: AGHT+IGGZxYQr+LLoy8bEdHUKGbCLuJQ0gfi58q4jvR2bx074SYFubzhdfhY5JKnP3Pyt5bf5k/gtg==
X-Received: by 2002:a17:902:dac3:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2984ed27ec5mr76936745ad.6.1763024073273;
        Thu, 13 Nov 2025 00:54:33 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:32 -0800 (PST)
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
Subject: [PATCHv2 4/4] zram: drop wb_limit_lock
Date: Thu, 13 Nov 2025 17:54:02 +0900
Message-ID: <20251113085402.1811522-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251113085402.1811522-1-senozhatsky@chromium.org>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
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
index 6312b0437618..28afb010307d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -512,9 +512,7 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -529,9 +527,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	val = zram->wb_limit_enable;
-	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return sysfs_emit(buf, "%d\n", val);
@@ -549,9 +545,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -559,15 +553,13 @@ static ssize_t writeback_limit_store(struct device *dev,
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
@@ -866,18 +858,18 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
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
@@ -991,13 +983,10 @@ static int zram_writeback_slots(struct zram *zram,
 
 	blk_start_plug(&wb_ctl->plug);
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
@@ -2944,7 +2933,6 @@ static int zram_add(void)
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_batch_size = 1;
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
2.51.2.1041.gc1ab5b90ca-goog

