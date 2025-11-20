Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828336C5A5
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652133; cv=none; b=J9t3xGCDnW7JaPYrrINuZyR49RJ8y/4dz4dGBu3bGGl48JzKGzhT4SSSnzPVzfSr65K+CXdb0E0rdmiy+q4fZdPbm3gIfbZRaXzIm4XWycKDpBYXC0qJsRXT8QMs1CtWgFa4h3uvrS9kRZ/ujtbOf1qM1ZABctKcK7uTZOuAl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652133; c=relaxed/simple;
	bh=QWWiZ4tHfeSo/6PGZPwYSUTo9cWJq/8Qx6JfMxUueJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IThddJrovOXtBgfFds+W0H3heGZFiWpvioXyMieNzBdbB/8VeCYqF8eMLiqMaOH3eR6joJC3po4arQF4tdd+Mz0LZH0s+KCSzYBENRpPqDmP1w2Awu/ztji1nCzPARMKEI8Q82ADgHGzbMfvmnJ1EzCrKNyru3RWpAp6Sp6pecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RWe0yvJM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWe0yvJM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555b384acso12265875ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652131; x=1764256931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAmKATgpNu/alXOGtuyOI3W/oFMTAwgOBJmF8/nzO6s=;
        b=RWe0yvJM4/Wq+vwCaQja9061Q+DPoK07YROLAfRCAjw19SO0s1SJ9U7WS8fBox8jQC
         lY4B3qu4qKVXAZuiF421G3ZE2RcDxWZTOrRw0d+vHIXtq2Zjoy4I8LGIDEO6oI+GA/TT
         jnxq8RkZYWscvyuC+SyZa3AeSFby59ALdTwXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652131; x=1764256931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAmKATgpNu/alXOGtuyOI3W/oFMTAwgOBJmF8/nzO6s=;
        b=V8jTZJ6fpsY+f1zU1GS0lH66xaN8BplNmzDVl87t5T7bg5/a40DMwTQiPauuHvRzFo
         z27oeTvPXZ7aPveyQrj6MuvuiTrniMkALJkaHrX+RmH4hJTzs6hkTp+5gzFbk86LqPCT
         eB8PhsdS1HvxSAb3qt6JSesAokHFw1CM3KyvyYZjj+IXcHsFeNtO/l7aPvtWQPj7B4bp
         sItqPBZSEKkgOco+aV3f7jOHhg6iKOe0Hk0qHa77wMx88qv84WWg9HQ6+nsTEy5wxEYX
         S3Hrkx8A3nOn+asgo39VoOOSRIJC5djRf9wZETTuAO4O/5RW/yxlAzEeIby425K8O19z
         KUyA==
X-Forwarded-Encrypted: i=1; AJvYcCWWayr273JPo15+Z32k72b39D9fO2yTNGJePCBjRf31AaMsCINUDEXU6Nv9Nsm39EOuNfwSq3eCzBvUXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVt3GSLicRehz8gcyWyoBUuC9P82oO0tk6y0DtKchc/LYVuoLn
	CHvfjnDwKDwHi8JmcaRhD6NvFdyx6NDyGK653LtLZySdL/CTBrYVmYbLSHJltCvCCw==
X-Gm-Gg: ASbGncuhHRYCL/ahe1xocgprrQlXVIHzMjk7/IVLjfWcYLBlebKYHEoLXIyQC6OeMXD
	UbT39sDd2u/1lPsaTp9lUxtVcl8J6V1nEIF/1yP0b+FYi0ie6LiJvyLSdJIC7SVAVdFglfZJlSP
	zsHSJbkCYqRyJs2aWl/8Ga5lqx9zCD36XlO0aDBH0F2CWTEAnFUzFwvtyPhZpjI/DAMN+UJ04zM
	7hQ3NY6u/YDDJJ5ZpsCTG4X+IGqggVqqmb4fAbqb8b1sLe9Rm2keNSaiU3FMhTDOzpyP/VKP77J
	oeM0SQCD5eHQYJYw9PGElKmYRW9SSi8FWxbBq5b0QU9bDH8Kq7dlWcuIEmpu9ozcWVG/U9pm83N
	nfYpxGUIWwGmrNwoXtr6w683b59Bp6W++PY2rvRq8ZQZELP6ElgCtQNx9BreMGi0O2khL0vliQe
	GVA+aJvDQ0dx7sxq0aqcvOdWfP3LzXL20tsJwHyg==
X-Google-Smtp-Source: AGHT+IGXx99ORaMc9c2Jm3Uyx2w4g0SNrUulESpO10c9NwCK4Ja79Nw8/lRM5g2x9jRJA1DHlD8CCA==
X-Received: by 2002:a17:90b:53c8:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-34727d5233emr3818884a91.34.1763652131431;
        Thu, 20 Nov 2025 07:22:11 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:11 -0800 (PST)
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
Subject: [RFC PATCHv5 2/6] zram: add writeback batch size device attr
Date: Fri, 21 Nov 2025 00:21:22 +0900
Message-ID: <20251120152126.3126298-3-senozhatsky@chromium.org>
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
index 37c1416ac902..7904159e9226 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -588,6 +588,42 @@ static ssize_t writeback_limit_show(struct device *dev,
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
@@ -779,10 +815,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
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
@@ -797,7 +830,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	init_waitqueue_head(&wb_ctl->done_wait);
 	spin_lock_init(&wb_ctl->done_lock);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1197,7 +1230,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2840,6 +2873,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2861,6 +2895,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2922,6 +2957,7 @@ static int zram_add(void)
 
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
2.52.0.rc1.455.g30608eb744-goog

