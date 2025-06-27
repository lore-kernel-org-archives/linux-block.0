Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1149199FD0;
	Fri, 27 Jun 2025 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996407; cv=none; b=AVppFf8q53rE9MNOZdlCzR/E7x2SnX9RHOVcqVF+qa9gE/blSDLRzMsRmrn9J/FFwcPxzqIwKoDzIx92cVvMLC1PmGj33GUssq4Q14yPShROOVf8Bn507BId1Q8YTDMMoLufllqPeNo4xwjhSO7db0nidhBePizC06lT7krT9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996407; c=relaxed/simple;
	bh=Gk7kFiL+rrU52+4FUyQNDVBOPxsbEg3rY7ghxnKefLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+7nDTUVTDQqD379Tvrh6E73kVS3bO8BQRdeOH+697w059UttyUyiPJz+AJu61LM5fO32JLe7D41MUojPgoXb4yRcD/I6LGF7HasRlqf9t6INzto3bG3ax1aRxztl5C4Z8EoRgiPymsB5UBNCoczVgZiqd7e3BB1GMB4C7blwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg88jAFv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg88jAFv"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1588094b3a.2;
        Thu, 26 Jun 2025 20:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750996405; x=1751601205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K87WAvZZg6aBFOTATYCqslzfrGhe3K40+/UhVUBzSYs=;
        b=gg88jAFv9goRjpnWPAwym77hSQ+xzSnrMu/b9F9vEcT1c0OK0e3rIxFYvI/Yj9StaK
         9S0oUH/Vef031ZdED0lO9zMtb4uYKEqierit2MABZ+WMX2JdbewjcuJaaKnjxnpwkppf
         Y8er6Ay1g5JU7F5QqV9E7wV7q+b34mjPIJtA/nO340Vib8vxeb39SFPR2MkvUd7wZNO7
         VENkFrPakrxGdbYBnicPEpMydCIiKU4j9uHSxDRfryX4PIMOp93YQMrKyu5Gu7Zw6/O9
         ry52PbwF9zRfPHT4xXjrlVQqhl8ud43M9ySB1KEDxmfE6a7JHID0MIgtCr1JqeQva6un
         bsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750996405; x=1751601205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K87WAvZZg6aBFOTATYCqslzfrGhe3K40+/UhVUBzSYs=;
        b=dtzfn4rF6ca2NCZtMoEr3FtwiRl9X9tfzSDLpaBZzSa6D/gRTR6SvIyBLKUf11kozr
         +x0TrgyozfawnvwLGWqgkUf6bkY7ix4R3sTJA7e2l+FHAqJfV9Ilv98vo8mP1+7XTk+J
         vaMl57meN2q07tTjWcKM1a3JN4f202nEMVIES9qBjOOa1T2jfiSbVEnhp/bznU0IaTf4
         nGmJQ8egSmVUxLkGm1AOp0EwrTUIiIJTGtM0dSb4vmekSOX8Oqoja8T3PHHwCi0pRQLR
         5KH5fI3m63keqGkqEl8QN2twMXmPqjM0qLf5UMBUZ88hZI9g7lJygtpUa8r2PRYWhwWu
         WuJg==
X-Forwarded-Encrypted: i=1; AJvYcCVM2NLepRqd7C2T1hNEC1vPkeSaW/ECvI6m0UK2bEJ36hgq7iSClMABE0l8cNxUGi/gAIGecVs0+D59tic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/WYXTNFB1Qb50Scrs9uNI3iGHVAmXehJ4AORktK2DGLr2llT
	v6HiUz+H+DjLKBdT6NYW6QBbjsEszmAQ1zBE0dCPhu/SlRh4APT1vEdB
X-Gm-Gg: ASbGnctXkmLiWeESA3SpKJrUcmeVrbeTK2FxR++dg5Zw1r9GKJVq0Rlx0bgSEihGQO3
	SmOpPLHi+GUKxXzXV18uaclCysXdHR8+lfd1bMQ7OIGXhfWdP9Bi0gXl1ALr+Beb/pdDJ4wvorE
	9jjUDpztq4YkPiMzgD+KeeWrSqHjgwXhbVTHkt6Ww5tgnISKhB57BdO3VbgxJvmTQARJ5lwc9o4
	Jtt3BxE8FKcFQUgW0rBwqkqEArIkjh5XjXGyFt2muVhKVSdJTB4y2c9TgR3T1lZsws0mZhVe3UT
	D2+U/xxKG424iMNur1oZENl5CoWCvLjxLKqfvZH6dt0UKWjPHgSfyDmMwOxKGMbmG1nYBzdIAyh
	6
X-Google-Smtp-Source: AGHT+IF7R5hjRTDRDCQN9AaGEHThNKiPKHDQS9ya7XZS3RcjsRj8yG10vQFi6xfY9LoKiuNBh6EX2w==
X-Received: by 2002:aa7:88c9:0:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-74af6f7e449mr2262434b3a.17.1750996404849;
        Thu, 26 Jun 2025 20:53:24 -0700 (PDT)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b3bcsm1110713b3a.101.2025.06.26.20.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 20:53:24 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] block: zram: replace scnprintf() with sysfs_emit() in *_show() functions
Date: Fri, 27 Jun 2025 09:22:56 +0530
Message-ID: <20250627035256.1120740-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in sysfs
*_show() functions in zram_drv.c to follow the kernel's guidelines
from Documentation/filesystems/sysfs.rst.

This improves consistency, safety, and makes the code easier to
maintain and update in the future.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/block/zram/zram_drv.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..a1f2f45d4b99 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -373,7 +373,7 @@ static ssize_t initstate_show(struct device *dev,
 	val = init_done(zram);
 	up_read(&zram->init_lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t disksize_show(struct device *dev,
@@ -381,7 +381,7 @@ static ssize_t disksize_show(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+	return sysfs_emit(buf, "%llu\n", zram->disksize);
 }
 
 static ssize_t mem_limit_store(struct device *dev,
@@ -532,7 +532,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
@@ -567,7 +567,7 @@ static ssize_t writeback_limit_show(struct device *dev,
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static void reset_bdev(struct zram *zram)
@@ -1292,7 +1292,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 		if (!zram->comp_algs[prio])
 			continue;
 
-		sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2, "#%d: ", prio);
+		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
 		sz += __comp_algorithm_show(zram, prio, buf + sz);
 	}
 
@@ -1365,7 +1365,7 @@ static ssize_t io_stat_show(struct device *dev,
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
+	ret = sysfs_emit(buf,
 			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
@@ -1395,7 +1395,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	orig_size = atomic64_read(&zram->stats.pages_stored);
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
-	ret = scnprintf(buf, PAGE_SIZE,
+	ret = sysfs_emit(buf,
 			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
@@ -1420,8 +1420,8 @@ static ssize_t bd_stat_show(struct device *dev,
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-		"%8llu %8llu %8llu\n",
+	ret = sysfs_emit(buf,
+			"%8llu %8llu %8llu\n",
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
@@ -1439,7 +1439,7 @@ static ssize_t debug_stat_show(struct device *dev,
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
+	ret = sysfs_emit(buf,
 			"version: %d\n0 %8llu\n",
 			version,
 			(u64)atomic64_read(&zram->stats.miss_free));
@@ -2682,7 +2682,7 @@ static ssize_t hot_add_show(const struct class *class,
 
 	if (ret < 0)
 		return ret;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 /* This attribute must be set to 0400, so CLASS_ATTR_RO() can not be used */
 static struct class_attribute class_attr_hot_add =
-- 
2.43.0

