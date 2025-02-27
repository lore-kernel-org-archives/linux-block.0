Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C01B043F
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674041; cv=none; b=ib5XKfDj9Lt3moS0T6hdtQSjYFv5NJ7uMSu4v0/YznqstdQZVoTWnAUDqaK9sefJFnrLE8F1aktwaQmJ5ONeQyzI/SVoGVdj7ZOYeDDW2i+SP/pr3juhbFERPH0inR9+AQGI4aPqYnUSXZOz+EQoWecTJkEKFaaOqwhFInp/6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674041; c=relaxed/simple;
	bh=pLIf7xsLXbThXSxmzfd4KnR7+2f+v/4wvN2ZmzRGna8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2glWS96KjATw1kjJMDGsgMv2SWABjVyUHHFiBLiS+d96Ht2b1Cj4mRBHxdf48EaIXk6jqwPNovq7ApT1m0ZYY1H5jzmDdd1SDIKNq0IdIN5b7gWrGq/cYKdUh5yyv5UhJHdVHD5pCdqzRFfDFTh+1Cd/hQcHpx1irQNbS5yqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQH4TPYk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQH4TPYk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740674036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oZcxjI4+7P21B+uedoPfIm/5MklCtv1CyQ28To44/3c=;
	b=VQH4TPYk3wOqqp6W3EjEAJePcfhMiusO7TDgripYPSl3fpsJu/e5JAyZbJvmafEfVOO+tO
	ya9U6D+JdDg5Dcqpn2ZfvUbEXItSdFelsiTzlKUUTrOouYbH7kewymhKhxR2J2JM9C9RbG
	lq4ztv06TkdsnT4FZbmhgSWougkKQ/Q=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] loop: Remove struct loop_func_table
Date: Thu, 27 Feb 2025 17:33:43 +0100
Message-Id: <20250227163343.55952-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct is introduced in the commit 754d96798fab
("loop: remove loop.h"), but it is not used now.
So remove it.

No functional changes.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c05fe27a96b6..aea84b57891a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -45,8 +45,6 @@ enum {
 	Lo_deleting,
 };
 
-struct loop_func_table;
-
 struct loop_device {
 	int		lo_number;
 	loff_t		lo_offset;
-- 
2.39.5

