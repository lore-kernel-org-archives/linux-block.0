Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518B421F10
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459416; cv=none; b=XLdhnTJgNmxzLL8eqkIMaCKtphB81FMrkDjkyQtj+CTKtC04MfJWW+68zVAko5QFHgX+im0VjXtDTt2CyWpUPH5oqx0QfLZQ2YWUr8bjc6VhcqMFUACZXfiHMXE/om0zSp/mIlACQPteT5HX4y4/A+TD7wZ0ixH0CcGwbXfaCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459416; c=relaxed/simple;
	bh=omLfhd9P8ZMzbrFN/bvkQuKDPR19lEwO9vI8Cxa2iaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q6/zy9dmoP2XHa4Eik0BL0A3Z7UB/XGAj2raB7F+gpWMQz70IZOnqhHD7uDqZe9MvT9kopQ8Pa7v8fwL0AfxysKmc4jom+t570aolt9f9IYA/K02zmw+P2IrkbHeyRHfb4OGyU/uP5obzVbzCxhPrIbbRo8L6TaNvU61fC2eH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=CZyy77nX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="CZyy77nX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so3151658a12.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779459405; x=1780064205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sm5g6roIH5VbkZ70IevzPDKMpg3vptkkzH9aFt0FTL4=;
        b=CZyy77nX+uX1tOSiQRRcj58hEwJc4wF8fj1VwIcRp7FB9oeg3bRLKkMyJqQNnnUse+
         CB6ufwwhmKcmLx2OZQhXwzjRqyPjXrpWoDliVjWZ4c9ZNEiM10iTTZD73Acrj7x8CW2P
         Typ9dpCiuNjk1OmTTKpLlNnx168z9Bu9OSqTq3ixUpikJyK+/zcv2vacIESY7S4GaH7C
         GPyiFxBZGtaL3y9nJ7+XPwd5fB3TmfnD7L3HIE//rQUIonmQXQdgCtfa368iYXE6NR0v
         XEsRmxbDWUjRaMXaqW1LZzQL9dJ5Zc92pwGzV1dEMyIoE7OiiPJmQH9KP7BjxdFx6ybK
         gYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459405; x=1780064205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm5g6roIH5VbkZ70IevzPDKMpg3vptkkzH9aFt0FTL4=;
        b=KbhBdQx1S3JAofW9o9B3i2ncSiB4w1JOpq1XR5y9JO0Z8ZlGklzcAY4dya+Pi3enBX
         5UEIpBJgRpU4+itrsX7U9+yJJ3ODuWPsaHxvcMxnsroLpWNSpjnFrc7j844T19QFEGVr
         se2PZ/EQWfIUOT21j9KbLTQUeYkuU29Amhypo3YWgcDryn8BTaeMuTTS3x9RUW7bOslT
         GAJZJBfcHPv/Z/w3Lvhs5CYSWa259bdu+LdV5QhnomruYpCUSXlPogjBpByNCjaj0qaq
         EBismN0LeBi04+RNZkl4ZzDSPqBJEWw7+kVZJ6xlc4drRm/983w99N0ow4sAkBK7w5D1
         AbpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KXSwhdfKDhbIMmCcAxOYqkPLxGH8gGM1EMxsTc8VKxoXdBqdOOmmF/4ovGl2h0O6DU2NEV+CP6sJEFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwrB+uufc9X6u/6kDaIwTEwMWp6ZSB23S80YaN2vF/aFvb14j
	M9TOdNmfG0fR/OUi2Kg7A4LRC4WCWctpAFbzO/Z8KFSmENVR1lNJbgHvOllbz/RNk/4=
X-Gm-Gg: Acq92OHZul1c6y9rWUJdqyLtQq+2IBEHMq12l9yHla4oAjhpsl0m+YSIBkqIixvyqWx
	zQj6jrBluLmG++Gc3yYo+aZGoerxmxaP5zyTCe/WKCctos3HEMjqjMk6wF4x1sbZ3PmlyjszG0W
	VDs7IbSBm7DMkgNjKaOQajty3CNcVwopMgZOjlcCDJiABwEqQGiuXpKz12TjcYZMAbh/dqpp1cq
	cAEtrjYECzThPiLXKcR1aDnReP9AvDV4AcyoOIMlSMW77v9/rYUbS1D2DH8Aet0S87mpmbw9h98
	oXw8+tgBeC6uKyEVn88UMbhX9NJpknKwzb0TfwXQsdP0ER3XBiFh4BN342cc/6KtfBL8+Vfb6Xa
	rKeIT+Rr69ns7j72nRYUMmZRUKkVJuYZYrS2gBzUCSQrv5sp6yX1PAuhy6Rw8zPsqx8l56MxF8V
	GUPvnHHxJUho4IchdV2Kg=
X-Received: by 2002:a17:902:d4d1:b0:2bd:a5f:1d04 with SMTP id d9443c01a7336-2beb05bf787mr40573715ad.9.1779459404474;
        Fri, 22 May 2026 07:16:44 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a75sm28387505ad.14.2026.05.22.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:16:43 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH v5] block: propagate in_flight to whole disk on partition I/O
Date: Fri, 22 May 2026 22:16:38 +0800
Message-ID: <20260522141638.298530-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Now when I/O is submitted to a partition, the per-CPU in_flight[]
counter is incremented only on the partition's block_device, not on the
underlying whole disk. This leads to a problem which can be shown by a
fio test:

lsblk
  NAME     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
  mydev    252:1    0   20G  0 disk
  └─mydev1 259:0    0   10G  0 part

iostat -xp 1
  Device       r/s        rkB/s      ... aqu-sz   %util
  mydev    128153.00  512612.00      ...  13.22   72.20
  mydev1   128154.00  512616.00      ...  13.22  100.00

%util is different between mydev and mydev1, which is unexpected.

This is the cumulative effect of a series of patches. The root cause is
commit e016b78201a2 ("block: return just one value from part_in_flight"),
which deleted the branch in part_in_flight() that aggregated the whole-disk
in_flight count on top of the partition's. Then the second commit is
commit 10ec5e86f9b8 ("block: merge part_{inc,dev}_in_flight into their
only callers"), which folded the whole-disk in_flight accounting into
generic_start_io_acct() and generic_end_io_acct(). Those two helpers
were then removed by commit e722fff238bb ("block: remove
generic_{start,end}_io_acct"), and from that point on the whole disk's
in_flight is no longer accounted at all.

In update_io_ticks(), if calling bdev_count_inflight() finds that the
inflight value of the whole device is 0, the accumulation of io_ticks will
be skipped, causing the reported util% value to be underestimated.

Fix it by restoring the whole-disk in_flight accounting.

Fixes: e016b78201a2 ("block: return just one value from part_in_flight")
Suggested-by: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: Update commit message.
v3: Take Christoph's advice and factor the common code into two helpers.
v4: Remove my redundant new line in blk.h. Add Christoph's Reviewed-by
tag.
v5: Remove the changelog from the commit message.
 block/blk-core.c |  4 ++--
 block/blk-mq.c   |  5 ++---
 block/blk.h      | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..81b322b8a385 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1042,7 +1042,7 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 {
 	part_stat_lock();
 	update_io_ticks(bdev, start_time, false);
-	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
+	bdev_inc_in_flight(bdev, op);
 	part_stat_unlock();
 
 	return start_time;
@@ -1073,7 +1073,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 	part_stat_inc(bdev, ios[sgrp]);
 	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
+	bdev_inc_in_flight(bdev, op);
 	part_stat_unlock();
 }
 EXPORT_SYMBOL(bdev_end_io_acct);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..6bdfe642bd93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1082,8 +1082,7 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
-		part_stat_local_dec(req->part,
-				    in_flight[op_is_write(req_op(req))]);
+		bdev_dec_in_flight(req->part, req_op(req));
 		part_stat_unlock();
 	}
 }
@@ -1143,7 +1142,7 @@ static inline void blk_account_io_start(struct request *req)
 
 	part_stat_lock();
 	update_io_ticks(req->part, jiffies, false);
-	part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
+	bdev_inc_in_flight(req->part, req_op(req));
 	part_stat_unlock();
 }
 
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf..11245a494c43 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/part_stat.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
@@ -485,6 +486,26 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 		q->last_merge = NULL;
 }
 
+static inline void bdev_inc_in_flight(struct block_device *bdev,
+				      enum req_op op)
+{
+	bool rw = op_is_write(op);
+
+	part_stat_local_inc(bdev, in_flight[rw]);
+	if (bdev_is_partition(bdev))
+		part_stat_local_inc(bdev_whole(bdev), in_flight[rw]);
+}
+
+static inline void bdev_dec_in_flight(struct block_device *bdev,
+				      enum req_op op)
+{
+	bool rw = op_is_write(op);
+
+	part_stat_local_dec(bdev, in_flight[rw]);
+	if (bdev_is_partition(bdev))
+		part_stat_local_dec(bdev_whole(bdev), in_flight[rw]);
+}
+
 /*
  * Internal io_context interface
  */
-- 
2.43.0

