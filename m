Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22725A655;
	Mon, 16 Mar 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644653; cv=none; b=SAOFua3zZUkw1S9tlJoPNieTW9CGIWlocBfATXb6fOREocovPfjVhPfm4LX+b3wjpYXoHiCZQwqWWkwBH3+dn789pEd8AIzKb8EMCBi6xbIGvPLW5xpg/xLxu4PPU29jImiixqXoYQhOcegA42wsJcyIn1DLy1Hfuw0pHm2T+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644653; c=relaxed/simple;
	bh=Nk+SdV3EmwkPKY+kSJeGHIkhg1w689CrkeY+31Dn7JI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJTpZVUTeOQ1U5N5ca7vTQ05rjatvOKvzCgDDasLO1WVckv26jKQ+thuTYzLqklCr9nYS5yTchmtRkN0S2SJ7RSygEltT+VZ6BN2i8idEz7vv1rHbfZ/GnqDuMv23PXazJ3KhcWtXSXCCPrtDu1Liq2P1JDMZHKL4Y5OcMRlC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FTx/HVqC; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FTx/HVqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773644652; x=1805180652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcaWTWB9jH4dvndQPVa+EJIrVfjs3M40llDrFeP1Fqw=;
  b=FTx/HVqCcPDawZr+E/KyljyexIepaPKfb1pt3q7nZqlLwpCzGb9RxTBc
   /aOxPT1AbGwTvGUbZy8cx1u/59fzDpoGpE6uSeOzKKEID0IYMaLPw2Rnj
   D6WO5G+yKGC7dmFs624AeAvEVT133Zgn7oU5RvvUUeZ2G3w+9UX9OrbVH
   CgsHzhcFzent/3/j3UYPTp4AEmtx1gFYytxQlB/s+ioZv9PtQJTqYGFV1
   fpyfhjzQxMYHJp4nrOAsiUjCUpTWy1jKzlZtoac8ctwPTQNPKatXxW39H
   SiTZ0jzMnABwwd54m6UqO2wx5gxulFbqYSNW4lIiCELq2MzposYpAkzJP
   w==;
X-CSE-ConnectionGUID: dajelrIlQxOBEqrcPkfHPQ==
X-CSE-MsgGUID: UHzGCNTVQhqNDwv8djZADA==
X-IronPort-AV: E=Sophos;i="6.23,123,1770595200"; 
   d="scan'208";a="15105575"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:04:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.226:2525] with esmtp (Farcaster)
 id 306cfb32-9b41-47db-ab42-3f47477815ac; Mon, 16 Mar 2026 07:04:09 +0000 (UTC)
X-Farcaster-Flow-ID: 306cfb32-9b41-47db-ab42-3f47477815ac
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 07:04:09 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.26) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 07:04:07 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Yu Kuai <yukuai@fnnas.com>, Nilay Shroff <nilay@linux.ibm.com>, Ming Lei
	<ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>,
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Subject: [PATCH v2] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
Date: Mon, 16 Mar 2026 07:03:59 +0000
Message-ID: <20260316070358.65225-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
wbt_alloc() and wbt_init(). However, both are expected failure paths:

- wbt_alloc() can return NULL under memory pressure (-ENOMEM)
- wbt_init() can fail with -EBUSY if wbt is already registered

syzbot triggers this by injecting memory allocation failures during MTD
partition creation via ioctl(BLKPG), causing a spurious warning.

wbt_init_enable_default() is a best-effort initialization called from
blk_register_queue() with a void return type. Failure simply means the
disk operates without writeback throttling, which is harmless.

Replace WARN_ON_ONCE with plain if-checks, consistent with how
wbt_set_lat() in the same file already handles these failures. Add a
pr_warn() for the wbt_init() failure to retain diagnostic information
without triggering a full stack trace.

Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter")
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
Changes in v2:
- Add pr_warn() for wbt_init() failure as suggested by Yu Kuai
- Link to v1: https://lore.kernel.org/all/20260315143137.13547-2-ytohnuki@amazon.com/
---
 block/blk-wbt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 33006edfccd4..dcc2438ca16d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -782,10 +782,11 @@ void wbt_init_enable_default(struct gendisk *disk)
 		return;
 
 	rwb = wbt_alloc();
-	if (WARN_ON_ONCE(!rwb))
+	if (!rwb)
 		return;
 
-	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
+	if (wbt_init(disk, rwb)) {
+		pr_warn("%s: failed to enable wbt\n", disk->disk_name);
 		wbt_free(rwb);
 		return;
 	}
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705



