Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE80265623
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761763; cv=none; b=Qe2agT3Fz3juaqX9+eSqYDiTXwBVzkt8WtfXAVzemT/oVJOV4I9lEeb5fjlgUl026OPfo9bnkOlfhzr0oU+G6JnYSLK2U98W2ViyzsYKS9tKwFRBHfie6XTuyljYvXp3hXHBy6NHi5V8w78I3P8fahmzCaGRfrm8o04MpqToqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761763; c=relaxed/simple;
	bh=7Lz7zct0T+drazH0wRYYmjTYORRDWotElxY6m2xO7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ktg3VQASHOh8J7ydw3oLifvuDfRNP0/2o8gtFO5PqFmljvLCNAunprlZ8Gy7G36/DpRW505N+HLvEbU+ulQ+pjefxkCe4RwTt8L8mlwEvGqu2YGwtRvgRT9S5xs1RfK+epNeqX1R3UzByvT/oVqyCtuNZye34fJm2F37hVR3av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=egqTZPRm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="egqTZPRm"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83d5bbef760so4133445b3a.1
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779761761; x=1780366561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kchS3QdWpyeEDApYkMFv3kCi0sAF0UzPuKNZ9sqfNKo=;
        b=egqTZPRmVfKGxtIZo3hjDVzT1ayoJwH0BHqDq4JTZMwtZA5xLojg7rSudIBWDKXMHw
         C7h64/F2WLC6CYmNfygtm50UAsxqENdYcKDtJtuiYwmntHC70/RtA3plsolgmuYBTaUu
         X1WOItYaCSBlPu4+7Z3EzzqkMQHFDMrZSp4R/BCIee1XFVz3cPqy02kzuM/G3oRFGdCA
         bXdgbhDpOzJKu5Y/Wai4yLvxdx+eYBEFddMltxD2OcTmzBQTrb7qhGd6iahKI3mwxzF7
         N+TCkjhMXvYOv3v7Gud/gRvVA46JwqOUMf8WckyHnFv5pXuZtehowEPYY/dPXgO1IFRI
         WsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779761761; x=1780366561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kchS3QdWpyeEDApYkMFv3kCi0sAF0UzPuKNZ9sqfNKo=;
        b=U7eduel6jCrY/bVArqoM0neN5N+DTP4Bvir7eBAgdVn4RYRmT3eLCYMXexv2YEQUGm
         YeZbIPsTPYzv/D3dBnxCZ0x1F6rSg2PhkmyH8aHDkOyLL3t0hmegpusH/pgE1qaDTirW
         xKZZnbUkSSZr7svdMqdBMeWaSVem17MN5QGVzF7auXsWjQR1JicT9Axndk2wLbP8qfep
         XrJbpWawx8PbW/ot9Q2eBS6bJE54++YlNG1+3SditDicBr0mgGvz62kCfT4zizEAgIX8
         97a1jhKDjASeqEs4PnlSbpEfrHkyl1o14A9zElLrSQUbQ6UUTUO/B9xXtkWoOl1L+7jX
         ZoQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RVpEJNhp7CMaK7YnUw/wq56oHJ4X187SelBTRA0wzeTs2OOCIDfk/dDxssZOD41tItpGNiIwKzRxfFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXEwdYyvg17f+THbQRAPSz6lyel/COC4Hx7Nzxj5TH0ed83HC
	J5+kq6klMvMTw9OwnLT4dtbkuUJZVzL4C8GFs1ZOqTUEVibpH98iI0MQos4oxixBHe6fnsJ+ltG
	xQkma
X-Gm-Gg: Acq92OGpm0Yz4oebRBkacdu1sIqqj5Vf6emUaWYbIEDy6ZBE9ECV7JKwTfcbwL/Z62W
	RWWGRTQLQBZHcrIFgmI1phb6Ck+mcvOTXdYY4tsZQlUWsPii4OeEk5pqnW09f5k4T9SN/hcm4vT
	SDCa27bRu9By+LZalmfR0hXjCGnOYxIyAMxYagKI8cHeWN0JqOsM4jsQhZphPwZuwA9FDMeNJ9C
	XT2M2yYUbO4Tpq9hbLajx2iCagFr3FpVpQj3KePJ3xf4V3CnmDtazqQSurI3FLw6vv/LcFXKTbE
	1gGon5qs91jmizenmGPmwO7fmPfsUHFccnZBA5R2abstRT536IzHKzMjsKwYCb4vRX0CDSltCl+
	GDBvVr4/QC5s3mk1oN4MMC2z2ns2JIapCbq/iIPGsKQRl0+kO+zV7brS7bAAnV3EgO21EZ4QYKP
	Wh2dNvyYfN
X-Received: by 2002:a05:6a00:4fc1:b0:82c:9126:320c with SMTP id d2e1a72fcca58-8415f0e6355mr15934960b3a.3.1779761761207;
        Mon, 25 May 2026 19:16:01 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164e9e7cdsm11181027b3a.34.2026.05.25.19.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:16:00 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH v7] block: propagate in_flight to whole disk on partition I/O
Date: Tue, 26 May 2026 10:15:55 +0800
Message-ID: <20260526021555.359500-1-yizhou.tang@shopee.com>
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
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: Update commit message.
v3: Take Christoph's advice and factor the common code into two helpers.
v4: Remove my redundant new line in blk.h. Add Christoph's Reviewed-by
tag.
v5: Remove the changelog from the commit message.
v6: Accept Keith's suggestion and fix the bug in bdev_end_io_acct().
v7: Address the review feedback from Claude Opus 4.7 and update
blk_account_io_merge_request().
 block/blk-core.c  |  4 ++--
 block/blk-merge.c |  3 +--
 block/blk-mq.c    |  5 ++---
 block/blk.h       | 21 +++++++++++++++++++++
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..cee4e4a37503 100644
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
+	bdev_dec_in_flight(bdev, op);
 	part_stat_unlock();
 }
 EXPORT_SYMBOL(bdev_end_io_acct);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..62d68a72f569 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -723,8 +723,7 @@ static void blk_account_io_merge_request(struct request *req)
 	if (req->rq_flags & RQF_IO_STAT) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
-		part_stat_local_dec(req->part,
-				    in_flight[op_is_write(req_op(req))]);
+		bdev_dec_in_flight(req->part, req_op(req));
 		part_stat_unlock();
 	}
 }
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

