Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F93BE62B
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456668; cv=none; b=B+aMa8BxdEqj46SNv2GF3Qpo4aYk/DbQpoIu/VIae6XdOyzOIK5Lb+IEkzEMtA4yjDnCkhUluTz/Dj6mA38J0UWL1Z/CIS676M8MdIGy8MZGEtAyVyJeBDGxhLU1iuGBxP0r0VR6mAm9/0EduayFFx+4nMs0zjqTZzSVAdnoM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456668; c=relaxed/simple;
	bh=mi82fMIZNh3A5to3F0s08Wq2UY0bGc650iAhyM1ybnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BapZwKw6YD+WgSdu5uIqidMa7xqkgaimgHxhyxn7/0I+z+QJjxsIQw6voT68jyaUCSdF67q+DYJ78GfMTXeRvWkDKPgeBSou4DRZ4CiNqwN3EoknfBHHc5VOdoyUw6m6g1I5QQYfLFDoCe2+E0MFEM0E4UXBS8QKQhgMMYq0vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=f/b0sLYA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="f/b0sLYA"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so3231913b3a.3
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779456666; x=1780061466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B22k9eeZKBPFuLDyjeMCdwNfa51/Ct7mQh0rmSVG1Mk=;
        b=f/b0sLYA/yvhsfZuCtDaYwXySZM3D3p8vnx1gPIfKcwXynD4Kna7NGaoT1XD+DJF2m
         ky++aHCXZzWWtYzXstuqQJ8b5h4IOqlag4zLl3ttUrMmbmP3E5cxLBYvhp8ByC+Usiei
         63SP6HmSuwBFwVwEarQYndmBRV0edoeNmZbeXZ9NFWyMAxwNWKUD/HhS8ZJIe8UNlaQp
         sg7qhHo6T0c/5zOA2ao3z2kOb41RcOcmcBZU+EZGTLvYrcnMwFJfY3RxUwY6Rd7RuCgV
         WMBxKEaoLQjAAwgG98oyuRN+cPF1miXvnMerOUiKHF+5JfrMsgjl3azhF7DKRpHvgpEx
         Gvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456666; x=1780061466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B22k9eeZKBPFuLDyjeMCdwNfa51/Ct7mQh0rmSVG1Mk=;
        b=LJ4r6RJAnP/m7a2ZgCPU5vXi/tcdmpfvyQpTsx7fBBetz2kimzsPO5NbWtkjsgEDXp
         5YRQacm9XFNJHX0lKOsMgvoWKqlLFlZib+MaSIHO9C0Hs/aBGa2qh/jnt8mlQEAhUUM5
         A4PSq3inPjcBVjtH9g7mIswLUyc76ZkC95Itm2bJ7VXhqQyZoSxxsI0/6w14Waj8+uG/
         r9GhjcScMMT307r714bkRsJ34ZV1Pz1bmSxxCVkXoNt3DgNsGZXf49add3sr0b6YOK12
         p6CaSIDqM1PkJ4LRqsVhlHmTksxtSVovuoP+LzaM3ezJKSjyCVYf2UXru7qIhpMBpkm/
         vYbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QEus8icwdsnI772+i4RkQd90ZG8bR1+tJRoO54U4BX90I49oQMw85CKZF1gtwVvV4rS+uox9iyS6eJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1oEXsAA3Vj1bGN0oItfFuPg7FXf2qPljDNd4Mla2C7jjHr17
	wuwiQTvvjdPJ6BChX8jmo6FIT1GriTXEsvjKM5f29bWB0dJx1Hh1mQsSxh4pDg8scNc=
X-Gm-Gg: Acq92OG8WTUJtMx9zEOQrKuF23AAVHuEcUY2//4cpBPrK/udkUCHOeqcUSiy4ZCVpUO
	xjYteRjgd3cLXG6BarEzvaCGHPJh8vCe9ltdjhTTBZn71YfG+BnW0L4RorpafdZC6Llttmlk63W
	kU3KBtIzoW4B8kOzsz+bieIKyd8lCHtysxvxWdUS3FQmQV6pZeWQCk0rpL8l4tzY0MTwKEt7J+G
	UayqmH8ldwAQaedSeVgLXmuShxPqpef6ZgeZ5O5b163mDNd9SJcRcOf8IYPr4Q6NBo+ir19lfsy
	5bH9R7muNr3HnxxUzv80jA2DB79CyM6F6YjzxVW6fqBwAKC3hnHR0eHc+ehR27kR48f9PEuGBDC
	5DiA5209d24e2rbNNGAmxiQWejB3q70x3pLfh7NHO2LdMDkIMnB5PQ3almSY9wBLfXJi7N6YDNO
	OniZn0TbEA
X-Received: by 2002:a05:6a00:410f:b0:83b:a723:d704 with SMTP id d2e1a72fcca58-8415f15c9b5mr3871690b3a.19.1779456665869;
        Fri, 22 May 2026 06:31:05 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164e9e793sm2725173b3a.39.2026.05.22.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:31:04 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH v4] block: propagate in_flight to whole disk on partition I/O
Date: Fri, 22 May 2026 21:30:59 +0800
Message-ID: <20260522133059.279211-1-yizhou.tang@shopee.com>
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

v2: Update commit message.
v3: Take Christoph's advice and factor the common code into two helpers.
v4: Remove my redundant new line in blk.h. Add Christoph's Reviewed-by
tag.

Fixes: e016b78201a2 ("block: return just one value from part_in_flight")

Suggested-by: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
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

