Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0E2236FD
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174121; cv=none; b=QZSLg7yvLUuAdBOr4lXljuC34nA+oDxjHueUiOsWPYeh5Tiszv3Pnss3Ri4qNMCGPmCQQyKgatq+BrNn1ybLwg5lPOHVHv7FVTeKRbLBo0mscDQA9qxCQcdOp7vDtaCxPFv4F+3zcfH3ADH1erEixAhjX4rpujRC+sJm2L6Zewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174121; c=relaxed/simple;
	bh=Rz8KWpOT2ndvIDkVBobKDwBDCHXj3WRK7sMmSaWxLC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DThgWLUbRitTNP0K/4NxRFQnfDbi6oXhq+E4oO2bHdrrdJYbgNiT99oF6C4Ctas7co87SbmjNW7Oo1Bt8IxylPCmQibhpRh1tWmmBmVdeQag0Ww4IWibL7YvzNqIGflZOffgVZdp7GcALA2kLBBjHWTrpDJ+bLG8Sl0NPZt/zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oNq4l35W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNq4l35W"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297d4ac44fbso27572445ad.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763174119; x=1763778919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4c/dqlofQQ1Cq0Pw+ZOefCVsG4PeXoReJklWLO52f0=;
        b=oNq4l35WTBo8aXmcPQUBIFqbTTWOnBieCw1Y999IGc6jhhXIxayJUzrOxOPzUSH3uv
         INqhLmY0s7TkeZIncOU+W8hm+4SyIDXvngdBGssC0RB3ahzmxrSdemt1s7PIO8mDYzY/
         HwlmVv1vizCSjp6w55CijHGFOyvZ77wXyuvGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174119; x=1763778919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4c/dqlofQQ1Cq0Pw+ZOefCVsG4PeXoReJklWLO52f0=;
        b=B+QrxoZZ9oWFB/NjyFDLotllbnNtc4e5pKJepxpASZ20ymxY0m6ra/favbRi0l4Zjq
         DDqevmtsokUv5K4W8AmWrq6pFHDJ4FNYeeGjlWihh8EpCn03Yc7vN53LAna7OiS+diG9
         qA/2I5Z6Eaz4hwVxmzEhOhuYLnx4Y+dtzRcrtlaq/reLNUoPtmHtPLJ51tdU/HkKkN+c
         QNydqnk/UYAJef+VOEbtL2H5VSA38Itm/+e214EdJSSJ4+fd03lUY6poqmxvNX0/r3VJ
         bc+QouuZBvv5O4sxLflqIeDbWGLOyvYtYVisfVlc5M0vkb2ExpZt3DR8Rho4eVSoQTiO
         C9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWHSCzjrRNqljQHU8iDu1C41SAPIjKUP5DF6lOlqDIPXb5ACGhz0OK/WrQGS8tPPpIQISQ0EleaDnH3IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZQ14FNt5ihHI8/7YtO9Fna6NL3GGG2As0kh2IGRNRH9QY3Bq
	/zgFztZEGiSVEjvEMmGhgG2eo9p6iNIHepKKFzM29Zrdt/oEAcvhQhC4wEFbZak0iw==
X-Gm-Gg: ASbGncssc0IlplPEmZk1WxgD4otBtpvnu7ZaA/JpFdbYYajmz7DjEjj0C01W0vpL/vI
	7KwNHta02rJsf6mO6mFSppMelsZcOgLj7WESEjVz+YAo6CpmYtkBhJ7EC03i4vFPAlq0QiOcm1j
	hxUSLfBXMwZqVRuMUj52Rp1DDeEon48t73cpQXpOZk1L1iLL+r8wejDxkmLsAfHD2nuqqq1uyeX
	3SzXXhSSqtgNHvLDyWODQuD7Rct8uogknJ/96KGCRUd9ilqrwyKcUU1BvlY3V5WSMvnQh+BEv23
	LqUrhLn61+dB3NPerboFhfZC/kWijAyXSBZvOtyWJN/nAog69cOy6aRwBfW+RNeoauV6Sela1Zz
	FZfFqo/WiG7csXPtPZesxLTisikGkaz8ORZdEvwVsyifNcFBIA2Kh5hZwxvfvTsWfBQ/o0YUmf1
	wvZ8d/3+Gfa63ZvGhA82pq3a+B5W/Bfh2btrRg2A==
X-Google-Smtp-Source: AGHT+IErO2AnZLN2sgTOQ83bbSpiNbBMpGFTea0Uu0P8ZBl3yHBz5eWOR7rGBCRpubc/taMzYWS5Lg==
X-Received: by 2002:a17:903:11c7:b0:281:fd60:807d with SMTP id d9443c01a7336-29867ec97d1mr58658215ad.2.1763174119552;
        Fri, 14 Nov 2025 18:35:19 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1088sm68641555ad.57.2025.11.14.18.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:35:19 -0800 (PST)
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
Subject: [PATCHv3 4/4] zram: drop wb_limit_lock
Date: Sat, 15 Nov 2025 11:34:47 +0900
Message-ID: <20251115023447.495417-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115023447.495417-1-senozhatsky@chromium.org>
References: <20251115023447.495417-1-senozhatsky@chromium.org>
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
index 76daf1e53859..bc268670f852 100644
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
@@ -990,13 +982,10 @@ static int zram_writeback_slots(struct zram *zram,
 
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
@@ -2942,7 +2931,6 @@ static int zram_add(void)
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

