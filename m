Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4220335073
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024068; cv=none; b=rYQqSrk52C/G23X48ICxE/be6jTcTplR6UK1O+l/v8a5M+fB8J21gAGuvstFzAZAgCE87y+7SHFnIIsvbEYYqR1jgJn1f93+AxD67k2g2+v8cPTZRxClk/aum2ENT79NNCqtvGaJDEtz3lzw5ECXJxhekyny5zYhctjZHI21GSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024068; c=relaxed/simple;
	bh=ldH7pRzrAo36eX2sXr7TZBqNdm9QeHPB/CJSrJctR1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5QdGsHhbjIs0z7RQILfAdw/uiEZVDgbwGKjJo+GMLRalUK7e5wz1AfhrxuKf06Cvajo3WApSqyiZpmf1hmq9XsBFhUrs0PypMm4p4V40i0aEMkB3zwyoIfHgRmtBBmMsCNEtIfnT/N6XXSZYrpFBDNbdkSidNvpyC5z3VggkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OBT17WO1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OBT17WO1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2956d816c10so6321005ad.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 00:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024066; x=1763628866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPh7ilOkJcTxNjuYqTovUMBkJNBd0ZFj5iFNSZBggZc=;
        b=OBT17WO10C2XCNHg66/2dDbK+GzYwoCrlI/8jGjV5MAIKBDNW+ND4LBETe3Ya4YJfs
         qPH/hF10J4rSAvLmzAz8sVY+IVXahAfDpH4p9OzCOSHBWqzrEp0NT60V6ELR8/7VT94P
         dqIyaDUwLwypXoiRtTumvGzowfnB4qqbw7FyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024066; x=1763628866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPh7ilOkJcTxNjuYqTovUMBkJNBd0ZFj5iFNSZBggZc=;
        b=CZ8qy5y/I1rqJR+PJVZJRfGq4bmy03E0GiYWUT77XhvW+NCG9w5vhY6CT/De2S3tKX
         b5pV+f2F0nLY+q6bMkuTXG1uXih1CJVPAV/R0iRk+xPdufuPN2M0eqGEmKbaG6mILDpr
         Wq2DENSHsk6XONCBCkfBuDUYNF3i5VI3KbJZnKw5bvNQA1ZEzWaSzQTyRgHGQqJvhEV3
         XafD4fv82B2tG7MYo8fGamVKJZiAeII3a3gCt94CNLCxDa6wtJy2uKRGKK0W/Dpoj1PA
         1uYYKAzoN0Yp+P/KY/3YhhwpQhg4kdWylimQmJhd/dc0jxK/MRNc7LuOtADAjmS6/UIz
         qgoA==
X-Forwarded-Encrypted: i=1; AJvYcCVfXp1xKtVZzzm3ISqZ1LlIgow8Fp0PAULGRwz8E2vX9wevXxmOn51lpPmPVtbL4UR2yr38Ve1L/aVmPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8qEI04QFUmEgy74N7DF9KwQap3L2ZnM0NQBNDZaRvW+uxA0t
	P1ChvW1wM5ql1/W2/SA85815Z/fi4mt1vmSEAisw0Ii4SRVaymsCuxSYTLw3ZmzmSA==
X-Gm-Gg: ASbGncs/FbDWp5psN81ZOeOeZqJrQP5SV2qeTHgLHLU4uokIEVTDrtEVV3LAtTCJjoM
	tqj9FELxHqVngdfysMQQ4ZpFB3MYZESezSy9NOmX+i1pTJpO/WqtbQ7cgPZ5ZXuDH3pIioOCtBA
	4v7227fQLy55v7Ta3TyyTkmEeAHT9HGrJmM/w8FLQ2cB7+5Bki8RdFUHi89IvEhU1qiH5ri1nJb
	c/oK2CV7vxYKBly+6W8n1LR/4k2EOi3ggqcDMlQW7T+KOjzhQt8Ts4vZrJ1F4rQgxBhVJlhVxf8
	9Qej1m+b16jJ26xGpv27pMkoQAtyEwiqugIZwc/EQHPk0e5Dm6C82jR+BZSKLB152HM/lKobyN2
	Fo43hba8pw9iVgDP3Oud5bvspxCyLYcMv0Dx23iHbQ3VpWHhSUShlB+84Vo7ziiODy2d4yck/lZ
	kRD/YtN+3aUCt92PMjDoClxs41chWfaQ/jrzwMXw==
X-Google-Smtp-Source: AGHT+IHDznvOsg6P+PZ5zeENKccT9BP5vgmm7k+qpOBrv2DZh+4wB1td4Wp2IINZJb4BaEgtt31Ibw==
X-Received: by 2002:a17:903:13c6:b0:295:4d50:aab6 with SMTP id d9443c01a7336-2984ed92f90mr78132405ad.18.1763024066402;
        Thu, 13 Nov 2025 00:54:26 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:25 -0800 (PST)
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
Subject: [PATCHv2 2/4] zram: add writeback batch size device attr
Date: Thu, 13 Nov 2025 17:54:00 +0900
Message-ID: <20251113085402.1811522-3-senozhatsky@chromium.org>
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

Introduce writeback_batch_size device attribute so that
the maximum number of in-flight writeback bio requests
can be configured at run-time per-device.  This essentially
enables batched bio writeback.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 48 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a0a939fd9d31..238b997f6891 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,6 +570,42 @@ static ssize_t writeback_limit_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
+static ssize_t writeback_batch_size_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtouint(buf, 10, &val))
+		return ret;
+
+	if (!val)
+		val = 1;
+
+	down_read(&zram->init_lock);
+	zram->wb_batch_size = val;
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t writeback_batch_size_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	u32 val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->wb_batch_size;
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
 static void reset_bdev(struct zram *zram)
 {
 	if (!zram->backing_dev)
@@ -776,10 +812,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 	kfree(wb_ctl);
 }
 
-/* XXX: should be a per-device sysfs attr */
-#define ZRAM_WB_REQ_CNT 1
-
-static struct zram_wb_ctl *init_wb_ctl(void)
+static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 {
 	struct zram_wb_ctl *wb_ctl;
 	int i;
@@ -793,7 +826,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_completion(&wb_ctl->done);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1182,7 +1215,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2823,6 +2856,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2844,6 +2878,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2905,6 +2940,7 @@ static int zram_add(void)
 
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_batch_size = 1;
 	spin_lock_init(&zram->wb_limit_lock);
 #endif
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..1a647f42c1a4 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -129,6 +129,7 @@ struct zram {
 	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
+	u32 wb_batch_size;
 	u64 bd_wb_limit;
 	struct block_device *bdev;
 	unsigned long *bitmap;
-- 
2.51.2.1041.gc1ab5b90ca-goog

