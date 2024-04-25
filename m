Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A414A4F3
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064501; cv=none; b=Hzxs/xxqXHe+lO9YRQL1vIjL+EAXR0JtfLo70NvSVTCfc9IMY80sm0ylGKHMRJbr9Hmm+09jPpUmg26sUN+eib2Ck3WglPtMGfhwtBCI3A0cSaPxBoMif4+kJN63AfoMitAo5dTc82XxhEKstk0unkbodveqT1lxuXP1cSngvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064501; c=relaxed/simple;
	bh=McppaKYzNyXwgynKsmCWRw2BKx4zerHC1xjy1gYIWcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXWDPK6sUVLm7JilpE8Be8sgNWlm1eEkRXYJ99BPLYQhAM8RuZTF9ezXTrZQ+dExKrsefRKxNz/7sSpzYN9dNH8ME8keku+2NOQ5xdtKIT/BQEZQkY+Vi4hW4uMcj1PY6+hiVBF+n/1rc2gMQs5pFcrQCv+3u/xMMccyF+7G7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBQuao0r; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBQuao0r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714064496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEHm3RwVQXQwEuGIdsX26HbxlFe+upIkheV8G9dv0WQ=;
	b=DBQuao0rWDzILUjcmghCvi98RGEmq6iG1wcjRk502fSU8wLm6eqoZ8AglhGIOuNN/mTITb
	11UTPIA07IPORdH+3dPJ2DFGASRz85rzALMcyE7hfIVp1aUE9kS9cqK4dxlrJkBTdXzOCs
	iuCYDa0Tj6BxaY7gZMELiL1xWyOHkdY=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2 1/1] null_blk: Fix the problem "mutex_destroy missing"
Date: Thu, 25 Apr 2024 19:01:27 +0200
Message-Id: <20240425170127.4926-1-yanjun.zhu@linux.dev>
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

