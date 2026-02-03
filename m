Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EB284B2F
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118541; cv=none; b=T9F8ZFCuM1uqIBoGWhmOYvG1mwWVA9Fu3W/vRzxr8tv8jvc6LgtAKN/mRRNiWfcKzi/Pce67Y+KLMK0xaplZrAi3FUEBOFTaf6lF+knRbSdXpuvN3pOa1EcfpySXeiXu6riob6j7LrF1w3QHuu6eCyk085TKEImsPLec4Q1ZuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118541; c=relaxed/simple;
	bh=po6igGCqFvhMkU276BVatti3l4UZsOHfF12sI3ntqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yo4P+iwktHOuDS2BTFBHZcheCQS0WGj/jwLkMhODBN8q3dnV5AZrTXfPdSEBk8BkFuxRBKSfU0afdzDqQcmK6sZImjjHLIVILPTXozBbljM+Qm9k6ov466mAx3qWUdm85BuELFd1ZsWV6cMPBt9w6tf7cDzSt9MjcEgAC7JAUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ghol197i; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ghol197i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770118539; x=1801654539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=po6igGCqFvhMkU276BVatti3l4UZsOHfF12sI3ntqDw=;
  b=ghol197iSjRrUaI53Q/zDwA90aiEBlFLha26snzrfCcSUfflMAn4NkHX
   r3ByTGsxt0XZmL8NrEC47W7cSW7FBfk/uk+BQLQqYV0lFN6IaysXFBrCV
   nVdyhbSOxdOZtFUfrsvT6WgrOkXd1ykd0tq3WbWp3BlbMx1OZrIfh4ZW+
   mUsi8r8PNyzP6Aj1kY84yuL/sydQd/wdF+S4jlIHKb+rWX+kIky9JDmP5
   qZSQAglAXv7gOp2FYektUX8DMziPnMmI5kZwtAM5oCevEp2NKE9awlte4
   hC+qfHBFrtvnvsYq2glmFwKXjqqiX8HeD4KBr7wRHohPRqgqbWK04nWyL
   g==;
X-CSE-ConnectionGUID: 7Y1GRG8bR+iziXCy/5jTmg==
X-CSE-MsgGUID: 3AJDPpWyT+G8J4hwN7JBEQ==
X-IronPort-AV: E=Sophos;i="6.21,270,1763395200"; 
   d="scan'208";a="141156897"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2026 19:35:33 +0800
IronPort-SDR: 6981dd85_MQRy/pW2bTvHSlA9cXxV4jouKJ8GZHoo4fBY+ReljvZdjUl
 1b5EOPEZ1xSQUBh2muKGBGdZl0zMaub9ScYgDqQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 03:35:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Feb 2026 03:35:32 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] block: don't use strcpy to copy blockdev name
Date: Tue,  3 Feb 2026 12:35:28 +0100
Message-ID: <20260203113528.1669120-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0-day bot flagged the use of strcpy() in blk_trace_setup(), because the
source buffer can theoretically be bigger than the destination buffer.

While none of the current callers pass a string bigger than
BLKTRACE_BDEV_SIZE, use strscpy() to prevent eventual future misuse and
silence the checker warnings.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202602020718.GUEIRyG9-lkp@intel.com/
Fixes: 113cbd62824a ("blktrace: pass blk_user_trace2 to setup functions")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d031c8d80be4..c4db5c2e7103 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -793,7 +793,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return PTR_ERR(bt);
 	}
 	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
-	strcpy(buts.name, buts2.name);
+	strscpy(buts.name, buts2.name, BLKTRACE_BDEV_SIZE);
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-- 
2.52.0

