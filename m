Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4814BF87
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065407; cv=none; b=jY5CZ0tvla3IA4sGf3bfg66cUQremgeQjXZy+9TMnxPpsMNRl5+JyQ/eaNmKhQi2r75rmPFLuqaqKz1CxTxywTUmotENh7HlD46JKefdLzRcoSQlS8spgiPId44RtPsDm2eWMEjGwv3t/fCOHQcNyx1MnjWjt0O60/NwGDfSuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065407; c=relaxed/simple;
	bh=McppaKYzNyXwgynKsmCWRw2BKx4zerHC1xjy1gYIWcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMlk4x8YHsUIKFTZkGIc5/X7zfFLTvkbQc/2SghiWwakhRaArZylpaqVp1c7sNrxDZ51+tWOi+FH3mMLTfUF1WTOKZpPP92d76Fn3dGcPKQiq+auTCDu3avQJlsCeOgn4HRPYVxjiSdRwApkzBIgTgd//y0iir/HVZozqRrYEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ess9yUc1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ess9yUc1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714065403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEHm3RwVQXQwEuGIdsX26HbxlFe+upIkheV8G9dv0WQ=;
	b=Ess9yUc1WXkC9ppLEx/KRdk6AQUTkyHQaHjWGwSirUbBGpWV2mRW0gaqmON/kYwE3SoWar
	jr+fr73B+FzrImOLc/RKKzRRBaGJn5ByaSUc4SxO9AJqPRMU473wmWwLz2bk8jqnh2iCDL
	Cy/0kA3B2IurPp3s0qmDe7JnnofdCIY=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v3 1/1] null_blk: Fix missing mutex_destroy() at module removal
Date: Thu, 25 Apr 2024 19:16:35 +0200
Message-Id: <20240425171635.4227-1-yanjun.zhu@linux.dev>
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

Fixes: f2298c0403b0 ("null_blk: multi queue aware block test driver")
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
2.34.1

