Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF82942A
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982162; cv=none; b=ex2M+iFEzUF2104jom1EehyfYR5tyjioae4Nirb4Y4kRrYSGD6z4q1Z3kEfXodka/Ci6oZSir9DyEK/Q9w4ODlLcdMmb+gZUGqDT3oCR1bXR8WGEfo2HnhPgESa5bQiBIvq56MC1zw8ER8quze8qq8CYVmRosUXjEO1sREB+UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982162; c=relaxed/simple;
	bh=oV+qbr7y8Stvsf1rJIaB7oJqFjz9nWf4STseq2i/b9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSefgA31VhtdQD3SVAUisXOlJLaXrJOhbEuc4veptLtJyBofoMYLtHJZby1klkuTN3B60wWoqQHKZKuyHs+OuTbiHsZygnk35QPMGvEmO85KpUVIDX+GpKd41tRV6wEupXJphVzZSFlrOscaVn3K7jda4nx4PgltE26dthabuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LcrRoEt+; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LcrRoEt+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714982157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nz/Fgtj/P4PtXDiBKaekuv5gQ5gu+tR+gD0oLgZ/xWA=;
	b=LcrRoEt+gvqkXV+C5yZppWcJlZ3WA780bA6Xpcp3JNO/v3hULwzESuvwL7KlHwZZJPO7DS
	cfenJ9WB9ktBrwyuwflwkji9IlCHjHh2v5U1xs65QE0T56uMSTESeOSEvAeoczUq03YJ8a
	77mR0igW0wUeJwNZnRJAvbK6W2Rybow=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 1/1] null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()
Date: Mon,  6 May 2024 09:55:38 +0200
Message-Id: <20240506075538.6064-1-yanjun.zhu@linux.dev>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ed33cf7192d2..5ad5cd49ae8e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2119,4 +2119,5 @@ module_init(null_init);
 module_exit(null_exit);
 
 MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
+MODULE_DESCRIPTION("multi queue aware block test driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1

