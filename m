Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD2393DEE
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652138; cv=none; b=e1OWRja5wPkmvBc4ucDg+wFfvBLNYv5TySEVjiyQVEBF8LbNnhXBCJrKoi3p1d+wB4hGUFi8Rs/EUk07GmnWRwZOj42UdOd+uKHCOhANvf/fbmoDSFQfj8ssf3I6RoSZky6w4GT2cvqPtqSGMoPnm+CYj2P6ib1njAQpeAqe0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652138; c=relaxed/simple;
	bh=PRNpmIyzIQt6oDSuT13eKGI1o2cKI4pCtHaFoUAiu9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiAAfm9lSWtVnaHqJZzACnldFLAfSRpMEnWOHJLb4wHFMpEfd2xQnF0zmosUDhqWwACiX8HHx9c1COHZ3y62mE25xEVn9yvgwmTQ3ts+RKLDaBisMHNnFEF6YYxiSC/o7pViD49pg+D3NY9a0keKrFADdl8UnBN09UpKs0vg/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CGd4azZR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGd4azZR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso1169253b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652136; x=1764256936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bqQNyl0EBA1tCBIt5a+Z0GgRe/Buq+cexkkYbJh4q8=;
        b=CGd4azZRvFKin1+X23aed5sdzldklguJzf4PHguUpnbYmw2mPluv5pJvJrXEwPV1cN
         i+bHR1GTUDckO0iAf+VFpPO9l6n4ARbygxgot4IHTpbZkOPIRSh1oJ2p2HYX4xnezIht
         6753luCxzOzQLdGDOBIjSXJyxFdYzjx4OSzo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652136; x=1764256936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bqQNyl0EBA1tCBIt5a+Z0GgRe/Buq+cexkkYbJh4q8=;
        b=N6owHvuiVFEwAzzBFYxCyGnXsFHKIVoY8bLM6slIowe+VV19DV/ql8Z+a4L1mu3kHV
         GRJ0+Za1qr5VU17XIXEsdMOpWAijaLsHrOaemWyOxqdVuSUrHzCJIr4oEAomZfml0NgO
         KDWj0N51P1G2r2wpbhjJOgFYPMRDWz2v7iUezCKfi7ycrQJIZFi//w8RfVyf5cIsjSxN
         jqP98nd5ezBPi9dc37s4leBXyDKWWgz+UI7CYRIFviZrsxvXxBwaEm7mYq2NCjO7Fup0
         YvYhlKbCrwkC5HFd+8QdED2QlK4jkk9hB4ROS0O1Sgu0flaCXrsLRGRbxkSoVv82YF2M
         x+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnBj3ePQWeGGbjwNSdV0tX68dxIrQKIS3NF0Rxbemc54GyCGHw1vZHOIZYLldNqwIFzvBy9YoBtxKLPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYf5JzdLCh+p1O23/6A89ASuDsq1fYH1iSRv986RXkFqoatPl
	CxpR6T6d5o3vQ/CE9nVaRAnLGVR/EtyDt5p6y5EsW7LWzdsPBfmijucsLr5LZlOESg==
X-Gm-Gg: ASbGnctVccijhFhi8/He4bS80tn1RRVHXB+L1/HKB8wg/eshMyBjFRwuriKVH7k0a9C
	OFpoKtG4ArwwSJOPys9Np5au0wWUizn5iAfs8/gzQ08dQq6BGqxx/AqArQ5i7P1L5KRwnStNl+O
	4EnHW+r/gYLLJbsf9MnaH/RQEIs5CZCs56iQ2lCyzT8CRYPj1bJQ+Hj6X3T/hnQnb7qxoE+3SKv
	8J6lwApcab18YAf++iOBs0ye3HpLlSSgLI7TLiFctlbb2203u7FCf9ZvCgGxS3gxmRPgJ+TnUPd
	Rmd7IYPl4w3m2bximlBJ9nveYOw6uigyUqxGd8SqBkMmw66BXe8d3+7E8T1+PCEr1RQZUDrYi5B
	gD9RoczPXhCvkmH+0Lfcmo/ROV3Jouqh743MJFK7Lt7gA8Hp/jD1YrEl9PKE6lvHPHU4xVxzxHE
	ah0oZBL4P6pbvQXBmxMmMqObTFR1iJHEEtLNnBJ419nvx4sfdv
X-Google-Smtp-Source: AGHT+IE03gD53APBfw1EXEVlOEjEP8sWWJxhTauo8qfdCA6G5JLbr6CU65y8SGc2126/gbRkzxoUKg==
X-Received: by 2002:a05:6a00:23c3:b0:7aa:d7dd:b7dc with SMTP id d2e1a72fcca58-7c3f0b62fe1mr4912657b3a.31.1763652136376;
        Thu, 20 Nov 2025 07:22:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:16 -0800 (PST)
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
Subject: [RFC PATCHv5 4/6] zram: drop wb_limit_lock
Date: Fri, 21 Nov 2025 00:21:24 +0900
Message-ID: <20251120152126.3126298-5-senozhatsky@chromium.org>
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
index 71f37b960812..671ef2ec9b11 100644
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
@@ -869,18 +861,18 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
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
@@ -1004,13 +996,10 @@ static int zram_writeback_slots(struct zram *zram,
 	u32 index = 0;
 
 	while ((pps = select_pp_slot(ctl))) {
-		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
-			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
 			break;
 		}
-		spin_unlock(&zram->wb_limit_lock);
 
 		while (!req) {
 			req = zram_select_idle_req(wb_ctl);
@@ -2961,7 +2950,6 @@ static int zram_add(void)
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

