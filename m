Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A92FE568
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010615; cv=none; b=pXJauwAA6lSRzutOW5Dezqli6peJSPkJh+RQzIkFgDq4ChfM9xxuzGHTzwFzojyhsiBE4NwsDiPVu7QP6s7S80L2WVa29xtyHfWS9mIybP0OYrxVpA5Ubr/YBSdldBY/dQwF4HLq/aYHjjwfrfqmUMTLQON6uP3Dno1duAYNQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010615; c=relaxed/simple;
	bh=cMx4qen1C9cTMSARxh2QYlJlXXgdR4BaF7yclib3aXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4nOp7DEi05lP0C9eRAC2Bv89TGVnTW+b0c+ble/kQN3ULrAOlMcnCIYzfL0O/gQzKPILrRWr7N3soVe2PxgBWR6E643Hm5PQdJP3TbJUme9W2Rv+Yl8gkZDT4Rqq8+/K1sKszZ2acTFwphAgxKyaTDGSO64WNvnKOBSVnGN0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6+jjynw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6+jjynw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2957850c63bso4081335ad.0
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763010613; x=1763615413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQMe04Yi7xRdtm756UdrAtfkVrI3s7FJjDivoW7Ul4k=;
        b=j6+jjynwqgDyrbdE6uHsFWQoXLsY0dXHLaCShP9kEZQzUAroEwXURRZdgUAMfX6S8+
         ePhznHm78xeAhfNzIDiCOJe9r00XbikWtZxWQ4pJnCqF97SYmzeNK0nleHbSPIr+HpL/
         2FUXHDA8bPDMWLXSh6GdQY0uxPTPrGm7Dt5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763010613; x=1763615413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQMe04Yi7xRdtm756UdrAtfkVrI3s7FJjDivoW7Ul4k=;
        b=UptXPWy3MgY8LbpJ4uxhR36r/qQJkZX2UkOOK7fVM/m1xic6mzC5t5nozozfvgycqG
         i6q3Fw9b1KDBxxMGBhMEBsUJ2GjmJboOTsIvpNfuxqvq/D/m7xEXhHltU40z6NlpvRTj
         k+96jri36N+MH9vXMXa61zWOA/5Deg3RaXE5XsDqu2NBKE7ZQVmKLx0G0PI8MSeGQezX
         t2J5cwpRMf8EQrzgO4XLuoU6LY6XFHclksGSNExXRSIFRR9UmgTZdKti2sbp/AyL/i7i
         hprkO6e9i8IJCSg8N8EO+9QxujzO/tQ0gGsfd7Q3aADBLGljuvPETt53hmJMQiSJ98g4
         EZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAlSAm1t/Ni3uQdQE6d2nFsWiH9d7JxKPBv4p/GMWdDvSPBp3NfLx/VIoCKrKp+479S6ozNlLFO8FYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55ypJc7eRuSaaJkcFZoUjelwVKziuO2zV8wwViTO8BHZsziKH
	mqyrqQlNRAYKpVyCMVHqFqYUV+2HfUebTHwZUzigbJdMRRVsy60NHpmIpLXIaqa4Ig==
X-Gm-Gg: ASbGncsMNEtCh4t4xHgbQpTnra0tusLNG1lCVhP4+YKymn1prk2FnXGCk/isElcfz4I
	IEQcGnd7mMs3TNc0iVpQdTVrfHHpUqkdYMLpHhT+OtthRdmzGU22PCcuNbUBeM7A8cwxpyqLPl9
	hssJsBpR6L/TdTdXsr9CvD8i7ZZH50IrvCGKW+XOTUlT+vFhAyXI4YX/kNak2UsYjw42u2p76Rk
	UMNVX+olQnnq+hQ5R1jfO84qqOTM4T3VJTSNte1ggB1u0JSU94aAJKL5GZTZTK8xii0gy5mLvuC
	2hXTqErg852a4qVfQT6FodWjebuqSIUkC2Ry+wbfIM+Ue+SGrwxhIHkQDUmA+xF1mF8BcShnHcT
	2LFViDIq2I6imITvBbVPwGHQB5Sgdngc4HQ4JXyJxTNDqRu8VMFu/vj+kHi0LY0XhSQHx2eT+AD
	TLdwyB
X-Google-Smtp-Source: AGHT+IFaLW8GEDBcsoapOHe3wZi+rPMM3f3HSMv0BD1FRNhd+sUeimcHYmWoETvZ4VyiSFWPGjfTLA==
X-Received: by 2002:a17:902:ce07:b0:24b:1585:6350 with SMTP id d9443c01a7336-2985a4dd2b8mr29219475ad.11.1763010613390;
        Wed, 12 Nov 2025 21:10:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm9713465ad.18.2025.11.12.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:10:12 -0800 (PST)
Date: Thu, 13 Nov 2025 14:10:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <mc5ww2wi6islokdc4kwu2pw4a7l5ufwigsfw4b626okq5uk2ic@f5x2otsnarws>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
 <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>

On (25/11/13 11:04), Sergey Senozhatsky wrote:
> On (25/11/06 09:49), Yuwen Chen wrote:
> > +
> > +#define ZRAM_WB_REQ_CNT (32)
> > +
> 
> How was this number chosen?  Did you try lower/higher values?
> I think we might want this to be runtime tunable via sysfs, e.g.
> writeback_batch_size attr, with min value of 1.

So I think something like this should work:

---
 drivers/block/zram/zram_drv.c | 50 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 10b6e57603a0..cf92d4e8ca9b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,6 +570,44 @@ static ssize_t writeback_limit_show(struct device *dev,
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
+	spin_lock(&zram->wb_limit_lock);
+	val = zram->wb_batch_size;
+	spin_unlock(&zram->wb_limit_lock);
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
 static void reset_bdev(struct zram *zram)
 {
 	if (!zram->backing_dev)
@@ -776,10 +814,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 	kfree(wb_ctl);
 }
 
-/* should be a module param */
-#define ZRAM_WB_REQ_CNT (32)
-
-static struct zram_wb_ctl *init_wb_ctl(void)
+static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 {
 	struct zram_wb_ctl *wb_ctl;
 	int i;
@@ -793,7 +828,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_completion(&wb_ctl->done);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		req = kmalloc(sizeof(*req), GFP_KERNEL);
@@ -1145,7 +1180,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2786,6 +2821,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2807,6 +2843,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2868,6 +2905,7 @@ static int zram_add(void)
 
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
