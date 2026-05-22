Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA230677D
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449880; cv=none; b=VnKb699ExEkJTVBhJ/9fse0EJftqZjgKyS3+4NINu1pv+CgXrv7UQdDB0Jt7EM4VV0VIew1k2OeYjNZaRNMzl5wzl287rLfUoIgGOFWyWzl8UvWQUOiauVA7wsoE7xSHUubseC8k2kRc3H9nkJGzDwy4XUAs2NJF4Y9BKBURfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449880; c=relaxed/simple;
	bh=+6XTlrFaNMeuJy/nAA9K8IKD9L0qB+VwyTccxLkgEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+sJWAX/aRrAJQrEzQ8VYwT2zkFOB9bRvCxNoPV5Pd16Vht4oqNWhMjB7DviKJDHKod6dgL0pKStonP2ncV/pobnZvZ4FyAr95Dul7eZaDRu4RFN+QCAkMMAoiOOzFEPnd+hmtaT6KdsYxn0k31xB6nVa37CmCJ3n8DOHsgkodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=dfyhb27Z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="dfyhb27Z"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36a7bbb9698so255996a91.2
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779449879; x=1780054679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2dyv1Pdhzf1sUnv9J0e7+lVLWOmeeI6cw+f8Q9XDUs=;
        b=dfyhb27ZYDUTrR/wh079736nH96f553DfLABLAKz05Fyk8hMbEkfEVymHiR0Eq7nhC
         zvFpuJ2lF6Oam5FE37komrFWILRVZTTtMOQGbiZjCJS0tuu82H8zXLEXIo0nE+GSwaPT
         niAgCK2xWg2k87BOCoh8BAIy1EDTEYOuMZOC7Vk6ROdhk5JnhvoVMOhxdpCNXYLP3rKN
         ssBMc8idMCFcO5Zw2A/kKnDqgmaNbti9rm9/iRi4bZ217Id3lDCp3RUSXAlqfegaewW3
         RkilYgVAcnx97FvEtkZmL+XQjhgCIceFeHZUMgWnT/qSvkWNl1plbxcy6Qu52l4r8EHx
         x9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449879; x=1780054679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2dyv1Pdhzf1sUnv9J0e7+lVLWOmeeI6cw+f8Q9XDUs=;
        b=d1zHX/bHoovdE47jkfBPqDsgKwsZVaigmQxHVDC6d61aEbIpsmC8YYldVSqqWwFpyY
         Dq8Un+ES9JelxKv69ngC/V6s0dSd+KiDKi6+HNxZtjarsoZcWfLtHxYLlyGbBniG9BWZ
         H/21kWxw7f0rQU1xBITL005U5nlQvIOJ6OwOAd74He95ma225OI8wWjwbXzeP6B4VEap
         +WSEAA/4o5IrxsCqrdeFS/8V1vDLtrisCJN3ETmFNgylIjUoyZ/TTt7NWUmLHS0l9uHJ
         PMmqfKZri3joiz1UNjvS2xLD8/qvOXZfHbkzNudZ1WMa7kwklC53+wxlaGabqSbTm/Wu
         xh0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Q7mFMNGxqjW5H3qn9TC9k5uufE/+hwaDq7pn/IMFltw6YGGCZHDwL8FCytKye4DpiauO6Alci5gTpDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwXIzT2Pd5U3P6jCSgsePs7QXGL2TqTzyPumo4e6m1xexRRlc
	fWazkTl6YJ1RO8n4C82dEzruu3pii+6uI+E3/b5EeFQdJNwlrvcnYtxmi/mlsIkXpqQ=
X-Gm-Gg: Acq92OG2n1+1D0tC7cx/edHkbMALBcaZmx9aPMRirKzb38jiOK0KbGjRBb4DXWnuUGj
	qhajRK4J0NC9D/jdoqT7p78bqng2+XBBzvDO2jN9LEjUGh2zOdiGlfYyW9hMyhEcp9hS9Xis/Yt
	bn+V2PXP4hEdgMjkt3Y7euiecj1jnP6RBXearGPu89p4rn5x6rII1cyn0Ftq5q7mZT3i8yooai2
	Ya72pBdH29+ph3yvxunnGNi5GpHpbRaDkx0j7Bc9dl/cUIkaY2ArHvVddrPSdZxQ2o2cp9K0HcI
	BSd4p96/v8c8dfOd0o35YY0EjmTxWwQoDUIIfLOPyxKX9lUJpbXlnuLEywS32cSKgNzSKjm8ovf
	9kTeLrzMVsWiRas3e67jt/Wre0+OXr+ZUKPUFNXN5EhUI+0J7iuas4xu/tm1xa5QIhvJoob1ch/
	tpuiVNBnLU2A5vY2yfgHg=
X-Received: by 2002:a17:90b:564f:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-36a674d88edmr3074090a91.9.1779449878838;
        Fri, 22 May 2026 04:37:58 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm1619107a91.15.2026.05.22.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:37:57 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH] block: propagate in_flight to whole disk on partition I/O
Date: Fri, 22 May 2026 19:37:51 +0800
Message-ID: <20260522113751.171630-1-yizhou.tang@shopee.com>
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

This is the cumulative effect of a series of patches.  The key step is
commit 10ec5e86f9b8 ("block: merge part_{inc,dev}_in_flight into their
only callers"), which folded the whole-disk in_flight accounting into
generic_start_io_acct() and generic_end_io_acct().  Those two helpers
were then removed by commit e722fff238bb ("block: remove
generic_{start,end}_io_acct"), and from that point on the whole disk's
in_flight is no longer accounted at all.

Fix it by restoring the whole-disk in_flight accounting.

Fixes: e722fff238bb ("block: remove generic_{start,end}_io_acct")

Suggested-by: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-core.c | 4 ++++
 block/blk-mq.c   | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..03f4b7015e69 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1043,6 +1043,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 	part_stat_lock();
 	update_io_ticks(bdev, start_time, false);
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
+	if (bdev_is_partition(bdev))
+		part_stat_local_inc(bdev_whole(bdev), in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
 	return start_time;
@@ -1074,6 +1076,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
+	if (bdev_is_partition(bdev))
+		part_stat_local_dec(bdev_whole(bdev), in_flight[op_is_write(op)]);
 	part_stat_unlock();
 }
 EXPORT_SYMBOL(bdev_end_io_acct);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..60ead16f1496 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1084,6 +1084,9 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_local_dec(req->part,
 				    in_flight[op_is_write(req_op(req))]);
+		if (bdev_is_partition(req->part))
+			part_stat_local_dec(bdev_whole(req->part),
+					    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
@@ -1144,6 +1147,9 @@ static inline void blk_account_io_start(struct request *req)
 	part_stat_lock();
 	update_io_ticks(req->part, jiffies, false);
 	part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
+	if (bdev_is_partition(req->part))
+		part_stat_local_inc(bdev_whole(req->part),
+				    in_flight[op_is_write(req_op(req))]);
 	part_stat_unlock();
 }
 
-- 
2.43.0

