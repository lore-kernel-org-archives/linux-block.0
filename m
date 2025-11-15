Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DB21B9E2
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174114; cv=none; b=GS9Vq5pKo+HvFshFpWWESpNQwy4KNfQ5eUhEru7x4mRzpuEtTx4skqz66f7m5XTt8Wjt93J9P+6crTMXDoxPY+y5jgB8w//OLdsz3mQ3a3vKkjeK3ppOv1DP31LF1JxkWVk9wQR5vn5ULi+u3AgpmHeAhw38n9AswUtmX46FT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174114; c=relaxed/simple;
	bh=0g8jpnw8n4tuMYaSz6purFL7v5+h4IGLV8N/LFNz/kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9/VZEj0AW/8omeew66HjXa7DbWpQoCmAFlevreKWJqHIVvUs8lHmEWf6PaFWV19b+eM0jC8RB7OSIjdz56WTB1BJKIHNvfXOl/pNc4Hd/8hThRDG32Vxps4aLst1KwXaH3tJtbfeLXgEkWyTZkyVjkdD3OmRfrOfN4Zq3Hxc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pwsc51FI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pwsc51FI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2953e415b27so24986885ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763174112; x=1763778912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOd9p1bhE9EtjpjaBLy8H5nHDKfUvKLk4XDOygNo1pE=;
        b=Pwsc51FIOYibm5MI7VtJNKU01+DRf1hwLlUjleSeyNFkHk6WjttX/JhMfdVM74pEm5
         13zsheWxRsIdIvaWAfj7qf0PWZHJNSMgf720XJ2gvZHoLlJFbifEjpFGAkNdMKKGy2xD
         q45bl/cis9f1bIAPv2LbeGcPSDJ9qPoBHMDNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174112; x=1763778912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOd9p1bhE9EtjpjaBLy8H5nHDKfUvKLk4XDOygNo1pE=;
        b=HhSECSJYNnrfvXh5Ud28tW//glCgDY3wLgSH6K3TcWicVZYH0MTpqSPEqfKqbouqVM
         iZP4fNPhgFYcksvYrNjSkGLA3BdjGXBhu+nx+wY/m4e9T3aLDWPbkE0BCTgpK3Ag3CxK
         T80ytFt40ElfCnxAqfTRib1KgvEQLFOOJ2JvS45hXpj9n7mz+TsuB22qxmp6mTnzCyYY
         QrOVEOA3/jOsrvfDBWZXDBdqGaxzWBxZgYRii8zu7bYF8WPjaiFytUDM3TYBtZCXBKaH
         Ygqqh3RAQjWOoL8IKzWhXGilTkSQ8dynDodAivNxOKov0iFTGNlRINjSXPv3VV2pyFpY
         RYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJNf2qGCbepJXAZre0+htdC4DBEFEhu7uN71YAquJDnK41vWLClgQrkxrO9z+6DyP5YTm02QzZSUxQFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww75U2GCIulelRp8B1whFzeLV2htYL1hba31Ry2nQ9O2W9/1/m
	HFgWiEQmRDdPCa1pNYWEAhWbWG7RXdblwle0+RcblPcHd+CsTEjf02odCJRKxqrBRVz0y8VskWd
	YRU8=
X-Gm-Gg: ASbGncsN8D3b2gpTaQ76AKrqQxr0Kqicdg+PptaQ6immh87qvM0Hlw9gDR4rf+YXN/O
	eM3l6rOtqEObF9fZjAmxFO924wkXLnOWaHH9hK4W6nzPaXQxCP02lgSS1ssjlv1p+7GDx2SZEnt
	TG7sZL7vINT9totnAHIlX3R0cTCRwLNH98Qy0EWoH/N/3ID9+WQdTpLxzX7Trs9aZb8NN5LmlrX
	/Hj3qzvBA7U6fHQ6lpNLbr137/KpTy8eUI6fsWIK9S/Q4kHl2BcEogfCkd1vzqvQEw5zphJPKpZ
	QRM6aKA/wr54bfIBtlg8T4Rk4Cyr1EFIoGaQ7SK3TC6p43zhO+5G9/JgWbl0v/gRAOvj2vTuMey
	7xETHznrMRBiDVz7MEXTNJdeVk5ErH/EuQFZ/8eUxlA/YZXUmnHmZ2UCu6rXwjAjFrDA6hb2s3h
	jAMy0E023bBZcYJEpdlXYLbTDuMGk=
X-Google-Smtp-Source: AGHT+IHzkpY6gZM/cY3aeRPppAXw311i5GjcubtsX0WPOoLgk2KhW+0UonihGhlFXEg97h5sI/EG9A==
X-Received: by 2002:a17:903:2f86:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2986a76b5b8mr60561225ad.58.1763174112371;
        Fri, 14 Nov 2025 18:35:12 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1088sm68641555ad.57.2025.11.14.18.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:35:12 -0800 (PST)
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
Subject: [PATCHv3 2/4] zram: add writeback batch size device attr
Date: Sat, 15 Nov 2025 11:34:45 +0900
Message-ID: <20251115023447.495417-3-senozhatsky@chromium.org>
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
index 84e72c3bb280..e6fecea2e3bf 100644
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
@@ -1180,7 +1213,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2821,6 +2854,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2842,6 +2876,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2903,6 +2938,7 @@ static int zram_add(void)
 
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

