Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA2374F5
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059539; cv=none; b=IeOaEYg+FiYTeHaHuT56/NUINB/o5DLthkXJc7LbbgwCYws8v5odK8vbW+VuHDe5o/kqiJJpetmCq0wlRIHBRH6CFaqrf01LXgWsSrHU2mOcXQ+Jq6o8rlKNa41oAOh2c9OeqwbcQ646UGofyRr+gO0ivrM8x2UutDW4MoBIXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059539; c=relaxed/simple;
	bh=tJTt4wHmrNvmY4Vqk9dmCBMEtZd6NJChtFh3dOYIh2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cn8hGAO2sFkWpUA6Xs3FtncN3936JaL7V555/I3pIcHCxU5wIb3alE8bvJibsKVweHJys8J3NDXm59Fs2HbUcxiWow6BwS1Rh89afkOYGpQQPaTXEAnxFo9cyg9F8QtajXf11Lhqke2UmZSpRGqt2rfIUc+qeBKXj5IDcvjMiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itd8c4R2; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itd8c4R2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714059534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U4o92js82P0i9dSIdEi5q5JrZ5qZXyUIDDVHmig0B7E=;
	b=itd8c4R2fsESEbTl/jfUAEmpgb4N7rSGV6OZ4UOW3I7QJEJ/SCfCJd0wjSeBGqh1FlEbym
	rrJViEez7QMtkeIDaf/W61Kore/LX8qDBmMGLwZR09jdgPEvCJeeG+XjE60joi24GAZc5O
	QPbUqdMT4XThrs3s1EtxVQD1882mOFQ=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] null_blk: Fix the problem "mutex_destroy missing"
Date: Thu, 25 Apr 2024 17:38:44 +0200
Message-Id: <20240425153844.20016-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a mutex lock is not used any more, the function mutex_destroy
should be called to mark the mutex lock uninitialized.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/null_blk/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ed33cf7192d2..eed63f95e89d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2113,6 +2113,8 @@ static void __exit null_exit(void)
 
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
+
+	mutex_destroy(&lock);
 }
 
 module_init(null_init);
-- 
2.20.1

