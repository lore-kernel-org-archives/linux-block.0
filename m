Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB103A1A58
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453286; cv=none; b=nVS5vmkaNjh1GIwmDLh26Jt5AqSYdPnPsz/mgj3rpVDmcqKVwrJNZkUAcjn9e1pV+z/RtejRTNsjS33jc7srcBoOzgW/6AtDytP3O2di2lrZjY3lqkvXyMdaRFWKU9eHWC+5Fp2DOzS5g74ooE5Y/cic3f12aLbtMDxdvaOQph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453286; c=relaxed/simple;
	bh=CZe2Th/Kz3g0cBOC7HmIuidtzfohRB7G6m4QxL1cUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S3D5lAlJ4L0O23XDwcVynfjGtPwcGevUB4GcRlV7llk6IPypEamqqYbXu3rhnGma8weSu/4+VMaxEAYyB9LYfwFO7Olo6l8gH2E0Z3j1jAX/uMrQniOdsManzNg7aU8G94G1Ml9EQOD0XJL71f427FAMLnmr0bSMCG7USpMD9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lXw4EiK7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lXw4EiK7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8367df48711so3150776b3a.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779453284; x=1780058084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8NDhTcBxupujmsLnW4nemiXS1D1a+QTzbnmjzpK93I=;
        b=lXw4EiK7F8j38PQWddfX6qnKgKay/vO4JKr0M9t++kXE/XngdNPr8/JypsjM/Hr+yS
         b/8CQdAZ32uHBVkGJXgEc+qv1b8nssnNeI9sAWpLb3Y6up0GcwSeLqJ/ZsXNSvAaK4JW
         MPLJyk/ViXwD0IYtqJlBB55P5RuggXDWtXsaQC+Ojejr6WXFNw8ky9Az+5xJV+fAk9K/
         vqVdMkInZQ/WwYngNTuaJl7kSIoL3XyKgDXm30s+e63xR9EtpQdPSrjmklUNp12Xn6I+
         0nMJnSRnxrMZHbaMIs3+QijKAmKPeI2T0xDdFp0l3BACB+EzpCpjwrLJU1vyXKt4CCWD
         H0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453284; x=1780058084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8NDhTcBxupujmsLnW4nemiXS1D1a+QTzbnmjzpK93I=;
        b=authdXPgrKQpg1mg0oSvF9B5H1CFRL1Q0B/ENKix6KEAoVSgVItg5YNCQ2ASV3QWuk
         Z9Bykewm3dTHCDRtNqNucGakrbgsHZ3yVI8i0hyZurEmecrCVGZsY1xA0M/B3Er05sDl
         akb+zR4ZY3Fy4buyvzhe1M/2Q2OJhz9fzQ/7eJwJo0k3rYEIQo3XzJjrxOPqSfOQGHMM
         9NyiQo8IIS/0kCpBKte3R24qs13mR+6OzbEBf7RiTSBEJmQhcmoigFf9bthO77MZUpAp
         M5FP4vFOhsBxtEze79VYXGGLP26ealuwVUmtU6ICUn9emPmFAPYC4afIHf8QBstTUFzj
         TqVA==
X-Forwarded-Encrypted: i=1; AFNElJ/ppfsEhTxdtjgz1lufSD++IRODbVX00/ybUb5FrSQNKmsgR06bGdI4/5Mmi8XRFZOoPpyylSPsngV0yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy55Bvsv9jsKVyhGSDLC0wkJq22kxpkOfbD8MRQwolDlFWTyy
	UjMNuhNzzH0R7Q3uXevj2RTk48jem0pB9IiKk36j3txr6MuKSUKtDIGCstOUc+7sEyQ=
X-Gm-Gg: Acq92OGVae1zwECxv+seX4XsiZt1QG8rnR5LT6GR4MdJ2fX3+Esz7RpicA54quztGtQ
	hYTSbtmIk/xldSXBGQVtL1DR86/3sK06Wv7hE7khxPHJnETWEvV1Uu98i9z4vlLU61QKcy29jJl
	tmn7taeuAkojQBBfHw62jC7tZdCIkP2Hm9D5E/G+Tmn6nHdw14KoIfuJGeayKIrMbHnFa/rbUCf
	8EvK3o+DM/NcJLXraqBmL+wVxxOOmS6gHH+d2kTpX27Otjt1NFV48EGTH5OP0sXj0JBHyo2+BXH
	2SDc4OehxeF1fNUSxWhJPxb5zWMW2PU6G+rrgpOKOp+Z5N82jsOFOz0b0ORsjtqzQxHjCPg/hrm
	OvZa3qrgO+n2RJF974keggQtdaj3M/Y28zbUnz5PjHJOqygBB/X5K0kMnfoSJ5xx/DI2EOg+7gW
	L5kqh0noua
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d79c:4159 with SMTP id adf61e73a8af0-3b3293404c6mr3695201637.32.1779453284125;
        Fri, 22 May 2026 05:34:44 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b3867sm1496576a12.11.2026.05.22.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:43 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de
Cc: yukuai@fnnas.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH v2] block: propagate in_flight to whole disk on partition I/O
Date: Fri, 22 May 2026 20:34:37 +0800
Message-ID: <20260522123437.214058-1-yizhou.tang@shopee.com>
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
---
v2: Update commit message.
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

