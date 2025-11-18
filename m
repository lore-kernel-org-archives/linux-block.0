Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCC30277E
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451021; cv=none; b=hLnCBKRNbVbjKguSz3FlpHTfAICnGj69hcpsuHR1kYXICi0ZeGyOCFMpzoCYuX9w1tFXjdJMrMnqr7mcWi5ER7go9pMSTyAdbpweM4KeT/k1fMMPbmNYOlZkFEeXM2RY60UlipelID9BeaT7cCrHnoy6CzYMzbvXxIgopqI177I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451021; c=relaxed/simple;
	bh=w/1Ykm2PaEu512nWzHzi9guwWnDK5t0d+FGYYp2oDdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czug50GvjKW1DRVV8Jy+uqTZf2tbisj9kdwySolMTVGhP1S/x/qr2pZ9KXIgme5Gc2Y2NOkxtcfBVwQqS/tnsk8P8pj5P+/q1BVBDpolscsXTgaL58BhGQZrU8JbAq7huK6gLO+4Z0Ua3RyRJbAikqjSe5wcRUdBX7hePLqUJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=deCx3Mch; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="deCx3Mch"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2957850c63bso53440995ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451019; x=1764055819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVrPRt4Q28dKav7HserS19FijFvKacb/VGjhgi5CQXo=;
        b=deCx3MchO7mgYrDZI1mhAcIrSoKdpGiTran1spccuunGKD9iSdoTbgmlno+FCpM867
         bl4dwK5Dfou2HzR5nxcFJjK25DbM1SkqAHDsTfz7+E9bDF/SaxzAP81AjTBcDV0oRe19
         CWxrZ0QjxhuekPPBXNrxB0KTDIlC0yU0S1mTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451019; x=1764055819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVrPRt4Q28dKav7HserS19FijFvKacb/VGjhgi5CQXo=;
        b=G/UjN9Hrg0K9nYxGiXmzCvU8kuD7aCDoWfGsViarKNHqZ+d5OcW/xOoNgN55Hg2dtz
         26TbwoQVd4XlER82h3vbJYf1MfjCpGOHflWnagICkJPK0E6GuatCxSl/8GqF+owOThO5
         ipt+MF8EVyLYNcva23FZSrA/NimbuKOwMN9v1nHWK0fDNKe0yWGsN7hDLA13vf9XwmCJ
         kOawKNjhyq6a9/4o9onVSGBm1Nzw4KxCuAitnu1ZMuDf55kqy9FiVgfowNWJwtqjz8I2
         PNJhH7uGY31IuSysBvp1/JZrMs8C2LEemA884suRalz48FlT3e8xu01AWOTVFG3s6ErE
         tJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUmduU6Ytz8cO5pff1HV2DebIqrnN0Ww0chxzaopxf63dlSNh5EMFi3SlY+hhhpQ/n1kdGALssfXv/vrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3f1JugP3AgLp/GCf0RcywsS6C+O6m+dQsWzGaJ8bMdqvzNgq0
	Fft4mMMQYy3QrZUcn9q8A5sRmdR5XVK9SlspeFcYWyZSsSVLPmSup48tgI1yeWSv4Q==
X-Gm-Gg: ASbGncsm8afCE6l6rasMrFBWFi4sk4SK3KpgETBmr9ja5pR7xAa11Kxtx2Vhu8h7Vh6
	qNgEgZGjuCv1/VOLjr9wdNsLCijBjnwjLisDKDmOFjZBTq2MvavaQ6T33aYNaAfbkokihUKK9WH
	HYnfBinApwLMBvEsH6rR8SjhMVy5ccUINOuxHLeB0172zLQz0H42osaAWQ6vmdCoYOr+NOIC/NC
	WYR2Yp7pLv/rB62BQ7EIohjEC7axrSiD3sx340vg6G6j6rX6ERCkcNyzt0lkH6/Tiyd1HLcyBrA
	ZHo9/VlopenT5pgtec6W95kgENLpTf2xb3NesJgSb0pCC7xylTrM5a43E3rleizzCCouC/YFr9y
	r0pq+fm1kbnmEg6vlc+m8VRXMYOgiM/rj1RhI/ekWpmYj1bKQbN05giN0uaByrCba9i7l3AXbCK
	raNWMlrATC64EO4HdVJ8FjNd176JWnbir+t7178g==
X-Google-Smtp-Source: AGHT+IH8beW/w0lcFBPafVCSixbqD2wiZbB5SYmhJXK7ukSZHGhJTLatf743/ai6p9Zl//4nec99vQ==
X-Received: by 2002:a17:903:38c7:b0:299:dc97:a694 with SMTP id d9443c01a7336-299f55a1d97mr25472885ad.24.1763451018460;
        Mon, 17 Nov 2025 23:30:18 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:18 -0800 (PST)
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
Subject: [PATCHv4 2/6] zram: add writeback batch size device attr
Date: Tue, 18 Nov 2025 16:29:56 +0900
Message-ID: <20251118073000.1928107-3-senozhatsky@chromium.org>
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
index ea06f4d7b623..be39fe04b9b1 100644
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
@@ -775,10 +811,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
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
@@ -792,7 +825,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_completion(&wb_ctl->done);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1183,7 +1216,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2826,6 +2859,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2847,6 +2881,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2908,6 +2943,7 @@ static int zram_add(void)
 
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

