Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4F2D7388
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797255; cv=none; b=cRXI+AcuUN5xzzpetoQ26N+94cMjJqGMWOOWJjp/h6aILi3fMoUtE4g3XZpIdJi9C1WoQlbUSO5KKBNySpV+VSso/pCiTpei0onYr5WiJ8+2wxLg1ugtWDDo9KJ6Jw4IRN03q6Gpbof1kskbesJM90eRjz/yGRL9CCrg9bM5WYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797255; c=relaxed/simple;
	bh=RU7LKKkrOdPOazKvr9ZHQjeWATjBMgcJ+HOgz91KiKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSa3L4jTnIQejcEQuNvddceln2Ytp0PdosMyZDQNTDvuqTFjR6VTY9f9JXUvAdH+v7bQXKSzVMtEyU/HZWvQGkkN+mWvO3jDwYfmghjgnSRnkFBb7GS6PiMyx4OBRmdBRY1MFeaHYF69On855wY5FuNOjvAr0TTfv6+MgmP/EfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nmzPSXIT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nmzPSXIT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2981f9ce15cso32548065ad.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797253; x=1764402053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX4VpemLPNnHEK+as4wej/2Q8OupmjwjrzAvH21+biQ=;
        b=nmzPSXIT18UjzkozSVKR5CtqzZrUP3UHTdpPG4QL/sCbgCcdhoJUJuu+55Ef0MeFSd
         lE72bA9SWOD3riJam/qviTnRSLud2B3xJDaPlzlp0krUHI3iYZ15DRbmxRSpv9OvbZjt
         eSMZLfPsltdhjWGh/SETa3G8yPxvg0dV9KJxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797253; x=1764402053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SX4VpemLPNnHEK+as4wej/2Q8OupmjwjrzAvH21+biQ=;
        b=f+0mpu0mG0ZRlAik/ZKVd5cInjQSMfa4fRD5n419GKoh7UfhuorvWryl3CietKDW6U
         E1563xQnfbfewhbI3qhrBG73AVN/kv6kOvnu34ZRkEouFDXbyLwNwkf5ABNtn/SbOzb+
         B9udPlAM2Es6NZ+fqsFSQrkcL4dj4UNyBHW2nHnS2gsM9E8OvOTMaa/KqJyc8pZgLkKA
         jWSyeGcgfbAxWRw6/sh4c1c6SKaNjivgbUrGJiPFzc+3pjaPI6mSe8VpRkrS4bZVYWzq
         NX9xg1jtSyt7URDU7rAKCXn7m5qww3Qxwoc+jVYwGsmweNqz6Xd4lEawyDJNsmxkzxge
         5c0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuenMNbUGhyea6dNbSjqzLoCOdAyw6kBw3DzxohcjB046I3aCi9a2ZcyG+Bw6C9UDqrJ0RPRDXDG2+LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAOyYcZ4de+WrmrGroNW4mYeztI7+vOEqrBs++5ds3A4XIFY5
	5/1/536oJ8eaD8JAaYJKXM8sNztBnNRPi1fOp72VOmWQ3LHuXQyhIslAyRZCen/pzg==
X-Gm-Gg: ASbGncsNlV9PMZ1T4HZhZJsX6PESCTlTojLJTxW5FW4knf62ufsdZ1mMM8DFrIRLHT3
	8owHmq8YIsQVpYqnR9ZY+I+PZScngzvPtn4DMmcI4rP3+czaImOIp21ZV0kN0dH1tk5dsxwSJ17
	ikLvmXTA9rbwS/cPKrPmh2wK8jRMEp8vNfIVFnFlAXwl+RyOqq83DsoK3xPfgRgdiNYJrjvvtxs
	sUjFmt46BbKmOLQfxWbpwKcTjN7w+U2jdi4zDZhLfdPEa+GxDDYhJGN4Zhg1GtrszRjkaDYiJGK
	eWNvzJEUBd516fBw8JcLRNklFmTABQfp6VG+79PyUbEMDAD0X9Bv1XGsJ9WhPvgkZVWp5y1doS0
	wEkx70BoAmNgNIlPmocVBIOBpryJcNGEyaUSnb3nu9Ae6ge1nkAeo0Hm5oJheUG+W2KQXmGG0Kr
	C908mmhParF0lY5rCIrGWFncUnpr3RAGhK015TJfIfG2JBbBB5F/7dpfGz6MG5V3PDHOnM+GAiU
	pnH7o1ZmKZ0
X-Google-Smtp-Source: AGHT+IFnu2Sudoe6jxzn5HtnDaCFVbXUPGcH4YtmUDiSHkmwz2BuN3F8fTnfFOOCqEYv14rgm5x3cw==
X-Received: by 2002:a17:903:320a:b0:29a:5ce:b467 with SMTP id d9443c01a7336-29b6bf9e98amr65542735ad.54.1763797253269;
        Fri, 21 Nov 2025 23:40:53 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:40:52 -0800 (PST)
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
Subject: [PATCHv6 2/6] zram: add writeback batch size device attr
Date: Sat, 22 Nov 2025 16:40:25 +0900
Message-ID: <20251122074029.3948921-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 46 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06ea56f0a00f..5906ba061165 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -590,6 +590,40 @@ static ssize_t writeback_limit_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
+static ssize_t writeback_batch_size_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 val;
+
+	if (kstrtouint(buf, 10, &val))
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	down_write(&zram->init_lock);
+	zram->wb_batch_size = val;
+	up_write(&zram->init_lock);
+
+	return len;
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
@@ -781,10 +815,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 	kfree(wb_ctl);
 }
 
-/* XXX: should be a per-device sysfs attr */
-#define ZRAM_WB_REQ_CNT 32
-
-static struct zram_wb_ctl *init_wb_ctl(void)
+static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 {
 	struct zram_wb_ctl *wb_ctl;
 	int i;
@@ -799,7 +830,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	init_waitqueue_head(&wb_ctl->done_wait);
 	spin_lock_init(&wb_ctl->done_lock);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1200,7 +1231,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2843,6 +2874,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2864,6 +2896,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2925,6 +2958,7 @@ static int zram_add(void)
 
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_batch_size = 32;
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
2.52.0.460.gd25c4c69ec-goog

