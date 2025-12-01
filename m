Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245B30216C
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582499; cv=none; b=RVd6m0+TOhxFq8wgCaPcjLvrXu4aRnDpOueO8ToGXxrEjzuWAYqgbQprdrXZj5TltK3K4x/rVCEgbnkE72u9sRH/VD39Tv6nRlbwgJoA/dns41tjc6LmSNIer0j3i/ubvtnXH2N49TateltA/tUS1cji+264FK38N1S+80Y0ENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582499; c=relaxed/simple;
	bh=+u6s6RCpy6sbmxn7iBizLf84Ie3MOO3BbWEG6PneCSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoX7OpeWunJzNKYhFeOu0NIU5rCbRkTiE9wt25TyLnKrYchVu3k2irvCX50etG82RD+B0KFaooupFB98rqyM1M2QvxazatqFuuP5/PdF1feJBTldZgXzlVFXI0f/dNzjynogMTv0+7pqtZYj6h6Z/OSQ00bjSBpVKSp+lt4OXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kFQ87Ki+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFQ87Ki+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso6322410b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764582496; x=1765187296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFPCMT/DEG4vuNOqo+8qbFXraYHdGAlN+ITtNxeLbtw=;
        b=kFQ87Ki+taeoI5yC5k3YX+1oGLEEUTmAE9aYdH7+dKkC4FcW8HSJNZd2c5LmYI5uwN
         VS3bV1Y/1mK20Qn1p+9S+9x8rwYO32BTowy4lX0AmgSllhTMYogoPhDy+xhaKxLunbRN
         6orgX12vA7zZtd7D0c9747TJlufSZ4aHunWAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582496; x=1765187296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFPCMT/DEG4vuNOqo+8qbFXraYHdGAlN+ITtNxeLbtw=;
        b=ZgEOgwic+px31okbBO9v5+YK38kdB8hNAiv7PO+CDbke/RIejkvFYJWGzNd3WdKMxb
         eLZEJoRQkzKsax18eftZjn+6E7xsC7+Dfsza+spLZKiC/0SQlld9gs36yMqE6S27Jf1P
         Gci79t6hIBdbQ+bKyVJsoNW+Mlugj4GWXKjsV2gwi14c8mJxxnWRyNuEStxT41jKIfFA
         Vfz19RXNOrApaPfOWQzUA1axRzYXACdws+P+fsrAZS3h/Z5FHK5h5Tis/DIiRwUhwnKQ
         aenfXSOXkkPEfSEwlaJ1IQs49NGryZ0GJ9CZfTAEt+caIzIeFs2758545dqw8NtS517D
         tAUg==
X-Forwarded-Encrypted: i=1; AJvYcCXmF+BLXlUrDy0P2T95ALvnWySSz4R6s7bOxCx/iwV8iYHcygtr4hcyH6QxhePjCg2nVKIQyRWnFwJ+GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeb8SApMaIBmf6T5rGaKMs7VvBupMA0lELNrE/EaCMU6jfgs9
	3V1e80kXXCpkOkF4IrPBQlOkMEY/dXsMTIFuL/9+sYgYLu0s27IQ4RBm8sRf+QBrag==
X-Gm-Gg: ASbGncsDlGZ3TeAjV6NM0Vw/I+RchivYXzh318gvgS0FMPkWcScMLrbhvQVpqx0yiYi
	9p1FMIFdQ2Bf4h9uZMgHz73kUaxKz5dRQRO7Y1fUKx/hlDXdTdGUCwrXcNm3J7kA5RA8dXERgum
	EXjdhHide1uvgndFyp/J7h+fg2U083QCQVD6f1C0h4wYErOnRGuqvQeUC0ddQQrS9EDdbbg/lo9
	Pk9h1pA5sH+9zEwwVCXl31SxEnO4dg/H+uZnXfDhucKQR7VfKpeQl15IRQCqA+BjYh6ZsJkUrk5
	RKwhXSEANnA6VZKGwG2tLsQfag74pZjWonb6T+yLjw7jNVehmqPZ7odX40XSW8/ZAGRFK2coccj
	ATBDZq9bj4j5RuXVYe6aSZVasj+ttk8y38iH6XzvKM4GKLQSfHVHvoFo9sgoVAxudSA9qM3V8VM
	1586ZhM5PyGvEOzsbKSgG6yAEzVI3/dQLJ39wQq449EjJ8QaBQP69hjfugKFfy0vH/NEtuhd0/e
	A==
X-Google-Smtp-Source: AGHT+IFlrnHAUO0MwvM1aa8kkuCDrVgQUWK4lsCQPDK031ojL9Sillo7MDoVjBI+gYL8H8kP47VqCA==
X-Received: by 2002:a05:6a00:4b4d:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-7ca89a6c1d3mr23814778b3a.27.1764582496654;
        Mon, 01 Dec 2025 01:48:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db577sm12882074b3a.31.2025.12.01.01.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:48:16 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/7] zram: move bd_stat to writeback section
Date: Mon,  1 Dec 2025 18:47:51 +0900
Message-ID: <20251201094754.4149975-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251201094754.4149975-1-senozhatsky@chromium.org>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move bd_stat function and attribute declaration to
existing CONFIG_WRITEBACK ifdef-sections.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 48 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3cc03c3f7389..1a0f550219b1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -539,6 +539,24 @@ struct zram_rb_req {
 	u32 index;
 };
 
+#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
+static ssize_t bd_stat_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret;
+
+	down_read(&zram->init_lock);
+	ret = sysfs_emit(buf,
+			 "%8llu %8llu %8llu\n",
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+
 static ssize_t writeback_compressed_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t len)
@@ -1976,28 +1994,8 @@ static ssize_t mm_stat_show(struct device *dev,
 	return ret;
 }
 
-#ifdef CONFIG_ZRAM_WRITEBACK
-#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
-static ssize_t bd_stat_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct zram *zram = dev_to_zram(dev);
-	ssize_t ret;
-
-	down_read(&zram->init_lock);
-	ret = sysfs_emit(buf,
-			"%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
-	up_read(&zram->init_lock);
-
-	return ret;
-}
-#endif
-
 static ssize_t debug_stat_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	int version = 1;
 	struct zram *zram = dev_to_zram(dev);
@@ -2015,9 +2013,6 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
-#ifdef CONFIG_ZRAM_WRITEBACK
-static DEVICE_ATTR_RO(bd_stat);
-#endif
 static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -3079,6 +3074,7 @@ static DEVICE_ATTR_WO(mem_used_max);
 static DEVICE_ATTR_WO(idle);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
+static DEVICE_ATTR_RO(bd_stat);
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
@@ -3102,6 +3098,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_idle.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
+	&dev_attr_bd_stat.attr,
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
@@ -3111,9 +3108,6 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
-#ifdef CONFIG_ZRAM_WRITEBACK
-	&dev_attr_bd_stat.attr,
-#endif
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
-- 
2.52.0.487.g5c8c507ade-goog

