Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A8370AF3
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455659; cv=none; b=PKarSEDPgrpqzSYgnAFIJiLYjXq2ylGtsUvcd5hi3RAFK3NQBjpHekBlD0TmAzCKgv9uedRzdviHcqdc9xU6OlflyiQ9tc9SwAwXyHRxi81UAEMoiIJmV114+2z5ZjubEC4Nx8RwTf7P9hc/U4EWHTm2V+ImSj1oTE+wS3Ucqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455659; c=relaxed/simple;
	bh=YSAciv9TDQClx2IMLcHJIqG7XiH7Ty8bOhwekIMEN50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7QnViiFZGMhHIrnDEPECZlTL/4eOougZpnRz474ZRUItYrWDhybHwW5hPz8LVVGQFwfybUS0dxvMsIAFcWM2iiD90mmdgGjXW2comHGUU76nvMUXyeD6DoVW7Uxyh3IAWIzMU6VOXgATbsyNBuXGofga8BA6jjAmHqA4B6kinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TtyiNMVu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TtyiNMVu"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83d5bbef760so3082602b3a.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779455657; x=1780060457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5auOG1877ywlMK3+iSMdUow3qmNazPx9wYUImkm+Qrw=;
        b=TtyiNMVu/Ilxh82WFB/zXNZQOtoZdhSumNqHMKeNlHdkeC/qThEgAkjX3zi2zCqPH3
         2eqwG3f3hedF4rmtpLCgIVkwZAyZp29Hi05NeI6ugGdNqkXiAr6ATIUVvRIYLXj+2YDm
         MklY0lDt0PP321F8gRuli58Znfb3YS31+rbgwgmucN5IsGIjEar5HAdv6KPx6fEzrbZZ
         HUwHymLaxyKK3/fy5Bo6+m4pJJZU4Dc72yv/f1UTo23VlBzdebqXUUuJmJLXlwZOyECy
         mSlJ0PdJ+/HgcVfEtgoVswzZB3rBLazJT2beGkx3YkG0WwgVmIjdQoODhh01rjWwh6a8
         1UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455657; x=1780060457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5auOG1877ywlMK3+iSMdUow3qmNazPx9wYUImkm+Qrw=;
        b=ECw9/NLAcGDDKmOxLQFKVuA515thKB2WmW7WB3MtUEdIfBCDw/sYyec1a3M3+iyZvw
         k79rvPG93Fkfu07zaPmqmZyMuM8YaSUnFrEovQ1P9PZiW6owUiTPKddnYu+2TEhEtsxK
         gmYrP8Jzo1CnuAD/kB+vW2nwUnyYP/LcSf+PjwZXo21o/rsaafUG0TTeuefzTREjTs2m
         PDhE8P0XEl1wgGEoePtGX9Zby8EYwDzKz+wAjdRvGSCfQhPaqhtjJuqbwQGfcizTnCO9
         oKTPzTb+Wy5kpPmkXO3rYysNI0gBff6aLM/9tEgJH3i/LLjY/vBEFsVs6uQwA5S1JY7Z
         oNiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FgPOVWyxrvBjVKGB24Xbr/bsgZPgARobZqt2ixV7bcgfGoqlJC2PhwbQJip0uqgiWkZWxUCCl4Ihwig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6xc7b58d5klq2AWPbcwg/zyT25bYuwio08Fux9IcGB55P3S6
	I+Uu9e3pLnM2Vc0ltkemod2hia0feAam30+yhCpKtPuwaoUMam798br/ufUz4Az+pak=
X-Gm-Gg: Acq92OHSwH/pirpsxUbQrNCOaIEKawm+BVo+Hx1i+ic8kRkPbr5IBg1+gStkqtdwqiC
	+f1xRGjnAMZaUEn5gOGnSPsqbyxsubTv743NNPF9fbU3uI+D7WWTEpdzHmyAPRqN6tEYcuxpVLV
	8rdosDvNyCs3eAfrl+x8AhhC8kDWNjuu+MxW3fRnFrfzkkFWx1o2Yw30k+uZMNHEcqJDxrdLH5Z
	aQnPzNQAV0D5n6ROMJ301SE7UsdqL/B6mLkoYBaX96KxWGku21H2gX3AErZDJfJ6rM21EB96sf1
	SNHw3ympYzfM3gpj/GLUi2YOQlACwF2jr61d0nZbVeWZkYxs2/QxbITs1vOPPh5redEVdk6jmjR
	MD8I02dDqsjKGRNtQirQlZsttuLG7srlHDx/CsnjVs38MqBHkUJY8YIR6LYpx6fufMMDwroSP6L
	QsWXy4FhD8plyJ6UxlpUk=
X-Received: by 2002:a05:6a00:e8b:b0:835:cc47:6fe8 with SMTP id d2e1a72fcca58-8415f3bcffamr3913828b3a.46.1779455656963;
        Fri, 22 May 2026 06:14:16 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009852sm2030340b3a.59.2026.05.22.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:14:16 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH v3] block: propagate in_flight to whole disk on partition I/O
Date: Fri, 22 May 2026 21:14:09 +0800
Message-ID: <20260522131409.261259-1-yizhou.tang@shopee.com>
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

v2: Update commit message.
v3: Take Christoph's advice and factor the common code into two helpers.

Suggested-by: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-core.c |  4 ++--
 block/blk-mq.c   |  5 ++---
 block/blk.h      | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

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
index b998a7761faf..05099aab6863 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/part_stat.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
@@ -11,6 +12,7 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
+
 struct elv_change_ctx;
 
 /*
@@ -485,6 +487,26 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
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

