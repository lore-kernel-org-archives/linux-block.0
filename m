Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009715E97
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611278; cv=none; b=XpkgG5KZfGl/QR1RsRFjAH9aookjg6Ggr8+d8Tl7JdGU8k+71hjJpt/o0WCQzx3ERBBm25sUwybLeIv2w6ufbw13aZvNCmkdWFVXg3G3EroDkaPSdMKzd3crwq7MV6pNOKvL/hDB16vbHNPhCpXmlECx9eSxXs9CNx7ziIp4Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611278; c=relaxed/simple;
	bh=VzU/r74608DW8rwP3q/dNanxvdMrpgci97YcayLvb2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aAwBVYFUugzQEP1h5VDOidk+IddxJR8uCHFpKnFbzgeKPc8DMZ8Kx1T/51O15OTrYEu1hkDSC3+GUStD3lFj+ts7AD6hI5/ayce1T2fMg1ig+dONhm6rOEum9zAM7LMvfOnZzk0h4sLWrZgoq28V7jS0arI4ox+9l7JMXCP3pjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49B1lclI040915;
	Fri, 11 Oct 2024 09:47:38 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XPq6d43yJz2RY1yf;
	Fri, 11 Oct 2024 09:39:21 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 11 Oct 2024 09:47:34 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>, <xiuhong.wang.cn@gmail.com>
Subject: [PATCH] Revert "blk-throttle: Fix IO hang for a corner case"
Date: Fri, 11 Oct 2024 09:47:24 +0800
Message-ID: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49B1lclI040915

This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.

The throtl_adjusted_limit function was removed after
commit bf20ab538c81 ("blk-throttle: remove
CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
able to scale after setting bps or iops to 1 will not occur.
So revert this commit that bps/iops can be set to 1.

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 block/blk-throttle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c4192e12efa..443d1f47c2ce 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1485,13 +1485,13 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -EINVAL;
-		if (!strcmp(tok, "rbps") && val > 1)
+		if (!strcmp(tok, "rbps"))
 			v[0] = val;
-		else if (!strcmp(tok, "wbps") && val > 1)
+		else if (!strcmp(tok, "wbps"))
 			v[1] = val;
-		else if (!strcmp(tok, "riops") && val > 1)
+		else if (!strcmp(tok, "riops"))
 			v[2] = min_t(u64, val, UINT_MAX);
-		else if (!strcmp(tok, "wiops") && val > 1)
+		else if (!strcmp(tok, "wiops"))
 			v[3] = min_t(u64, val, UINT_MAX);
 		else
 			goto out_finish;
-- 
2.25.1

