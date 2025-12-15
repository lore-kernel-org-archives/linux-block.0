Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B723816C
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765777655; cv=none; b=WUF6yZNvlfax9/s9gLmFjsVuPKejtDtRv6ngnic1vygPQQzi3G59aEK+LtdiExoLhQegFeEwvycI+zJMd+rBRlMD7b/shbqaPzqnw72haDN3OFCSUhgLG/nBzuTVyqF+OewY5JkVNVdWR47dY1NMu/omWXsJlHH4TLNLC8TA5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765777655; c=relaxed/simple;
	bh=0Wgl08X9hh9HTm14kWLCUhGJf30BWwjSIYurF9BVHb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE75NtgeUbe8+nIKhAa1ZjoPCOZJiAsCAcgRT3we1VMAxHvCZx2fn9Su05tMibNnL31WzimYJHHZmWoDlwQFHHAXVuyz7GZv1JZxyWKaFaMReo7S2BQqA871HQaONY6qaMgBk651/PVO60gG6qwZgd2soWO2VQusANvO1s5qJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MdOH9ulz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MdOH9ulz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a081c163b0so17934285ad.0
        for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 21:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765777653; x=1766382453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IonsJ3LbB8AUdyCVRgel7KA7biBiZzI5NrUoHUACON4=;
        b=MdOH9ulzkSUCHka3L1MBilWox7YLV0FSONXo5atBOPConZe3LZHzZ7dfH6RkhflCGp
         +yJ7yMtds+ZXXmzmv5wxh9GSh9F1+rsOFdLGMXbmqV4QpxgrCYWVuRATMeObOXpPY5W0
         3erfg8LBuxfQHoX96mfT5xolAMWmtNqMqrEuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765777653; x=1766382453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IonsJ3LbB8AUdyCVRgel7KA7biBiZzI5NrUoHUACON4=;
        b=MP3gYmjAaOqUcX5SlOBt+3qAzQo2bpcl4JiIaNtVnN8+kjF1rdoFzJafKSBI/ZQ/79
         FDeivU3x3SdNmmwPfo7yp5Vddwm/38XhSVL1OVZXDyYEfKLNsBDTEFha20wKy58NJCgv
         ZvERq1BrH7mi9dR+mKEcVUq62dnoqIHT96lTnKargNg9C7rAXXzWDCrRqeBpo2/N/4aC
         Pk67WFLRsuissY0iEbeVWEtHVC3+CbYmDSi8rq6GJRrzrsHpM5M5kwkqBzYXRwm+KIic
         hf78csbsrkI1tXTnPdjoXJmikbFOV7UI1d3TJTqo6qbRgCnvUWwsGSSRH3IVRAOBpex8
         OAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlbBbqZBOtycG/pSSzo90KQNuJJP+qFEP59Frq7W9KP87um8t7kimmf3kYinO0I7Yg+NWJx2qx2xj32A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIXCwUzLXOvOxeqc1pm0u3TkR+4392US4LCGh5K+z8TUmNPJz
	LF3rYhHDWl51KcYcAmSYngPJshn+WkIS4f+9YQjmjtUGWujEUJbXv5ZAUQE8e42uqg==
X-Gm-Gg: AY/fxX4JVaze+A9XEDCj2KG0PKDdPrigZfeSf/FI3HdpyY5G/BLxydkfSQJL5aOiLRY
	aQVMi0vliTB1Dc+W1v+vCMKfbam0JwpVeD/PCLJFklrnsuF/F7Eld0u7Axuvy0frtK5D00FJrsJ
	V3hLQtfyfNlP5GR5q0pZ0336np9zGQYErpLS3uIybVpKHGxCxOq/xNbotVhOU0T6LTT5crWrNL1
	ZMNLVATjOw7P17zOp51b/atrS3k2v4AxVhUssIxXx/LYNgw9MieMDSi/vGSRLwkoIIE1S2odapF
	R34nE2VRmmxBLv2zsUEUstgnBEEvPYr5BLURs6GpMBY8X7pskqB+TKJsXvk/ejovtxmqZBg/jDn
	SftPUaiM5TxGqfdxaFyiRpV7m0LPFnsqDDvgBT/VC1vAVNOPnf4Ct9qs3L3vZlROU6rF6CNxgqv
	b4g5+DJPU6XpxuRPzVZcvg+i34SjMDHdtZoSWTUEy+ESBgUgChZNaZSNiLx0crjE/m5bKeD8dvg
	Q==
X-Google-Smtp-Source: AGHT+IGWzKWE4FxeG3w6tIQsZVaipTdv+2vkpll/N34qp/C6l7qnJ36dIs1SGAcaq63EU+SH6DLpqw==
X-Received: by 2002:a17:902:e94d:b0:295:6d30:e25f with SMTP id d9443c01a7336-29f243879d8mr94329765ad.53.1765777652755;
        Sun, 14 Dec 2025 21:47:32 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:88fa:c762:fe19:6db7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0bb39db53sm36391945ad.11.2025.12.14.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:47:32 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/3] zram: use u32 for entry ac_time tracking
Date: Mon, 15 Dec 2025 14:47:11 +0900
Message-ID: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can reduce sizeof(zram_table_entry) on 64-bit systems
by converting flags and ac_time to u32.  Entry flags fit
into u32, and for ac_time u32 gives us over a century of
entry lifespan (approx 136 years) which is plenty (zram
uses system boot time (seconds)).

In struct zram_table_entry we use bytes aliasing, because
bit-wait API (for slot lock) requires a whole unsigned
long word.

Suggested-by: David Stevens <stevensd@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 60 +++++++++++++++++------------------
 drivers/block/zram/zram_drv.h |  9 ++++--
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 67a9e7c005c3..65f99ff3e2e5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -81,7 +81,7 @@ static void zram_slot_lock_init(struct zram *zram, u32 index)
  */
 static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
 {
-	unsigned long *lock = &zram->table[index].flags;
+	unsigned long *lock = &zram->table[index].__lock;
 
 	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
 		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
@@ -94,7 +94,7 @@ static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	unsigned long *lock = &zram->table[index].flags;
+	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
 	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
@@ -103,7 +103,7 @@ static void zram_slot_lock(struct zram *zram, u32 index)
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	unsigned long *lock = &zram->table[index].flags;
+	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_release(slot_dep_map(zram, index), _RET_IP_);
 	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
@@ -130,34 +130,33 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 }
 
 static bool zram_test_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+			   enum zram_pageflags flag)
 {
-	return zram->table[index].flags & BIT(flag);
+	return zram->table[index].attr.flags & BIT(flag);
 }
 
 static void zram_set_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+			  enum zram_pageflags flag)
 {
-	zram->table[index].flags |= BIT(flag);
+	zram->table[index].attr.flags |= BIT(flag);
 }
 
 static void zram_clear_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+			    enum zram_pageflags flag)
 {
-	zram->table[index].flags &= ~BIT(flag);
+	zram->table[index].attr.flags &= ~BIT(flag);
 }
 
 static size_t zram_get_obj_size(struct zram *zram, u32 index)
 {
-	return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
+	return zram->table[index].attr.flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
 }
 
-static void zram_set_obj_size(struct zram *zram,
-					u32 index, size_t size)
+static void zram_set_obj_size(struct zram *zram, u32 index, size_t size)
 {
-	unsigned long flags = zram->table[index].flags >> ZRAM_FLAG_SHIFT;
+	unsigned long flags = zram->table[index].attr.flags >> ZRAM_FLAG_SHIFT;
 
-	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
+	zram->table[index].attr.flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
 static inline bool zram_allocated(struct zram *zram, u32 index)
@@ -208,14 +207,14 @@ static inline void zram_set_priority(struct zram *zram, u32 index, u32 prio)
 	 * Clear previous priority value first, in case if we recompress
 	 * further an already recompressed page
 	 */
-	zram->table[index].flags &= ~(ZRAM_COMP_PRIORITY_MASK <<
-				      ZRAM_COMP_PRIORITY_BIT1);
-	zram->table[index].flags |= (prio << ZRAM_COMP_PRIORITY_BIT1);
+	zram->table[index].attr.flags &= ~(ZRAM_COMP_PRIORITY_MASK <<
+					   ZRAM_COMP_PRIORITY_BIT1);
+	zram->table[index].attr.flags |= (prio << ZRAM_COMP_PRIORITY_BIT1);
 }
 
 static inline u32 zram_get_priority(struct zram *zram, u32 index)
 {
-	u32 prio = zram->table[index].flags >> ZRAM_COMP_PRIORITY_BIT1;
+	u32 prio = zram->table[index].attr.flags >> ZRAM_COMP_PRIORITY_BIT1;
 
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
@@ -225,7 +224,7 @@ static void zram_accessed(struct zram *zram, u32 index)
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-	zram->table[index].ac_time = ktime_get_boottime();
+	zram->table[index].attr.ac_time = (u32)ktime_get_boottime_seconds();
 #endif
 }
 
@@ -447,7 +446,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 		is_idle = !cutoff ||
-			ktime_after(cutoff, zram->table[index].ac_time);
+			ktime_after(cutoff, zram->table[index].attr.ac_time);
 #endif
 		if (is_idle)
 			zram_set_flag(zram, index, ZRAM_IDLE);
@@ -461,18 +460,19 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	ktime_t cutoff_time = 0;
+	ktime_t cutoff = 0;
 
 	if (!sysfs_streq(buf, "all")) {
 		/*
 		 * If it did not parse as 'all' try to treat it as an integer
 		 * when we have memory tracking enabled.
 		 */
-		u64 age_sec;
+		u32 age_sec;
 
-		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) && !kstrtoull(buf, 0, &age_sec))
-			cutoff_time = ktime_sub(ktime_get_boottime(),
-					ns_to_ktime(age_sec * NSEC_PER_SEC));
+		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
+		    !kstrtouint(buf, 0, &age_sec))
+			cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
+					   age_sec);
 		else
 			return -EINVAL;
 	}
@@ -482,10 +482,10 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	/*
-	 * A cutoff_time of 0 marks everything as idle, this is the
+	 * A cutoff of 0 marks everything as idle, this is the
 	 * "all" behavior.
 	 */
-	mark_idle(zram, cutoff_time);
+	mark_idle(zram, cutoff);
 	return len;
 }
 
@@ -1588,7 +1588,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		if (!zram_allocated(zram, index))
 			goto next;
 
-		ts = ktime_to_timespec64(zram->table[index].ac_time);
+		ts = ktime_to_timespec64(zram->table[index].attr.ac_time);
 		copied = snprintf(kbuf + written, count,
 			"%12zd %12lld.%06lu %c%c%c%c%c%c\n",
 			index, (s64)ts.tv_sec,
@@ -2013,7 +2013,7 @@ static void zram_slot_free(struct zram *zram, u32 index)
 	unsigned long handle;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-	zram->table[index].ac_time = 0;
+	zram->table[index].attr.ac_time = 0;
 #endif
 
 	zram_clear_flag(zram, index, ZRAM_IDLE);
@@ -3286,7 +3286,7 @@ static int __init zram_init(void)
 	struct zram_table_entry zram_te;
 	int ret;
 
-	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.flags) * 8);
+	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.attr.flags) * 8);
 
 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 72fdf66c78ab..48d6861c6647 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -65,10 +65,15 @@ enum zram_pageflags {
  */
 struct zram_table_entry {
 	unsigned long handle;
-	unsigned long flags;
+	union {
+		unsigned long __lock;
+		struct attr {
+			u32 flags;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-	ktime_t ac_time;
+			u32 ac_time;
 #endif
+		} attr;
+	};
 	struct lockdep_map dep_map;
 };
 
-- 
2.52.0.239.gd5f0c6e74e-goog

