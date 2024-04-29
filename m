Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6717BCB
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381963; cv=none; b=s3NWOg5ZDdBQKUUYs1pTkc5XofHnTQXlHqAmW7Zyv1zbFijiKF/Caub+U9H9PiEQ8Ex4jU7N52SQHLE9TzT4q8VyY2TrQ7JdG9P8dNpNd3cyX8kBj+aeh9Xw+NmIgKkAefeM9kmioPheU5GOIv5FVy/yjLXMA9L0Cl/x0yJ+B+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381963; c=relaxed/simple;
	bh=OfeQ86e/JIUgE0xRQJuFRkHsgAd3FkRJpAia+ZpurCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbvVN67mfSQ0AWkReizIf+n/n0fLk6kf9xrO9/5y+Mv/iimnyVeG8mlCJMypcsIQoGV5uKAOAcdkUN2yneq8Y4MpTJFlWbyzU0ppcTBD6jNznCx+Ibx2aOioeTSdRBfNNIg5iYr8ugCnB1eXpyuRmxPRZ0HOtyfapoXRgbdhym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oarI9yrN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oarI9yrN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714381958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ebJ7+9kiikPuOPUNfz9sbKLoBH7jSaePi+RWAEylcV4=;
	b=oarI9yrNWSs06YEG97LSlKSybkyAqk/IefgDlZx7qEr01SHJ4ka5F4rlfMvIs9x/kU4WRw
	gQWPsfyo6lcypln55v9GGxmtZq2RxOAi+ooFblqY7zqno2hMyVFpjFe9A3c1ruGXsMMhMC
	nZym2U1LWAoHQ0NVufzUVcG0NuF+uM8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()
Date: Mon, 29 Apr 2024 11:12:27 +0200
Message-Id: <20240429091227.6743-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No functional changes intended.

Fixes: f2298c0403b0 ("null_blk: multi queue aware block test driver")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eed63f95e89d..aa084ae75e53 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2121,4 +2121,5 @@ module_init(null_init);
 module_exit(null_exit);
 
 MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
+MODULE_DESCRIPTION("Null test block driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

