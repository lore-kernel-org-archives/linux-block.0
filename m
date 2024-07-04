Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44134A31
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055226; cv=none; b=ugV9ejKJFnvPjvr8+WJaR3CqkkcQMZSJGTWFT14YHOOmgg+Q/wS0+E7t0dJcSS0DI+RPJ/mG423bXP7dAX6if7tuN00n7raLGi2bUpRQPvZcFSpXxC4xilDzSH3x1eC/mxkGdGPctFsVHwCurYadko455IDU3fwmlr95cM0HrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055226; c=relaxed/simple;
	bh=c/Iht3r0UfI1cVQ1ma1/TCpMCYslvZdtxmTVm6ugyq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZgK6RBptwHeG8L9XTEprT3KBv8oWsCKnaxHLMlK1ziKaCJVBZsZ5OI7+TWwr8AHOWoHoZ5YE7JgYTl5I8BZAtTmjyK68Pbs+wrIQxPoTjqqXDUOwu017zdIQrAT6/lKNSt2AjuzEr+dozFGxiVo7HEL13FqpqipIw5eT+2Vra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PG004taA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PG004taA"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720055222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dHyyOptbTiBT2cmj/dHDIeLqkK+pMjugcq4UvIUbf8M=;
	b=PG004taAPGyyaSshSXaVuJKNIVWRci2IPTe6GKfGlq10CW10d8ocgb0kpjqH6yhl/nz34e
	WZ/HNQ92A1N04n66RnzekW0QOEau6xn1wtA/gt1MKvRDtfOYYau0xUQ/1nfyOmJFLUedhb
	GcfOrH19CWyjcbvPEOhLpYEWERT3hgs=
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: yanjun.zhu@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] null_blk: Fix error "ERROR:INITIALISED_STATIC: do not initialise statics to false"
Date: Thu,  4 Jul 2024 03:06:38 +0200
Message-Id: <20240704010638.324349-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No functional changes intended.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 75f189e42f88..ea3989dce3be 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,7 +77,7 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
-static bool g_virt_boundary = false;
+static bool g_virt_boundary;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
 
-- 
2.34.1

