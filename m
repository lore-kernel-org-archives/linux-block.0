Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347023EAB4
	for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440742; cv=none; b=Z8Li9HlLk4WHKntbT5HXTLKWIyYeQBCwESoRIKKDznlx1lpo5J98vEz5h3z+CynZ4p4yim4yNIiY29eHrLQ5X8gq2Q/Asrug8i5EqEWtZ+qzYUrcDpIIFegAsNuXaBMY+4fooYl1JclLtxatJWdLZI7Le3iW+Ac1vtpy/v6am1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440742; c=relaxed/simple;
	bh=Gp+VLR61Dl9CsyJ61qEVNObKOU3+x56JQIrKxWVLSgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1y5Ze+dB0gnLXMKByCw//APK3Ff4kJ0zt0m8aKatP5mu0EEwxELGuAI3wU+8nCIjKAh8GtUDwGGPnHaX9PwKTgz4cZZY0OyXmLHMZJWEYNZaKqSAQE/Bl0JPbNkuWn2GfNqeQk+AoIZQ9jhbWOhvE+tjlhfulcLZB9vXXpwyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZFgbfL/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZFgbfL/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so3815107b3a.2
        for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440740; x=1762045540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S45Vd5RIAYqg0q86pnKyuOv36CWTtcQIjH0J0fCtYok=;
        b=OZFgbfL/R16jY5xLMT6zm5P/ULKLCNNWRqrgwJxpIKscH+yCCCzlAPqvio2ehgfZZD
         SIbmtIngnPlVSttwEZqbjXxsqcj5hSx/63tmXRvzmfiW4MSlXsfV4wwvcRQKD0f8kMBy
         pVOAknVOhs7eIgBonKRPzPUcW2QK01VqF5aIcUzXDApQsbF1Ju4rge2OQIObntgMecRj
         ufYGXSwUrA8kTSxE9p9yEYwH9xXLDUUmVTPRn8OWaiOtVaMAsSIHB6m4EnAfPe+qVDWj
         smOHjBB+lQaw6OZwoLKfZgwru4/E2cnkNwXh/Ma8tXSjfKg6wKrlmuMWxyn0eV64Pksx
         8Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440740; x=1762045540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S45Vd5RIAYqg0q86pnKyuOv36CWTtcQIjH0J0fCtYok=;
        b=VZQSQsV4BCutkSm5UDHm4snv+Bdv9c/0itRNRBYPFOGR56pm6mw5gWIbTWLZz+R5IJ
         qeenXXcsq7Obl3+jseUjADKlbmrwwoj9mK5pS3Ygg6Ol6pfLnC/InbSfAMVodrORI2dj
         dhzN8nUGUeYKfkIKqzyrEEqNFBsZ2gWKFoNF5zfMX1pNG8iOaS+AKzxRiX/ghJjHzbMm
         6PS5ZYErwZtmQ/hN1RCojvOusBlhOq7JAdXLnxXE9tM0VCVkvB+J/MQJyRsKXhwQuuDN
         HcpjuhcwyXuMph+AR/zS9B2+UTzwzL+pMulHrNidzeuwom0wjhl5LsCMtoRBOiCWkHMO
         OlIg==
X-Forwarded-Encrypted: i=1; AJvYcCXcSFllQev5PNu6OnxSeWOaZvc6D6dydk9sQyIKOrF4kFS1b3TWEnByVK8biIvbtairm3CsVIdMMSfB7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2Mp7c7Ks/cPjXVrKKTSl8a2nwMzSLFtMloTcAhTwdcjKKJXy
	Ym/83l1ExGVK8e2eJv6RdqLbP9BEww2Wq003T0qY4zctGU+y8tFRb8Cw
X-Gm-Gg: ASbGncuKRNkMGCUTkom9431e8fuwLOs4U0bb7fI2wRGwpLcb3oKvtQ6M2R06d4tiGgp
	WAOuayVsVs4c8Z3xM1xTCqE/tw0CCcl2BPIgqs5IMi0wUfnipNu+mbvmsfHByXptX/MoQLELrFf
	HcCR71eSd3yzRZv2SzXtrJg6JdPDX3CVeVnv37qTaUHRd2erZrOnuFBp2HZ7k8bej8lYia6Usbp
	E5/NRmaAJ0m1fY1Zsba+UBruMb7fNLmtcynqGpZrIdhFAiiZ38u2qPrW+g1jNsWCAsipIp5ifmI
	cJT00FNvnuxDkfDLM7GDAJB62iq9VCKueae8PhafwJaabMl6HjtDcWSkSNJbSU4HLSrfTshfYNq
	77BtKxfc834fw+KV9TvrtzNIv+9vfFx4rKeJl2KItZghC6gm/GhSLVymDADFCmG8mei10T2QatX
	Klpzlqrc4yj1PWcR3CjaN2gNa6
X-Google-Smtp-Source: AGHT+IH3gaZfX15xSYXSXwe2kaT3c45YGp22P1ke9T0VYUHajdlPt4RUIsJeGLbWWKCn87o/Tq/dUg==
X-Received: by 2002:a05:6a20:3c8d:b0:2e5:c9ee:96fb with SMTP id adf61e73a8af0-334a8650396mr43445620637.59.1761440740211;
        Sat, 25 Oct 2025 18:05:40 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:39 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 2/3] zram: Zram supports per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:09 +0000
Message-ID: <0eef2265014bf9806eeaf5a00c9632958668c257.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows zram to get the per-cgroup compression priority,
enabling administrators to select different compression algorithms
for different cgroups.

The feature is enabled by:
echo 1 > /sys/block/zramX/per_cgroup_comp_enable.
---
 drivers/block/zram/zram_drv.c | 74 +++++++++++++++++++++++++++++++----
 drivers/block/zram/zram_drv.h |  2 +
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..da79034f2efa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
+#include <linux/memcontrol.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
@@ -1223,6 +1224,7 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 		kfree(zram->comp_algs[prio]);
 
 	zram->comp_algs[prio] = alg;
+	zram->comp_algs_flag |= (1 << prio);
 }
 
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
@@ -1396,7 +1398,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-static ssize_t recomp_algorithm_show(struct device *dev,
+static ssize_t multi_comp_algorithm_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
@@ -1405,7 +1407,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	u32 prio;
 
 	down_read(&zram->init_lock);
-	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
 
@@ -1416,7 +1418,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	return sz;
 }
 
-static ssize_t recomp_algorithm_store(struct device *dev,
+static ssize_t multi_comp_algorithm_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf,
 				      size_t len)
@@ -1450,12 +1452,43 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (!alg)
 		return -EINVAL;
 
-	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
+	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
 	ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
+
+static ssize_t per_cgroup_comp_enable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtoull(buf, 10, &val))
+		return ret;
+
+	down_read(&zram->init_lock);
+	zram->per_cgroup_comp_enable = val;
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t per_cgroup_comp_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	bool val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->per_cgroup_comp_enable;
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
 #endif
 
 static ssize_t compact_store(struct device *dev,
@@ -1840,9 +1873,30 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
+static inline bool is_comp_priority_valid(struct zram *zram, int prio)
+{
+	return zram->comp_algs_flag & (1 << prio);
+}
+
+static inline int get_comp_priority(struct zram *zram, struct page *page)
+{
+	int prio;
+
+	if (!zram->per_cgroup_comp_enable)
+		return ZRAM_PRIMARY_COMP;
+
+	prio = get_cgroup_comp_priority(page);
+	if (unlikely(!is_comp_priority_valid(zram, prio))) {
+		WARN_ON_ONCE(1);
+		return ZRAM_PRIMARY_COMP;
+	}
+	return prio;
+}
+
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
+	int prio;
 	unsigned long handle;
 	unsigned int comp_len;
 	void *mem;
@@ -1856,9 +1910,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+	prio = get_comp_priority(zram, page);
+	zstrm = zcomp_stream_get(zram->comps[prio]);
 	mem = kmap_local_page(page);
-	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
+	ret = zcomp_compress(zram->comps[prio], zstrm,
 			     mem, &comp_len);
 	kunmap_local(mem);
 
@@ -1894,6 +1949,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zram_free_page(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
+	zram_set_priority(zram, index, prio);
 	zram_slot_unlock(zram, index);
 
 	/* Update stats */
@@ -2612,7 +2668,8 @@ static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
-static DEVICE_ATTR_RW(recomp_algorithm);
+static DEVICE_ATTR_RW(multi_comp_algorithm);
+static DEVICE_ATTR_RW(per_cgroup_comp_enable);
 static DEVICE_ATTR_WO(recompress);
 #endif
 static DEVICE_ATTR_WO(algorithm_params);
@@ -2639,8 +2696,9 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
-	&dev_attr_recomp_algorithm.attr,
+	&dev_attr_multi_comp_algorithm.attr,
 	&dev_attr_recompress.attr,
+	&dev_attr_per_cgroup_comp_enable.attr,
 #endif
 	&dev_attr_algorithm_params.attr,
 	NULL,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..34ae0c3a9130 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -120,11 +120,13 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_COMPS];
+	u8 comp_algs_flag;
 	s8 num_active_comps;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by disk->open_mutex */
+	bool per_cgroup_comp_enable;
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
-- 
2.48.1

