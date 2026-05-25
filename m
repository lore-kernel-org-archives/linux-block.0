Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9837E0E8
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675565; cv=none; b=oyymgoGE9RGgXtiyTRJsRfb8+Vk4Jc6anyRzqpr2ZV9FRTmnq00b7fgUoYJ32//WTcKFhF8im8BxERF3TcqCzPZHpCRYp2bJ7EoeIctKM1LlTYqCYKIx94DGWVFY7BOCSSsYCqTL5RcjKDovKhwadcNID93HxSWbsdmwLifT0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675565; c=relaxed/simple;
	bh=zReoTNQHuCqcKjkBzIWRBpEKu5UKFc50Fud645+nme4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW8n5NuWIupPculELBuNhu07UgWS8uA/tP9t206PWt+7v5A2yHMJea25tXugWvtshzhdsy2YadM//rUbe+mbeT9nliaenTjwyugsIsHYyxBgpICukrBGiqyIwpNZFE89u+Ezo8iYs6QRu9SlBsSoCEabdMGDYNkO8JeW9tmvnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Boe0NcUX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Boe0NcUX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367c26471f5so5827294a91.1
        for <linux-block@vger.kernel.org>; Sun, 24 May 2026 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779675563; x=1780280363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw2pRdAsIvFX8ugAdOnRGn1wklNSpi51u1Gkz1tBy7w=;
        b=Boe0NcUXiG6UAMypy6W0H6ngvN8712yCNqv/WrGROdu9Im7hGdnEnL+L/gCk3vzMbT
         4WbcqP9z9D8b96oyh1q2qGPHk13AEvJJo/nhchTAp2QL33jrRtwmymXo4XR8VvM+y0K/
         8OpBW+KVTHHuJa2+HGLGJscVf7nJK77OxocO7Iz0he/SJOcG7Htc+poa17tsTr0kn4Ou
         jbOzMi9i9x6ayqx0VIVXuLhd9EPBPitve8mK7gv5XfwkAmEytINOSKxaGMQD6oF9pw/v
         BBtXAQeGAnFZ8k6DVwK5jRIR8G/MzLn96FWg3Au7+LFt1RDgSWMTHNnUNuVt9vKgVJDy
         GCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779675563; x=1780280363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw2pRdAsIvFX8ugAdOnRGn1wklNSpi51u1Gkz1tBy7w=;
        b=dj325S8y0Rdf0Vp8i30jiZjYcQjYjWm+kpLcXYAesw/gWhH5PpSKEqINTKa9EhInW1
         UVL9MhrWvLSZffm7S3DIvOZACBp/VEyqDygzIPaWR4++loCQVeeGQuDt68cL0nLma0Qw
         zYg8stWAczMd8xlClUyfyrSBvIZyWJOAAa3IQitAKCHD6nWxIV4q5BiH2uQP2s19p5RA
         CQTT9G6wp6oapGhFgm/X1IPLxiZEOUA8af1sodeYZy0v/hxVBgf6auaQgBPIl5MopfGt
         YERUxpm9t9S7DUgdSC6MCEpag14pIKuksJJAZ6r2gxchYu9O42Y3p1lgThgGUf2DEGU7
         BUNA==
X-Forwarded-Encrypted: i=1; AFNElJ82dc4QpbG9reAjK8Ziv54Mf5tu9J9ZUOZZjsvZqKmWd3Vk0yNzIfXGvqn1xGQTgGpoeBZF4QZ6wqK1JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjSYE6PiPK3y31Qw8hvwHKgvW6D1tgv9M1abSKU6ZEnIb7QdL
	At5RYqB0bK5OTSu0ko16Z6AKaFhga63HwSXEIK7n1X4t8pFnqPMS63m2IKLvKOhLpKE=
X-Gm-Gg: Acq92OERX3WX+xqMyPdP9+Lk0TPV65n1D9UyeUhK26EQ/lGFLyQ8+aN1euWaJJ1UrsN
	GIW9c/XeysxkDz57Hkj8dF+2FqhTpGDEMUy4IUGSkNTJ47g7m+8E5AJXRxoPuQVADMHr/NgXiL1
	3cT5lhdfzwkAii4RZ74FmEx4IPHLVxtR2U3hHD6DEH0QESosVK50Ib/pqyq+9YxbGi0+rsx+JbO
	J8fmlTVfyzkLjqCt6cFyponh5rpTKD5aMJSCJIZ5idj92ZvQNQhZEHjO6E5ImyzzFisfaR+oDD8
	/BbX+zRs1LsWes4+mIWHp41m9DgozCddrgApih/9bIJYAmgoPjS0Rp4Uw7vhf3nKqv9i4p1QDcb
	yluoBQRh3rX/oqSY3oCAKRDb8a4ybdgeNKrp+1clq2zuzGWynz9LlQDbWWsGAQAf5kVVVw3nfbe
	WtsZ1u5vdkxIOHeUkSfKQ=
X-Received: by 2002:a17:903:3c28:b0:2bd:3c1a:473e with SMTP id d9443c01a7336-2beb038b83amr135531425ad.14.1779675562898;
        Sun, 24 May 2026 19:19:22 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b303bsm79652165ad.38.2026.05.24.19.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:19:22 -0700 (PDT)
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
Subject: [PATCH v6] block: propagate in_flight to whole disk on partition I/O
Date: Mon, 25 May 2026 10:19:17 +0800
Message-ID: <20260525021917.273190-1-yizhou.tang@shopee.com>
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
v6: Accept Keith's suggestion and fix the bug in bdev_end_io_acct().
 block/blk-core.c |  4 ++--
 block/blk-mq.c   |  5 ++---
 block/blk.h      | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

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

